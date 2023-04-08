import QtQuick 2.12
import QtQuick.Controls 2.0
import ZoolButton 1.2
import ZoolText 1.1

Rectangle{
    id: r
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    anchors.fill: parent
    property alias c: col
    Flickable{
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: col.height+app.fs*10
        ScrollBar.vertical: ScrollBar{}
        Column{
            id: col
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: txt
                width: r.width-app.fs
                color: apps.fontColor
                font.pixelSize: app.fs*0.5
                wrapMode: Text.WordWrap
                textFormat: Text.MarkdownText
            }
            ZoolButton{
                text: 'Cerrar'
                anchors.right: parent.right
                onClicked: r.destroy(1)
            }
        }
    }
    ZoolButton{
        text: 'X'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        onClicked: r.destroy(1)
    }
    Component.onCompleted: txt.text=unik.getFile('./updates.md').replace('versión:X.XX.XX', 'versión '+app.version)
}
