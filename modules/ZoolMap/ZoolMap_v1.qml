import QtQuick 2.7
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS

import ZoolMap.ZoolMapSignCircle 1.0
import ZoolMap.ZoolMapHousesCircle 1.0
import ZoolMap.ZoolMapPlanetsCircle 1.0
import ZoolMap.ZoolMapAspsCircle 1.0

Item{
    id: r
    height: parent.height-app.fs*0.25
    width: height
    anchors.centerIn: parent

    property alias objSignCircle: signCircle
    property alias objHousesCircle: housesCircle


    property bool showZonas: true

    property bool ev: app.ev
    property int zodiacBandWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumMargin: app.fs*0.25
    property int planetSize: !r.ev?app.fs:app.fs*0.75
    property int planetsPadding: app.fs*8
    property int planetsMargin: app.fs*0.15
    property int aspsCircleWidth: 100
    property int planetsBackBandWidth: 100

    property int planetsAreaWidth: 100
    property int planetsAreaWidthBack: 100

    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
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
    property color bodieBgColor: apps.backgroundColor
    //<--Theme

    property var aTexts: []

    onVisibleChanged: {
        if(visible){
            return
            let jsonFileData=unik.getFile('/home/ns/gd/Zool/Natalia_S._Pintos.json')
            let j=JSON.parse(jsonFileData).params
            //if(app.dev)log.lv('loadAsSin(\n'+fileName+')\n'+JSON.stringify(j, null, 2))

            let t='sin'
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
            app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, e, t, hsys, -1, aR)
        }
    }
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
                property real m_zoom1: 0.5
                property real m_zoom2: 0.5
                property real m_max: 6
                property real m_min: 0.5

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
                    visible: signCircle.v
                }
                //BackgroundImages{id: backgroundImages}
                Rectangle{
                    id: xz
                    anchors.fill: parent
                    color: 'transparent'
                    Circle{
                        id:ae
                        d: r.ev?r.width:0
                        c: 'transparent'
                        property int w: 100
                    }
                    Circle{
                        id:ai
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
                ZoolMapSignCircle{id: signCircle; width: ai.width-r.housesNumWidth*2-r.housesNumMargin*2;}
                ZoolMapHousesCircle{id: housesCircle; width: ai.width; z:ai.z+1}
                //ZoolMapHousesCircle{id: housesCircleBack; width: z0.width; isBack: true; visible: r.ev}
                ZoolMapHousesCircle{id: housesCircleBack; width: ai.width}
                ZoolMapAspsCircle{id: aspsCircle;width:ca.width; z:ai.z+3;}
                ZoolMapPlanetsCircle{id: planetsCircle; width: signCircle.width-signCircle.w*2; z: ai.z+4}
                ZoolMapPlanetsCircle{id: planetsCircleBack; width: ae.width-r.housesNumWidth*2-r.housesNumMargin*2; z:ai.z+5; isBack: true;}
                /*ZoolHousesCircleBack{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id: housesCircleBack
                    height: width
                    anchors.centerIn: signCircle
                    w: r.fs
                    widthAspCircle: aspsCircle.width
                    visible: false//app.ev
                    //visible: planetsCircleBack.visible
                }
                ZoolHousesCircle{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircle
                    height: width
                    anchors.centerIn: signCircle
                    //w: r.fs*6
                    widthAspCircle: aspsCircle.width
                    visible:false
                    //visible: r.v
                }
                AxisCircle{id: axisCircle;visible: !app.ev}

                ZoolSignCircle{
                    id:signCircle
                    showBorder: true
                    onRotChanged: housesCircle.rotation=rot
                }
                ZoolDinHousesCircle{id: dinHousesCircleBack; isBack: true}
                ZoolDinHousesCircle{id: dinHousesCircle}
                NumberLines{}
                AspCircleV2{
                    id: aspsCircle
                    rotation: signCircle.rot - 90// + 1
                }
                //AscMcCircle{id: ascMcCircle;visible: !app.ev}
                AscMcCircle{id: ascMcCircle;visible: false}
                ZoolPlanetsCircle{
                    id: planetsCircle
                    height: width
                    anchors.centerIn: parent
                    //showBorder: true
                    //v:r.v
                }
//                PlanetsCircleBack{
//                    id:planetsCircleBack
//                    height: width
//                    anchors.centerIn: parent
//                    visible: app.ev
//                }
                ZoolPlanetsCircleBack{
                    id:planetsCircleBack
                    height: width
                    anchors.centerIn: parent
                    visible: app.ev
                }
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
        ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        //resizeAspsCircle()
        //<--ZoolMap

        //ascMcCircle.loadJson(j)


        //dinHousesCircle.loadHouses(j)

        //panelAspects.load(j)
        //zoolDataBodies.loadJson(j)

        //zoolElementsView.load(j, false)
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
        //console.log('JSON::: '+json)
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
        ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
        //signCircle.width=ai.width
        //planetsCircle.width=ai.width
        ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2

        //resizeAspsCircle()
        //<--ZoolMap

        //dinHousesCircleBack.loadHouses(j)

        //if(app.mod==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))

        //        if(app.mod==='dirprim'){
        //            log.lv('is dirprim')
        //        }
        //zoolDataBodies.loadJsonBack(j)
        //panelDataBodiesV2.loadJson(j)

        //app.backIsSaved=isSaved
        //if(app.dev)log.lv('sweg.loadSweJsonBack() isSaved: '+isSaved)
        app.ev=true
        //centerZoomAndPos()
    }
    function resizeAspsCircle(){
        let w2=((ae.widt-planetsCircleBack.getMinAsWidth())/2)-r.planetSize*2
        ae.w=parseInt(w2)
        log.lv('ae.w='+ae.w)
        //ai.width=ae.width-ae.w*2
        /*let w=0
        w=planetsCircle.getMinAsWidth()-r.planetSize*2
        width=w*/
    }

    //-->ZoomAndPan
    function centerZoomAndPos(){
        pinchArea.m_x1 = 0
        pinchArea.m_y1 = 0
        pinchArea.m_x2 = 0
        pinchArea.m_y2 = 0
        pinchArea.m_zoom1 = 0.5
        pinchArea.m_zoom2 = 0.5
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
}
