import QtQuick 2.0
import ZoolText 1.1
import ZoolButton 1.2

Rectangle{
    id: r
    width: app.fs*6
    height: txt.contentHeight+app.fs*0.5
    color: 'blue'
    opacity: text===''?0.0:1.0
    property string text: ''
    MouseArea{
        anchors.fill: parent
        onClicked: r.text=''
    }

    Rectangle{
        id: cotaBg
        anchors.fill: parent
        color: '#333'//apps.backgroundColor
        border.width: 2
        border.color: 'yellow'
    }
    Text{
        id: txt
        width: r.width-app.fs*0.5
        text: r.text
        color: apps.fontColor
        font.pixelSize: app.fs*0.5
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
    }
}
