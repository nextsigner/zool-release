import QtQuick 2.7
import QtQuick.Controls 2.12
import comps.MouseAreaView 1.0

import ZoolMap.ZoolMapSignCircle 1.1
import ZoolMap.ZoolMapHousesCircle 1.2
import ZoolMap.ZoolMapPlanetsCircle 1.1
import ZoolMap.ZoolMapAspsCircle 1.2
import ZoolMap.ZoolMapAspsView 1.0
import ZoolMap.ZoolMapAspsViewBack 1.0
import ZoolMap.ZoolMapAsInfoView 1.0
import ZoolElementsView 1.0
import ZoolMap.NumberLines 2.0

import ZoolMap.ZoolMapNakshatraView 1.0

import ZoolMap.ZoolMultiCap 2.0


Rectangle{
    id: r
    height: parent.height-app.fs*0.25
    width: height
    anchors.centerIn: parent
    border.width: xZoolMap.showDevLines?50:0
    border.color: xZoolMap.showDevLines?'#8833ff':'transparent'
    color: xZoolMap.showDevLines?'#8f8faa':'transparent'
    opacity: tapa.opacity
    //anchors.horizontalCenterOffset: 0-r.width*0.5
    //anchors.verticalCenterOffset: 0-r.width*0.5
    //clip: true
    /*MouseAreaView{
        width: xMed.width//*0.5
        height: xMed.height//*0.75
        v:2
        bw:30
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: r.width*0.5
        anchors.verticalCenterOffset: r.width*0.5
    }*/

    property bool previewEnabled: false

    property string lastAspShowed: 'int'

    property alias xzm: xSweg

    property alias cm: capaMods
    //property alias anv: aspNameView
    property alias oc: centro
    property alias objTapa: tapa
    property alias objTRAC: tResizeAspCircle
    property alias objSignsCircle: signCircle
    property alias objHousesCircle: housesCircle
    property alias objHousesCircleBack: housesCircleBack
    property alias objPlanetsCircle: planetsCircle
    property alias objPlanetsCircleBack: planetsCircleBack
    property alias objCA: ca
    property alias objAspsCircle: aspsCircle
    property alias objAspsCircleBack: aspsCircleBack
    property alias objZoolAspectsView: panelAspects
    property alias objZoolAspectsViewBack: panelAspectsBack
    property alias objAsInfoView: zoolMapAsInfoView

    property alias zev: zoolElementsView
    property alias zmc: zoolMultiCap


    property bool showZonas: true

    property bool isDataDiff: false
    property bool ev: false
    property bool lockEv: false
    property int zodiacBandWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumWidth: !r.ev?app.fs:app.fs*0.75
    property int housesNumMargin: app.fs*0.25
    property int fs: app.fs
    property var aSigns: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var aSignsLowerStyle: ['aries', 'tauro', 'geminis', 'cancer', 'leo', 'virgo', 'libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property var aBodiesFiles: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property int planetSize: !r.ev?app.fs*1.5:app.fs
    property real planetsSep: 1.25
    property int planetsPadding: app.fs*8
    property int planetsMargin: app.fs*0.15
    property int aspsCircleWidth: 100
    property int planetsBackBandWidth: 100

    property int planetsAreaWidth: 100
    property int planetsAreaWidthBack: 100
    property string folderImg: u.getPath(5)+'/modules/ZoolBodies/ZoolAs/imgs_v1'

    property color backgroundColor: enableBackgroundColor?apps.backgroundColor:'transparent'
    property bool enableBackgroundColor: apps.enableBackgroundColor
    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1

    property int currentHouseIndex: 0
    property int currentHouseIndexBack: 0

    property var aHouseShowed: []

    property int currentSignIndex: 0

    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1

    property bool loadingJsonInt: false
    property bool loadingJsonExt: false
    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack

    property date currentDate
    property date currentDateBack
    property string currentNom: ''
    property string currentNomBack: ''
    property string currentGenero: 'n'
    property string currentGeneroBack: 'n'
    property string currentFecha: ''
    property string currentFechaBack: ''
    property string currentLugar: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolar: -1
    property int currentGradoSolarBack: -1
    property int currentRotationxAsSol: -1
    property int currentRotationxAsSolBack: -1
    property int currentMinutoSolar: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolar: -1
    property int currentSegundoSolarBack: -1
    property real currentGmt: 0
    property real currentGmtBack: 0
    property real currentLon
    property real currentLonBack
    property real currentLat
    property real currentLatBack
    property real currentAlt: 0
    property real currentAltBack: 0

    property int currentIndexSign: -1
    property int currentIndexSignBack: -1
    property string currentNakshatra: ''
    property string currentNakshatraBack: ''
    property string currentHsys: apps.currentHsys

    property string uAspShow: 'int_red'
    property bool aspShowSelected: false

    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property bool enableAnZoomAndPos: true
    property bool isMultiCapturing: false
    property bool isMultiCapturingPlanets: false
    property bool capturing: false

    property var listCotasShowing: []
    property var listCotasShowingBack: []

    property bool enableLoad: true
    property bool enableLoadBack: true

    property int maxAbsPosInt: 1
    property int maxAbsPosExt: 1
    property real dirPrimRot: 0.00

    property int ejeTipoCurrentIndex: -2
    property bool automatic: false
    property bool safeTapa: false
    property bool pointerRotToCenter: false

    //-->ZoomAndPan
    property bool zoomAndPosCentered: pinchArea.m_x1===0 && pinchArea.m_y1===0 && pinchArea.m_y2===0 && pinchArea.m_x2===0 && pinchArea.m_zoom1===0.5 && pinchArea.m_zoom2===0.5 && pinchArea.m_max===6 && pinchArea.m_min===0.5
    property real xs: scaler.xScale
    property real z1: pinchArea.m_zoom1
    property var uZp
    property real uMouseX: 0.0
    property real uMouseY: 0.0
    //<--ZoomAndPan

    //-->Theme
    property string themeName: 'Zool'
    property var aSignsColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6']
    property color bodieColor: apps.fontColor
    property color bodieColorBack: apps.fontColor
    property color bodieBgColor: 'transparent'
    property color bodieBgColorBack: 'transparent'
    property int bodieBgBorderWidth: 0
    property int bodieBgBorderWidthBack: 0
    property color bodieBgBorderColor: "white"
    property color bodieBgBorderColorBack: "white"
    property color houseLineColor: 'white'
    property color houseLineColorBack: '#00ff00'
    property bool showSignsCircleColors: true
    property color iconSignColor: "white"
    property color borderSignColor: "white"
    property int borderSignCircleWidth: 2
    property color pointerBgColor:"#FFFFFF"
    property color pointerFontColor:"red"
    property int pointerBorderWidth:3
    property color pointerBorderColor:"#FF0000"
    //<--Theme

    property var aTexts: []
    property alias rectXBackItems: xBackItems
    onVisibleChanged: {
        if(visible){
            centerZoomAndPos()
            //return
            let filePath='/home/ns/gd/Zool/Natalia_S._Pintos.json'
            loadFromFile(filePath, 'sin', true)
        }
    }
    onAutomaticChanged: {
        if(automatic){
            tAutoMaticPlanets.currentJsonData=zm.currentData
        }else{
            centerZoomAndPos()
        }
    }
    onCurrentPlanetIndexChanged: {
        zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>=0){
            zm.currentPlanetIndexBack=-1
            zm.currentHouseIndexBack=-1
        }
        if(sspEnabled){
            if(currentPlanetIndex>=-1&&currentPlanetIndex<10){
                app.ip.opacity=1.0
                app.ip.children[0].ssp.setPlanet(currentPlanetIndex)
            }else{
                app.ip.opacity=0.0
            }
        }
        //zoolDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>14){
            /*if(currentPlanetIndex===20){
                sweg.objHousesCircle.currentHouse=1
                swegz.sweg.objHousesCircle.currentHouse=1
            }
            if(currentPlanetIndex===16){
                sweg.objHousesCircle.currentHouse=10
                swegz.sweg.objHousesCircle.currentHouse=10
            }*/
        }
    }
    onCurrentPlanetIndexBackChanged: {
        zoolDataBodies.currentIndexBack=currentPlanetIndexBack
        /*if(currentPlanetIndexBack>=0){
            zm.currentPlanetIndex=-1
            zm.currentHouseIndex=-1
        }*/
    }
    onCurrentGmtChanged: {
        //if(zm.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    /*onCurrentGmtBackChanged: {
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmtBack
        tReloadBack.restart()
    }*/
    onCurrentDateChanged: {
        //controlsTime.setTime(currentDate)
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.state='show'
        let a=currentDate.getFullYear()
        let m=currentDate.getMonth()
        let d=currentDate.getDate()
        let h=currentDate.getHours()
        let min=currentDate.getMinutes()
        //xDataBar.currentDateText=d+'/'+parseInt(m + 1)+'/'+a+' '+h+':'+min
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    //    onCurrentDateBackChanged: {
    //        controlsTimeBack.setTime(currentDateBack)
    //        if(app.t==='trans'){
    //            app.j.loadTransFromTime(app.currentDateBack)
    //        }
    //        //xDataBar.state='show'
    //        let a=currentDateBack.getFullYear()
    //        let m=currentDateBack.getMonth()
    //        let d=currentDateBack.getDate()
    //        let h=currentDateBack.getHours()
    //        let min=currentDateBack.getMinutes()
    //        tReloadBack.restart()
    //    }
    onDirPrimRotChanged: {
        if(app.t==='dirprim'){
            planetsCircleBack.rotation=planetsCircle.rotation-dirPrimRot
            housesCircleBack.rotation=360-dirPrimRot
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
    MouseAreaView{
        id: dragAreaBack
        hoverEnabled: true
        drag.target: rect
        drag.filterChildren: true
        width: xMed.width//*0.5
        height: xMed.height//*0.75
        v:0
        bw:30
        acceptedButtons: Qt.AllButtons;
        //anchors.centerIn: parent
        //anchors.horizontalCenterOffset: r.width*0.5
        //anchors.verticalCenterOffset: r.width*0.5
        onClicked: {
            click(mouse)
        }
        onDoubleClicked: {
            doubleClick(mouse)
        }
    }
    function click(mouse){
        apps.zFocus='xMed'

        if (mouse.button === Qt.LeftButton   && (mouse.modifiers & Qt.ControlModifier)) {
            apps.xAsShowIcon=!apps.xAsShowIcon
        }else{
            if (mouse.button === Qt.RightButton) {

                //menuRuedaZodiacal.uX=mouseX
                //menuRuedaZodiacal.uY=mouseY
                //menuRuedaZodiacal.isBack=false
                menuRuedaZodiacal.popup()
            }else{
                //apps.xAsShowIcon=!apps.xAsShowIcon
            }
        }
    }
    function doubleClick(mouse){
        centerZoomAndPos()
    }
    Item{
        id: xBackItems
        width: 100
        height: 100
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: r.width*0.5
        anchors.verticalCenterOffset: r.height*0.5
        //visible: false
        ZoolMapAspsView{
            id: panelAspects
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: xLatIzq.visible?0:0-xLatIzq.width
            parent: xMed
            //visible: false
            //visible: r.objectName==='sweg'
        }
        ZoolMapAspsViewBack{
            id: panelAspectsBack
            anchors.top: parent.top
            anchors.topMargin: !apps.showAspPanelBack?0:height*0.5-(app.fs)
            parent: xMed
            anchors.left: parent.left
            anchors.leftMargin: xLatIzq.visible?width:width-xLatIzq.width
            transform: Scale{ xScale: -1 }
            rotation: 180
            visible: planetsCircleBack.visible
        }
    }
    //    Flickable{
    //        id: flick
    //        anchors.fill: parent
    Item{
        id: container
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 0-parent.width*0.5
        anchors.verticalCenterOffset: 0-parent.height*0.5
        Rectangle {
            id: rect
            border.width: 0
            width: r.width*2
            height: width
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
                Behavior on origin.x{enabled: !r.isMultiCapturing; NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on origin.y{enabled: !r.isMultiCapturing; NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on xScale{enabled: !r.isMultiCapturing; NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
                Behavior on yScale{enabled: !r.isMultiCapturing; NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            }
            Behavior on x{enabled: !r.isMultiCapturing; NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Behavior on y{enabled: !r.isMultiCapturing; NumberAnimation{duration: r.enableAnZoomAndPos?2500:1}}
            Timer{
                id: tReload
                running: false
                repeat: false
                interval: 100
                onTriggered: {
                    let j=getCurrentParamsWithNewTime(zm.currentDate)
                    j.params.gmt=r.currentGmt
                    r.safeTapa=true
                    r.load(j)
                }
            }
            Timer{
                id: tReloadBack
                running: false
                repeat: false
                interval: 100
                onTriggered: {
                    app.j.setNewTimeJsonFileDataBack(zm.currentDateBack)
                    app.j.runJsonTempBack()
                }
            }
            Timer{
                id: tUpdateGUI
                running: true
                repeat: true
                interval: 1000
                onTriggered: {
                    revIsDataDiff()
                    if(zm.ev){
                        r.maxAbsPosExt=planetsCircleBack.getMaxAsAbsPos()
                        //ai.width=r.width-(zm.planetSize*(r.maxAbsPosExt+1)*2)
                    }else{
                        //ai.d=r.width//-(zm.planetSize*(r.maxAbsPosExt+1)*2)
                    }
                    //housesCircle.wbgc=planetsCircle.getMinAsWidth()*0.5//-r.planetSize*2
                    //housesCircleBack.wbgc=signCircle.width//ai.width
                    //zm.objPlanetsCircle.vw=zm.objAspsCircle.width
                    if(app.t==='dirprim')housesCircleBack.width=ae.width
                    //log.lv('R:'+JSON.stringify(currentJson.pc.c0.gdec, null, 2))
                    //imgEarth.rotation=360-signCircle.rotation//currentJson.pc.c0.gdec--45
                }
            }
            PinchArea {
                id: pinchArea
                anchors.fill: parent

                property real m_x1: 0
                property real m_y1: 0
                property real m_y2: 0
                property real m_x2: 0
                property real m_zoom1: 1.0//0.5
                property real m_zoom2: 1.0//0.5
                property real m_max: 6
                property real m_min: 0.75//1.0//0.5

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
                MouseAreaView{
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: rect
                    drag.filterChildren: true
                    onWheel: {
                        let sent=wheel.angleDelta.y > 0
                        setZoom(sent, mouseX, mouseY)
                        let jsonNot={}
                        jsonNot.id='onWheel'
                        jsonNot.text='mouseX: '+mouseX+' xLatIzq.width: '+xLatIzq.width
                        //zpn.addNot(jsonNot, true, 20000)
                        r.uMouseX=mouseX
                        r.uMouseY=mouseY
                        /*return
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
                        */
                    }
                    acceptedButtons: Qt.AllButtons;
                    v:xZoolMap.showDevLines?2:0
                    bw:xZoolMap.showDevLines?10:0
                    bc: xZoolMap.showDevLin?'blue':'transparent'
                    bgc: '#ff8833'
                    onClicked: {
                        click(mouse)
                    }
                    onDoubleClicked: {
                        doubleClick(mouse)
                    }
                    Rectangle{
                        width: 4
                        height: parent.height*4
                        color: 'blue'
                        anchors.centerIn: parent
                        visible: xZoolMap.showDevLines
                        Rectangle{
                            width: parent.parent.width*4
                            height: 4
                            color: 'blue'
                            anchors.centerIn: parent
                        }
                    }
                    //                    MouseAreaView{
                    //                        anchors.fill: parent
                    //                        acceptedButtons: Qt.AllButtons;
                    //                        bgc: 'green'
                    //                        //z:parent.z-1
                    //                        onClicked: {
                    //                            apps.zFocus='xMed'
                    //                            if (mouse.button === Qt.RightButton) {

                    //                                //menuRuedaZodiacal.uX=mouseX
                    //                                //menuRuedaZodiacal.uY=mouseY
                    //                                //menuRuedaZodiacal.isBack=false
                    //                                menuRuedaZodiacal.popup()
                    //                            }
                    //                        }
                    //                        onDoubleClicked: {
                    //                            centerZoomAndPos()
                    //                        }
                    //                    }

                }
            }
            Item{
                id: xSweg
                width: r.width//*0.25
                height: width
                anchors.centerIn: parent
                //anchors.horizontalCenterOffset: 0-parent.width*0.25
                //anchors.verticalCenterOffset: 0-r.height//*0.15
                Rectangle{
                    id: bg
                    width: parent.width*10
                    height: width
                    color: backgroundColor
                    //visible: signCircle.v
                }
                //BackgroundImages{id: backgroundImages}
                ZoolMapAspsCircle{
                    id: aspsCircleBack
                    z: r.lastAspShowed==='ext'?aspsCircle.z+1:aspsCircle.z-1
                    isExt: true
                    width:ca.width
                    rotation: signCircle.rot - 90
                    opacity: r.lastAspShowed==='ext'?1.0:0.25
                }
                ZoolMapAspsCircle{
                    id: aspsCircle
                    width:ca.width
                    rotation: signCircle.rot - 90
                    opacity: r.lastAspShowed==='int'?1.0:0.25
                }
                Rectangle{
                    id: xz
                    anchors.fill: parent
                    color: 'transparent'
                    visible: false
                    Circle{
                        id: cc
                        d: zm.objAspsCircle.width
                        c: '#FF8833' //Esto se vera únicamente si el item de id:xz es visible.
                    }
                    Circle{
                        id:ae
                        d: r.ev?r.width:0
                        c: 'transparent'
                        property int w: 100
                    }
                    Circle{
                        id: ai
                        //d: !r.ev?r.width:ae.width-ae.w*2
                        d: !r.ev?r.width:r.width-(zm.planetSize*(r.maxAbsPosExt+1)*2)-zm.planetSize*2
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
                            d: 0//signCircle.width-(signCircle.w*2)-(zm.planetSize*(r.maxAbsPosInt+1)*2)//signCircle.width-(signCircle.w*2)-parent.w
                            color: 'transparent'//apps.backgroundColor
                            //onWidthChanged: aspsCircle.hideAndShow()
                        }
                    }

                    /*
                    Circle{
                        id: c100
                        d: signCircle.width-(signCircle.w*2)-(zm.planetSize*(r.maxAbsPosInt+1)*2)
                        c: 'red'
                        bc: 'yellow'
                        bw: 10
                        parent: signCircle
                        z: signCircle.z+1
                        SequentialAnimation on opacity{
                            running: true
                            loops: Animation.Infinite
                            ScriptAction{
                                script: c100.visible=true
                            }
                            PauseAnimation {
                                duration: 500
                            }
                            ScriptAction{
                                script: c100.visible=false
                            }
                            PauseAnimation {
                                duration: 500
                            }
                        }
                        Text{
                            text: ''+r.maxAbsPosInt
                            color: 'white'
                            font.pixelSize: app.fs*4
                            anchors.centerIn: parent
                        }
                    }
                    */

                    /*
                    Circle{
                        id: c101
                        d: r.width//signCircle.width-(signCircle.w*2)-(zm.planetSize*(r.maxAbsPosInt+1)*2)
                        c: 'red'
                        bc: 'yellow'
                        bw: 10
                        parent: signCircle
                        z: signCircle.z+1
                        SequentialAnimation on opacity{
                            running: true
                            loops: Animation.Infinite
                            ScriptAction{
                                script: c101.visible=true
                            }
                            PauseAnimation {
                                duration: 500
                            }
                            ScriptAction{
                                script: c101.visible=false
                            }
                            PauseAnimation {
                                duration: 500
                            }
                        }
                        Text{
                            text: ''+r.maxAbsPosInt
                            color: 'white'
                            font.pixelSize: app.fs*4
                            anchors.centerIn: parent
                        }
                    }
                    */
                }

                //ZoolMapHousesCircle{id: housesCircle; width: ai.width; z:ai.z+1}

                ZoolMapHousesCircle{id: housesCircleBack; width: ai.width; isExt: true}
                ZoolMapSignCircle{
                    id: signCircle
                    width: ai.width-r.housesNumWidth*2-r.housesNumMargin*2
                    onWidthChanged:{
                            aspsCircle.visible=false
                            tSetAspsCircleWidth.restart()
                    }
                    Timer{
                        id: tSetAspsCircleWidth
                        running: false
                        repeat: false
                        interval: 1000
                        onTriggered: {
                            //zm.resizeAspsCircle(r.isBack)
                            //zm.objTRAC.restart()
                            r.maxAbsPosInt=planetsCircle.getMaxAsAbsPos()
                            aspsCircle.visible=true
                            ca.d=signCircle.width-(signCircle.w*2)-(zm.planetSize*(r.maxAbsPosInt+1)*2)
                            zm.objTapa.opacity=1.0
                            zm.hideTapa()
                        }
                    }
                }

                //Container Grados
                Item{
                    id: xNL1
                    width: zm.objSignsCircle.width-(zm.zodiacBandWidth*2)
                    height: width
                    anchors.centerIn: parent
                    NumberLines{parent: apps.numberLinesMode===0?xNL1:xNL2; visible: apps.showNumberLines}
                }
                Rectangle{
                    id:bgPCB
                    width: planetsCircleBack.width
                    height: width
                    color: 'transparent'//r.bodieBgColorBack
                    radius: width*0.5
                    anchors.centerIn: parent
                    ZoolMapPlanetsCircle{id: planetsCircleBack; width: ae.width-r.housesNumWidth*2-r.housesNumMargin*2; z:ai.z+5; isBack: true; visible: r.ev}
                }
                Rectangle{
                    id:bgPC
                    width: signCircle.width
                    height: width
                    color: 'transparent'//r.bodieBgColor
                    radius: width*0.5
                    anchors.centerIn: parent
                    ZoolMapHousesCircle{id: housesCircle; width: ai.width; wbgc: ca.d}
                    ZoolMapPlanetsCircle{id: planetsCircle; width: signCircle.width-signCircle.w*2; z: ai.z+4;}
                }

                Item{
                    id: xNL2
                    width: zm.objSignsCircle.width-(zm.zodiacBandWidth*2)
                    height: width
                    anchors.centerIn: parent
                }
                ZoolMapNakshatraView{id: nakshatraView; width: ca.width; z: aspsCircle.z+1}
                Rectangle{
                    id: capaFront
                    width: parent.width
                    height: width
                    color: 'transparent'
                    border.width: 10
                    border.color: 'red'
                    visible: false
                    Rectangle{
                        id: ejeAbstractBodie
                        width: parent.width
                        height: 1
                        anchors.centerIn: parent
                        rotation: -30
                        Rectangle{
                            width: r.planetSize
                            height: width
                            radius: width*0.5
                            color: 'blue'
                            anchors.verticalCenter: parent.verticalCenter
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    //var globalCoordinates = parent.mapToGlobal(parent.x-parent.width*0.5, parent.y-parent.height*0.5)
                                    //var mouseP = Qt.point();
                                    //var mapped =
                                    var globalCoordinates = parent.mapToItem(capaFront, parent.x, parent.y);
                                    let s="X: " + globalCoordinates.x + " y: " + globalCoordinates.y
                                    let nx= globalCoordinates.x+25
                                    let ny= globalCoordinates.y-25
                                    s+='\nnx:'+nx+'\nny:'+ny
                                    zm.objAsInfoView.text=s
                                    zm.setPos(nx, ny, ejeAbstractBodie.rotation)
                                }
                            }
                        }
                    }
                }
                /*Rectangle{
                    id: aspNameView
                    width: aspNameText.contentWidth+app.fs*0.25
                    height: aspNameText.contentHeight+app.fs*0.25
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    radius: app.fs*0.1
                    anchors.centerIn: parent
                    property string n: ''
                    opacity: n===''?0.0:1.0
                    Text{
                        id: aspNameText
                        text:'<b>'+parent.n+'</b>'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        anchors.centerIn: parent
                    }
                }*/
                Item{
                    id: capaMods
                    anchors.fill: parent
                }
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

            Rectangle{
                id: centro
                width: 1
                height: width
                anchors.centerIn: parent
            }

        }

    }
    Rectangle{
        id: xFrontItems
        //anchors.fill: xBackItems
        border.width: xZoolMap.showDevLines?50:0
        color: xZoolMap.showDevLines?'white':'transparent'
        border.color: 'red'
        width: xMed.width
        height: r.height
        anchors.centerIn: parent
        Rectangle{
            anchors.fill: parent
            color: 'black'
            visible: zev.zoom===5.0
        }
        Text{
            text: 'xFrontItems'
            font.pixelSize: app.fs*4
            anchors.centerIn: parent
            visible: xZoolMap.showDevLines
        }
        ZoolElementsView{id: zoolElementsView}
    }
    ZoolMapAsInfoView{
        id: zoolMapAsInfoView
        width: xLatDer.width
        anchors.bottom: parent.bottom
        parent: xLatDer
    }
    ZoolMultiCap{id: zoolMultiCap}
    Rectangle{
        width: txtMod.contentWidth+app.fs
        height: txtMod.contentHeight+app.fs
        color: apps.fontColor
        anchors.centerIn: parent
        anchors.verticalCenterOffset: app.fs*3
        visible: apps.dev
        Text{
            id: txtMod
            text: app.t+r.ejeTipoCurrentIndex
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
    Timer{
        id: tAutoMaticPlanets
        running: r.automatic
        repeat: true
        interval: 10000
        property string currentJsonData: ''
        onTriggered: {
            //            if(tAutoMaticPlanets.currentJsonData!==zm.currentData){
            //                //tAutoMaticPlanets.stop()
            //                //return
            //            }
            if(zm.currentPlanetIndex<21){
                zm.currentPlanetIndex++
            }else{
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=-1
            }
        }
    }

    Timer {
        id: tResizeAspCircle
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            resizeAspCircle()
        }
    }
    Component.onCompleted: {
        if(!apps)return
        setTheme(apps.zmCurrenThemeIndex)
    }
    function nextTheme(){
        let jd=u.getFile('./modules/ZoolMap/themes.json')
        let lt=JSON.parse(jd).themes.length
        if(apps.currentThemeIndex>0){
            apps.currentThemeIndex--
        }else{
            apps.currentThemeIndex=lt-1
        }
    }
    function setTheme(i){
        //Set ZoolMap Theme
        let jd=u.getFile('./modules/ZoolMap/themes.json')
        let t=JSON.parse(jd).themes[i]
        //log.lv('Themes: '+JSON.stringify(j.themes[0], null, 2))
        r.bodieColor=t.bodieColor
        r.bodieColorBack=t.bodieColorBack
        r.bodieBgColor=t.bodieBgColor
        r.bodieBgColorBack=t.bodieBgColorBack
        r.bodieBgBorderWidth=t.bodieBgBorderWidth
        r.bodieBgBorderWidthBack=t.bodieBgBorderWidthBack
        r.bodieBgBorderColor=t.bodieBgBorderColor
        r.bodieBgBorderColorBack=t.bodieBgBorderColorBack
        r.houseLineColor=t.houseLineColor
        r.houseLineColorBack=t.houseLineColorBack
        r.showSignsCircleColors=t.showSignsCircleColors
        r.iconSignColor=t.iconSignColor
        r.borderSignColor=t.borderSignColor
        r.borderSignCircleWidth=t.borderSignCircleWidth
        r.pointerBgColor=t.pointerBgColor
        r.pointerFontColor=t.pointerFontColor
        r.pointerBorderWidth=t.pointerBorderWidth
        r.pointerBorderColor=t.pointerBorderColor?t.pointerBorderColor:'red'
        apps.fontColor=t.fontColor
        apps.backgroundColor=t.backgroundColor
        r.themeName=t.name
        let j={}
        j.id='theme'
        j.text='Tema N° '+parseInt(i+1)+' Nombre: '+t.name
        zpn.addNot(j, true, 10000)
        //log.lv('Themes r.bodieColor: '+r.bodieColor)
    }

    //-->Load Data
    function load(j){
        if(r.loadingJsonInt)return
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
        let valt=0.0
        if(j.params.alt){
            valt=j.params.alt
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=j.params.hsys?j.params.hsys:apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onFinished:{\n'
        c+='        r.loadingJsonInt=false\n'
        c+='        loadSweJson(logData)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    onLogDataChanged:{\n'
        c+='        //log.lv(logData)\n'
        c+='        if(!r.enableLoad)return\n'
        //c+='        let json=(\'\'+logData)\n'
        c+='        //log.lv(\'JSON: \'+json)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='    let cmd=\''+app.pythonLocation+' "'+u.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+app.sweFolder.replace(/\"/g, '')+'" '+valt+'\'\n'
        c+='        console.log(\'zm.load()\'+cmd)\n'
        c+='        run(cmd)\n'
        //c+='        Qt.quit()\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        r.loadingJsonInt=true
        app.t=j.params.t
        r.fileData=JSON.stringify(j)
        //zev.load(j)
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
        zm.ev=true
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
        let valt=0.0
        if(params.alt){
            valt=params.alt
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        r.currentFechaBack=vd+'/'+vm+'/'+va
        if(params.hsys)hsys=params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onFinished:{\n'
        c+='        r.loadingJsonExt=false\n'
        c+='        loadSweJsonBack(logData)\n'
        c+='        r.ev=true\n'
        c+='        app.objZoolFileExtDataManager.updateList()\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    onLogDataChanged:{\n'
        //c+='        if(!r.enableLoadBack)return\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\''+app.pythonLocation+' "'+u.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+app.sweFolder.replace(/\"/g, '')+'" '+valt+'\'\n'
        c+='          console.log("zm.loadBack() "+cmd)\n'
        c+='          run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        r.loadingJsonExt=true
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        if(j.params.t){
            app.t=j.params.t
        }else{
            app.t=j.params.t
        }
        r.fileDataBack=JSON.stringify(j)
    }
    function loadBackFromArgs(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, edad, tipo, hsys, ms, vAtRigth) {
        if(!r.lockEv){
            r.ev=false
        }
        r.lockEv=false
        let d=new Date(Date.now())
        let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh),
                            parseInt(vmin))
        let stringEdad=(''+edad).indexOf('NaN')<0?edad:''

        let extId='id'
        extId+='_'+vd
        extId+='_'+vm
        extId+='_'+va
        extId+='_'+vh
        extId+='_'+vmin
        extId+='_'+vgmt
        extId+='_'+vlat
        extId+='_'+vlon
        extId+='_'+valt
        extId+='_'+tipo
        extId+='_'+hsys

        let js='{"params":{"t":"'+tipo+'","ms":'+ms+',"n":"'+nom+'","d":'+vd+',"m":'+vm+',"a":'+va+',"h":'+vh+',"min":'+vmin+',"gmt":'+vgmt+',"lat":'+vlat+',"lon":'+vlon+',"alt":'+valt+',"c":"'+vCiudad+'", "hsys":"'+hsys+'", "extId":"'+extId+'"}}'
        //if(true)log.lv('Json loadBackFromArg(): '+JSON.stringify(JSON.parse(js)))
        //if(apps.dev)log.lv('Json fallado: loadBack( '+nom+',  '+vd+',  '+vm+',  '+va+',  '+vh+',  '+vmin+',  '+vgmt+',  '+vlat+',  '+vlon+',  '+valt+',  '+vCiudad+',  '+edad+',  '+tipo+',  '+hsys+',  '+ms+',  '+vAtRigth+')')

        //if(apps.dev)log.lv('Json fallado: loadBack(...) json: '+js)

        //log.lv('1029 js: '+js)
        let json=JSON.parse(js)

        /*let extIdExist=zfdm.isExtId(extId)
        if(apps.dev && extIdExist)log.lv('ExtId ya existe. extIdExist='+extIdExist)
        let isExtIdInAExtsIds=app.aExtsIds.indexOf(extId)>=0?true:false
        if(apps.dev && isExtIdInAExtsIds)log.lv('ExtId ya estan en aExtsIds. isExtIdInAExtsIds='+isExtIdInAExtsIds)
        if(!extIdExist && !isExtIdInAExtsIds){
            //zfdm.addExtData(json)
            zm.loadBack(json)
        }else{
            if(apps.dev)log.lv('ExtId ya existe.')
            let extJson={}
            extJson.params=zfdm.getExtData(extId)
            if(apps.dev)log.lv('Cargando ExtData...\n'+JSON.stringify(extJson, null, 2))
            zm.loadBack(extJson)
        }*/
        zm.loadBack(json)
        let aL=zoolDataView.atLeft
        let aR=vAtRigth
        //if(vAtRigth===[]){
        if(tipo==='sin'){
            aR.push('<b>'+nom+'</b>')
            aL.reverse()
        }
        if(tipo==='rs')aR.push(edad)
        aR.push(''+vd+'/'+vm+'/'+va)
        aR.push(''+vh+':'+vmin+'hs')
        aR.push('<b>GMT:</b> '+vgmt)
        aR.push('<b>Ubicación:</b> '+vCiudad)
        aR.push('<b>Lat:</b> '+parseFloat(vlat).toFixed(2))
        aR.push('<b>Lon:</b> '+parseFloat(vlon).toFixed(2))
        aR.push('<b>Alt:</b> '+valt)
        //}
        let strSep=''
        if(tipo==='sin'){
            strSep='Sinastría'
        }
        if(tipo==='rs')strSep='Rev. Solar '+va
        if(tipo==='trans')strSep='Tránsitos'
        if(tipo==='dirprim')strSep='Dir. Primarias'
        zoolDataView.setDataView(strSep, aL, aR)
        //zoolDataView.uExtIdLoaded=extId
        if(!r.lockEv){
            r.ev=true
        }
        r.lockEv=false
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        if(!r.safeTapa){
            tapa.visible=true
            tapa.opacity=1.0
        }
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        aspsCircle.clear()
        //zsm.getPanel('ZoolRevolutionList').clear()
        //panelRsList.clear()
        //planetsCircleBack.visible=false
        if(!r.lockEv){
            r.ev=false
        }
        r.lockEv=false
        apps.urlBack=''
        //panelAspectsBack.visible=false
        r.currentPlanetIndex=-1
        r.currentPlanetIndexBack=-1
        r.currentHouseIndex=-1
        r.currentHouseIndexBack=-1
        r.currentPlanetIndex=-1
        r.currentHouseIndex=-1

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

        r.currentJson=j
        //-->ZoolMap
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        housesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        //zpn.log('zm.maxAbsPosInt: '+zm.maxAbsPosInt)
        //r.maxAbsPosInt=planetsCircle.getMaxAsAbsPos()
        //zpn.log('r.maxAbsPosInt: '+r.maxAbsPosInt)
        aspsCircle.load(j)
        //ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        //ai.width=r.width
        zoolDataBodies.loadJson(j)
        zoolElementsView.load(j, false)
        let jsonAsps=aspsCircle.getAsps(j)
        panelAspects.load(jsonAsps)
        //log.lv('Nakshatra length:'+nakshatraView.aNakshatra.length)
        //log.lv('Nakshatra index:'+nakshatraView.getIndexNakshatra(j.pc.c1.gdec))
        //log.lv('Nakshatra:'+nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec)))
        r.currentNakshatra=nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec))

        //resizeAspsCircle()
        //zm.setPos(r.mapToGlobal(0, 0).x, r.mapToGlobal(0, 0).y, zm.objSignsCircle.rotation)
        zm.setPos(0, 0, 0)

        let o1=j.ph['h1']
        //r.isAsc=o1.is
        //r.gdegAsc=o1.rsgdeg
        //r.mdegAsc=o1.mdeg
        zm.uAscDegree=parseInt(o1.rsgdeg)
        o1=j.ph['h10']
        zm.uMcDegree=parseInt(o1.rsgdeg)

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
        if(!app.t==='dirprim' || !app.t==='progsec' || r.safeTapa){
            tapa.visible=true
            tapa.opacity=1.0
        }

        //zpn.log('loadSweJsonBack()...')

        zm.currentJsonBack=JSON.parse(json)


        //log.lv('zm.currentJsonBack='+JSON.stringify(zm.currentJsonBack, null, 2))
        //        if(apps.dev)
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
        if(app.t!=='rs'){
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
        //r.maxAbsPosExt=planetsCircleBack.getMaxAsAbsPos()
        //zpn.log('r.maxAbsPosExt: '+r.maxAbsPosExt)
        aspsCircleBack.load(j)
        housesCircleBack.width=ae.width
        //housesCircleBack.wbgc=app.fs*6
        //c101.width=r.width-app.fs
        //ai.width=r.width-(zm.planetSize*r.maxAbsPosExt*2)
        //ai.width=app.fs*10
        //c101.d=ai.width
        //ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
        //signCircle.width=ai.width
        //planetsCircle.width=ai.width
        //ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        //ai.width=app.fs*r.width-(r.width-zm.planetSize*r.maxAbsPosExt*2)
        zoolDataBodies.loadJsonBack(j)
        zoolElementsView.load(j, true)
        let jsonAsps=aspsCircleBack.getAsps(j)
        panelAspectsBack.load(jsonAsps)
        panelAspectsBack.visible=true
        r.currentNakshatraBack=nakshatraView.getNakshatraName(nakshatraView.getIndexNakshatra(j.pc.c1.gdec))
        //resizeAspsCircle()
        //<--ZoolMap

        //dinHousesCircleBack.loadHouses(j)

        //if(app.t==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))

        //        if(app.t==='dirprim'){
        //            log.lv('is dirprim')
        //        }

        //panelDataBodiesV2.loadJson(j)

        //app.backIsSaved=isSaved
        //if(apps.dev)log.lv('sweg.loadSweJsonBack() isSaved: '+isSaved)
        if(!r.lockEv){
            r.ev=true
        }
        r.lockEv=false
        if(app.t!=='dirprim'&&app.t!=='progsec'&&app.t!=='trans')centerZoomAndPos()
    }
    function loadFromFile(filePath, tipo, isBack){
        //zpn.log('loadFromFile( '+filePath+' )...')
        //if(isBack)zm.ev=true
        tapa.visible=true
        tapa.opacity=1.0
        let jsonFileData=u.getFile(filePath)
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
        let c=j.c
        let e='1000'
        let aR=[]
        app.t=tipo
        j.t=t
        let ms
        if(!j.ms){
            let date=new Date(Date.now())
            ms=date.getTime()
        }
        let msmod
        if(!j.msmod){
            msmod=ms
        }else{
            msmod=j.msmod
        }
        let p=zm.getParamsFromArgs(nom, d, m, a, h, min, gmt, lat, lon, alt, c, t, hsys, ms, msmod)
        if(!isBack){
            r.load(p)
        }else{
            //zpn.log('r.loadBack()...')
            //zpn.log('r.loadBack()->p= '+JSON.stringify(p, null, 2))
            r.loadBack(p)
        }
        //r.loadBackFromArgs(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, e, t, hsys, -1, aR)
    }
    function loadJsonFromFilePath(filePath){
        //zpn.log('loadJsonFromFilePath()...')
        let fileLoaded=zfdm.loadFile(filePath)
        let fileNameMat0=filePath.split('/')
        let fileName=fileNameMat0[fileNameMat0.length-1].replace(/_/g, ' ').replace('.json', '')
        if(!fileLoaded){
            if(apps.dev)log.lv('Error app.j.loadFile('+filePath+') fileLoaded: '+fileLoaded)
            return
        }
        zm.fileData=JSON.stringify(zfdm.getJsonAbsParams(false))
        //Global Vars Reset
        zm.resetGlobalVars()

        let jsonData=zfdm.getJsonAbs()
        let p=zfdm.getJsonAbsParams(false)
        //sweg.load(jsonData)
        zm.load(jsonData)
        let nom=p.n.replace(/_/g, ' ')
        let vd=p.d
        let vm=p.m
        let va=p.a
        let vh=p.h
        let vmin=p.min
        let vgmt=p.gmt
        let vlon=p.lon
        let vlat=p.lat
        let valt=p.alt?p.alt:0
        let vCiudad=p.c.replace(/_/g, ' ')
        let edad=zm.getEdad(vd, vm, va, vh, vmin)
        let numEdad=zm.getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
        let stringEdad='<b>Edad:</b> '
        if(edad===1){
            stringEdad+=edad+' año'
        }else{
            stringEdad+=edad+' años'
        }

        let dateNow=new Date(Date.now())
        let dateFN=new Date(va, vm-1, vd, vh, vmin)

        let a=[]
        a.push('<b>'+nom+'</b>')
        a.push(''+vd+'/'+vm+'/'+va)
        a.push(stringEdad)
        a.push(''+vh+':'+vmin+'hs')
        a.push('<b>GMT:</b> '+vgmt)
        a.push('<b>Ubicación:</b> '+vCiudad)
        a.push('<b>Lat:</b> '+parseFloat(vlat).toFixed(2))
        a.push('<b>Lon:</b> '+parseFloat(vlon).toFixed(2))
        a.push('<b>Alt:</b> '+valt)

        zoolDataView.setDataView(nom, a, [])

        //Seteando datos globales de mapa energético
        apps.url=filePath
        zm.currentNom=nom
        zm.currentGenero='n'
        if(p.g)zm.currentGenero=p.g
        zm.currentFecha=vd+'/'+vm+'/'+va
        zm.currentLugar=vCiudad
        zm.currentGmt=vgmt
        zm.currentLon=vlon
        zm.currentLat=vlat
        zm.currentAlt=valt
        zm.currentDate= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))

        zm.centerZoomAndPos()
    }
    function loadIntOrExt(fileName, isExt){
        let existe=u.fileExist(fileName)
        if(!existe)return
        r.lockEv=true
        let jsonData=u.getFile(fileName)
        let p=JSON.parse(jsonData).params

        if(!isExt){
            zm.fileData=JSON.stringify(p)
        }else{
            zm.fileDataBack=JSON.stringify(p)
        }
        //Global Vars Reset
        zm.resetGlobalVars()

        //let jsonData=zfdm.getJsonAbs()
        //let p=zfdm.getJsonAbsParams(false)
        //sweg.load(jsonData)
        if(!isExt){
            zm.load(p)
        }else{
            zm.loadBack(p)
        }
        let nom=p.n.replace(/_/g, ' ')
        let vd=p.d
        let vm=p.m
        let va=p.a
        let vh=p.h
        let vmin=p.min
        let vgmt=p.gmt
        let vlon=p.lon
        let vlat=p.lat
        let valt=p.alt?p.alt:0
        let vCiudad=p.c.replace(/_/g, ' ')
        let edad=zm.getEdad(vd, vm, va, vh, vmin)
        let numEdad=zm.getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
        let stringEdad='<b>Edad:</b> '
        if(edad===1){
            stringEdad+=edad+' año'
        }else{
            stringEdad+=edad+' años'
        }

        let dateNow=new Date(Date.now())
        let dateFN=new Date(va, vm-1, vd, vh, vmin)

        let aL=zoolDataView.atLeft
        let aR=zoolDataView.aRigth
        if(!isExt){
            aL=[]
            aL.push('<b>'+nom+'</b>')
            aL.push(''+vd+'/'+vm+'/'+va)
            aL.push(stringEdad)
            aL.push(''+vh+':'+vmin+'hs')
            aL.push('<b>GMT:</b> '+vgmt)
            aL.push('<b>Ubicación:</b> '+vCiudad)
            aL.push('<b>Lat:</b> '+parseFloat(vlat).toFixed(2))
            aL.push('<b>Lon:</b> '+parseFloat(vlon).toFixed(2))
            aL.push('<b>Alt:</b> '+valt)

            zoolDataView.setDataView(nom, aL, aR)

            //Seteando datos globales de mapa energético
            apps.url=filePath
            zm.currentNom=nom
            zm.currentGenero='n'
            if(p.g)zm.currentGenero=p.g
            zm.currentFecha=vd+'/'+vm+'/'+va
            zm.currentLugar=vCiudad
            zm.currentGmt=vgmt
            zm.currentLon=vlon
            zm.currentLat=vlat
            zm.currentAlt=valt
            zm.currentDate= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
        }else{
            aR=[]
            aR.push('<b>'+nom+'</b>')
            aR.push(''+vd+'/'+vm+'/'+va)
            aR.push(stringEdad)
            aR.push(''+vh+':'+vmin+'hs')
            aR.push('<b>GMT:</b> '+vgmt)
            aR.push('<b>Ubicación:</b> '+vCiudad)
            aR.push('<b>Lat:</b> '+parseFloat(vlat).toFixed(2))
            aR.push('<b>Lon:</b> '+parseFloat(vlon).toFixed(2))
            aR.push('<b>Alt:</b> '+valt)

            zoolDataView.setDataView(nom, aL, aR)

            //Seteando datos globales de mapa energético
            apps.urlBack=filePath
            zm.currentNomBack=nom
            zm.currentGenero='n'
            if(p.g)zm.currentGenero=p.g
            zm.currentFechaBack=vd+'/'+vm+'/'+va
            zm.currentLugarBack=vCiudad
            zm.currentGmtBack=vgmt
            zm.currentLonBack=vlon
            zm.currentLatBack=vlat
            zm.currentAltBack=valt
            zm.currentDateBack= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
        }

        if(!isExt&&app.t!=='dirprim'&&app.t!=='progsec')zm.centerZoomAndPos()
    }
    function loadNow(isExt){
        let d=new Date(Date.now())
        let currentUserHours=d.getHours()
        let diffHours=d.getUTCHours()
        let currentGmtUser=0
        //        if(currentUserHours>diffHours){
        //            currentGmtUser=parseFloat(currentUserHours-diffHours)
        //        }else{
        //            currentGmtUser=parseFloat(0-(diffHours+currentUserHours)).toFixed(1)
        //        }
        //log.ls('currentGmtUser: '+currentGmtUser, 0, xLatIzq.width)
        let dia=d.getDate()
        let mes=d.getMonth()+1
        let anio=d.getFullYear()
        let hora=d.getHours()
        let minutos=d.getMinutes()
        let nom="Tránsitos de "+dia+'/'+mes+'/'+anio+' '+hora+':'+minutos
        let ciudad="United Kingdom"
        let lat=0.0
        let lon=0.0
        let alt=6

        if(!isExt){
            zm.currentNom=nom
            zm.currentGenero='n'
            zm.currentFecha=dia+'/'+mes+'/'+anio
            zm.currentLugar=ciudad
            zm.currentGmt=currentGmtUser
            zm.currentLon=lon
            zm.currentLat=lat
            zm.currentAlt=alt
            zm.currentDate= new Date(parseInt(anio), parseInt(mes) - 1, parseInt(dia), parseInt(hora), parseInt(minutos))
        }else{
            zm.currentNomBack=nom
            zm.currentGeneroBack='n'
            zm.currentFechaBack=dia+'/'+mes+'/'+anio
            zm.currentLugarBack=ciudad
            zm.currentGmtBack=currentGmtUser
            zm.currentLonBack=lon
            zm.currentLatBack=lat
            zm.currentAltBack=alt
            zm.currentDateBack= new Date(parseInt(anio), parseInt(mes) - 1, parseInt(dia), parseInt(hora), parseInt(minutos))
        }
        //loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), currentGmtUser,lat,lon, alt, nom, ciudad, "trans", isExt)
        let json={}
        json.params={}
        json.params.n=nom
        json.params.d=d.getDate()
        json.params.m=d.getMonth() + 1
        json.params.a=d.getFullYear()
        json.params.h=d.getHours()
        json.params.min=d.getMinutes()
        json.params.gmt=currentGmtUser
        json.params.lat=lat
        json.params.lon=lon
        json.params.alt=alt
        json.params.c=ciudad
        json.params.t='trans'
        json.params.g='n'

        zfdm.mkFileAndLoad(json, true)
    }
    function loadFromArgs(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, data, tipo, isExt){
        //zpn.log('loadFromArgs()...')
        let dataMs=new Date(Date.now())
        let j='{"params":{"n":"Tránsitos", "t":"'+tipo+'","ms":'+dataMs.getTime()+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"alt":'+alt+',"c":"'+ciudad+'", "data": "'+data+'"}}'
        //log.lv('loadFromArgs(...): '+JSON.stringify(JSON.parse(j), null, 2))
        let json=JSON.parse(j)
        if(!isExt){
            zfdm.setJsonAbsParams(json.params, false)
            load(json)
        }else{
            zfdm.setJsonAbsParams(json.params, true)
            loadBack(json)
            //r.ev=true
        }
        let sep='Sinastría'
        if(tipo==='progsec')sep='Prog. Sec.'
        if(tipo==='trans')sep='Tránsitos'
        let aL=[]
        let aR=[]
        if(!isExt){
            //aL.push('Trásitos')
            aL.push(nom)
            aL.push(''+d+'/'+m+'/'+a)
            aL.push(''+h+':'+min+'hs')
            aL.push('<b>GMT:</b> '+gmt)
            aL.push('<b>Ubicación:</b> '+ciudad)
            aL.push('<b>Lat.:</b> '+lat)
            aL.push('<b>Lon.:</b> '+lon)
            aL.push('<b>Alt.:</b> '+alt)
        }else{
            aL=zoolDataView.atLeft
            aR.push(nom)
            aR.push(''+d+'/'+m+'/'+a)
            aR.push(''+h+':'+min+'hs')
            aR.push('<b>GMT:</b> '+gmt)
            aR.push('<b>Ubicación:</b> '+ciudad)
            aR.push('<b>Lat.:</b> '+lat)
            aR.push('<b>Lon.:</b> '+lon)
            aR.push('<b>Alt.:</b> '+alt)
        }
        zoolDataView.setDataView(sep, aL, aR)
        if(!r.lockEv){
            r.ev=isExt
        }
        r.lockEv=false
        //zm.ev=isExt
    }
    function loadFromJson(j, isExt, save){
        //zpn.log('loadFromJson()...')
        if(save){
            let mf=zfdm.mkFileAndLoad(JSON.parse(j))
            return
        }
        if(!isExt){
            load(JSON.parse(j))
        }else{
            loadBack(JSON.parse(j))
        }
    }
    function getParamsFromArgs(n, d, m, a, h, min, gmt, lat, lon, alt, c, t, s, ms, msmod, f, g){
        let j={}
        j.params={}
        j.params.n=n
        j.params.d=d
        j.params.m=m
        j.params.a=a
        j.params.h=h
        j.params.min=min
        j.params.gmt=gmt
        j.params.lat=lat
        j.params.lon=lon
        j.params.alt=alt
        j.params.c=c
        j.params.t=t
        j.params.s=s
        j.params.ms=ms
        j.params.msmod=msmod
        j.params.f=f
        j.params.g=g
        //log.lv('getParamsFromArgs() j.params.c: '+j.params.c)
        //log.lv('getParamsFromArgs(): '+JSON.stringify(j))
        return j
    }
    function getCurrentParamsWithNewTime(date){
        let jsonFromAbs=zfdm.getJsonAbs()
        let d=new Date(date)
        let j={}
        j.params={}
        j.params.n=jsonFromAbs.params.n
        j.params.d=d.getDate()
        j.params.m=d.getMonth() + 1
        j.params.a=d.getFullYear()
        j.params.h=d.getHours()
        j.params.min=d.getMinutes()
        j.params.gmt=jsonFromAbs.params.gmt
        j.params.lat=jsonFromAbs.params.lat
        j.params.lon=jsonFromAbs.params.lon
        j.params.alt=jsonFromAbs.params.alt
        j.params.c=jsonFromAbs.params.c
        j.params.t=jsonFromAbs.params.t
        j.params.s=jsonFromAbs.params.s
        return j
    }
    function getData(file, bodie, sign, house){
        let jd=u.getFile(file)
        let j=JSON.parse(jd)
        let item=(''+bodie+'_en_'+sign).toLowerCase()
        let s=''
        let tit='<h2>'+zdm.cfl(bodie)+' en '+zdm.cfl(sign)+'</h2>'
        s+=tit+'<br>'
        s+='<h3>Manifestaciones</h3><br>'
        let keys=Object.keys(j[item].manifestaciones)
        for(var i=0;i<keys.length;i++){
            let itemName=keys[i]
            s+='<p><b>'+zdm.cfl(itemName).replace(/_/g, ' ')+': </b>'
            s+=''+j[item].manifestaciones[itemName]+'</p><br>'
        }
        item=(''+bodie+'_en_'+house).toLowerCase()
        tit='<h2>'+zdm.cfl(bodie)+' en '+zdm.cfl(house).replace(/_/g, ' ')+'</h2>'
        s+=tit+'<br>'
        s+='<h3>Manifestaciones Negativas</h3><br>'
        keys=Object.keys(j[item].manifestaciones_negativas)
        for(i=0;i<keys.length;i++){
            let itemName=keys[i]
            s+='<p><b>'+zdm.cfl(itemName).replace(/_/g, ' ')+': </b>'
            s+=''+j[item].manifestaciones_negativas[itemName]+'</p><br>'
        }
        //log.lv('S:'+s)
        return s
    }
    function showInfoData(bodieIndex, signIndex, houseIndex){
        let b=zm.aBodiesFiles[bodieIndex]
        let s=zm.aSignsLowerStyle[signIndex]
        let h=parseInt(houseIndex)
        let data = getData('modules/ZoolMap/ZoolMapData/'+b+'.json', b, s, 'casa_'+h)
        let t='<h1>'+b+' en '+s+' en Casa '+h+'</h1>'
        zm.mkWindowDataView(t, data, app.width*0.5-app.fs*10, app.height*0.5-xApp.height*0.25, app.fs*20, xApp.height*0.5, app, app.fs*0.75)
        return
        //        let b=zm.aBodiesFiles[bodieIndex]
        //        let s=zm.aSignsLowerStyle[signIndex]
        //        let h=parseInt(houseIndex)
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='import QtQuick.Window 2.0\n'
        //c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    onLogDataChanged:{\n'
        //c+='        log.lv("D:"+logData)\n'
        c+='        let t=(""+(""+logData).split("</h1>")[0]).replace("<h1>", "")\n'
        c+='        zm.mkWindowDataView(t, logData, Screen.width*0.5-app.fs*10, Screen.height*0.5-xApp.height*0.25, app.fs*20, xApp.height*0.5, app, app.fs*0.75)\n'
        c+='        destroy()\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let b=("'+b+'").toLowerCase()\n'
        c+='        let s="'+s+'"\n'
        c+='        let h="casa_'+h+'"\n'
        c+='        let ss=b+"_en_"+s\n'
        c+='        if(apps.dev)log.lv("Buscando datos de:"+b+" en "+s+" "+ss)\n'
        c+='        let cmd="/home/ns/nsp/zool-release/modules/ZoolMap/ZoolMapData/getData.sh /home/ns/nsp/zool-release/modules/ZoolMap/ZoolMapData/"+b+".json "+b+" "+s+" "+h+""\n'
        c+='        if(apps.dev)log.lv("CMD:"+cmd)\n'
        c+='        console.log("CMD:"+cmd)\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        //c+='}\n'
        let obj=Qt.createQmlObject(c, xuqps, 'nioqmlcode')
    }
    function getZiDataNum(num, gen, show){
        let bashScriptPath=u.getPath(5)+'/modules/ZoolMap/ZoolMapData/getDataNum.sh'
        let jsonFilePath=u.getPath(5)+'/modules/ZoolMap/ZoolMapData/numerologia_segunda_persona_masc.json'
        if(gen==='fem')jsonFilePath=u.getPath(5)+'/modules/ZoolMap/ZoolMapData/numerologia_segunda_persona_fem.json'
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='import QtQuick.Window 2.0\n'
        //c+='Item{\n'
        c+='UnikQProcess{\n'
        c+='    onLogDataChanged:{\n'
        //c+='        log.lv("D:"+logData)\n'
        c+='        let t=(""+(""+logData).split("</h1>")[0]).replace("<h1>", "")\n'
        if(show){
            c+='        zm.mkWindowDataView(t, logData, Screen.width*0.5-app.fs*10, Screen.height*0.5-xApp.height*0.25, app.fs*20, xApp.height*0.5, app, app.fs*0.75)\n'
        }else{
            c+='        zm.mkItemDataView(logData, 0, 0, xLatDer.width, xLatDer.height, xLatDer, app.fs*0.75)\n'
        }
        c+='        destroy()\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        if(apps.dev)log.lv("Buscando datos de:'+num+'")\n'
        c+='        let cmd="'+bashScriptPath+' '+jsonFilePath+' '+num+'"\n'
        c+='        if(apps.dev)log.lv("CMD:"+cmd)\n'
        c+='        console.log("CMD:"+cmd)\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        //c+='}\n'
        let obj=Qt.createQmlObject(c, xuqps, 'nioqmlcode')
        ///getDataNum.sh /home/ns/nsp/zool-release/modules/ZoolMap/ZoolMapData/numerologia_segunda_persona_fem.json 1

    }
    //<--Load Data

    //-->Teclado
    property real panStepSize: app.fs
    Timer{
        id: tImcToFalse // Resetea isMultiCapturing
        interval: 1000
        onTriggered: {
            r.isMultiCapturing=false
        }
    }
    function toUp(ctrl){
        r.isMultiCapturing=true
        let a=getZoomAndPos()
        a[1]=parseFloat(a[1] - panStepSize)
        a[3]=parseFloat(a[3] - panStepSize)
        a[7]=parseFloat(a[7] - panStepSize)
        setZoomAndPos(a)
        tImcToFalse.restart()
    }
    function toDown(ctrl){
        r.isMultiCapturing=true
        let a=getZoomAndPos()
        a[1]=parseFloat(a[1] + panStepSize)
        a[3]=parseFloat(a[3] + panStepSize)
        a[7]=parseFloat(a[7] + panStepSize)
        setZoomAndPos(a)
        tImcToFalse.restart()
    }
    function toLeft(ctrl){
        r.isMultiCapturing=true
        let a=getZoomAndPos()
        a[0]=parseFloat(a[0] - panStepSize)
        a[2]=parseFloat(a[2] - panStepSize)
        a[6]=parseFloat(a[6] - panStepSize)
        setZoomAndPos(a)
        tImcToFalse.restart()
    }
    function toRight(ctrl){
        r.isMultiCapturing=true
        let a=getZoomAndPos()
        a[0]=parseFloat(a[0] + panStepSize)
        a[2]=parseFloat(a[2] + panStepSize)
        a[6]=parseFloat(a[6] + panStepSize)
        setZoomAndPos(a)
        tImcToFalse.restart()
    }
    function toSpace(ctrl){
        if(ctrl){
            apps.xAsShowIcon=!apps.xAsShowIcon
        }else{
            centerZoomAndPos()
        }

    }
    //<--Teclado

    //-->Make Dinamically
    function mkWindowDataView(title, data, x, y, width, height, parent, fs){
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import comps.WindowDataView 1.0\n'
        c+='WindowDataView{\n'
        c+='    id: w\n'
        c+='    Component.onCompleted:{\n'
        c+='        let d="'+data+'"\n'
        c+='        w.title="'+title+'"\n'
        c+='        w.x="'+x+'"\n'
        c+='        w.y="'+y+'"\n'
        c+='        w.width="'+width+'"\n'
        c+='        w.height="'+height+'"\n'
        c+='        w.fs="'+fs+'"\n'
        c+='        w.text=d\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, parent, 'mkWindowDataViewCode')
    }
    function mkItemDataView(data, x, y, width, height, parent, fs){
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import comps.ItemDataView 1.0\n'
        c+='ItemDataView{\n'
        c+='    id: w\n'
        c+='    Component.onCompleted:{\n'
        c+='        let d="'+data+'"\n'
        c+='        w.x="'+x+'"\n'
        c+='        w.y="'+y+'"\n'
        c+='        w.width="'+width+'"\n'
        c+='        w.height="'+height+'"\n'
        c+='        w.fs="'+fs+'"\n'
        c+='        w.text=d\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, parent, 'mkItemDataViewCode')
    }
    //<--Make Dinamically

    /*function resizeAspsCircle(isBack){
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
    }*/
    function resizeAspCircle(){
        if(r.ev){
            ai.width=planetsCircleBack.getMinAsWidth()-r.planetSize*2
            ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
            //aspsCircle.width=300
        }else{
            ai.width=r.width
            ca.d=planetsCircle.getMinAsWidth()-r.planetSize*2
        }
        hideTapa()
    }
    function hideTapa(){
        tapa.opacity=0.0
        r.safeTapa=false
    }
    function revIsDataDiff(){
        let j0=zfdm.getJsonAbsParams()
        //log.lv('j0:'+JSON.stringify(j0, null, 2))
        if(!zm.currentJson)return false;
        let j1=zm.currentJson.params
        let sj1='s_'+j1.d+'_'+j1.m+'_'+j1.a+'_'+j1.h+'_'+j1.min+'_'+j1.gmt+'_'+j1.lat+'_'+j1.lon+'_'+j1.alt
        let sj0='s_'+j0.d+'_'+j0.m+'_'+j0.a+'_'+j0.h+'_'+j0.min+'_'+j0.gmt+'_'+j0.lat+'_'+j0.lon+'_'+j0.alt
        r.isDataDiff=sj0!==sj1
        return r.isDataDiff
    }
    function getRevIsDataDiff(){
        let s=''

        let j0=zfdm.getJsonAbsParams()

        s+='Datos del Archivo'+'\n'
        s+='Fecha: '+j0.d+'/'+j0.m+'/'+j0.a+'\n'
        s+='Hora: '+j0.h+':'+j0.min+'hs GMT:'+j0.gmt+'\n'
        s+='\n'

        let j1=zm.currentJson.params

        s+='Datos modificados'+'\n'
        s+='Fecha: '+j1.d+'/'+j1.m+'/'+j1.a+'\n'
        s+='Hora: '+j1.h+':'+j1.min+'hs GMT:'+j1.gmt+'\n'
        s+='\n'

        let sj1='s_'+j1.d+'_'+j1.m+'_'+j1.a+'_'+j1.h+'_'+j1.min+'_'+j1.gmt+'_'+j1.lat+'_'+j1.lon+'_'+j1.alt
        let sj0='s_'+j0.d+'_'+j0.m+'_'+j0.a+'_'+j0.h+'_'+j0.min+'_'+j0.gmt+'_'+j0.lat+'_'+j0.lon+'_'+j0.alt
        s+='['+sj1+']\n'
        s+='['+sj0+']\n'
        //r.isDataDiff=sj0!==sj1
        return s
    }

    //-->ZoomAndPan
    function setZoom(sent, mouseX, mouseY){
        r.enableAnZoomAndPos=false
        pinchArea.m_x1 = scaler.origin.x
        pinchArea.m_y1 = scaler.origin.y
        pinchArea.m_zoom1 = scaler.xScale
        pinchArea.m_x2 = mouseX
        pinchArea.m_y2 = mouseY

        var newZoom
        if (sent) {
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
    }
    function centrarZooMap(){
        var item1=zm.xzm
        var item2=centro
        var absolutePosition = item2.mapToItem(item1, 0, 0);
        //return {x: absolutePosition.x, y:absolutePosition.y}

        /*
          //Probando
        pinchArea.m_zoom1=0.75
        pinchArea.m_zoom2=0.75
        pinchArea.m_x1=rect.width*0.5
        pinchArea.m_x2=pinchArea.m_x1
        pinchArea.m_y1=rect.height*0.5
        pinchArea.m_y2=pinchArea.m_y1
        */


        zm.panTo(absolutePosition.x, absolutePosition.y)


    }
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
    /*function zoomTo(z){
        centerZoomAndPos()
        pinchArea.m_zoom1 = z
        pinchArea.m_zoom2 = z
    }*/
    function zoomTo(z, centering){
        if(centering)centerZoomAndPos()
        pinchArea.m_zoom1 = z
        pinchArea.m_zoom2 = z
    }
    function setZoomAndPos(zp){
        r.uZp=zp
        pinchArea.m_x1 = zp[0]
        pinchArea.m_y1 = zp[1]//1
        pinchArea.m_x2 = zp[2]
        pinchArea.m_y2 = zp[3]//3
        pinchArea.m_zoom1 = zp[4]
        pinchArea.m_zoom2 = zp[5]
        rect.x = zp[6]
        rect.y = zp[7]//7
        if(zp[8]){
            app.currentXAs.objPointerPlanet.pointerRot=zp[8]
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
        if(zm.currentXAs){
            a.push(parseInt(zm.currentXAs.uRot))
        }else{
            a.push(0)
        }
        return a
    }
    function setPos(x, y, angle){
        var originalX = x;
        var originalY = y;

        // Ángulo de rotación del rectángulo contenedor
        var rotationAngle = angle//parent.rotation;

        // Calcular las coordenadas del punto después de la rotación
        var rotatedPoint = getCoordsRotatedPoint(originalX, originalY, rotationAngle);

        //console.log('Coordenadas rotadas:', rotatedPoint.x+' '+rotatedPoint.y);
        mr(rotatedPoint.x, rotatedPoint.y);
    }
    function panTo(newX, newY) {
        //log.lv('panTo('+newX+', '+newY+')')
        //rectXAnim.to = newX-rect.width*0.5//-xLatIzq.width//*0.5//-rect.width*0.25;
        rect.x = 0-rect.width*0.25+r.width*0.5-((0-newX+r.width*0.5)-(0-newX+r.width*0.5)-(0-newX+r.width*0.5))
        //rectYAnim.to = newY*0.25//+rect.height*0.25;
        rect.y = 0-rect.height*0.25+r.height*0.5-((0-newY+r.height*0.5)-(0-newY+r.height*0.5)-(0-newY+r.height*0.5))
        //rectXAnim.start();
        //rectYAnim.start();
    }
    function getCoordsRotatedPoint(x, y, angle) {
        // Convertir el ángulo a radianes
        var radians = angle * Math.PI / 180;

        // Calcular las coordenadas rotadas
        var rotatedX = x * Math.cos(radians) - y * Math.sin(radians);
        var rotatedY = x * Math.sin(radians) + y * Math.cos(radians);

        return { x: rotatedX, y: rotatedY };
    }
    function saveZoomAndPosHouse(house, isExt){
        let json=zfdm.getJsonAbs()
        if(!json[app.stringRes+'zoompos']){
            json[app.stringRes+'zoompos']={}
        }
        let sNomItem=''+app.stringRes+'zoompos'
        if(isExt)sNomItem+='Back'
        json[sNomItem]['h'+house]=r.getZoomAndPos()
        if(u.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json, null, 2)
        log.lv('json: '+njson)
        //zm.fileData=njson
        //zm.currentData=njson
        u.setFile(apps.url.replace('file://', ''), njson)
    }
    //Función para el desarrollo de el posicionamiento automático.
    function mr(x, y) {
        let c='import QtQuick 2.12\n'
        c+='Rectangle {\n'
        c+='    color: "red"\n'
        c+='    Timer{\n'
        c+='        running:true; repeat:false;interval:5000\n'
        c+='        onTriggered: parent.destroy()\n'
        c+='    }\n'
        c+='}\n'
        var d = Qt.createQmlObject(c, capaFront);
        d.width=50
        d.height=50
        d.border.width=4
        d.border.color='yellow'
        d.x = x-25;
        d.y = y-25;
    }
    //<--ZoomAndPan

    //-->Funciones Varias
    function unloadExt(){
        app.t='vn'

        zm.ev=false
        //aspsCircle.clear()
        aspsCircleBack.clear()
        zoolDataView.clearExtData()
        ai.width=r.width
        zm.objTapa.opacity=0.0
        aspsCircle.opacity=1.0
        aspsCircle.visible=true
        aspsCircleBack.opacity=0.0
        aspsCircle.visible=false
        panelAspectsBack.opacity=0.0
        loadFromFile(apps.url, 'vn', false)
    }
    function resetGlobalVars(){
        if(!r.lockEv){
            r.ev=false
        }
        r.lockEv=false
        r.currentPlanetIndex=-1
        r.currentPlanetIndexBack=-1
        r.currentHouseIndex=-1
        r.currentHouseIndexBack=-1
        r.currentSignIndex= 0
        r.currentNom= ''
        r.currentNomBack= ''
        r.currentFecha= ''
        r.currentFechaBack= ''
        r.currentGradoSolar= -1
        r.currentGradoSolarBack= -1
        r.currentMinutoSolar= -1
        r.currentMinutoSolarBack= -1
        r.currentSegundoSolar= -1
        r.currentSegundoSolarBack= -1
        r.currentGmt= 0.0
        r.currentGmtBack= 0.0
        r.currentLon= 0.0
        r.currentLonBack= 0.0
        r.currentLat= 0.0
        r.currentLatBack= 0.0
        r.uSon=''
        r.uSonBack=''
        apps.showAspPanelBack=false
        apps.urlBack=''
        apps.showAspPanelBack=false
        apps.showAspCircleBack=false
    }
    function getEdad(d, m, a, h, min) {
        let hoy = new Date(Date.now())
        let fechaNacimiento = new Date(a, m, d, h, min)
        fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
        let fechaNacimiento2 = new Date(fechaNacimiento)
        let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
        if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
            edad--
        }
        return edad
    }
    function getEdadRS(d, m, a, h, min) {
        let hoy = zm.currentDate//new Date(Date.now())
        let fechaNacimiento = new Date(a, m, d, h, min)
        fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
        let fechaNacimiento2 = new Date(fechaNacimiento)
        let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
        if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
            edad--
        }
        return edad
    }
    function getAgeFromTwoDates(fechaNacimiento, fechaActual) {
        var edad = fechaActual.getFullYear() - fechaNacimiento.getFullYear();
        var mes = fechaActual.getMonth() - fechaNacimiento.getMonth();

        if (mes < 0 || (mes === 0 && fechaActual.getDate() < fechaNacimiento.getDate())) {
            edad--;
        }

        return edad;
    }
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
    function getIndexHouse(gdec, isBack){
        let json=!isBack?zm.currentJson:zm.currentJsonBack
        let index=0
        let g=0.0
        for(var i=0;i<12;i++){
            let iseg=json.ph['h'+parseInt(i+1)].gdec
            let fseg
            if(i!==11){
                fseg=json.ph['h'+parseInt(i+2)].gdec
            }else{
                fseg=json.ph['h1'].gdec
            }
            if(fseg<iseg)fseg=fseg+360
            if(gdec>=iseg && gdec<=fseg){
                index=i
                break
            }
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
    function setHousesPointerShow(ih, only){
        if(!only){
            let i=r.aHouseShowed.indexOf(ih)
            if(i>=0){
                aHouseShowed.splice(i, 1);
            }else{
                aHouseShowed.push(ih)
            }
        }else{
            r.aHouseShowed=[]
            r.aHouseShowed.push(ih)
        }
        //log.lv('r.aHouseShowed: '+r.aHouseShowed)

    }
    //<--Funciones Varias

    //-->Data
    function getParams(){
        return zfdm.getJsonAbsParams()
    }
    function getBodieStatus(bodie, sign) {
        // Definimos las tablas de exaltación, caída y domicilio para cada cuerpo celeste
        const exaltation = {
            'Sol': 'aries',
            'Luna': 'tauro',
            'Mercurio': 'virgo',
            'Venus': 'piscis',
            'Marte': 'capricornio',
            'Júpiter': 'cancer',
            'Saturno': 'libra',
            'Urano': 'escorpio',
            'Neptuno': 'leo',
            'Plutón': 'aries',
            'N.Norte': 'geminis',
            'N.Sur': 'sagitario',
            'Quirón': 'aries',
            'Selena': 'tauro',
            'Lilith': 'escorpio',
            'Pholus': 'sagitario',
            'Ceres': 'cancer',
            'Pallas': 'libra',
            'Juno': 'leo',
            'Vesta': 'virgo'
        };

        const fall = {
            'Sol': 'libra',
            'Luna': 'escorpio',
            'Mercurio': 'piscis',
            'Venus': 'virgo',
            'Marte': 'cancer',
            'Júpiter': 'capricornio',
            'Saturno': 'aries',
            'Urano': 'tauro',
            'Neptuno': 'capricornio',
            'Plutón': 'libra',
            'N.Norte': 'sagitario',
            'N.Sur': 'geminis',
            'Quirón': 'libra',
            'Selena': 'escorpio',
            'Lilith': 'tauro',
            'Pholus': 'geminis',
            'Ceres': 'capricornio',
            'Pallas': 'aries',
            'Juno': 'acuario',
            'Vesta': 'piscis'
        };

        const domicile = {
            'Sol': 'leo',
            'Luna': 'cancer',
            'Mercurio': 'geminis',
            'Venus': 'tauro',
            'Marte': 'aries',
            'Júpiter': 'sagitario',
            'Saturno': 'capricornio',
            'Urano': 'acuario',
            'Neptuno': 'piscis',
            'Plutón': 'escorpio',
            'N.Norte': 'geminis',
            'N.Sur': 'sagitario',
            'Quirón': 'aries',
            'Selena': 'tauro',
            'Lilith': 'escorpio',
            'Pholus': 'sagitario',
            'Ceres': 'cancer',
            'Pallas': 'libra',
            'Juno': 'leo',
            'Vesta': 'virgo'
        };

        // Verificamos el estado del cuerpo celeste
        if (exaltation[bodie] === sign) {
            return 'exaltación';
        } else if (fall[bodie] === sign) {
            return 'caída';
        } else if (domicile[bodie] === sign) {
            return 'domicilio';
        } else {
            return 'normal';
        }
    }
    //<--Data
}
