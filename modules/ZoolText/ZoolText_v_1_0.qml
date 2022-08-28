import QtQuick 2.0
import QtQuick.Controls 2.0
import "../"

Item {
    id: r
    property alias text: txt.text
    property alias t: txt
    property alias r: xText
    property alias font: txt.font
    property alias color: txt.color
    property alias horizontalAlignment: txt.horizontalAlignment
    property alias contentWidth: txt.contentWidth
    property alias contentHeight: txt.contentHeight
    property int fs: app.fs
    property color textBackgroundColor: 'transparent'
    width: txt.contentWidth
    height: xText.height
    Rectangle{
        id: xText
        width: txt.width
        height: r.fs*1.2
        color: r.textBackgroundColor
        border.width: 0
        border.color: 'white'
        anchors.centerIn: parent
        Text {
            id: txt
            font.pixelSize: r.fs
            color: 'white'
            //width: r.width-app.fs
            anchors.centerIn: parent
        }
    }
}
