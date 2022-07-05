import QtQuick 2.12
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2
import unik.UnikQProcess 1.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property alias c: col
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            //tF.restart()
        }else{
            //tF.stop()
        }
    }
    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight:col.height+app.fs*2
        Column{
            id: col
            spacing: app.fs*0.25
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


}
