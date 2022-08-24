import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolButton 1.0
Rectangle{
    id: r
    width: parent.width
    height: col.height+app.fs
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    anchors.bottom: parent.bottom
    state: 'hide'
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:r.parent.width-r.width
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:r.parent.width
            }
        }
    ]
    Rectangle{
        width: app.fs
        height: r.height
        anchors.right: parent.left
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: r.state='show'
        }
    }
    Column{
        id: col
    Row{
        id: rowBtns1
        Repeater{
            model: ['Reiniciar', 'Apagar']
            ZoolButton{
                text:modelData
                onClicked: {
                    //r.clicked()
                }
            }
        }
    }
    }
}
