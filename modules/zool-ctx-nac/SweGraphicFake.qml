import QtQuick 2.0

Item {
    id: r
    width: parent.height-app.fs*6
    height: width
    //anchors.centerIn: parent
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    Rectangle{
        width: r.width*2
        height: 1
        color: 'red'
        anchors.centerIn: parent
    }
    Rectangle{
        //anchors.fill: parent
        width:  500
        height: 500
        color: 'transparent'
        border.width: 30
        border.color: 'red'
        radius: width*0.5
        anchors.centerIn: parent
    }

}
