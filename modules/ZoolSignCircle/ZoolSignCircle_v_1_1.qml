import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    height: width
    property int f: 0
    property int w: sweg.w
    property bool v: false
    property bool showBorder: false
    property bool showDec: apps.showDec
    property int rot: 0
    Behavior on w{enabled: apps.enableFullAnimation; NumberAnimation{duration: sweg.speedRotation}}
    /*Timer{
        running: true
        interval: 3000
        onTriggered: {
            r.width=r.width*4
            r.w=app.fs*60
            t2.start()

        }
    }
    Timer{
        id: t2
        running: false
        interval: 3000
        onTriggered: {
            r.grabToImage(function(result) {
                result.saveToFile("/home/ns/signcircle.png");
                Qt.openUrlExternally('file:///home/ns/signcircle.png')

            });
        }
    }*/
    Repeater{
        model: apps.enableWheelAspCircle?36:0
        Item{
            width: r.width
            height: 1
            anchors.centerIn: parent
            rotation: 10*index
            MouseArea {
                id: maw
                width: r.w
                height: r.w*2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin:  0-sweg.fs*0.05
                onClicked: r.v=!r.v
                property int m:0
                property date uDate//: app.currentDate
                property int f: 0
                property int uY: 0
                cursorShape: Qt.SizeVerCursor
                onWheel: {
                    let i=1
                    if (wheel.modifiers & Qt.ControlModifier) {
                        i=60
                    }
                    if (wheel.modifiers & Qt.ShiftModifier) {
                        i=60*24
                    }
                    if(wheel.angleDelta.y===120){
                        rotar(0,i)
                    }else{
                        rotar(1,i)
                    }
                    uY=wheel.angleDelta.y
                }
                //                Rectangle{
                //                    anchors.fill: parent
                //                    border.width: 1
                //                    border.color: 'red'
                //                }
            }
        }
    }

    //Probando/Visualizando rotación
    //    Rectangle{
    //        width: r.width
    //        height: 2
    //        anchors.centerIn: parent
    //        color: '#ff8833'
    //    }
    Image{
        id: signs
        anchors.fill: r
        source: './signCircle.png'
        anchors.centerIn: parent
        visible: false
    }
    Image{
        id: signsDec
        anchors.fill: r
        source: './signCircleDec.png'
        anchors.centerIn: parent
        visible: false
    }

    Rectangle{
        id: mask
        width: r.width//*0.5
        height: width
        anchors.centerIn: r
        color: 'transparent'
        visible: false
        Rectangle{
            width: parent.width
            height: width
            border.width: !app.ev?r.w:r.w*0.5
            color: 'transparent'
            radius: width*0.5
            anchors.centerIn: parent
            //color: 'red'
        }
    }
    Rectangle{
        id: maskDec
        width: r.width//*0.5
        height: width
        anchors.centerIn: r
        color: 'transparent'
        visible: false
        Rectangle{
            width: parent.width
            height: width
            border.width: !app.ev?r.w:r.w*0.5
            color: 'transparent'
            radius: width*0.5
            anchors.centerIn: parent
            //color: 'red'
        }
    }
    OpacityMask {
        id: oMSignCircle
        anchors.fill: r
        source: signs
        maskSource: mask
        invert: false
        //visible: false
    }
    OpacityMask {
        id: oMSignCircleDec
        //anchors.fill: r
        width: r.width-r.w*2
        height: width
        anchors.centerIn: parent
        source: signsDec
        maskSource: maskDec
        rotation: 0+5-10+2
        invert: false
        visible: r.showDec
    }
    Rectangle{
        id: borde1
        anchors.fill: parent
        color: 'transparent'
        border.width: 2
        border.color: apps.fontColor
        radius: width*0.5
    }
    Rectangle{
        id: borde2
        width: !app.ev?r.width-r.w*2:(r.width-r.w)
        height: width
        color: 'transparent'
        border.width: borde1.border.width
        border.color: apps.fontColor
        radius: width*0.5
        anchors.centerIn: parent
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        Repeater{
            model: 12
            Rectangle{
                width: r.width
                height: 1
                color: 'red'//'transparent'
                rotation: 0-(index*30)-15
                anchors.centerIn: parent
                Image {
                    id: iconoSigno
                    source: "../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w:r.w*0.5
                    height: width
                    rotation: 360-parent.rotation+30
                    antialiasing: true
                }
            }
        }
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        visible: r.showDec
        Repeater{
            model: r.showDec?12:0
            Rectangle{
                width: r.width-r.w*2
                height: 1
                color: 'transparent'
                rotation: 0-(index*10)-7
                anchors.centerIn: parent
                Image {
                    id: iconoSignoDec
                    source: "../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w:r.w*0.5
                    height: width
                    rotation: 360-parent.rotation+30
                    antialiasing: true
                }
            }
        }
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        visible: r.showDec
        Repeater{
            model: r.showDec?12:0
            Rectangle{
                width: r.width-r.w*2
                height: 1
                color: 'transparent'
                rotation: 0-(index*10)-7-120
                anchors.centerIn: parent
                Image {
                    id: iconoSignoDec24
                    source: "../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w:r.w*0.5
                    height: width
                    rotation: 360-parent.rotation+30
                    antialiasing: true
                }
            }
        }
    }
    Item{
        rotation: r.rot
        anchors.fill: parent
        visible: r.showDec
        Repeater{
            model: r.showDec?12:0
            Rectangle{
                width: r.width-r.w*2
                height: 1
                color: 'transparent'
                rotation: 0-(index*10)-7-120-120
                anchors.centerIn: parent
                Image {
                    id: iconoSignoDec36
                    source: "../../resources/imgs/signos/"+index+".svg"
                    width: !app.ev?r.w:r.w*0.5
                    height: width
                    rotation: 360-parent.rotation+30
                    antialiasing: true
                }
            }
        }
    }

    function subir(){
        rotar(1,1)
    }
    function bajar(){
        rotar(0,1)
    }
    function rotar(s,i){
        let grado=0
        let currentDate=app.currentDate
        if(s===0){
            currentDate.setMinutes(currentDate.getMinutes() + i)
        }else{
            currentDate.setMinutes(currentDate.getMinutes() - i)
        }
        app.currentDate=currentDate
    }
    function rotarSegundos(s){
        let currentDate=app.currentDate
        if(s===0){
            currentDate.setSeconds(currentDate.getSeconds() + 10)
        }else{
            currentDate.setSeconds(currentDate.getSeconds() - 10)
        }
        app.currentDate=currentDate
    }
}
