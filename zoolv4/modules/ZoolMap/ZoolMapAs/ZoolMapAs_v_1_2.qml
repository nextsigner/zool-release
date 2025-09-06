import QtQuick 2.0
import QtGraphicalEffects 1.0
import comps.MouseAreaView 1.0
import "../"
import "../../../comps" as Comps

import ZoolMap.ZoolMapBodie 1.0
import ZoolMap.ZoolMapAsCotaDeg 1.0
import ZoolMap.ZoolMapAsCotaText 1.0
import ZoolMap.ZoolMapPointerPlanet 1.1

Item{
    id: r
    //width: parent.width-((zm.planetSize*pos*2))-(zm.planetsMargin*2)//-(zm.planetsMargin*2)
    width: !apps.showDec?
               parent.width-((zm.planetSize*pos*2))
             :
               parent.width-((zm.planetSize*pos*2))-zm.objSignsCircle.w*2
    height: 10
    anchors.centerIn: parent
    z: !selected?numAstro:20


    property real mCaThis: zm.planetSize*pos*2 // Margin From SignsCircle To This Bodie

    property bool widhCAChecked: false

    property alias b: bodie

    property string folderImg: '../../../modules/ZoolMap/imgs/imgs_v1'

    property bool isHovered: false

    //property bool isPron: JSON.parse(app.currentData).params.t==='pron'
    property bool isBack: false
    property bool isPron: false//JSON.parse(app.fileData)?JSON.parse(app.fileData).params.t==='pron':false
    property int widthRestDec:apps.showDec?zm.objSignsCircle.w*2:0
    property bool selected: !isBack?numAstro === zm.currentPlanetIndex:numAstro === zm.currentPlanetIndexBack
    property string astro
    property int fs
    property var objData: ({g:0, m:0,s:0,ih:0,is:0, rsgdeg:0,rsg:0, gdec:0.000})
    property int absPos: 1
    property int pos: 1
    property int g: -1
    property int m: -1
    property int ih: -1
    property int is: -1
    property int numAstro: 0

    property string text: zm.aTexts[numAstro]

    property var aIcons: [0,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17]

    property color colorCuerpo: '#ff3300'

    property int uRot: 0

    property bool isZoomAndPosSeted: false
    property alias objOointerPlanet: pointerPlanet
    //property alias img: bodie.objImg
    //property alias img0: bodie.objImg0
    Behavior on rotation{enabled:(app.t==='dirprim' || app.t==='trans');NumberAnimation{duration: 2000}}
    //Behavior on width{enabled:(app.t==='dirprim' || app.t==='trans');NumberAnimation{duration: 500}}
    //Behavior on opacity{id:anOp;NumberAnimation{duration: 500}}
    onWidthChanged: {
        //h()
        if(app.t!=='trans' && app.t!=='dirprim')return
        if(!r.isBack){
            //zm.objAspsCircle.visible=false
        }else{
            //zm.objAspsCircleBack.visible=false
        }
        //zm.objTRAC.restart()
        //zm.objTapa.opacity=1.0
        //zm.resizeAspCircle()

        if(selected){
            if(!r.isBack){
                zm.objXII.setPosAndRot(r.rotation, r.width)
            }else{
                zm.objXIE.setPosAndRot(r.rotation, r.width)
            }
        }
    }
    onRotationChanged: h()
    onGChanged: h()
    onMChanged: h()
    onIhChanged: h()
    onIsChanged: h()
    onSelectedChanged: {
        if(selected)zm.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected){
            //bodie.objOointerPlanet.setPointerFs()
            housesCircle.currentHouse=objData.ih
            zm.currentHouseIndex=objData.ih
            if(!r.isBack){
                app.currentXAs=r
                zm.currentIndexSign=r.is
            }else{
                app.currentXAsBack=r
                zm.currentIndexSignBack=r.is
            }
            setRot()
            setZoomAndPos()
            app.showPointerXAs=true
            pointerPlanet.parent=!r.isBack?zm.objXII.pa:zm.objXIE.pa
            if(!r.isBack){
                zm.objXII.setPosAndRot(r.rotation, r.width)
            }else{
                zm.objXIE.setPosAndRot(r.rotation, r.width)
            }
            //zm.setPos(r.mapToGlobal(0, 0).x, r.mapToGlobal(0, 0).y, zm.objSignsCircle.rotation)


        }else{
            pointerPlanet.parent=bodie
        }
    }
    property int vr: 0
    //Behavior on width{NumberAnimation{duration:1500}}
    property bool posIncByZero: false
    function revPos(){
        posIncByZero=false
        r.vr=0//r.numAstro//-1
        for(var i=r.vr;i<zm.aBodies.length-r.numAstro;i++){
            const objAs=!r.isBack?zm.objPlanetsCircle.getAs(i):zm.objPlanetsCircleBack.getAs(i)
            const gdec=parseInt(r.objData.gdec)
            const l=gdec-10
            const h=gdec+10
            if(!objAs || !objAs.objData || !objAs.objData.gdec)continue
            const n=objAs.objData.gdec
            if((n > l && n < h)  && i!==numAstro  && i<numAstro && objAs.pos===r.pos){
                r.pos=objAs.pos+1
                r.absPos=r.pos

                /*if(!r.isBack){
                    if(r.pos>zm.maxAbsPosInt){
                        zm.maxAbsPosInt=r.pos
                        //zpn.log('i'+i+': '+r.pos+' zm.maxAbsPosInt: '+zm.maxAbsPosInt)
                    }
                }else{
                    if(r.pos>zm.maxAbsPosExt){
                        zm.maxAbsPosExt=r.pos
                        //zpn.log('i'+i+': '+r.pos+' zm.maxAbsPosInt: '+zm.maxAbsPosInt)
                    }
                }*/
                //break
            }else{
                if((0 > l && 10 < h)  && i!==numAstro  && i<numAstro && objAs.pos===r.pos && !r.posIncByZero){
                    r.pos=objAs.pos+1
                    r.absPos=r.pos
                    r.posIncByZero=true
                }
            }
        }
        r.vr++
    }
    Timer{
        id: tRevIsAspZone
        running: (!r.isBack && r.width<=zm.objAspsCircle.width) || r.width>zm.objCA.d-(zm.planetSize*2)
        repeat: true
        interval: 250
        onTriggered: {
            zm.maxAbsPosInt=zm.objPlanetsCircle.getMaxAsAbsPos()
            //zpn.log('-->'+zm.aBodies[r.numAstro]+' pos: '+pos+' zm.maxAbsPosInt: '+zm.maxAbsPosInt)
            zm.objCA.d=zm.objSignsCircle.width-(zm.objSignsCircle.w*2)-(zm.planetSize*(zm.maxAbsPosInt+1)*2)
        }
    }
    Timer{
        interval: 1000
        //running: r.numAstro===1 || r.numAstro===2
        repeat: true
        onTriggered: {
            let pos=getPos()
            let x=pos.x
            let y=pos.y
            let tx=parseInt(x)
            let ty=parseInt(y)
            let c='import QtQuick 2.0\n'
            c+='Rectangle{\n'
            c+='    width: 50\n'
            c+='    height: 50\n'
            c+='    color: "red"\n'
            c+='    x: '+x+'\n'
            c+='    y: '+y+'\n'
            c+='    Text{\n'
            c+='        text:"'+r.numAstro+':'+tx+'\n'+ty+'"\n'
            c+='        color: "white"\n'
            c+='        font.pixelSize: parent.width*0.35\n'
            c+='        anchors.centerIn: parent\n'
            c+='    }\n'
            c+='    Timer{\n'
            c+='        running: true\n'
            c+='        interval: 800\n'
            c+='        onTriggered: {\n'
            c+='            xLatIzq.opacity=0.0\n'
            c+='            xLatDer.opacity=0.0\n'
            c+='            parent.destroy(0)\n'
            c+='        }\n'
            c+='    }\n'
            c+='}\n'
            let obj=Qt.createQmlObject(c, zm.xzm, 'rectPosCode')
            //log.lv("Absolute Position of child rectangle: x ="+absolutePosition.x+", y ="+absolutePosition.y);
        }
    }

    //-->Para visualizar alcance de ancho
    Rectangle{
        id: cw1
        width: r.width
        height: app.fs*0.5
        color: 'transparent'
        border.width: 2
        border.color: 'yellow'
        anchors.centerIn: parent
        visible: false
        Rectangle{
            id: cw2
            width: zm.objCA.d+(zm.planetSize*2)
            height: app.fs*0.25
            color: 'transparent'
            border.width: 2
            border.color: 'blue'
            anchors.centerIn: parent
            /*onWidthChanged: {
                if(!r.isBack && r.pos===zm.maxAbsPosInt && parent.width>=width){
                    zpn.log('2-->'+zm.aBodies[r.numAstro]+' pos: '+pos+' zm.maxAbsPosInt: '+zm.maxAbsPosInt)
                }
            }*/

//            Timer{
//                id: tRevIsAspZoneDistante
//                //running: false//!r.isBack && r.pos===zm.maxAbsPosInt && parent.parent.width-2>parent.width//r.pos===zm.maxAbsPosInt && (r.width-(zm.planetSize*2))>=ca.width
//                running: !r.widhCAChecked && r.pos > 1 && r.pos===zm.maxAbsPosInt
//                repeat: true
//                interval: 3000
//                onTriggered: {
//                    if(!running)return
//                    if(cw1.width>=cw2.width){
//                        zpn.log('Offside-->'+zm.aBodies[r.numAstro]+' pos: '+pos+' zm.maxAbsPosInt: '+zm.maxAbsPosInt)
//                    }else{
//                        zpn.log('Inside-->'+zm.aBodies[r.numAstro]+' pos: '+pos+' zm.maxAbsPosInt: '+zm.maxAbsPosInt)
//                    }
//                    //zm.maxAbsPosInt=zm.objPlanetsCircle.getMaxAsAbsPos()

//                    //ca.d=zm.objSignsCircle.width-(zm.objSignsCircle.w*2)-(zm.planetSize*(zm.maxAbsPosInt+1)*2)
//                }
//            }

        }
    }

    //<--Para visualizar alcance de ancho

    Rectangle{
        id: centroBodie
        width: 2
        height: width
        radius: width*0.5
        color: 'red'
        anchors.centerIn: bodie
        visible: false
    }
    Rectangle{
        id: ejePos
        width: (zm.width-r.width)*0.5
        height: 1
        //anchors.centerIn: parent
        color: apps.houseColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.left
        visible: (app.t==='dirprim' || app.t==='trans') && !r.isBack
    }

    Row{
        anchors.verticalCenter: parent.verticalCenter
        anchors.right:  parent.left
        visible: apps.dev
        Repeater{
            model: r.pos
            Rectangle{
                width: zm.planetSize
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
        anchors.leftMargin: zm.planetSize
        //visible: (app.t==='dirprim'  || app.t==='trans' || app.t==='progsec') && r.isBack
        visible: (app.t==='dirprim' || app.t==='progsec') && r.isBack
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
    Item{
        id: ejePosBackTrans
        width: r.width*0.5
        height: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: zm.planetSize
        visible:  false//&& r.isBack
        Timer{
            running: app.t==='trans'
            repeat: true
            interval: 1000
            onRunningChanged: {
                if(!running)parent.visible=false
            }
            onTriggered: {
                let panel=zsm.getPanel('ZoolMods')
                let section=panel.getSection('ZoolFileTransLoader')
                let bb=section.objBB
                //if(bb.bsel1 === r.numAstro || bb.bsel2 === r.numAstro){
                if(bb.bsel2 === r.numAstro && r.isBack){
                    ejeTrans1.opacity=1.0
                    ejeTrans2.opacity=1.0
                    parent.visible=true
                }else if(bb.bsel1 === r.numAstro && !r.isBack){
                    ejeTrans1.opacity=1.0
                    ejeTrans2.opacity=1.0
                    parent.visible=true
                }else{
                    ejeTrans1.opacity=0.0
                    ejeTrans2.opacity=0.0
                    parent.visible=false
                }
            }
        }
        Rectangle{
            id: ejeTrans1
            width: r.width*0.5-zm.planetSize
            height: 1
            anchors.top: parent.top
            color: apps.houseColorBack
        }
        Rectangle{
            id: ejeTrans2
            width: r.width*0.5-zm.planetSize
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
    Image {
        id: imgEarth
        source: r.folderImg+"/earth.png"
        width: zm.width*0.05
        height: width
        rotation: -45
        antialiasing: true
        anchors.centerIn: parent
        visible: r.numAstro===0//&&apps.xAsShowIcon
    }
    ZoolMapBodie{
        id: bodie
        pos: r.pos
        numAstro: r.numAstro
        is: r.is
        width: zm.planetSize
        objData: r.objData
        anchors.left: parent.left
        anchors.leftMargin: 0//!r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        isBack: r.isBack
        selected: r.selected
        Rectangle{
            id: ejePosAsp
            width: r.width*0.5-(zm.objAspsCircle.width*0.5)-parent.width//(zm.width-r.width)*0.5
            height: apps.aspLineWidth
            //color: zm.uAspShow.split('_').length>=1?zm.uAspShow.split('_')[1]:'red'
            color: zm.uAspShow.split('_')[1]
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            visible: !r.isBack?(
                                    zm.uAspShow.indexOf('int_')===0 && (zm.uAspShow.indexOf('_'+r.numAstro+'_')>=0  || zm.uAspShow.indexOf('cellAsp_'+r.numAstro+'_')>=0)
                                    )
                              :
                                (
                                    zm.uAspShow.indexOf('ext_')===0 && (zm.uAspShow.indexOf('_'+r.numAstro+'_')>=0  || zm.uAspShow.indexOf('cellAsp_'+r.numAstro+'_')>=0)
                                    )
            Rectangle{
                width: parent.width+2
                height: parent.height+2
                anchors.centerIn: parent
                z: parent.z-1
                visible: !r.isBack?zm.aspShowSelectedInt:zm.aspShowSelectedExt
                onVisibleChanged: {
                    let difExtRot=0
                    if(r.isBack){

                        //zpn.log(zm.currentJsonBack?'SI zm.currentJsonBack':'No zm.currentJsonBack')
                        if(!zm.currentJson || !zm.currentJsonBack)return
                        //zpn.log('2 Definiendo..')
                        let jInt=zm.currentJson
                        let jExt=zm.currentJsonBack
                        let gAscInt=jInt.ph.h1.gdec
                        let gAscExt=jExt.ph.h1.gdec
                        if(gAscInt>gAscExt){
                            difExtRot=gAscInt-gAscExt
                        }else{
                            difExtRot=gAscExt-gAscInt
                        }
                        //log.lv('gAscInt: '+gAscInt+' gAscExt: '+gAscExt)
                        //log.lv('difExtRot: '+difExtRot)
                    }


                    //zpn.log('zm .objZoolAspectsViewBack .uAspShowed:'+zm.objZoolAspectsViewBack.uAspShowed)
                    labelAspName.text=!r.isBack?zm.objZoolAspectsView.uAspShowed:zm.objZoolAspectsViewBack.uAspShowed
                    let rot=0
                    if(r.ih===1){
                        rot=-90
                    }else if(r.ih===2){
                        rot=-135
                    }else if(r.ih===3){
                        rot=0
                    }else if(r.ih===4){
                        rot=90
                    }else if(r.ih===5){
                        rot=90
                    }else if(r.ih===6){
                        rot=-270
                    }else if(r.ih===7){
                        rot=180
                    }else if(r.ih===8){
                        rot=180
                    }else if(r.ih===9){
                        rot=90
                    }else if(r.ih===10){
                        rot=-90
                    }else if(r.ih===11){
                        rot=-90
                    }else if(r.ih===12){
                        rot=-180
                    }else{
                        rot=0
                    }
                    puntoPivote1.rot=rot-difExtRot
                }
                Rectangle{
                    width: puntoPivote1.width
                    height: width
                    color: puntoPivote1.color
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.right
                }
                Rectangle{
                    id: puntoPivote1
                    width: 1//app.fs*0.25
                    height: width
                    color: parent.color
                    rotation: 0-r.rotation-rot
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.top: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    property int rot: 0
                    Rectangle{
                        width: 1//parent.height
                        height: app.fs*3
                        color: parent.parent.color
                        anchors.top: parent.verticalCenter
                        //visible: false
                        Rectangle{
                            width: app.fs*0.25
                            height: width
                            radius: width*0.5
                            color: parent.color
                            anchors.horizontalCenter: parent.left
                            anchors.verticalCenter: parent.top
                        }
                        Rectangle{
                            width: 20
                            height: width
                            radius: width*0.5
                            color: 'red'
                            anchors.horizontalCenter: parent.left
                            anchors.verticalCenter: parent.bottom
                            Rectangle{
                                width: labelAspName.contentWidth+app.fs*0.35
                                height: labelAspName.contentHeight+app.fs*0.35
                                color: apps.backgroundColor
                                border.width: 1
                                border.color: apps.fontColor
                                anchors.centerIn: parent
                                rotation: puntoPivote1.rot-270-90
                                Text{
                                    id: labelAspName
                                    text: '??????'
                                    font.pixelSize: app.fs*0.5
                                    color: apps.fontColor
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }
        }

        ZoolMapPointerPlanet{
            id: pointerPlanet
            is:r.is
            gdeg: objData.g
            mdeg: objData.m
            rsgdeg:objData.gdec-(30*is)
            ih:objData.ih
            //expand: r.selected
            iconoSignRot: bodie.objImg.rotation+90
            p: r.numAstro
            cotaLong: app.fs*6
            pointerFs: app.fs*4
            opacity: (r.selected && app.showPointerXAs)||(ejePosBackTrans.visible)?1.0:0.0// && JSON.parse(app.currentData).params.t!=='pron'
            isExt: r.isBack
            onPointerRotChanged: {
                r.uRot=pointerRot
                //saveRot()
                //setRot()
            }
        }
        MouseAreaView{
            id: maSig
            property int vClick: 0
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons;
            hoverEnabled: true
            c: true
            onWheel: {
                //apps.enableFullAnimation=false
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(wheel.angleDelta.y>=0){
                        if(pointerPlanet.opacity===1.0){
                            pointerPlanet.pointerRot+=5
                        }else{
                            if(zm.planetSize<app.fs*2){
                                zm.planetSize+=app.fs*0.1
                                zm.resizeAspsCircle(r.isBack)
                            }
                        }
                    }else{
                        if(pointerPlanet.opacity===1.0){
                            pointerPlanet.pointerRot-=5
                        }else{
                            if(zm.planetSize>app.fs){
                                zm.planetSize-=app.fs*0.1
                                zm.resizeAspsCircle(r.isBack)
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
                    let sent=wheel.angleDelta.y > 0
                    zm.setZoom(sent, zm.uMouseX, zm.uMouseY)
                    return
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
                if(!r.isBack){
                    if(zm.objXII.z<=zm.objXIE.z)zm.objXII.z=zm.objXIE.z+1
                }else{
                    if(zm.objXIE.z<=zm.objXII.z)zm.objXIE.z=zm.objXII.z+1
                }
            }
            onMouseXChanged:{
                //r.isHovered=true
                //tWaitHovered.restart()
            }
            onMouseYChanged:{
                //r.isHovered=true
                //tWaitHovered.restart()
            }
            onExited: {
                //tWaitHovered.restart()
                //vClick=0
                zoolMapAsInfoView.text=''
            }
            onClicked: {
                //apps.sweFs=app.fs
                //log.lv('ZoolMapAs clicked: r.isBack'+r.isBack)
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    zm.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih

                    menuPlanets.isBack=false
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.currentIndexSign=r.is
                    menuPlanets.currentIndexHouse=r.ih
                    menuPlanets.popup()
                } else if (mouse.button === Qt.LeftButton) {
                    if(apps.dev)log.lv('Click en astro '+zm.aBodies[r.numAstro])
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
                }
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        if(!r.selected){
                            let msg='Mostrando '+app.planetasReferencia[r.numAstro]
                            msg+=' en el signo '+app.signos[r.is]
                            msg+=' en el grado '+r.objData.rsg+' '+r.objData.m+' minutos '+r.objData.s+' segundos. Casa '+r.ih
                            //zoolVoicePlayer.speak(msg, true)
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
            color: apps.fontColor
            visible: apps.dev
            Text{
                text: r.pos
                font.pixelSize: parent.width-4
                color: apps.backgroundColor
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
                     zm.listCotasShowing.indexOf(r.numAstro)>=0
                   :
                     zm.listCotasShowingBack.indexOf(r.numAstro)>=0
        //        Rectangle{
        //            width: 100
        //            height: 100
        //        }
        Timer{
            running: false//true
            repeat: true
            interval: 250
            onTriggered: {
                parent.visible=zm.listCotasShowing.indexOf(r.numAstro)>=0
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
        onOpacityChanged: r.text = zm.aTexts[numAstro]?zm.aTexts[numAstro]:''
        visible: false//r.text!==''
        onClicked: r.isHovered=false
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

    /*Comps.XCircleSignal{
        id: xCircleSignal
        width: app.fs*16
        height: width
        anchors.centerIn: bodie
        visible: apps.dev && r.selected && !r.isZoomAndPosSeted && JSON.parse(zm.currentData).params.t!=='pron'
    }*/
    //    Timer{
    //        running: !r.isZoomAndPosSeted && r.selected
    //        repeat: true
    //        interval: 1000
    //        onTriggered: setZoomAndPos()
    //    }
    Timer{
        id: tWaitHovered
        running: false
        repeat: false
        interval: 5000
        onTriggered: {
            r.isHovered=false
        }
    }
    Timer{
        id: tOpacity
        running: r.opacity!==1.0
        repeat: true
        interval: 1000
        onTriggered: {
            anOp.enabled=true
            r.opacity=1.0
        }
    }

    Timer{
        running: r.vr<zm.aBodies.length
        repeat: true
        interval: 100
        onTriggered: {
            if(numAstro>=1){
                revPos()
            }
        }
        onRunningChanged: {
            if(!running && numAstro===zm.aBodies.length-1){
                //zm.resizeAspsCircle(r.isBack)
                //zm.objTRAC.restart()
                //zm.objTapa.opacity=1.0
                //zm.hideTapa()
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
        json.rots['rc'+r.numAstro]=rot
        if(u.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }

    //Rot
    function setRot(){
        if(!r.isPron && !zm.pointerRotToCenter){
            let json=JSON.parse(zm.fileData)
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
        let itemName=app.stringRes+'zoompos'
        if(r.isBack){
            itemName+='Back'
        }
        let json=zfdm.getJson()
        if(!json[itemName]){
            json[itemName]={}
        }
        json[itemName]['zpc'+r.numAstro]=zm.getZoomAndPos()
        if(apps.dev){
            log.lv('xAs'+r.numAstro+': saveZoomAndPos()'+JSON.stringify(json, null, 2))
            log.lv('json['+itemName+'][zpc'+r.numAstro+']=sweg.getZoomAndPos()'+JSON.stringify(json[itemName+'']['zpc'+r.numAstro], null, 2))
        }
        if(u.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        zfdm.saveJson(json)
    }
    function setZoomAndPos(){
        let itemName=app.stringRes+'zoompos'
        if(r.isBack){
            itemName+='Back'
        }
        //let json=JSON.parse(zm.fileData)
        let json=zfdm.getJsonAbs()
        if(json[itemName]&&json[itemName]['zpc'+r.numAstro] && !zm.isMultiCapturing){
            zm.setZoomAndPos(json[itemName]['zpc'+r.numAstro])
            r.isZoomAndPosSeted=true
        }else{
            r.isZoomAndPosSeted=false
            zm.zoomTo(1.0, false)
            let pos=!r.isBack?zm.objPlanetsCircle.getAs(r.numAstro).getPos():zm.objPlanetsCircleBack.getAs(r.numAstro).getPos()

            zm.panTo(pos.x, pos.y)
            //log.lv('setZoomAndPos()....')
        }
    }
    function h(){
        anOp.enabled=false
        r.opacity=0.0
        tOpacity.restart()
    }
    function getPos(){
        var item1=zm.xzm
        var item2=centroBodie
        var absolutePosition = item2.mapToItem(item1, 0, 0);
        return {x: absolutePosition.x, y:absolutePosition.y}
    }
    function getAsFileNameForCap(){
        let sn=''+zm.aBodies[r.numAstro]
        sn+='_en_'+zm.aSigns[r.is]
        sn=sn.toLowerCase()
        sn=app.j.quitarAcentos(sn)
        sn+='_en_casa_'+r.ih
        sn+='.png'
        let fn=u.getPath(3)+'/Zool/caps'
        let folder=zm.currentNom.replace(/ /g, '_')
        let folderPath=fn+'/'+folder
        if(!u.folderExist(folderPath)){
            u.mkdir(folderPath)
        }
        let ffn=folderPath+'/'+sn
        return ffn
    }
}
