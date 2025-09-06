import QtQuick 2.0
import QtQuick.Window 2.0

Rectangle{
    id: r
    width: Screen.width*0.18
    height: Screen.height*0.18
    border.width: 2
    border.color: 'white'
    anchors.horizontalCenter: parent.horizontalCenter
    Column{
        anchors.centerIn: parent
        Rectangle{
            id: a4
            width: r.width
            height: r.height*0.1
            border.width: 1
            border.color: apps.fontColor
            color: 'green'
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mkSen(4)
                }
            }
            Text{
                text:'Zona 4'
                font.pixelSize: parent.height*0.5
                color: 'white'
                anchors.centerIn: parent
                Rectangle{
                    width: parent.width+parent.parent.height*0.1
                    height: parent.height+parent.parent.height*0.1
                    color: 'black'
                    anchors.centerIn: parent
                    z: parent.z-1
                }
            }

        }
        Row{
            Rectangle{
                width: r.width*0.2
                height: r.height-a4.height
                border.width: 1
                border.color: apps.fontColor
                color: '#ff8833'
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mkSen(1)
                    }
                }
            }
            Rectangle{
                width: r.width*0.6
                height: r.height-a4.height
                border.width: 1
                border.color: apps.fontColor
                color: '#ff3f8f'
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mkSen(2)
                    }
                }
            }
            Rectangle{
                width: r.width*0.2
                height: r.height-a4.height
                border.width: 1
                border.color: apps.fontColor
                color: '#ff8833'
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mkSen(3)
                    }
                }
            }
        }
    }

    function mkSen(nz){
        let c='import QtQuick 2.0\n'
        c='import ZoolSectionsManager.ZoolHelp.SenZonas 1.0\n'
        c+='SenZonas{nz:'+nz+'}'
        let comp=Qt.createQmlObject(c, capa101, 'senzonascode')
    }
}
