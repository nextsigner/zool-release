import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: r
    property bool isBack: false
    property bool selected: false
    property int pos: -1
    property int numAstro: -1
    property int is: -1
    property var objData
    property alias objImg: img0
    property color c: !r.isBack?zm.bodieColor:zm.bodieColorBack
    onCChanged: {
        if(r.numAstro===0){
            //log.lv('Themes r.bodieColor: '+zm.bodieColor)
            co.color=zm.bodieColor
        }
        //saAsColor.running=true
    }
    //property alias objImg0: img0
    property string folderImg: '../../../modules/ZoolMap/imgs/imgs_v1'
    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17,18,19]
    property color bgColor: !r.isBack?zm.bodieBgColor:zm.bodieBgColorBack
    width: zm.bodieSize
    height: width
    anchors.left: parent.left
    anchors.leftMargin: 0-xIconPlanetSmall.width
    anchors.verticalCenter: parent.verticalCenter
    Rectangle{
        id: bg
        //anchors.fill: parent
        width: parent.width*0.5
        height: width
        anchors.centerIn: parent
        radius: width*0.5
        color: !apps.xAsShowIcon?
                    r.bgColor
                 :(
                    r.numAstro<10||r.numAstro===12?'transparent':apps.fontColor
                  )
        border.color: !r.isBack?zm.bodieBgBorderColor:zm.bodieBgBorderColorBack
        border.width: !r.isBack?zm.bodieBgBorderWidth:zm.bodieBgBorderWidthBack
        antialiasing: true
        opacity: 0.65
    }
    Rectangle{
        id: nodoCenPointer
        width: r.width*0.5
        height: width
        radius: width*0.5
        color: 'transparent'
        rotation: 180
        visible: apps.xAsShowIcon && !r.selected
        anchors.centerIn: parent
        Rectangle{
            id: ejePointer
            width: zm.planetSize*f
            height: 1
            color: apps.fontColor
            anchors.left: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            property real f: 1.0
            Rectangle{
                width: txtBodieName.contentWidth+app.fs*0.25
                height: txtBodieName.contentHeight+app.fs*0.25
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs*0.15
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rotation: img0.rotation-nodoCenPointer.rotation
                MouseArea{
                    acceptedButtons: Qt.AllButtons;
                    anchors.fill: parent
                    onClicked: {
                        if (mouse.button === Qt.RightButton) {
                            nodoCenPointer.rotation-=10
                        }else{
                            nodoCenPointer.rotation+=10
                        }
                    }
                    onWheel: {
                        if(wheel.angleDelta.y>=0){
                            if(ejePointer.f<4.0)ejePointer.f+=0.1
                        }else{
                            if(ejePointer.f>1.0)ejePointer.f-=0.1
                        }
                    }

                }
                Text{
                    id: txtBodieName
                    text: zm.aBodies[r.numAstro]//+' '+r.pos
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
    }
    Image{
        id: img0
        //source: app.planetasRes[r.numAstro]?"./resources/imgs/planetas/"+app.planetasRes[r.numAstro]+".svg":""
        source: app.planetasRes[r.numAstro]||r.numAstro!==10?r.folderImg+"/"+app.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
        //source: '/home/nsp/zool-release/modules/ZoolBodies/ZoolAs/imgs_v1/'+app.planetasRes[0]+'.png'
        width: !apps.xAsShowIcon||r.numAstro<10?r.width*0.75:r.width*0.35
        height: width
        anchors.centerIn: parent
        /*rotation: !r.isBack?
                      0-parent.parent.rotation:
                      (app.t!=='dirprim'?0-parent.parent.rotation:0-parent.parent.rotation-zm.objPlanetsCircleBack.rotation)
        */
        rotation: !r.isBack?
                      0-parent.parent.rotation
                    :
                      0-parent.parent.rotation+zm.dirPrimRot
        antialiasing: true
        visible: !co.visible
    }

    ColorOverlay {
        id: co
        anchors.fill: img0
        source: img0
        color: r.c//apps.houseLineColorBack
        rotation: img0.rotation
        visible: !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0&&(r.numAstro!==10&&r.numAstro!==11)
        antialiasing: true
        SequentialAnimation{
            id: saAsColor
            //running: !r.selected//!apps.anColorXAs
            loops: 20//Animation.Infinite
            PropertyAnimation {
                target: co
                properties: "color"
                from: co.color
                to: r.c//!r.isBack?zm.bodieColor:zm.bodieColorBack//apps.fontColor//xAsColorBack
                duration: 500
            }
        }
        SequentialAnimation{
            //running: r.selected && !zm.capturing//apps.anColorXAs
            loops: Animation.Infinite
            onRunningChanged: {
                if(!running&&zm.capturing){
                    co.color=apps.xAsColorBack
                }
            }
            PropertyAnimation {
                target: co
                properties: "color"
                from: 'red'
                to: 'white'
                duration: 500
            }
            PropertyAnimation {
                target: co
                properties: "color"
                from: 'red'
                to: 'red'
                duration: 500
            }
        }
        Rectangle{
            width: parent.width*0.35
            height: width
            radius: width*0.5
            //anchors.verticalCenter: parent.verticalCenter
            anchors.bottom: parent.bottom
            anchors.left: parent.right
            anchors.leftMargin: 0-width
            visible: r.objData.retro===0
            Text{
                text: '<b>R</b>'
                font.pixelSize: parent.width*0.8
                anchors.centerIn: parent
            }
        }
    }
//    Rectangle{
//        anchors.fill: parent
//        color: 'red'
//        z: img0.z-1
//        visible: r.numAstro===14
//    }


//    Image {
//        id: img
//        source: app.planetasRes[r.numAstro]?r.folderImg+"/"+app.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
//        width: parent.width*0.8
//        height: width
//        rotation: 0-parent.parent.rotation
//        antialiasing: true
//        anchors.centerIn: parent
//        //anchors.horizontalCenterOffset: apps.xAsShowIcon?0-zm.fs*0.5:0
//        visible: false
//        Behavior on width {
//            enabled: apps.enableFullAnimation;
//            NumberAnimation{
//                duration: 350
//                easing.type: Easing.InOutQuad
//            }
//        }
//        Behavior on x {
//            enabled: apps.enableFullAnimation;
//            NumberAnimation{
//                duration: 350
//                easing.type: Easing.InOutQuad
//            }
//        }

//    }
//    ColorOverlay {
//        id: co1
//        anchors.fill: img
//        source: img
//        color: !apps.xAsShowIcon?(r.selected?apps.fontColor:apps.xAsColor):'white'
//        rotation: img.rotation
//        antialiasing: true
//        visible: false//!apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0
//    }
    onPosChanged: setPointerRot()
    function setPointerRot(){
        if(r.pos===0)nodoCenPointer.rotation=45
        if(r.pos===1)nodoCenPointer.rotation=-45
        if(r.pos===2)nodoCenPointer.rotation=70
        if(r.pos===3)nodoCenPointer.rotation=90
        if(r.pos>3)nodoCenPointer.rotation=180
    }

}
