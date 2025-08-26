import QtQuick 2.0
import ZoolButton 1.2

Rectangle{
    id: r
    width: xLatDer.width
    height: xLatDer.height
    //minimumWidth: xLatDer.width
    //minimumHeight: xLatDer.height
    color: apps.backgroundColor
    x: 0
    clip: true
    border.width: 2
    border.color: apps.fontColor
    property string text: ''
    property int fs: app.fs
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        Flickable{
            width: r.width
            height: r.height
            contentWidth: r.width
            contentHeight: txt.contentHeight+app.fs
            anchors.centerIn: parent
        Text{
            id: txt
            text: r.text
            width: parent.width-app.fs
            height: parent.height-app.fs
            wrapMode: Text.WordWrap
            anchors.centerIn: parent
            color: apps.fontColor
            font.pixelSize: r.fs
        }

        }
    }

    ZoolButton{
        text: 'X'
        width: app.fs*0.5
        height: width
        fs: app.fs*0.35
        anchors.top: parent.top
        anchors.right: parent.right
        onClicked:{
            r.destroy()
        }
    }
}
