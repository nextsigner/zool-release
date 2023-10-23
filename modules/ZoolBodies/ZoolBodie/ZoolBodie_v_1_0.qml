import QtQuick 2.0
import QtGraphicalEffects 1.0
//import "../"
//import "../../../comps" as Comps

Rectangle{
    id: r
    //width: r.fs*0.85
    property bool isBack: false
    property bool selected: false
    property int numAstro: -1
    property int is: -1
    property var objData
    //property alias objOointerPlanet: pointerPlanet
    property alias objImg: img
    property alias objImg0: img0
    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'
    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17]
    width:
        !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0?
            (!app.ev?r.fs*0.85:/*Tam glifo interior*/r.fs*0.85):
            (!app.ev?r.fs*2:r.fs)
    height: width
    anchors.left: parent.left
    anchors.leftMargin: 0-xIconPlanetSmall.width
    anchors.verticalCenter: parent.verticalCenter
    radius: width*0.5
    color: !r.isBack?'blue':'red'
//    Rectangle{
//        width: app.fs
//        height: width
//        anchors.centerIn: parent
//    }
//    PointerPlanet{
//        id: pointerPlanet
//        is:r.is
//        //is: objData.is
//        gdeg: objData.g
//        mdeg: objData.m
//        rsgdeg:objData.rsg
//        ih:objData.ih
//        expand: r.selected
//        iconoSignRot: img0.rotation
//        p: r.numAstro
//        opacity: r.selected&&app.showPointerXAs?1.0:0.0
//        isBack: r.isBack
//    }

    Rectangle{
        //Circulo prueba/ocultar.
        width: parent.width+sweg.fs*0.1
        height: width
        anchors.centerIn: parent
        radius: width*0.5
        border.width: 1
        border.color: "yellow"//apps.backgroundColor
        color: apps.xAsBackgroundColorBack
        antialiasing: true
        visible: false
    }
    Rectangle{
        //Circulo que queda mostrando el cuerpo chico.
        id: xIconPlanetSmall
        width: parent.width+sweg.fs*0.1
        height: width
        anchors.centerIn: parent
        radius: width*0.5
        border.width: 0
        border.color: apps.backgroundColor
        opacity: apps.xAsBackgroundOpacityBack
        color: apps.xAsBackgroundColorBack
        antialiasing: true
        visible: false//co.visible
    }

    MouseArea{
        id: maSig
        property int vClick: 0
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons;
        hoverEnabled: true
        onWheel: {
            //apps.enableFullAnimation=false
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    pointerPlanet.pointerRot+=5
                }else{
                    pointerPlanet.pointerRot-=5
                }
            }else{
                if(wheel.angleDelta.y>=0){
                    //                    if(reSizeAppsFs.fs<app.fs*2){
                    //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                    //                    }else{
                    //                        reSizeAppsFs.fs=app.fs
                    //                    }
                    pointerPlanet.pointerRot+=45
                }else{
                    //                    if(reSizeAppsFs.fs>app.fs){
                    //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                    //                    }else{
                    //                        reSizeAppsFs.fs=app.fs*2
                    //                    }
                    pointerPlanet.pointerRot-=45
                }
            }
            //reSizeAppsFs.restart()
        }
        onEntered: {
            vClick=0
            r.parent.parent.cAs=r.parent
        }
        onExited: {
            vClick=0
            //r.parent.cAs=r.parent
        }
        onClicked: {
            //apps.sweFs=app.fs
            if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
                menuPlanets.isBack=r.isBack
                menuPlanets.currentIndexPlanet=r.numAstro
                menuPlanets.popup()
                menuPlanets.currentIndexPlanet=r.numAstro
                menuPlanets.popup()
            } else if (mouse.button === Qt.LeftButton) {
                vClick++
                tClick.restart()
            }
        }
        onDoubleClicked: {
            tClick.stop()
            r.parent.doublePressed(r)
        }
        Timer{
            id: tClick
            running: false
            repeat: false
            interval: 500
            onTriggered: {
                if(maSig.vClick<=1){
                    r.parent.parent.pressed(r.parent)
                }else{
                    r.parent.parent.doublePressed(r.parent)
                }
            }
        }
    }
    Image{
        id: img0
        //source: app.planetasRes[r.numAstro]?"./resources/imgs/planetas/"+app.planetasRes[r.numAstro]+".svg":""
        source: app.planetasRes[r.numAstro]?r.folderImg+"/"+app.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
        //source: '/home/nsp/zool-release/modules/ZoolBodies/ZoolAs/imgs_v1/'+app.planetasRes[0]+'.png'
        width: r.width*0.9
        height: width
        //x:!r.selected?0:r.parent.width*0.5-img0.width*0.5//+sweg.fs*2
        //y: (parent.width-width)/2
        anchors.centerIn: parent
        //rotation: 0-parent.parent.rotation
        rotation: app.mod!=='dirprim'?0-parent.parent.rotation:0-parent.parent.rotation-sweg.objPlanetsCircleBack.rotation
        antialiasing: true
        visible: !co.visible
    }

    ColorOverlay {
        id: co
        anchors.fill: img0
        source: img0
        color: apps.houseLineColorBack
        rotation: img0.rotation
        visible: !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0
        antialiasing: true
        SequentialAnimation{
            running: !r.selected//!apps.anColorXAs
            loops: 3//Animation.Infinite
            PropertyAnimation {
                target: co
                properties: "color"
                from: co.color
                to: apps.fontColor//xAsColorBack
                duration: 500
            }
        }
        SequentialAnimation{
            running: r.selected && !app.capturing//apps.anColorXAs
            loops: Animation.Infinite
            onRunningChanged: {
                if(!running&&app.capturing){
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
    Image {
        id: img
        source: app.planetasRes[r.numAstro]?r.folderImg+"/"+app.planetasRes[r.numAstro]+(apps.xAsShowIcon&&r.aIcons.indexOf(r.numAstro)>=0?"_i.png":".svg"):""
        //source: '/home/nsp/zool-release/modules/ZoolBodies/ZoolAs/imgs_v1/'+app.planetasRes[0]+'.png'
        //width: r.parent.parent.objectName==='sweg'?!r.selected?parent.width:parent.width*2:!r.selected?parent.width:parent.width*1.25
        width: parent.width*0.8
        height: width
        rotation: 0-parent.parent.rotation
        antialiasing: true
        anchors.centerIn: parent
        //anchors.horizontalCenterOffset: apps.xAsShowIcon?0-sweg.fs*0.5:0
        Behavior on width {
            enabled: apps.enableFullAnimation;
            NumberAnimation{
                duration: 350
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on x {
            enabled: apps.enableFullAnimation;
            NumberAnimation{
                duration: 350
                easing.type: Easing.InOutQuad
            }
        }

    }
    ColorOverlay {
        id: co1
        anchors.fill: img
        source: img
        color: !apps.xAsShowIcon?(r.selected?apps.fontColor:apps.xAsColor):'white'
        rotation: img.rotation
        antialiasing: true
        visible: !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0
    }

    Component.onCompleted: {
        if(r.numAstro===0){
            let comp=Qt.createComponent('./zoolbody/ZoolBodySun.qml')
            let obj=comp.createObject(r, {w: r.width*0.5})
            img.visible=false
            co1.visible=false
        }
    }
}
