import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps

import ZoolFileMaker 1.4
//import ZoolFileExtDataManager 1.2
import ZoolFileLoader 1.3
import ZoolFileTransLoader 1.2
import ZoolFileDirPrimLoader 1.6
import ZoolButton 1.0
import ZoolText 1.0

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
        if(visible)zoolVoicePlayer.speak('Sección para administrar archivos.', true)
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
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Settings{
        id: settings
        property string currentQmlTypeShowed: 'ZoolFileMaker'
        property bool showModuleVersion: false
        property bool inputCoords: false
        property bool showConfig: false

    }
    Text{
        text: 'ZoolFileManager v1.2'
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
                    text:'Crear'
                    colorInverted: zoolFileMaker.visible
                    onClicked: {
                        showSection('ZoolFileMaker')
                    }
                }
                ZoolButton{
                    text:'Buscar'
                    colorInverted: zoolFileLoader.visible
                    onClicked: {
                        showSection('ZoolFileLoader')
                    }
                }
                ZoolButton{
                    text:'Transitos'
                    colorInverted: zoolFileTransLoader.visible
                    onClicked: {
                        showSection('ZoolFileTransLoader')
                    }
                }
                ZoolButton{
                    id: botDirPrim
                    text:'Direcciones'
                    colorInverted: zoolFileDirPrimLoader.visible
                    onClicked: {
                        showSection('ZoolFileDirPrimLoader')
                    }
                }
            }
        }
        Item{
            id: xSections
            width: r.width
            height: r.hp
            ZoolFileMaker{
                id: zoolFileMaker;
                //visible: true
                height: r.hp
            }
            ZoolFileLoader{id: zoolFileLoader}
            ZoolFileTransLoader{id: zoolFileTransLoader}
            ZoolFileDirPrimLoader{id: zoolFileDirPrimLoader}
        }
    }
    Rectangle{
        id: xConfig
        width: r.width-app.fs*0.5
        height: colTextJsonFolder.height+app.fs*0.5
        border.width: 1
        border.color: apps.fontColor
        radius: app.fs*0.25
        color: 'transparent'
        visible: zoolFileManager.s.showConfig
        parent: zoolFileMaker.visible?zoolFileMaker.xCfgItem:(zoolFileLoader.visible?zoolFileLoader.xCfgItem:zoolFileTransLoader.xCfgItem)
        Column{
            id: colTextJsonFolder
            anchors.centerIn: parent
            spacing: app.fs*0.5
            ZoolText{
                text:'<b>Carpeta de Archivos</b>'
                fs: app.fs*0.5
            }
            ZoolText{
                text:apps.jsonsFolder
                fs: app.fs*0.5
            }
            Row{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText{
                    text:'Usar Carpeta Temporal:'
                    fs: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    width: app.fs*0.5
                    checked: apps.isJsonsFolderTemp
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged:app.cmd.runCmd('temp-silent')
                }
            }
            Comps.XTextInput{
                id: tiJsonsFolder
                width: xConfig.width-app.fs*0.5
                t.font.pixelSize: app.fs*0.65
                anchors.horizontalCenter: parent.horizontalCenter
                t.maximumLength: 200
                text: apps.jsonsFolder
                onPressed: {
                    apps.jsonsFolder=text
                }
                Text {
                    text: 'Cambiar a carpeta'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
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
    }
    function getSection(typeOfSection){
        let obj
        for(var i=0;i<xSections.children.length;i++){
            let o=xSections.children[i]//.children[0]
            //if(app.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
    function enter(){
        panelActive.enter()
    }
    function clear(){
        panelActive.clear()
    }
    function toRight(){
        panelActive.toRight()
    }
    function toLeft(){
        panelActive.toLeft()
    }
    function toUp(){
        panelActive.toUp()
    }
    function toDown(){
        panelActive.toDown()
    }
}
