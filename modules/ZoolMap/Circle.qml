import QtQuick 2.0

Rectangle{
    id: r
    property int d: 100
    property alias c: r.color
    property alias bc: r.border.color
    property alias bw: r.border.width
    width: d
    height: d
    radius: width*0.5
    anchors.centerIn: parent
    border.width: 1
    border.color: 'yellow'
}
