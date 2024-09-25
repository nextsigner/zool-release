import QtQuick 2.0

MouseArea{
    id: r
    property color bgc: 'red'
    property color bc: 'yellow'
    property int bw: 2
    property int v: !apps.dev?0:2
    property bool c: false
    Rectangle{
        visible: r.v!==0
        color: r.v===1?'transparent':r.bgc
        border.width: r.v===2 || r.v===3 ? r.bw:0
        border.color: r.bc
        radius: r.c?width*0.5:0
        anchors.fill: parent
    }
}
