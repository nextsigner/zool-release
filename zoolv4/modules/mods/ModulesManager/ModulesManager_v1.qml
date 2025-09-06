import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1

import ZoolButton 1.0
import ZoolText 1.2

//import mods.ModulesManager.ModulesLoader 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property var cm

    property int hp: r.parent.height//-app.fs

    property var panelActive
    property alias s: settings
    property int currentIndex: -1

    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex
    //onCmChanged: zpn.log('cm.objectName: '+cm.objectName)

    Settings{
        id: settings
        fileName: u.getPath(4)+'/ModulesManager.cfg'
        property string currentQmlTypeShowed: 'ModulesLoader'//'Intelink'
    }

    Item{
        id: xSections
        width: r.width
        height: r.hp
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Extras')
        r.showSection(s.currentQmlTypeShowed)
        r.panelActive=r.getSection(s.currentQmlTypeShowed)

        loadCurrentModule()
    }

    function showSection(qmltype){
        let newCi=-1
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]
            o.visible=false
        }
        for(i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]
            if(app.j.qmltypeof(o)!==qmltype){
                o.visible=false
            }else{
                o.visible=true
                newCi=i
            }
        }
        s.currentQmlTypeShowed=qmltype
        if(newCi)r.currentIndex=newCi
        //zsm.currentSectionFocused=r
        apps.zFocus='xLatIzq'
    }
    function getSection(typeOfSection){
        let obj
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]//.children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
    function getSectionVisible(){
        if(r.cm)return r.cm
        //zpn.log('xSections .children .length: '+xSections.children.length)
        let obj
        let o
        for(var i=0;i<r.children.length;i++){
            o=r.children[i]
            //zpn.log('getSectionVisible() o.objectName: '+o.objectName)
            if(o.objectName.indexOf('mm_')===0){
                //zpn.log('getSectionVisible() o.visible: '+o.visible)
                obj=o
                break
            }
        }
        if(obj)return obj
        for(i=0;i<capa101.children.length;i++){
            o=capa101.children[i]
            //zpn.log('getSectionVisible() o.objectName: '+o.objectName)
            if(o.objectName.indexOf('mm_')===0){
                //zpn.log('getSectionVisible() o.visible: '+o.visible)
                obj=o
                break
            }
        }
        if(obj)return obj
        for(i=0;i<xSections.children.length;i++){
            o=xSections.children[i]//.children[0]
            //zpn.log('getSectionVisible() objName: '+o.objectName)
            if(o.visible){
                //zpn.log('getSectionVisible() o.visible: '+o.visible)
                obj=o
                break
            }
        }
        return obj
    }

    //-->Teclado
    function toEnter(ctrl){
        getSectionVisible().toEnter(ctrl)
    }
    function clear(){
        getSectionVisible().clear()
    }
    function toLeft(ctrl){
        if(!ctrl){
            getSectionVisible().toLeft()
        }else{
            if(r.currentIndex>0){
                r.currentIndex--
            }else{
                r.currentIndex=1
            }
            if(r.currentIndex===0){
                showSection('ZoolFileMaker')
            }else{
                showSection('ZoolFileLoader')
            }
        }
    }
    function toRight(ctrl){
        if(!ctrl){
            getSectionVisible().toRight()
        }else{
            if(r.currentIndex===0){
                r.currentIndex=1
            }else{
                r.currentIndex=0
            }
            if(r.currentIndex===0){
                showSection('ZoolFileMaker')
            }else{
                showSection('ZoolFileLoader')
            }
        }
    }
    function toUp(){
        getSectionVisible().toUp()
    }
    function toDown(){
        getSectionVisible().toDown()
    }
    function toTab(){
        getSectionVisible().toTab()
    }
    function toEscape(){
        //console.log('r.cm.objectName: '+r.cm.objectName)
        //zpn.log('r.cm.objectName: '+r.cm.objectName)
        if(r.cm){
            r.cm.toEscape()
            return
        }
        let i=getSectionVisible()
        //zpn.log('toEscape() i.objectName: '+i.objectName)
        if(i)getSectionVisible().toEscape()
    }
    function isFocus(){
        if(app.ci && app.ci.objectName.indexOf('mm_ModulesLoader')<0){
            return app.ci.isFocus()
        }
        return false
    }
    function toHelp(){
        getSectionVisible().toHelp()
    }
    //<--Teclado

    property bool hasUnUsedFunction: true
    function unUsed(){
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]
            if(o.hasUnUsedFunction){
                o.unUsed();
                //log.lv('Panel Anterior con unUsed(): '+panelType)
            }else{
                //log.lv('Panel Anterior sin unUsed(): '+panelType)
            }
        }
    }

    //-->Funciones de Panel de Herramientas Extras
    function loadCurrentModule(){
        //zpn.log('uModule: '+s.currentQmlTypeShowed)
        for(var i=0;i<xSections.children.length; i++){
            xSections.children[0].destroy(0)
        }
        //let extrasModsPath=u.getPath(5)+'/modules/mods/ModulesManager'
        let c='import mods.ModulesManager.'+s.currentQmlTypeShowed+' 1.0\n'
        c+=''+s.currentQmlTypeShowed+'{}\n'
        let comp=Qt.createQmlObject(c, xSections, 'loadcurrentmodules-code')
    }
    function loadModule(moduleName, version){
        //zpn.log('Loading '+moduleName+' version '+version)
        for(var i=0;i<xSections.children.length; i++){
            xSections.children[0].destroy(0)
        }
        //let extrasModsPath=u.getPath(5)+'/modules/mods/ModulesManager'
        let c='import mods.ModulesManager.'+moduleName+' '+version+'\n'
        c+=''+moduleName+'{objectName:"mm_'+moduleName+'"}\n'
        let comp=Qt.createQmlObject(c, xSections, 'loadcurrentmodules-code')
        r.cm=comp
    }
    //<--Funciones de Panel de Herramientas Extras
}
