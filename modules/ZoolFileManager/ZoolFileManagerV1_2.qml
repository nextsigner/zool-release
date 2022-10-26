import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps
import "../../js/Funcs.js" as JS

import ZoolFileMaker 1.0
import ZoolFileLoader 1.1
import ZoolFileTransLoader 1.0
import ZoolButton 1.0
import ZoolText 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property var panelActive: zoolFileMaker.visible?zoolFileMaker:zoolFileLoader

    property alias ti: zoolFileLoader.ti
    property alias currentIndex: zoolFileLoader.currentIndex
    property alias listModel: zoolFileLoader.listModel

    property alias tiN: zoolFileMaker.tiN
    property alias tiC: zoolFileMaker.tiC


//    property real lat:-100.00
//    property real lon:-100.00

//    property real ulat:-100.00
//    property real ulon:-100.00

//    property string uFileNameLoaded: ''
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            tF.restart()
        }else{
            tF.stop()
        }
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
        property bool showModuleVersion: false
        property bool inputCoords: false
    }
    Text{
        text: 'ZoolFileManager v1.1'
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
        spacing: -app.fs*0.25
        //anchors.centerIn: parent
        Row{
            id: rowBtns
            ZoolButton{
                text:'Crear Archivo'
                colorInverted: zoolFileMaker.visible
                onClicked: {
                    zoolFileMaker.visible=true
                    zoolFileLoader.visible=false
                    zoolFileTransLoader.visible=false
                }
            }
            ZoolButton{
                text:'Cargar Archivo'
                colorInverted: zoolFileLoader.visible
                onClicked: {
                    zoolFileMaker.visible=false
                    zoolFileLoader.visible=true
                    zoolFileTransLoader.visible=false
                }
            }
            ZoolButton{
                text:'Transitos'
                colorInverted: zoolFileTransLoader.visible
                onClicked: {
                    zoolFileMaker.visible=false
                    zoolFileLoader.visible=false
                    zoolFileTransLoader.visible=true
                }
            }
        }
        ZoolFileMaker{
            id: zoolFileMaker;
            visible: true
            height: r.parent.height-rowBtns.children[0].height-rowBtns.parent.spacing
        }
        ZoolFileLoader{
            id: zoolFileLoader;
            visible: false
            height: zoolFileMaker.height
        }
        ZoolFileTransLoader{
            id: zoolFileTransLoader;
            visible: false
            height: zoolFileMaker.height
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
        visible: app.dev
        parent: zoolFileMaker.visible?zoolFileMaker.xCfgItem:zoolFileLoader.xCfgItem
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
    function showFileMaker(){
        apps.currentSwipeViewIndex=r.itemIndex
        sv.currentIndex=apps.currentSwipeViewIndex
        zoolFileLoader.visible=false
        zoolFileMaker.visible=true

    }
    function showFileLoader(){
        apps.currentSwipeViewIndex=r.itemIndex
        sv.currentIndex=apps.currentSwipeViewIndex
        zoolFileMaker.visible=false
        zoolFileLoader.visible=true

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
