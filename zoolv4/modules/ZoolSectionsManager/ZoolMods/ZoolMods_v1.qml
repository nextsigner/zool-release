import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../../comps" as Comps

import ZoolSectionsManager.ZoolMods.ZoolFileTransLoader 1.6
import ZoolSectionsManager.ZoolMods.ZoolFileDirPrimLoader 1.7
import ZoolSectionsManager.ZoolMods.ZoolFileProgSecLoader 1.0
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

    property var panelActive: zoolFileTransLoader



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
            //r.panelActive.setInitFocus()
        }
    }
    Settings{
        id: settings
        fileName: u.getPath(4)+'/ZoolMods.cfg'
        property string currentQmlTypeShowed: 'ZoolFileTransLoader'

    }
    Text{
        text: 'ZoolMods v1.0'
        font.pixelSize: app.fs*0.5
        color: apps.fontColor
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        opacity: settings.showModuleVersion?1.0:0.0
        MouseArea{
            anchors.fill: parent
            onClicked: settings.showModuleVersion=!settings.showModuleVersion
        }
    }
    Column{
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
                    text:'Transitos'
                    colorInverted: zoolFileTransLoader.visible
                    onClicked: {
                        showSection('ZoolFileTransLoader')
                    }
                }
                ZoolButton{
                    id: botDirPrim
                    text:'Dir. Prim.'
                    colorInverted: zoolFileDirPrimLoader.visible
                    onClicked: {
                        showSection('ZoolFileDirPrimLoader')
                    }
                }
                ZoolButton{
                    id: botProgSec
                    text:'Prog. Sec.'
                    colorInverted: zoolFileProgSecLoader.visible
                    onClicked: {
                        showSection('ZoolFileProgSecLoader')
                    }
                }
            }
        }
        Item{
            id: xSections
            width: r.width
            height: r.hp
            ZoolFileTransLoader{id: zoolFileTransLoader}
            ZoolFileDirPrimLoader{id: zoolFileDirPrimLoader}
            ZoolFileProgSecLoader{id: zoolFileProgSecLoader}
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
        zsm.aPanelesTits.push('Métodos')
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
        //r.currentIndex=newCi
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
    function getSectionIndex(typeOfSection){
        let ci=-1
        let obj
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i].children[0]
            //log.lv('getSectionIndex( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                ci=i//zsm.aPanelsIds.indexOf(app.j.qmltypeof(o))
                break
            }
        }

        return ci
    }
    function clear(){
        panelActive.clear()
    }


    //-->Teclado
    function toEnter(){
        panelActive.toEnter()
    }
    function toLeft(){
        panelActive.toLeft()
    }
    function toRight(){
        panelActive.toRight()()
    }
    function toUp(){
        panelActive.toUp()
    }
    function toDown(){
        panelActive.toDown()
    }
    function isFocus(){
        return panelActive.isFocus()
    }
    function toEscape(){
        panelActive.toEscape()
    }
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
    //-->Teclado
}
