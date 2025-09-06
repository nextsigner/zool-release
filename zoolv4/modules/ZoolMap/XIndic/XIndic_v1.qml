import QtQuick 2.0

Item{
    id: r
    width: !isExt?zm.objPlanetsCircle.width:zm.objPlanetsCircleBack.width
    height: width
    //rotation: zm.objSignsCircle.rot-90//!isExt?zm.objPlanetsCircle.rot:zm.objPlanetsCircleBack.rot
    rotation: -90
    anchors.centerIn: parent
    property alias pa: posAs
    property int w: 500
    property bool isExt: false
    property bool dev: app.dev
    Rectangle{
        id: ejeAs
        width: 3
        height: r.w
        color: r.dev?'red':'transparent'
        anchors.centerIn: parent
        Rectangle{
            id: posAs
            width: zm.planetSize
            height: width
            color: 'transparent'
            border.width: r.dev?6:0
            border.color: 'red'
            radius: width*0.5
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    function setPosAndRot(gdec, w){
        r.w=w
        ejeAs.rotation=gdec
    }
}
