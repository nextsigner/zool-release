import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps
import "../../js/Funcs.js" as JS

import ZoolFileMaker 1.0
import ZoolFileLoader 1.1
import ZoolButton 1.0

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


    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property string uFileNameLoaded: ''
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
        running: svIndex===itemIndex
        repeat: false
        interval: 1500
        onTriggered: {
            tiNombre.t.selectAll()
            tiNombre.t.focus=true
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
                colorInverted: !zoolFileMaker.visible
                onClicked: {
                    zoolFileMaker.visible=!zoolFileMaker.visible
                    zoolFileLoader.visible=!zoolFileLoader.visible
                }
            }
            ZoolButton{
                text:'Cargar Archivo'
                colorInverted: !zoolFileLoader.visible
                onClicked: {
                    zoolFileMaker.visible=!zoolFileMaker.visible
                    zoolFileLoader.visible=!zoolFileLoader.visible
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
