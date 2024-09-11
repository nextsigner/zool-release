import QtQuick 2.0

Item{
    id: r
    property color c: 'red'
    Row{
        spacing: r.height
        anchors.left: parent.left
        anchors.leftMargin: r.height
        Repeater{
            model: 100
            Rectangle{
                width: r.height
                height: width
                radius: width*0.5
                color: r.c
                anchors.verticalCenter: parent.verticalCenter
                opacity: 0.75
            }
        }
    }
}
