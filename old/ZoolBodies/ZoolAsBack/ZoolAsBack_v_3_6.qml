import QtQuick 2.0
import QtGraphicalEffects 1.0
import ZoolText 1.1

import ZoolBodies.ZoolBodie 1.0
import ZoolBodies.ZoolAsCotaDeg 1.0

import "../"

Item{
    id: r
    //width: !selected?(planetsCircle.expand?parent.width-(r.fs*2*objData.p)-r.fs:parent.width-(r.fs*1.5*objData.p))-r.fs:parent.width//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    width: (signCircle.width+sweg.fs*0.25)+(r.fs*objData.p)+sweg.fs*2
    height: 1
    anchors.centerIn: parent
    //z: !selected?numAstro:15

    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'

    property int numAstro: 0
    property string astro

    property bool selected: numAstro === app.currentPlanetIndexBack

    property int is
    property int fs:sweg.fs*0.75//planetsCircleBack.planetSize
    //property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property int pos: 1
    property int g: -1
    property int m: -1



    property color colorCuerpo: '#ff3300'

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12]

    property int uRot: 0

    property alias objOointerPlanet: pointerPlanet
    //property alias img: bodie.objImg
    //property alias img0: bodie.objImg0

    onSelectedChanged: {
        if(selected)housesCircleBack.currentHouse=objData.ih
        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            pointerPlanet.setPointerFs()
            housesCircleBack.currentHouse=objData.ih
            app.currentHouseIndexBack=objData.ih
            app.currentXAsBack=r
            setRot()
            setZoomAndPos()
            app.showPointerXAsBack=true
        }
    }
    onObjDataChanged: {
        pointerPlanet.is=r.is
        pointerPlanet.gdeg=objData.g
        pointerPlanet.mdeg=objData.m
        pointerPlanet.rsgdeg=objData.rsg
        pointerPlanet.ih=objData.ih
    }
    //Probando/Visualizando rotación
    Rectangle{
        width: r.width
        height: apps.widthHousesAxis
        anchors.centerIn: parent
        //color: apps.fontColor
        //visible: apps.showHousesAxis
        //y: lineaEje2.y
        visible: false
        color: 'yellow'
        antialiasing: true
    }
    Rectangle{
        width: (r.width-signCircle.width)*0.5+signCircle.w*0.5//+r.fs*0.25//r.fs+r.fs*objData.p-1
        height: 1//apps.widthHousesAxis
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0//-r.fs*0.25
        //anchors.centerIn: parent
        color: apps.fontColor
        antialiasing: true
        Canvas {
            id:canvasSen
            width: sweg.fs*0.2
            height: width
            //rotation: 180
            anchors.verticalCenter: parent.verticalCenter
            //anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 0-width
            antialiasing: true
            onPaint:{
                var ctx = canvasSen.getContext('2d');
                ctx.clearRect(0, 0, canvasSen.width, canvasSen.height);
                ctx.beginPath();
                ctx.moveTo(0, canvasSen.width*0.5);
                ctx.lineTo(canvasSen.width, 0);
                ctx.lineTo(canvasSen.width, canvasSen.width);
                ctx.lineTo(0, canvasSen.width*0.5);
                ctx.strokeStyle = canvasSen.parent.color
                ctx.lineWidth = 1;
                ctx.fillStyle = canvasSen.parent.color
                ctx.fill();
                ctx.stroke();
            }
        }
    }
    //    Rectangle{
    //        id: xIcon
    //        //width: r.fs*0.85
    //        width:
    //            !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0?
    //                (!app.ev?r.fs*0.85:/*Tam glifo interior*/r.fs*0.85):
    //                (!app.ev?r.fs*2:r.fs)
    //        height: width
    //        anchors.left: parent.left
    //        anchors.leftMargin: 0-xIconPlanetSmall.width
    //        //anchors.leftMargin: !r.selected?0:width*0.5
    //        anchors.verticalCenter: parent.verticalCenter
    //        radius: width*0.5
    //        color: 'red'
    ZoolBodie{
        id: bodie
        numAstro: r.numAstro
        is: r.is
        width:
            !apps.xAsShowIcon||r.aIcons.indexOf(r.numAstro)<0?
                (!app.ev?r.fs*0.85:/*Tam glifo interior*/r.fs*0.85):
                (!app.ev?r.fs*2:r.fs)
        objData: r.objData
        anchors.left: parent.left
        anchors.leftMargin: !r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        isBack: true
        PointerPlanet{
            id: pointerPlanet
            is:r.is
            //is: objData.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.rsg
            ih:objData.ih
            expand: r.selected
            iconoSignRot: bodie.objImg.rotation
            p: r.numAstro
            opacity: r.selected&&app.showPointerXAs?1.0:0.0
            isBack: true
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
                r.parent.cAs=r
            }
            onExited: {
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
                    menuPlanets.isBack=true
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
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
    }
    ZoolAsCotaDeg{
        id: xDegData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        isBack: true
        distancia: bodie.objImg.width
        gdec: objData.gdec
        g: objData.rsg
        m:objData.m
        s:objData.s
        ih:objData.ih
        is:objData.is
        cotaColor: 'red'//xIconPlanetSmall.color
        cotaOpacity: 1.0//xIconPlanetSmall.opacity
        //rot: -270
        visible: sweg.listCotasShowingBack.indexOf(r.numAstro)>=0
        Timer{
            running: true
            repeat: true
            interval: 250
            onTriggered: {
                parent.visible=sweg.listCotasShowingBack.indexOf(r.numAstro)>=0
            }
        }
    }

    function rot(d){
        if(d){
            pointerPlanet.pointerRot+=5
        }else{
            pointerPlanet.pointerRot-=5
        }
        saveRot(parseInt(pointerPlanet.pointerRot))
    }
    function saveRot(rot){
        let json=zfdm.getJson()
        if(!json.rots){
            json.rots={}
        }
        json.rots['rcBack'+r.numAstro]=rot
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }

    //Rot
    function setRot(){
        let json=zfdm.getJson()
        if(json.rots&&json.rots['rcBack'+r.numAstro]){
            r.uRot=json.rots['rcBack'+r.numAstro]
            pointerPlanet.pointerRot=r.uRot
        }
    }
    function restoreRot(){
        pointerPlanet.pointerRot=r.uRot
    }

    //Zoom And Pos
    function saveZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        json[app.stringRes+'zoompos']['zpcBack'+r.numAstro]=sweg.getZoomAndPos()
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }
    function setZoomAndPos(){
        let json=JSON.parse(app.fileData)
        if(json[app.stringRes+'zoompos']&&json[app.stringRes+'zoompos']['zpcBack'+r.numAstro]){
            sweg.setZoomAndPos(json[app.stringRes+'zoompos']['zpcBack'+r.numAstro])
        }
    }
}
