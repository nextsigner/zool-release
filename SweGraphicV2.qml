import QtQuick 2.7
import QtQuick.Controls 2.12
import "Funcs.js" as JS
import "./comps" as Comps

Item {
    id: r
    width: !app.ev?
               parent.height*apps.sweMargin-app.fs*6:
               //app.fs*30
               housesCircleBack.width-housesCircleBack.extraWidth-fs
    height: width
    //anchors.centerIn: parent
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.horizontalCenterOffset: sweg.fs
    //clip: true
    property bool zoomAndPosCentered: pinchArea.m_x1===0 && pinchArea.m_y1===0 && pinchArea.m_y2===0 && pinchArea.m_x2===0 && pinchArea.m_zoom1===0.5 && pinchArea.m_zoom2===0.5 && pinchArea.m_max===6 && pinchArea.m_min===0.5
    property real xs: scaler.xScale
    property real z1: pinchArea.m_zoom1
    property var uZp

    property int  verticalOffSet: 0//xDataBar.state==='show'?sweg.fs*1.25:0
    property int fs: r.objectName==='sweg'?apps.sweFs*1.5:apps.sweFs*3
    property int w: apps.signCircleWidth//fs
    property bool v: false
    property alias expand: planetsCircle.expand
    property alias objAspsCircle: aspsCircle
    property alias objPlanetsCircle: planetsCircle
    property alias objHousesCircle: housesCircle
    property alias objHousesCircleBack: housesCircleBack
    property alias objSignsCircle: signCircle
    property alias objAscMcCircle: ascMcCircle
    property alias objEclipseCircle: eclipseCircle
    property int speedRotation: 1000
    property var aStates: ['ps', 'pc', 'pa']
    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
    property string currentHsys: apps.currentHsys

    property bool enableAnZoomAndPos: true

    property var jsonStandByForBack

    state: apps.swegMod//aStates[0]
    states: [
        State {//PS
            name: aStates[0]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(12 +6):r.fs*(12 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*2:sweg.width-sweg.fs*2-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        },
        State {//PC
            name: aStates[1]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(15 +6):r.fs*(15 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*6:sweg.width-sweg.fs*6-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        },
        State {//PA
            name: aStates[2]
            PropertyChanges {
                target: r
                //width: app.ev?r.fs*(12 +6):r.fs*(12 +10)
            }
            PropertyChanges {
                target: signCircle
                width: !housesCircleBack.visible?sweg.width-sweg.fs*2:sweg.width-sweg.fs*2-housesCircleBack.extraWidth*2
            }
            PropertyChanges {
                target: planetsCircle
                width: signCircle.width-signCircle.w
            }
        }
    ]

    onStateChanged: {
        //swegz.sweg.state=state
        apps.swegMod=state
    }
    onEnableAnZoomAndPosChanged: {
        tEnableAnZoomAndPos.restart()
    }
    Behavior on opacity{NumberAnimation{duration: 1500}}
    Behavior on verticalOffSet{NumberAnimation{duration: app.msDesDuration}}
    Item{id: xuqp}
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
                        onClicked: {
                            apps.zFocus='xMed'
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
                BackgroundImages{id: backgroundImages}
                Comps.HouseCircleBack{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircleBack
                    height: width
                    anchors.centerIn: signCircle
                    w: r.fs
                    widthAspCircle: aspsCircle.width
                    visible: app.ev
                    //visible: planetsCircleBack.visible
                }
                Comps.HouseCircle{//rotation: parseInt(signCircle.rot);//z:signCircle.z+1;
                    id:housesCircle
                    height: width
                    anchors.centerIn: signCircle
                    //w: r.fs*6
                    widthAspCircle: aspsCircle.width
                    //visible: r.v
                }
                AxisCircle{id: axisCircle}
                NumberLines{}
                Comps.SignCircle{
                    id:signCircle
                    //width: planetsCircle.expand?r.width-r.fs*6+r.fs*2:r.width-r.fs*6
                    anchors.centerIn: parent
                    showBorder: true
                    v:r.v
                    w: r.w
                    onRotChanged: housesCircle.rotation=rot
                    //onShowDecChanged: Qt.quit()
                }
                AspCircleV2{
                    id: aspsCircle
                    rotation: signCircle.rot - 90// + 1
                }
                AscMcCircle{id: ascMcCircle}
                PlanetsCircle{
                    id:planetsCircle
                    height: width
                    anchors.centerIn: parent
                    //showBorder: true
                    //v:r.v
                }
                PlanetsCircleBack{
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
            }
        }
    }
    PanelAspects{
        id: panelAspects
        anchors.bottom: parent.bottom
        parent: xMed
        visible: r.objectName==='sweg'
    }
    PanelAspectsBack{
        id: panelAspectsBack
        anchors.top: parent.top
        //anchors.topMargin: 0-(r.parent.height-r.height)/2
        parent: xMed
        anchors.left: parent.left
        anchors.leftMargin: width
        transform: Scale{ xScale: -1 }
        rotation: 180
        visible: r.objectName==='sweg'&&planetsCircleBack.visible
    }
    //    Rectangle{
    //        color: 'red'
    //        border.color: 'blue'
    //        border.width: 10
    //        anchors.fill: parent
    //    }
    Rectangle{
        //Este esta en el centro
        visible: false
        opacity: 0.5
        width: r.fs*2//planetsCircle.children[0].fs*0.85+4
        height: width
        color: 'red'
        radius: width*0.5
        border.width: 2
        border.color: 'white'
        anchors.centerIn: parent
    }
    Timer{
        id: tLoadSin
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            let j=JSON.parse(app.fileData)
            //app.fileDataBack=JSON.stringify(j.paramsBack)
            let njson=JSON.parse('{}')
            njson.params=j.paramsBack
            JS.loadJsonFromParamsBack(njson)
            //loadSweJsonBack(j)
            //log.l(JSON.stringify(j.paramsBack))
            //log.visible=true
            //loadBack(current)
        }
    }
    Timer{
        id: tFirtShow
        running: false
        repeat: false
        interval: 2000
        onTriggered: r.opacity=1.0
    }
    //    Rectangle{
    //        width: app.fs*6
    //        height: width
    //        anchors.centerIn: parent
    //        Text{
    //            id: ihr
    //            font.pixelSize: app.fs*2
    //            anchors.centerIn: parent
    //        }
    //    }
    function loadSign(j){
        aspsCircle.clear()
        console.log('Ejecutando SweGraphic.loadSign()...')
        //unik.speak('load sign')
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(3000)
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
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData).replace(/\\n/g, \'\')\n'
        c+='        app.currentJsonSignData=JSON.parse(json)\n'
        c+='        panelControlsSign.loadJson(app.currentJsonSignData)\n'
        c+='        app.mod="pl"\n'
        //c+='        if(panelZonaMes.state===\'show\')panelZonaMes.play()\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+unik.currentFolderPath()+'\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_asc_aries.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+unik.currentFolderPath()+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodesign')
    }
    function load(j){
        //console.log('Ejecutando SweGraphic.load()...')
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
        let hsys=apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //console.log(\'JSON: \'+json)\n'
        c+='        loadSweJson(json)\n'
        c+='        //swegz.sweg.loadSweJson(json)\n'
        if((j.params.tipo==='rs' && j.paramsBack) || j.params.tipo==='sin' && j.paramsBack){
                r.jsonStandByForBack=j.paramsBack
                //log.ls('r.jsonStandByForBack:'+JSON.stringify(r.jsonStandByForBack), 0, 500)
                c+='        loadBackFromStandBy()\n'
        }
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'sweg.load() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
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
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //console.log(\'JSON Back: \'+json)\n'
        c+='        loadSweJsonBack(json)\n'
        c+='        //swegz.sweg.loadSweJsonBack(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'sweg.loadBack() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
    }
    function loadBackFromStandBy(){
        //console.log('Ejecutando SweGraphic.load()...')
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let j=r.jsonStandByForBack
        let vd=j.d
        let vm=j.m
        let va=j.a
        let vh=j.h
        let vmin=j.min
        let vgmt=j.gmt
        let vlon=j.lon
        let vlat=j.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
        if(j.hsys)hsys=j.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //console.log(\'JSON Back: \'+json)\n'
        c+='        loadSweJsonBack(json)\n'
        c+='        //swegz.sweg.loadSweJsonBack(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'sweg.loadBack() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        aspsCircle.clear()
        panelRsList.clear()
        //planetsCircleBack.visible=false
        app.ev=false
        apps.urlBack=''
        panelAspectsBack.visible=false
        sweg.objHousesCircle.currentHouse=-1
        //swegz.sweg.objHousesCircle.currentHouse=-1
        app.currentPlanetIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)
        app.currentJson=j
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        //r.earth.rotation=0-(signCircle.rot+parseFloat(j.pc.c0.gdec).toFixed(2))
        //r.earth.rotation=(0-120)-(signCircle.rot)+parseFloat(j.pc.c0.gdec).toFixed(2)
        ascMcCircle.loadJson(j)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        //planetsCircleBack.loadJson(j)
        panelAspects.load(j)
        panelDataBodies.loadJson(j)
        aspsCircle.load(j)
        panelElements.load(j)
        eclipseCircle.arrayWg=housesCircle.arrayWg
        eclipseCircle.isEclipse=-1
        //if(app.mod!=='rs'&&app.mod!=='pl'&&panelZonaMes.state!=='show')panelRsList.setRsList(61)
        r.v=true
        //apps.enableFullAnimation=true
        //let j=JSON.parse(app.fileData)
        if(j.params.tipo==='sin'){
            tLoadSin.start()
        }
        tFirtShow.start()        
        panelSabianos.numSign=app.currentJson.ph.h1.is
        panelSabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
        panelSabianos.loadData()
        if(apps.sabianosAutoShow){
            //panelSabianos.state='show'
            sv.currentIndex=1
        }
        centerZoomAndPos()
        //panelAspTransList.state='hide'
        //        } catch(e) {
        //            //alert(e); // error in the above string (in this case, yes)!
        //            JS.showMsgDialog('Error de carga', 'Hay un error en la carga de los datos.', 'Error SweGraphic::loadSweJson(json)')
        //        }
    }
    function loadSweJsonBack(json){
        //console.log('JSON::: '+json)
        app.currentJsonBack=JSON.parse(json)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.mod!=='rs'){
            panelElementsBack.load(j)
            //panelElementsBack.visible=true
            //Qt.quit()
        }else{
            //panelElementsBack.visible=false
        }
        housesCircleBack.loadHouses(j)
        planetsCircleBack.loadJson(j)
        panelDataBodies.loadJsonBack(j)
        //panelDataBodiesV2.loadJson(j)
        app.ev=true
        centerZoomAndPos()
    }
    function nextState(){
        let currentIndexState=r.aStates.indexOf(r.state)
        if(currentIndexState<r.aStates.length-1){
            currentIndexState++
        }else{
            currentIndexState=0
        }
        r.state=r.aStates[currentIndexState]
        //swegz.sweg.state=r.state
    }
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
        return a
    }
}
