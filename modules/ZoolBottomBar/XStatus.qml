import QtQuick 2.0
import ZoolText 1.0
Rectangle{
    id: r
    width: row.width+app.fs
    height: r.parent.height
    color: 'transparent'
    border.width: 1
    border.color: 'white'
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    Row{
        id: row
        anchors.centerIn: parent
        spacing: app.fs*0.25
        ZoolText{
            text: '<b>State:</b> '+zoolDataBodies.state
            font.pixelSize: r.height*0.25
            color: 'white'
        }
        Column{
            visible: false
            ZoolText{
                text: '<b>Sol:</b> '+app.currentGradoSolar
                font.pixelSize: r.height*0.25
                color: 'white'
            }
            ZoolText{
                text: '<b>Asc:</b> '+app.uAscDegree
                font.pixelSize: r.height*0.25
                color: 'white'
            }
            ZoolText{
                text: '<b>Mc:</b> '+app.uMcDegree
                font.pixelSize: r.height*0.25
                color: 'white'
            }
        }
        ZoolText{
            text: '<b>Mod:</b> '+app.mod
            font.pixelSize: r.height*0.5
            color: 'white'
        }
        ZoolText{
            id: txtStatus
            text: '<b>SWEG:</b> '+sweg.state
            font.pixelSize: r.height*0.5
            color: 'white'
        }
//        ZoolText{
//            text: '<b>LT:</b> '+(xLayerTouch.visible?'SI':'NO')
//            font.pixelSize: app.fs*0.5
//            color: 'white'
//        }
    }
}
