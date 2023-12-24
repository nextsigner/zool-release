import QtQuick 2.7
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS


import ZoolMap.ZoolMapSignCircle 1.1
import ZoolMap.ZoolMapHousesCircle 1.0
import ZoolMap.ZoolMapPlanetsCircle 1.1
import ZoolMap.ZoolMapAspsCircle 1.0
import ZoolMap.ZoolMapAspsView 1.0
import ZoolMap.ZoolMapAspsViewBack 1.0
import ZoolMap.ZoolMapAsInfoView 1.0

import ZoolMap.ZoolMapNakshatraView 1.0


Item{
    id: r
    height: parent.height-app.fs*0.25
    width: height
    anchors.centerIn: parent
    anchors.horizontalCenterOffset: 0-r.width*0.5
    anchors.verticalCenterOffset: 0-r.width*0.5

    property alias objTapa: tapa
    property alias objSignsCircle: signCircle
    property alias objHousesCircle: housesCircle
    property alias objHousesCircleBack: housesCircleBack
    property alias objPlanetsCircle: planetsCircle
    property alias objPlanetsCircleBack: planetsCircleBack
    property alias objAspsCircle: aspsCircle
    property alias objZoolAspectsView: panelAspects
    property alias objZoolAspectsViewBack: panelAspectsBack


    property bool showZonas: true

    property bool ev: app.ev
    property int zodiacBandWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumMargin: app.fs*0.25
    property int fs: app.fs
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property int planetSize: !r.ev?app.fs*1.5:app.fs
    property int planetsPadding: app.fs*8
    property int planetsMargin: app.fs*0.15
    property int aspsCircleWidth: 100
    property int planetsBackBandWidth: 100

    property int planetsAreaWidth: 100
    property int planetsAreaWidthBack: 100

    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
    property int currentIndexSign: -1
    property string currentNakshatra: ''
    property string currentNakshatraBack: ''
    property string currentHsys: apps.currentHsys

    property bool enableAnZoomAndPos: true

    property var listCotasShowing: []
    property var listCotasShowingBack: []

    property bool enableLoad: true
    property bool enableLoadBack: true

    property real dirPrimRot: 0.00

    property int ejeTipoCurrentIndex: -2

    //-->ZoomAndPan
    property bool zoomAndPosCentered: pinchArea.m_x1===0 && pinchArea.m_y1===0 && pinchArea.m_y2===0 && pinchArea.m_x2===0 && pinchArea.m_zoom1===0.5 && pinchArea.m_zoom2===0.5 && pinchArea.m_max===6 && pinchArea.m_min===0.5
    property real xs: scaler.xScale
    property real z1: pinchArea.m_zoom1
    property var uZp
    //<--ZoomAndPan

    //-->Theme
    property color bodieColor: apps.fontColor
    property color bodieColorBack: apps.fontColor
    property color bodieBgColor: 'transparent'
    property color bodieBgColorBack: 'transparent'
    //<--Theme

    property var aTexts: []

    onVisibleChanged: {
        if(visible){
            centerZoomAndPos()
            //return
            let filePath='/home/ns/gd/Zool/Natalia_S._Pintos.json'
            loadFromFileBack(filePath, 'sin')
        }
    }
    onDirPrimRotChanged: {
        if(app.mod==='dirprim'){
            planetsCircleBack.rotation=planetsCircle.rotation-dirPrimRot
        }
    }
    onEnableAnZoomAndPosChanged: {
        tEnableAnZoomAndPos.restart()
    }
    Behavior on opacity{NumberAnimation{duration: 1500}}
//    Rectangle{
//        anchors.fill: parent
//        color: 'yellow'
//    }
    Item{id:xuqp}
    Flickable{
        id: flick
        anchors.fill: parent
        Rectangle {
            id: rect
            border.width: 0
            width: Math.max(xSweg.width, flick.width)*2
            height: Math.max(xSweg.height, flick.height)*2
            border.color: '#ff8833'
            color: 'transparent'
            antialiasing: true
            //x:(parent.width-width)/2
            transform: Scale {
                id: scaler
                origin.x: pinchArea.m_x2
                origin.y: pinchArea.m_y2
                xScale: pinchArea.m_zoom2
                yScale: pinchArea.m_zoom2
                Behavior on origin.x{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on origin.y{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on xScale{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on yScale{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            }
            Behavior on x{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Behavior on y{NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            PinchArea {
                id: pinchArea
                anchors.fill: parent

                property real m_x1: 0
                property real m_y1: 0
                property real m_y2: 0
                property real m_x2: 0
                property real m_zoom1: 1.0
                property real m_zoom2: 1.0
                property real m_max: 6
                property real m_min: 1.0

                onPinchStarted: {
                    console.log("Pinch Started")
                    m_x1 = scaler.origin.x
                    m_y1 = scaler.origin.y
                    m_x2 = pinch.startCenter.x
                    m_y2 = pinch.startCenter.y
                    rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                    rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                }
                onPinchUpdated: {
                    console.log("Pinch Updated")
                    m_zoom1 = scaler.xScale
                    var dz = pinch.scale-pinch.previousScale
                    var newZoom = m_zoom1+dz
                    if (newZoom <= m_max && newZoom >= m_min) {
                        m_zoom2 = newZoom
                    }
                }
                Timer{
                    id: tEnableAnZoomAndPos
                    running: false
                    repeat: false
                    interval: 1500
                    onTriggered: r.enableAnZoomAndPos=true
                }
                Rectangle{
                    width: parent.width*3
                    height: width
                    color: 'transparent'
                    anchors.centerIn: parent
                    MouseArea{
                        anchors.fill: parent
                        onDoubleClicked: centerZoomAndPos()
                    }
                }
                MouseArea {
                    //z:parent.z-1
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: rect
                    drag.filterChildren: true
                    onWheel: {
                        r.enableAnZoomAndPos=false
                        pinchArea.m_x1 = scaler.origin.x
                        pinchArea.m_y1 = scaler.origin.y
                        pinchArea.m_zoom1 = scaler.xScale
                        pinchArea.m_x2 = mouseX
                        pinchArea.m_y2 = mouseY

                        var newZoom
                        if (wheel.angleDelta.y > 0) {
                            newZoom = pinchArea.m_zoom1+0.1
                            if (newZoom <= pinchArea.m_max) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_max
                            }
                        } else {
                            newZoom = pinchArea.m_zoom1-0.1
                            if (newZoom >= pinchArea.m_min) {
                                pinchArea.m_zoom2 = newZoom
                            } else {
                                pinchArea.m_zoom2 = pinchArea.m_min
                            }
                        }
                        rect.x = rect.x + (pinchArea.m_x1-pinchArea.m_x2)*(1-pinchArea.m_zoom1)
                        rect.y = rect.y + (pinchArea.m_y1-pinchArea.m_y2)*(1-pinchArea.m_zoom1)
                        //console.debug(rect.width+" -- "+rect.height+"--"+rect.scale)
                    }
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            apps.zFocus='xMed'
                            if (mouse.button === Qt.RightButton) {

                                menuRuedaZodiacal.uX=mouseX
                                menuRuedaZodiacal.uY=mouseY
                                menuRuedaZodiacal.isBack=false
                                menuRuedaZodiacal.popup()
                            }
                        }
                        onDoubleClicked: {
                            centerZoomAndPos()
                        }
                    }

                }
            }
            Item{
                id: xSweg
                width: r.width//*0.25
                height: width
                anchors.centerIn: parent
                //anchors.horizontalCenterOffset: xSweg.width*0.5
                Rectangle{
                    id: bg
                    width: parent.width*10
                    height: width
                    color: backgroundColor
                    //visible: signCircle.v
                }
                //BackgroundImages{id: backgroundImages}
                Rectangle{
                    id: xz
                    anchors.fill: parent
                    color: 'transparent'
                    visible: false
                    Circle{
                        id:ae
                        d: r.ev?r.width:0
                        c: 'transparent'
                        property int w: 100
                    }
                    Circle{
                        id: ai
                        d: !r.ev?r.width:ae.width-ae.w*2
                        c: 'transparent'
                        //opacity: 0.5
                        property int w: 10
                        Circle{
                            id:bgAi
                            anchors.fill: parent
                            color: r.bodieBgColor
                        }
                        Circle{
                            id: ca
                            d: signCircle.width-(signCircle.w*2)-parent.w
                            color: apps.backgroundColor
                        }
                    }
                }

                ZoolMapHousesCircle{id: housesCircle; width: ai.width; z:ai.z+1}
                ZoolMapHousesCircle{id: housesCircleBack; width: ai.width; isBack: true}
                ZoolMapAspsCircle{id: aspsCircle;width:ca.width; z:ai.z+3; rotation: signCircle.rot - 90}
                Rectangle{
                    id:bgPCB
                    width: planetsCircleBack.width
                    height: width
                    color: r.bodieBgColorBack
                    radius: width*0.5
                    anchors.centerIn: parent
                    ZoolMapPlanetsCircle{id: planetsCircleBack; width: ae.width-r.housesNumWidth*2-r.housesNumMargin*2; z:ai.z+5; isBack: true; visible: r.ev}
                }
                Rectangle{
                    id:bgPC
                    width: signCircle.width
                    height: width
                    color: r.bodieBgColor
                    radius: width*0.5
                    anchors.centerIn: parent
                    ZoolMapPlanetsCircle{id: planetsCircle; width: signCircle.width-signCircle.w*2; z: ai.z+4;}
                }
                ZoolMapSignCircle{id: signCircle; width: ai.width-r.housesNumWidth*2-r.housesNumMargin*2;}
                //NumberLines{visible:true}
                ZoolMapNakshatraView{id: nakshatraView; width: ca.width; z: aspsCircle.z+1}
                /*
                EclipseCircle{
                    id: eclipseCircle
                    width: housesCircle.width
                    height: width
                }
                Rectangle{
                    width: 3
                    height: r.height*2
                    color: apps.fontColor
                    anchors.centerIn: parent
                    visible: app.showCenterLine
                }
                Rectangle{
                    width: r.height*2
                    height: 3
                    color: apps.fontColor
                    anchors.centerIn: parent
                    visible: app.showCenterLine
                }
                ZoolAutoPanZoom{id:zoolAutoPanZoom}
                */
            }
        }
    }
    ZoolMapAspsView{
        id: panelAspects
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: xLatIzq.visible?0:0-xLatIzq.width
        parent: xMed
        //visible: r.objectName==='sweg'
    }
    ZoolMapAspsViewBack{
        id: panelAspectsBack
        anchors.top: parent.top
        //anchors.topMargin: 0-(r.parent.height-r.height)/2
        parent: xMed
        anchors.left: parent.left
        anchors.leftMargin: xLatIzq.visible?width:width-xLatIzq.width
        transform: Scale{ xScale: -1 }
        rotation: 180
        visible: planetsCircleBack.visible
    }
    ZoolMapAsInfoView{
        id: zoolMapAsInfoView
        width: xLatDer.width
        anchors.bottom: parent.bottom
        parent: xLatDer
    }
    Rectangle{
        width: txtMod.contentWidth+app.fs
        height: txtMod.contentHeight+app.fs
        color: apps.fontColor
        anchors.centerIn: parent
        anchors.verticalCenterOffset: app.fs*3
        visible: app.dev
        Text{
            id: txtMod
            text: app.mod+r.ejeTipoCurrentIndex
            font.pixelSize: app.fs
            color: apps.backgroundColor
            anchors.centerIn: parent
        }
    }

    Rectangle{
        id: tapa
        width: r.width*4
        height: width
        color: apps.backgroundColor
        anchors.centerIn: parent
        visible: false
        onOpacityChanged:{
            if(opacity===0.0){
                visible=false
                opacity=1.0
            }
        }
        Behavior on opacity{NumberAnimation{duration: 1000}}
    }

    //-->Load Data
    function load(j){
        //console.log('Ejecutando SweGraphic.load()...')
        r.dirPrimRot=0

        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=j.params.hsys?j.params.hsys:apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        if(!r.enableLoad)return\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //log.lv(\'JSON: \'+json)\n'
        c+='        loadSweJson(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'zoolMap.load() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\')\n'
        //c+='        Qt.quit()\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.mod=j.params.tipo
        app.fileData=JSON.stringify(j)
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
        r.dirPrimRot=0
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let params
        params=j.params

        let vd=params.d
        let vm=params.m
        let va=params.a
        let vh=params.h
        let vmin=params.min
        let vgmt=params.gmt
        let vlon=params.lon
        let vlat=params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
        if(params.hsys)hsys=params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        //c+='        if(!r.enableLoadBack)return\n'
        c+='        let json=(\'\'+logData)\n'
        //c+='        log.lv(\'JSON Back: \'+json)\n'
        //c+='        console.log(\'JSON Back: \'+json)\n'
        c+='        loadSweJsonBack(json)\n'
        c+='        app.ev=true\n'
        c+='        app.objZoolFileExtDataManager.updateList()\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'zoolMap.loadBack() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.mod=j.params.tipo
        app.fileDataBack=JSON.stringify(j)
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        tapa.visible=true
        tapa.opacity=1.0
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        aspsCircle.clear()
        //zsm.getPanel('ZoolRevolutionList').clear()
        //panelRsList.clear()
        //planetsCircleBack.visible=false
        app.ev=false
        apps.urlBack=''
        //panelAspectsBack.visible=false
        app.currentPlanetIndex=-1
        app.currentPlanetIndexBack=-1
        app.currentHouseIndex=-1
        app.currentHouseIndexBack=-1
        //sweg.objHousesCircle.currentHouse=-1
        //swegz.sweg.objHousesCircle.currentHouse=-1
        app.currentPlanetIndex=-1
        app.currentHouseIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)

        //r.aTexts[] reset
        let nATexts=[]
        for(var i=0;i<Object.keys(j.pc).length;i++){
            nATexts.push('')
        }
        r.aTexts=nATexts

        app.currentJson=j
        //-->ZoolMap
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        aspsCircle.load(j)
        //ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        ai.width=r.width
        zoolDataBodies.loadJson(j)
        zoolElementsView.load(j, false)
        panelAspects.load(j)
        //log.lv('Nakshatra length:'+nakshatraView.aNakshatra.length)
        //log.lv('Nakshatra index:'+nakshatraView.getIndexNakshatra(j.pc.c1.gdec))
        //log.lv('Nakshatra:'+nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec)))
        r.currentNakshatra=nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec))

        //resizeAspsCircle()
        //<--ZoolMap

        //ascMcCircle.loadJson(j)


        //dinHousesCircle.loadHouses(j)





        //eclipseCircle.arrayWg=housesCircle.arrayWg
        //eclipseCircle.isEclipse=-1
        //r.v=true
        /*let sabianos=zsm.getPanel('ZoolSabianos')
        sabianos.numSign=app.currentJson.ph.h1.is
        sabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
        sabianos.loadData()
        if(apps.sabianosAutoShow){
            //panelSabianos.state='show'
            zsm.currentIndex=1
        }*/
    }
    function loadSweJsonBack(json){
        if(!app.mod==='dirprim'){
            tapa.visible=true
            tapa.opacity=1.0
        }
        app.currentJsonBack=JSON.parse(json)
        //        if(app.dev)
        //            log.lv('ZoolBodies.loadSweJsonBack(json): '+json)
        //            log.lv('ZoolBodies.loadSweJsonBack(json) app.currentJsonBack: '+app.currentJsonBack)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        /*if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.mod!=='rs'){
            //panelElementsBack.load(j)
            zoolElementsView.load(j, true)
            //panelElementsBack.visible=true
            //Qt.quit()
        }else{
            //panelElementsBack.visible=false
        }*/

        //-->ZoolMap
        housesCircleBack.loadHouses(j)
        planetsCircleBack.loadJson(j)

        housesCircleBack.width=ae.width
        //ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
        //signCircle.width=ai.width
        //planetsCircle.width=ai.width
        ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        zoolDataBodies.loadJsonBack(j)
        r.currentNakshatraBack=nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec))
        //resizeAspsCircle()
        //<--ZoolMap

        //dinHousesCircleBack.loadHouses(j)

        //if(app.mod==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))

        //        if(app.mod==='dirprim'){
        //            log.lv('is dirprim')
        //        }

        //panelDataBodiesV2.loadJson(j)

        //app.backIsSaved=isSaved
        //if(app.dev)log.lv('sweg.loadSweJsonBack() isSaved: '+isSaved)
        app.ev=true
        if(!app.mod==='dirprim')centerZoomAndPos()
    }
    function loadFromFileBack(filePath, tipo){
        tapa.visible=true
        tapa.opacity=1.0
        let jsonFileData=unik.getFile(filePath)
        let j=JSON.parse(jsonFileData).params
        let t=tipo
        let hsys=j.hsys?j.hsys:apps.currentHsys
        let nom=j.n
        let d=j.d
        let m=j.m
        let a=j.a
        let h=j.h
        let min=j.min
        let gmt=j.gmt
        let lat=j.lat
        let lon=j.lon
        let alt=j.alt?j.alt:0
        let ciudad=j.ciudad
        let e='1000'
        let aR=[]
        app.mod=tipo
        app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, e, t, hsys, -1, aR)
    }
    //<--Load Data

    function resizeAspsCircle(isBack){
        if(!isBack){
            if(apps.showDec){
                //log.lv('1 resizeAspsCircle('+isBack+') apps.showDec: '+apps.showDec)
                ca.d=planetsCircle.getMinAsWidth()-r.planetSize//*2
            }else{
                //log.lv('2 resizeAspsCircle('+isBack+') apps.showDec: '+apps.showDec)
                ca.d=planetsCircle.getMinAsWidth()-r.planetSize-r.objSignsCircle.w*2
            }
        }
        if(isBack && r.ev){
            ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
            ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        }
    }
    function hideTapa(){
        tapa.opacity=0.0
    }

    //-->ZoomAndPan
    function centerZoomAndPos(){
        pinchArea.m_x1 = 0
        pinchArea.m_y1 = 0
        pinchArea.m_x2 = 0
        pinchArea.m_y2 = 0
        pinchArea.m_zoom1 = 1.0
        pinchArea.m_zoom2 = 1.0
        rect.x = 0
        rect.y = 0
    }
    function zoomTo(z){
        centerZoomAndPos()
        pinchArea.m_zoom1 = z
        pinchArea.m_zoom2 = z
    }
    function setZoomAndPos(zp){
        r.uZp=zp
        pinchArea.m_x1 = zp[0]
        pinchArea.m_y1 = zp[1]
        pinchArea.m_x2 = zp[2]
        pinchArea.m_y2 = zp[3]
        pinchArea.m_zoom1 = zp[4]
        pinchArea.m_zoom2 = zp[5]
        rect.x = zp[6]
        rect.y = zp[7]
        if(zp[8]){
            app.currentXAs.objOointerPlanet.pointerRot=zp[8]
        }
    }
    function getZoomAndPos(){
        let a = []
        a.push(parseFloat(pinchArea.m_x1).toFixed(2))
        a.push(parseFloat(pinchArea.m_y1).toFixed(2))
        a.push(parseFloat(pinchArea.m_x2).toFixed(2))
        a.push(parseFloat(pinchArea.m_y2).toFixed(2))
        a.push(parseFloat(pinchArea.m_zoom1).toFixed(2))
        a.push(parseFloat(pinchArea.m_zoom2).toFixed(2))
        a.push(parseInt(rect.x))
        a.push(parseInt(rect.y))
        a.push(parseInt(app.currentXAs.uRot))
        return a
    }
    //<--ZoomAndPan

    function getAPD(isBack){
        return !isBack?planetsCircle.getAPD():planetsCircleBack.getAPD()
    }
    function getIndexSign(gdec){
        let index=0
        let g=0.0
        for(var i=0;i<12+5;i++){
            g = g + 30.00
            if (g > parseFloat(gdec)){
                break
            }
            index = index + 1
        }
        return index
    }
    function convertDDToDMS(D, lng) {
      return {
        dir: D < 0 ? (lng ? "W" : "S") : lng ? "E" : "N",
        deg: 0 | (D < 0 ? (D = -D) : D),
        min: 0 | (((D += 1e-9) % 1) * 60),
        sec: (0 | (((D * 60) % 1) * 6000)) / 100,
      };
    }
    function getDDToDMS(D) {
      return {
        deg: 0 | (D < 0 ? (D = -D) : D),
        min: 0 | (((D += 1e-9) % 1) * 60),
        sec: (0 | (((D * 60) % 1) * 6000)) / 100,
      };
    }
    function getAspType(g1, g2, showLog, index, indexb, pInt, pExt){
        let ret=-1

        //Prepare Grado de Margen de Conjunción
        let gmcon1=parseFloat(g2 - 0.25)
        let gmcon2=parseFloat(g2 + 0.25)
        //Conjunción
        if(g1 >= gmcon1 && g1 <= gmcon2 ){
            ret=0
            return ret
        }

        //Prepare Grado de Oposición
        let gop=parseFloat( parseFloat(g1) + 180.00)
        if(gop>=360.00)gop=parseFloat(360.00-gop)
        if(gop<0)gop=Math.abs(gop)
        //if(showLog)log.lv('g1:'+g1+'\ngop: '+gop)
        //Oposición
        if(g1 >= gop-0.25 && g1 <= gop+0.25 ){
            ret=1
            return ret
        }

        //Prepare Grado de Cuadratura
        let gcu=parseFloat( parseFloat(g1) + 90.00)
        if(gcu>=360.00)gcu=parseFloat(360.00-gcu)
        if(gcu<0)gcu=Math.abs(gcu)
        let gmcua1=parseFloat(gcu - 0.25)
        let gmcua2=parseFloat(gcu + 0.25)

        let gcu2=parseFloat( parseFloat(g1) - 90.00)
        if(gcu2>=360.00)gcu2=parseFloat(360.00-gcu2)
        if(gcu2<0)gcu2=Math.abs(gcu2)
        let gmcua3=parseFloat(gcu2 - 0.25)
        let gmcua4=parseFloat(gcu2 + 0.25)
        //if(showLog && indexb === 6 && pInt==='Sol')log.lv('pInt '+pInt+':'+g1+'\npExt '+pExt+': g2:'+g2+' gcu: '+gcu+'\ngmcua1: '+gmcua1+'\ngmcua2: '+gmcua2)
        //Cuadratura
        if((g2 >= gmcua1 && g2 <= gmcua2) || (g2 >= gmcua3 && g2 <= gmcua4)){
            ret=2
            return ret
        }
        return ret
    }
}
