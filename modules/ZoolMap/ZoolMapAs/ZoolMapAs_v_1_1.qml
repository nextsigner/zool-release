import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../"
import "../../../comps" as Comps

import ZoolBodies.ZoolBodie 1.0
import ZoolMap.ZoolMapAsCotaDeg 1.0
import ZoolMap.ZoolMapAsCotaText 1.0
import ZoolMap.ZoolMapPointerPlanet 1.0

Item{
    id: r
    //width: parent.width-((zoolMap.planetSize*pos*2))-(zoolMap.planetsMargin*2)//-(zoolMap.planetsMargin*2)
    width: !apps.showDec?
               parent.width-((zoolMap.planetSize*pos*2))
             :
               parent.width-((zoolMap.planetSize*pos*2))-zoolMap.objSignsCircle.w*2
    height: 10
    anchors.centerIn: parent
    z: !selected?numAstro:20

    property string folderImg: '../../../modules/ZoolBodies/ZoolAs/imgs_v1'

    property bool isHovered: false

    //property bool isPron: JSON.parse(app.currentData).params.tipo==='pron'
    property bool isBack: false
    property bool isPron: false//JSON.parse(app.fileData)?JSON.parse(app.fileData).params.tipo==='pron':false
    property int widthRestDec:apps.showDec?zoolMap.objSignsCircle.w*2:0
    property bool selected: !isBack?numAstro === zoolMap.currentPlanetIndex:numAstro === zoolMap.currentPlanetIndexBack
    property string astro
    property int fs
    property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int ih: -1
    property int is: -1
    property int numAstro: 0

    property string text: zoolMap.aTexts[numAstro]

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17]

    property color colorCuerpo: '#ff3300'

    property int uRot: 0

    property bool isZoomAndPosSeted: false
    property alias objOointerPlanet: pointerPlanet
    //property alias img: bodie.objImg
    //property alias img0: bodie.objImg0
    onSelectedChanged: {
        if(selected)zoolMap.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            //bodie.objOointerPlanet.setPointerFs()
            housesCircle.currentHouse=objData.ih
            zoolMap.currentHouseIndex=objData.ih
            app.currentXAs=r
            zoolMap.currentIndexSign=r.is
            setRot()
            setZoomAndPos()
            app.showPointerXAs=true
            //zoolMap.setPos(r.mapToGlobal(0, 0).x, r.mapToGlobal(0, 0).y, zoolMap.objSignsCircle.rotation)
        }
    }
    property int vr: 0
    //Behavior on width{NumberAnimation{duration:1500}}
    Timer{
        running: r.vr<zoolMap.aBodies.length
        repeat: true
        interval: 100
        onTriggered: {
            if(numAstro>=1){
                revPos()
            }
        }
        onRunningChanged: {
            if(!running && numAstro===zoolMap.aBodies.length-1){
                zoolMap.resizeAspsCircle(r.isBack)
                zoolMap.hideTapa()
            }
        }
    }
    function revPos(){
        for(var i=r.vr;i<zoolMap.aBodies.length;i++){
            const objAs=!r.isBack?zoolMap.objPlanetsCircle.getAs(i):zoolMap.objPlanetsCircleBack.getAs(i)
            const l=parseInt(r.objData.gdec)-10
            const h=parseInt(r.objData.gdec)+10
            if(!objAs || !objAs.objData || !objAs.objData.gdec)continue
            const n=objAs.objData.gdec
            if((n > l && n < h)  && i!==numAstro  && i<numAstro){
                r.pos=objAs.pos+1
                break
            }
        }
        r.vr++
    }
    Rectangle{
        id: ejePos
        width: (zoolMap.width-r.width)*0.5
        height: 1
        //anchors.centerIn: parent
        color: apps.houseColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.left
        visible: app.mod==='dirprim' && !r.isBack
    }
    Row{
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:  parent.left
        visible: app.dev
        Repeater{
            model: r.pos
            Rectangle{
                width: zoolMap.planetSize
                height: width
                border.width: 2
                border.color: 'red'
                Text{
                    text: r.vr
                    font.pixelSize: parent.width*0.8
                    anchors.centerIn: parent
                }

            }
        }
    }
    Item{
        id: ejePosBack
        width: r.width*0.5
        height: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: zoolMap.planetSize
        visible: app.mod==='dirprim' && r.isBack
        Rectangle{
            width: r.width
            height: 1
            anchors.top: parent.top
            color: apps.houseColorBack
        }
        Rectangle{
            width: r.width
            height: 1
            anchors.bottom: parent.bottom
            color: apps.houseColorBack
        }
    }
    Rectangle{
        width: r.width*4
        height: 4
        x:0-r.width*2
        anchors.verticalCenter: parent.verticalCenter
        color: apps.xAsLineCenterColor
        visible: r.selected && (apps.showXAsLineCenter || apps.showDec)
    }
    ZoolBodie{
        id: bodie
        numAstro: r.numAstro
        is: r.is
        width: zoolMap.planetSize
        objData: r.objData
        anchors.left: parent.left
        anchors.leftMargin: 0//!r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        isBack: r.isBack
        ZoolMapPointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.rsg
            ih:objData.ih
            expand: r.selected
            iconoSignRot: parent.objImg.rotation
            p: r.numAstro
            opacity: r.selected&&app.showPointerXAs?1.0:0.0// && JSON.parse(app.currentData).params.tipo!=='pron'
            onPointerRotChanged: {
                r.uRot=pointerRot
                //saveRot()
                //setRot()
            }
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
                        if(pointerPlanet.opacity===1.0){
                            pointerPlanet.pointerRot+=5
                        }else{
                            if(zoolMap.planetSize<app.fs*2){
                                zoolMap.planetSize+=app.fs*0.1
                                zoolMap.resizeAspsCircle(r.isBack)
                            }
                        }
                    }else{
                        if(pointerPlanet.opacity===1.0){
                            pointerPlanet.pointerRot-=5
                        }else{
                            if(zoolMap.planetSize>app.fs){
                                zoolMap.planetSize-=app.fs*0.1
                                zoolMap.resizeAspsCircle(r.isBack)
                            }
                        }
                    }
                }else if (wheel.modifiers & Qt.ShiftModifier){
                    if(wheel.angleDelta.y>=0){
                        xTextData.rot+=5
                    }else{
                        xTextData.rot-=5
                    }
                    r.isHovered=true

                    tWaitHovered.restart()
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
                r.isHovered=true
                zoolMapAsInfoView.text=r.text
                vClick=0
                r.parent.cAs=r
            }
            onMouseXChanged:{
                r.isHovered=true
                tWaitHovered.restart()
            }
            onMouseYChanged:{
                r.isHovered=true
                tWaitHovered.restart()
            }
            onExited: {
                tWaitHovered.restart()
                vClick=0
                zoolMapAsInfoView.text=''
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    zoolMap.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih

                    menuPlanets.isBack=false
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
                function rotatePoint(x, y, angle) {
                    // Convertir el ángulo a radianes
                    var radians = angle * Math.PI / 180;

                    // Calcular las coordenadas rotadas
                    var rotatedX = x * Math.cos(radians) - y * Math.sin(radians);
                    var rotatedY = x * Math.sin(radians) + y * Math.cos(radians);

                    return { x: rotatedX, y: rotatedY };
                }   running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        if(!r.selected){
                            let msg='Mostrando '+app.planetasReferencia[r.numAstro]
                            msg+=' en el signo '+app.signos[r.is]
                            msg+=' en el grado '+r.objData.rsg+' '+r.objData.m+' minutos '+r.objData.s+' segundos. Casa '+r.ih
                            zoolVoicePlayer.speak(msg, true)
                        }
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Rectangle{
            width: parent.width*0.5
            height: width
            color: 'black'
            visible: app.dev
            Text{
                text: r.pos
                font.pixelSize: parent.width-4
                color: 'white'
                anchors.centerIn: parent
            }
        }
    }
    ZoolMapAsCotaDeg{
        id: xDegData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        isBack: r.isBack
        distancia: bodie.width
        gdec: objData.gdec
        g: objData.rsg
        m:objData.m
        s:objData.s
        ih:objData.ih
        is:objData.is
        cotaColor: apps.fontColor
        cotaOpacity: 1.0//xIconPlanetSmall.opacity
        //rot: -270
        visible: !r.isBack?
                     zoolMap.listCotasShowing.indexOf(r.numAstro)>=0
                   :
                     zoolMap.listCotasShowingBack.indexOf(r.numAstro)>=0
//        Rectangle{
//            width: 100
//            height: 100
//        }
        Timer{
            running: false//true
            repeat: true
            interval: 250
            onTriggered: {
                parent.visible=zoolMap.listCotasShowing.indexOf(r.numAstro)>=0
            }
        }
    }

    ZoolMapAsCotaText{
        id: xTextData
        width: bodie.width*2
        anchors.centerIn: bodie
        z: bodie.z-1
        widthObjectAcoted: width*0.25
        isBack: false
        distancia: bodie.width*3
        text: r.text
        cotaColor: apps.fontColor
        cotaOpacity: 1.0
        opacity: r.isHovered||isPinched?1.0:0.0
        onOpacityChanged: r.text = zoolMap.aTexts[numAstro]?zoolMap.aTexts[numAstro]:''
        visible: false//r.text!==''
        onClicked: r.isHovered=false
    }

    Image {
        id: imgEarth
        source: r.folderImg+"/earth.png"
        width: zoolMap.width*0.05
        height: width
        rotation: -45
        antialiasing: true
        anchors.centerIn: parent
        visible: r.numAstro===0&&apps.xAsShowIcon
    }
    Rectangle{
        width: r.width*0.5-bodie.width
        height: app.fs*0.25
        color: 'transparent'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        visible: apps.xAsShowIcon
        anchors.leftMargin: bodie.width*0.5
        Comps.XSignal{
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: app.fs*6
            numAstro: r.numAstro
            //visible: r.numAstro===0
            visible: r.selected
        }
    }
    Comps.XCircleSignal{
        id: xCircleSignal
        width: app.fs*16
        height: width
        anchors.centerIn: bodie
        visible: app.dev && r.selected && !r.isZoomAndPosSeted && JSON.parse(app.currentData).params.tipo!=='pron'
    }
    Timer{
        running: !r.isZoomAndPosSeted && r.selected
        repeat: true
        interval: 1000
        onTriggered: setZoomAndPos()
    }
    Timer{
        id: tWaitHovered
        running: false
        repeat: false
        interval: 5000
        onTriggered: {
            r.isHovered=false
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
        json.rots['rc'+r.numAstro]=rot
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }

    //Rot
    function setRot(){
        if(!r.isPron){
            let json=JSON.parse(zoolMap.fileData)
            if(json.rots&&json.rots['rc'+r.numAstro]){
                r.uRot=json.rots['rc'+r.numAstro]
                pointerPlanet.pointerRot=r.uRot
            }
        }else{
            pointerPlanet.pointerRot=180
        }
    }
    function restoreRot(){
        pointerPlanet.pointerRot=r.uRot
    }

    //Zoom And Pos
    function saveZoomAndPos(){
        let json=zfdm.getJson()
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        json[app.stringRes+'zoompos']['zpc'+r.numAstro]=zoolMap.getZoomAndPos()
        if(app.dev){
            //log.ls('xAs'+r.numAstro+': saveZoomAndPos()'+JSON.stringify(json, null, 2), 0, log.width)
            //log.ls('json['+app.stringRes+'zoompos][zpc'+r.numAstro+']=sweg.getZoomAndPos()'+JSON.stringify(json[app.stringRes+'zoompos']['zpc'+r.numAstro], null, 2), 0, log.width)
        }
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }
    function setZoomAndPos(){
        let json=JSON.parse(zoolMap.fileData)
        if(json[app.stringRes+'zoompos']&&json[app.stringRes+'zoompos']['zpc'+r.numAstro]){
            zoolMap.setZoomAndPos(json[app.stringRes+'zoompos']['zpc'+r.numAstro])
            r.isZoomAndPosSeted=true
        }else{
            r.isZoomAndPosSeted=false
        }
    }
}
