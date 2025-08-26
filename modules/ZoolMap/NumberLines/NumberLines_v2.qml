import QtQuick 2.0

Rectangle{
    id: r
    width: parent.width//zm.objSignsCircle.width-(zm.zodiacBandWidth*2)
    height: width
    color: 'transparent'
    radius: width*0.5
    border.width: 0
    border.color: 'red'
    anchors.centerIn: parent
    rotation: signCircle.rot
    visible: apps.showNumberLines
    property bool fnd: false //full number degree count
    property int mode: apps.numberLinesMode
    Repeater{
        model: 360
        Item{
            width: parent.width//-signCircle.w
            height: 1
            rotation: index
            anchors.centerIn: parent
            Rectangle{
                width: app.fs*0.25
                height: 1
                color: apps.fontColor
                antialiasing: true
            }
        }
    }
    //Lineas Gruesas cada 10 grados
    Repeater{
        model: 36
        Item{
            width: parent.width
            height: 1
            rotation: index*10
            anchors.centerIn: parent
            Rectangle{
                width: app.fs*0.35
                height: 3
                y:-1
                color: apps.fontColor
                antialiasing: true
            }
            Rectangle{
                width: app.fs*0.1
                height: 3
                x:0-app.fs*0.1
                y:-1
                color: apps.backgroundColor
                opacity: 0.5
                antialiasing: true
            }
        }
    }
    //Circulo con el número del grado
    Repeater{
        model: 36
        Item{
            width: parent.width
            height: 1
            rotation: index*10
            anchors.centerIn: parent
            Rectangle{
                width: app.fs*0.5
                height: width
                x:r.mode===1?0-width-app.fs*0.1:0+width-app.fs*0.1
                y:0-width*0.5
                radius: width*0.5
                color: 'transparent'
                border.width: r.mode===1?0:1
                border.color: r.mode===1?apps.backgroundColor:apps.fontColor
                rotation: 360-parent.rotation-signCircle.rot
                Rectangle{
                    anchors.fill: parent
                    radius: width*0.5
                    color: apps.backgroundColor
                    opacity: 0.35
                    anchors.centerIn: parent
                }
                Rectangle{
                    anchors.fill: parent
                    radius: width*0.5
                    border.width: 1
                    border.color: apps.backgroundColor
                    color: 'transparent'
                    opacity: 0.5
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: r.fnd=!r.fnd
                }
                Text{
                    visible: r.fnd
                    text: '<b>'+parseInt(360-(index*10)===360?0:360-(index*10))+'</b>'
                    font.pixelSize: parent.width*0.45
                    color: apps.fontColor
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
                Text{
                    visible: !r.fnd;
                    font.pixelSize: parent.width*0.55;
                    color: apps.fontColor;
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent;
                    Component.onCompleted: {
                        if(index===1||index===4||index===7||index===10||index===13||index===16||index===19||index===22||index===25||index===28||index===31||index===34){
                            text='<b>20</b>'
                        }else if(index===2||index===5||index===8||index===11||index===14||index===17||index===20||index===23||index===26||index===29||index===32||index===35){
                            text='<b>10</b>'
                        }else{
                            text='<b>0</b>'
                        }
                    }
                }
            }
        }
    }
}
