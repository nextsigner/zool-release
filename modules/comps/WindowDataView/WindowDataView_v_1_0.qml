import QtQuick 2.0
import QtQuick.Window 2.0

Window{
    id: r
    width: xLatDer.width
    height: xLatDer.height
    //minimumWidth: xLatDer.width
    //minimumHeight: xLatDer.height
    title: 'WindowDataView'
    color: 'black'
    x: Screen.width-width
    visible: true
    property string text: ''
    property int fs: app.fs
    Rectangle{
        anchors.fill: parent
        color: 'black'
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
            color: 'white'
            font.pixelSize: r.fs
        }

        }
    }

}
