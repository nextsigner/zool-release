import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../../../comps" as Comps

import ZoolSectionsManager.ZoolFiles.ZoolFileMaker 1.8
import ZoolSectionsManager.ZoolFiles.ZoolFileLoader 1.4

import ZoolButton 1.0
import ZoolText 1.2

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property int hp: r.parent.height-xBtns.height//-rowBtns.parent.spacing //Altura de los paneles

    property var panelActive: zoolFileMaker.visible?zoolFileMaker:zoolFileLoader

    property alias ti: zoolFileLoader.ti
    property alias currentIndex: zoolFileLoader.currentIndex
    property alias listModel: zoolFileLoader.listModel

    property alias tiN: zoolFileMaker.tiN
    property alias tiC: zoolFileMaker.tiC

    property alias s: settings
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1
    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            tF.restart()
        }else{
            tF.stop()
        }
    }
    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        //if(visible)zoolVoicePlayer.speak('Sección para administrar archivos.', true)
    }
    Timer{
        id: tF
        running: svIndex===itemIndex && apps.zFocus==='xLatIzq'
        repeat: false
        interval: 1500
        onTriggered: {
            r.panelActive.setInitFocus()
        }
    }
    Settings{
        id: settings
        fileName: u.getPath(4)+'/ZoolFileManager.cfg'
        property string currentQmlTypeShowed: 'ZoolFileMaker'
        property bool showModuleVersion: false
        property bool inputCoords: false
        property bool showConfig: false

    }
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: xBtns
            width: r.width
            height: rowBtns.height+app.fs*0.5
            color: 'transparent'
            border.width: 0
            border.color: 'red'
            Flow{
                id: rowBtns
                spacing: app.fs*0.25
                width: parent.width-app.fs*0.5
                anchors.centerIn: parent
                ZoolButton{
                    text:'Crear'
                    colorInverted: !zoolFileMaker.visible
                    onClicked: {
                        showSection('ZoolFileMaker')
                    }
                }
                ZoolButton{
                    text:'Buscar'
                    colorInverted: !zoolFileLoader.visible
                    onClicked: {
                        showSection('ZoolFileLoader')
                    }
                }
            }
        }
        Item{
            id: xSections
            width: r.width-app.fs*0.5
            height: r.hp
            anchors.horizontalCenter: parent.horizontalCenter
            ZoolFileMaker{
                id: zoolFileMaker;
                //visible: true
                width: parent.width
                height: r.hp
            }
            ZoolFileLoader{
                id: zoolFileLoader
                width: parent.width
            }
        }
    }




    //    Component.onCompleted: {
    //        r.showSection(s.currentQmlTypeShowed)
    //    }

    function timer() {
        return Qt.createQmlObject("import QtQuick 2.0; Timer {}", r);
    }
    function mkTimer(){
        let t = new timer();
        t.interval = 2000;
        t.repeat = false;
        t.triggered.connect(function () {
            log.visible=false
            //log.lv("I'm triggered once every second");
        })
        t.start();
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Administrar archivos')
        r.showSection(s.currentQmlTypeShowed)
        r.panelActive=r.getSection(s.currentQmlTypeShowed)
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
        r.currentIndex=newCi
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
        let obj
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]//.children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(o.visible){
                obj=o
                break
            }
        }
        return obj
    }
    function clear(){
        getSectionVisible().clear()
    }
    //-->Teclado
    function toEnter(ctrl){
        getSectionVisible().toEnter(ctrl)
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
        let s = getSectionVisible()
        if(s)getSectionVisible().toEscape()
    }
    function isFocus(){
        return getSectionVisible().isFocus()
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
}
