import QtQuick 2.12
import QtQuick.Controls 2.12

Flickable{
    id: r
    width: 500//parent.width
    height: 600//parent.height
    //contentWidth: children[0].width
    //contentHeight:  children[0].height
    anchors.centerIn: parent
    clip: true
    property string pId: 'indefinido'
    //property int contentWidth: r.width-app.fs*0.5
    property var itemType
    visible: zsm.aPanelsIds.indexOf(qmltypeof(itemType))===zsm.currentIndex
    onVisibleChanged: {
        if(visible){
            r.width=r.parent.width
            r.height=r.parent.height
            r.contentWidth= r.children[0].width
            r.contentHeight=  r.children[0].height
        }
    }
//    MouseArea{
//        anchors.fill: parent
//        z: parent.z-1
//        onWheel: {
//            if(wheel.angleDelta.y>=0){
//                if(r.contentY<r.height-(r.contentHeight-r.height)){
//                    r.contentY+=10
//                }else{
//                    //r.contentY=r.height-r.contentHeight
//                }
//            }else{
//                if(r.contentY>=0){
//                    r.contentY-=10
//                }else{
//                    r.contentY=0
//                }
//            }
//        }
//        //onClicked: Qt.quit()
//    }

    function qmltypeof(obj) {
        let str = obj.toString();
        let m0=str.split('_')
        return m0[0]
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r.itemType))
        zsm.aPanelesTits.push(r.pId)
    }
}
