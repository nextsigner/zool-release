import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12

import unik.UnikQProcess 1.0
import unik.Unik 1.0


import "./js/Funcs_v2.js" as JS
import "./js/Capture.js" as CAP
import "./comps" as Comps

//Default Modules
import comps.ZoolAppSettings 1.0
import ZoolNewsAndUpdates 3.4
import ZoolMainWindow 1.0
import ZoolTopMenuBar 1.0
import ZoolText 1.0
import ZoolDataBar 3.1
import ZoolDataView 1.2
import ZoolEvolutionView 1.0
import ZoolLogView 1.0

import ZoolFileDataManager 1.0
import web.ZoolServerFileDataManager 1.0
//import ZoolBodies 1.10
import ZoolMap 2.0
import ZoolBodiesGuiTools 1.0

import ZoolMenus.ZoolMenuCtxAs 1.0
import ZoolMenus.ZoolMenuCtxNom 1.0
import ZoolMenus.ZoolMenuCtxIsDataDiff 1.0
import ZoolMenus.ZoolMenuCtxSep 1.0

import ZoolMenuCtxZodiacBack 1.0
import ZoolMenuCtxPlanetsAsc 1.0
import ZoolMenuCtxHouses 1.0

import ZoolControlsTime 1.0

import ZoolSectionsManager 1.1

import ZoolDataBodies 3.1
import ZoolElementsBack 1.0


import comps.ZoolPanelNotifications 1.0
import web.ZoolWebStatusManager 1.0
//import MinymaClient 1.0

import ZoolMediaLive 1.1
import ZoolVoicePlayer 1.0
import ZoolDataEditor 1.0
import ZoolVideoPlayer 1.0
import ZoolInfoDataView 1.0
import ZoolBottomBar 1.0

import NodeIOQml 1.1

import ZoolRemoteDataManager 1.0


ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight-app.fs*4
    color: apps.enableBackgroundColor?apps.backgroundColor:'black'
    title: argtitle && argtitle.length>1?argtitle:'Zool '+version
    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    property string version: '0.0.-1'
    property string sweBodiesPythonFile: Qt.platform.os==='linux'?'astrologica_swe_v4.py':'astrologica_swe.py'
    property var j: JS
    property var c: CAP

    property string mainLocation: ''
    //property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+unik.getPath(4)+'/Python/python.exe'+'"'

    property string pythonLocation: Qt.platform.os==='linux'?'python3':'"'+currentPath+'/Python/python.exe'+'"'

    property int fs: apps.fs//Qt.platform.os==='linux'?width*0.02:width*0.02
    property string stringRes: 'Screen'+Screen.width+'x'+Screen.height
    property string url
    property string t: 'vn'

    property bool backIsSaved: false

    property var objInFullWin
    //property bool capturing: false

    property bool showCenterLine: false
    property bool enableAn: false
    property int msDesDuration: 500

    property var minymaClient2
    property var objZoolFileExtDataManager
    property var aExtsIds: []

//    property string fileData: ''
//    property string fileDataBack: ''
//    property string currentData: ''
//    property string currentDataBack: ''
//    property var currentJson
//    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''


    property date currentDateBack
    property string currentNomBack: ''
    property string currentFechaBack: ''
    property string currentLugarBack: ''
    property int currentAbsolutoGradoSolarBack: -1
    property int currentGradoSolarBack: -1
    property int currentMinutoSolarBack: -1
    property int currentSegundoSolarBack: -1
    property real currentGmtBack: 0
    property real currentLonBack: 0.0
    property real currentLatBack: 0.0


    property bool lock: false


    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    //property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    //property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'asc', 'mc']
    property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta', 'asc', 'mc']
    property var planetasReferencia: ['el sol', 'la luna', 'el planeta mercurio', 'el planeta venus', 'el planeta marte', 'el planeta jupiter', 'el planeta saturno', 'el planeta urano', 'el planeta neptuno', 'pluton', 'el nodo norte', 'el nodo sur', 'el asteroide quiron', 'la luna blanca selena', 'la luna negra lilith', 'el ascendente', 'el medio cielo']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte']
    //property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

    property var arbolGenealogico: ['Raíz', 'Portal', 'Ala', 'Integrador']

    //property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'G', 'M']
    property var ahys: ['P', 'K', 'O', 'R', 'C', 'A', 'V', 'X', 'H', 'T', 'B', 'M']
    //property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Gauquelin', 'Morinus']
    property var ahysNames: ['Placidus', 'Koch', 'Porphyrius', 'Regiomontanus', 'Campanus', 'Iguales', 'Vehlow', 'Sistema de Rotación Axial', 'Azimuthal', 'Topocéntrico', 'Alcabitus', 'Morinus']
    /*
                ‘P’     Placidus
                ‘K’     Koch
                ‘O’     Porphyrius
                ‘R’     Regiomontanus
                ‘C’     Campanus
                ‘A’ or ‘E’     Equal (cusp 1 is Ascendant)
                ‘V’     Vehlow equal (Asc. in middle of house 1)
                ‘X’     axial rotation system
                ‘H’     azimuthal or horizontal system
                ‘T’     Polich/Page (“topocentric” system)
                ‘B’     Alcabitus
                ‘G’     Gauquelin sectors
                ‘M’     Morinus
*/



    property var cmd

    //XAs
    property var currentXAs
    property bool showPointerXAs: true
    property var currentXAsBack
    property bool showPointerXAsBack: true

    property bool sspEnabled: false

    menuBar: ZoolTopMenuBar {
        id: menuBar
    }
    onDevChanged: {
        if(dev){
            let c=unik.getFile('./dev.qml')
            let comp=Qt.createQmlObject(c, xApp, 'devqmlcode')
        }
    }
    FontLoader {name: "fa-brands-400";source: "./fonts/fa-brands-400.ttf";}
    FontLoader {name: "FontAwesome";source: "./fonts/fontawesome-webfont.ttf";}
    FontLoader {name: "ArialMdm";source: "./fonts/ArialMdm.ttf";}
    FontLoader {name: "TypeWriter";source: "./fonts/typewriter.ttf";}
    Unik{id: unik}
    ZoolAppSettings{id: apps}
    ZoolRemoteDataManager{id: zrdm}
    ZoolFileDataManager{id: zfdm}
    ZoolServerFileDataManager{id: zsfdm}
    NodeIOQml{
        id: nioqml
        user: 'zool'
        to: 'all'
        onDataReceibed:{
            //log.lv("onDataReceibed:"+data+'\n\n')
            let json=JSON.parse(data)
            if(app.dev){
                log.lv("From:"+json.from+'\n\n')
                log.lv("To:"+json.to+'\n\n')
                log.lv("Data:"+json.data+'\n\n')
            }

            /*
            let d = new Date(Date.now())
            let sd=d.toString()

            let txt=''
            txt+='From: '+json.from+' '+sd+'\n'
            txt+='To: '+json.to+'\n'
            txt+='Data: '+json.data
            txt+='\n\n'
            log.lv('nioqml std:'+txt)
            */
            /*if(json.data.indexOf('qmlcode=')>=0){
                let m0=data.split('qmlcode=')
                let c=''
                c+='import QtQuick 2.0\n'
                c+='Item{\n'
                c+='    Component.onCompleted:{\n'
                c+=m0[1]+'\n'
                c+='    }\n'
                c+='}\n'
                let obj=Qt.createQmlObject(c, xApp, 'nioqmlcode')
            }*/
            if(json.data==='isWindowTool'){
                if(app.flags===Qt.Tool){
                    send(json.from, 'isWindowTool=true')
                }else{
                    send(json.from, 'isWindowTool=false')
                }
            }
            if(json.data==='windowToWindow'){
                app.flags=Qt.Window
            }
            if(json.data==='windowToTool'){
                app.flags=Qt.Tool
            }
            if(json.data.indexOf('load=')===0){
                app.j.loadJson('/home/ns/gd/Zool/Ricardo.json')
                zm.automatic=true
            }
            if(json.data==='showDec'){
                apps.showDec=!apps.showDec
            }
            if(json.data==='za'){
                zm.automatic=!zm.automatic
            }
            if(json.data==='centerZoomAndPan'){
                zm.centerZoomAndPos()
            }
            if(json.data.indexOf('zl|')===0){
                let m0=json.data.split('|')
                app.j.loadJson('/home/ns/gd/Zool/'+m0[1]+'.json')
            }
            if(json.data.indexOf('zi|')===0){
                let m0=json.data.split('|')
                let b=m0[1]
                let s=m0[2]
                let h=parseInt(m0[3])+1
                zm.getZiData(b, s, h)
            }
        }
        onDataError:{
            log.lv('Error:\n'+e+'\n\n')
        }
        //Component.onCompleted: init()
    }
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            id: xSwe1
            //width: xApp.width-xLatIzq.width-xLatDer.width
            width: zm.width
            height: xLatIzq.height
            color: apps.backgroundColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: xLatIzq.visible?0:0-xLatIzq.width*0.5
            anchors.bottom: parent.bottom
            //clip: xLatIzq.visible
            //ZoolBodies{id: sweg;objectName: 'sweg'; visible: !app.dev}
            ZoolMap{
                id: zm;
                rectXBackItems.width: xMed.width
                rectXBackItems.height: xMed.height
            }
            Image {
                id: xDataBarUItemGrabber
                //source: xDataBar.uItemGrabber
                source: zoolDataView.uItemGrabber
                width: parent.width
                fillMode: Image.PreserveAspectCrop
                visible: zm.capturing
            }
            Image{
                id: xAspsUItemGrabber
                source: zm.objZoolAspectsView.uItemGrabber
                width: parent.width*0.2
                height: parent.width*0.2
                fillMode: Image.PreserveAspectCrop
                anchors.bottom: parent.bottom
                visible: zm.capturing
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    border.width: 1
                    border.color: 'red'
                    visible: app.dev
                }
            }
            Image{
                id: xAspsUItemGrabberBack
                source: zm.objZoolAspectsViewBack.uItemGrabber
                width: parent.width*0.2
                height: parent.width*0.2
                fillMode: Image.PreserveAspectCrop
                anchors.top: parent.top
                visible: zm.capturing && zm.ev
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    border.width: 1
                    border.color: 'red'
                    visible: app.dev
                }
            }
            Image {
                id: xElementsUItemGrabber
                //source: panelElements.uItemGrabber
                //source: zoolElementsView.uItemGrabber
                //width: panelElements.width
                //fillMode: Image.PreserveAspectFit
                fillMode: Image.PreserveAspectCrop
                anchors.top: xDataBarUItemGrabber.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0-width*0.75
                transform: Scale {
                    xScale: 0.25
                    yScale: 0.25
                }
                visible: zm.capturing
            }
            Rectangle{
                anchors.fill: parent
                color: 'transparent'
                border.width: 1
                border.color: 'yellow'
                visible: app.dev
            }
            Rectangle{
                width: 6
                height: xApp.height*2
                color: 'transparent'//apps.fontColor
                border.width: 1
                border.color: 'red'
                anchors.centerIn: parent
                visible: app.showCenterLine
            }
            Rectangle{
                width: xApp.height*2
                height: 6
                color: 'transparent'//apps.fontColor
                border.width: 1
                border.color: 'red'
                anchors.centerIn: parent
                visible: app.showCenterLine
            }
            ZoolText{
                id: capDate
                text: 'Imagen creada por Zool'
                textFormat: Text.PlainText
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                visible: zm.capturing
            }
        }

        Rectangle{
            id: xMsgProcDatos
            width: txtPD.contentWidth+app.fs
            height: app.fs*4
            color: 'black'
            border.width: 2
            border.color: 'white'
            visible: false
            anchors.centerIn: parent
            ZoolText {
                id: txtPD
                text: 'Procesando datos...'
                //font.pixelSize: app.fs
                //color: 'white'
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: parent.visible=false
            }
        }
        //Keys.onDownPressed: Qt.quit()
    }
    Item{
        id: capa101
        anchors.fill: xApp
        ZoolDataView{id: zoolDataView;}
        Row{
            anchors.top: zoolDataView.bottom
            anchors.bottom: xBottomBar.top
            Rectangle{
                id: xLatIzq
                width: xApp.width*0.2
                height: parent.height
                color: apps.backgroundColor
                visible: apps.showLatIzq
                ZoolSectionsManager{id: zsm}
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatIzq'
                }
            }
            Item{
                width: xLatIzq.width;
                height: 1;
                visible: !xLatIzq.visible


            }
            Item{
                id: xMed
                width: xApp.width-xLatIzq.width-xLatDer.width
                height: parent.height

                //ZoolElementsView{id: zoolElementsView}
                //ExtId
                Text{
                    text: '<b>uExtId: '+zoolDataView.uExtIdLoaded+'</b>'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.dev
                }
                Item{
                    id: xControlsTime
                    width: controlsTime.width
                    height: controlsTime.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTime.showCT=!xControlsTime.showCT
                    }
                    Item{
                        id:xIconClock
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        anchors.right: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTime.showCT=!xControlsTime.showCT
                                xControlsTimeBack.showCT=false
                            }
                        }
                        Text{
                            id:ccinit
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColor
                            anchors.centerIn: parent
                        }
                    }
                    //Comps.ControlsTime{
                    ZoolControlsTime{
                        id: controlsTime
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: zm.currentGmt=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }

                }
                Item{
                    id: xControlsTimeBack
                    width: controlsTimeBack.width
                    height: controlsTimeBack.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: zm.ev
                    property bool showCT: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                    }
                    Item{
                        id:xIconClockBack
                        width: app.fs
                        height: width
                        //anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.horizontalCenterOffset: width+app.fs*0.5
                        anchors.left: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: app.fs*0.1
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                xControlsTimeBack.showCT=!xControlsTimeBack.showCT
                                xControlsTime.showCT=false
                            }
                        }
                        Text{
                            id:ccinitBack
                            text:'\uf017'
                            font.family: 'FontAwesome'
                            font.pixelSize: app.fs*0.75
                            color: apps.houseColorBack//apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                    ZoolControlsTime{
                        id: controlsTimeBack
                        isBack: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: zm.currentGmtBack=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xMed'
                }
                Rectangle{
                    id: centro
                    width: 10
                    height: 5000
                    anchors.centerIn: parent
                    visible: false
                    Rectangle{
                        width: pppText.contentWidth+10
                        height: app.fs
                        anchors.centerIn: parent
                        Text{
                            id: pppText
                            font.pixelSize: app.fs*0.5
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            Item{
                id: xLatDer
                width: xApp.width*0.2
                height: parent.height

                //Chat{id: chat; z: onTop?panelPronEdit.z+1:panelControlsSign.z-1}
                //PanelControlsSign{id: panelControlsSign}
                ZoolDataBodies{id: zoolDataBodies}
                //PanelPronEdit{id: panelPronEdit;}
                ZoolVoicePlayer{id: zoolVoicePlayer}
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatDer'
                }
                ZoolPanelNotifications{id: zpn}
            }
        }
        //Comps.XDataStatusBar{id: xDataStatusBar}
        ZoolBodiesGuiTools{
            id: xTools
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: app.width*0.2
        }
        ZoolBottomBar{id: xBottomBar}
        ZoolInfoDataView{id: xInfoData}
        ZoolDataEditor{id: xEditor}
        //Num.PanelLog{id: panelLog}
        ZoolVideoPlayer{id: panelVideLectura;}
        Comps.VideoListEditor{id: videoListEditor}
        ZoolEvolutionView{id: zev}
    }
    Comps.XSelectColor{
        id: xSelectColor
        width: app.fs*8
        height: app.fs*8
        c: 'backgroundColor'
    }
    ZoolLogView{id: log}
    ZoolWebStatusManager{id: zwsm}
    Item{id: xuqps}
    QtObject{
        id: setHost
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let h=(''+data).replace(/\n/g, '')
                apps.host=h
                let ms=new Date(Date.now()).getTime()
                if(!apps.newClosed){
                    JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/windowstart/main.qml?r='+ms, setZoolStart)
                }
            }else{
                console.log('Data '+isData+': '+data)
                JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    QtObject{
        id: setZoolStart
        function setData(data, isData){
            if(isData){
                console.log('Host: '+data)
                let comp=Qt.createQmlObject(data, app, 'xzoolstart')
            }else{
                console.log('setXZoolStart Data '+isData+': '+data)
                JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }

    //    Text{
    //        text: '->'+menuBar.expanded
    //        font.pixelSize: app.fs*3
    //        color: 'red'
    //    }
    //Comps.MenuPlanets{id: menuPlanets}
    ZoolMenuCtxAs{id: menuPlanets}
    ZoolMenuCtxIsDataDiff{id: zMenuIsDataDiff}
    ZoolMenuCtxNom{id: zMenuNom}
    ZoolMenuCtxSep{id: zMenuSep}
    ZoolMenuCtxZodiacBack{id: menuRuedaZodiacal}
    ZoolMenuPlanetsCtxAsc{id: menuPlanetsCtxAsc}
    ZoolMenuCtxHouses{id: menuCtxHouses}
    ZoolMediaLive{id: zoolMediaLive;parent: zoolDataBodies}

    //Este esta en el centro
    Rectangle{
        id: centroideXMed
        visible: app.dev
        width: 6
        height: width
        color: 'transparent'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
    }

    //Linea vertical medio
    Rectangle{
        width: 2
        height: xApp.height*2
        anchors.centerIn: parent
        visible: app.dev
    }
    //    Timer{
    //        id: tLoadModules
    //        running: false
    //        repeat: false
    //        interval: 5000
    //        onTriggered: JS.loadModules()
    //    }


    Component.onCompleted: {
        let args=Qt.application.arguments
        JS.setFs()

        //Check is dev with the arg -dev
        if(args.indexOf('-dev')>=0){
            app.dev=true
        }
        let localhost=false
        if(args.indexOf('-localhost')>=0)localhost=true
        let setPortByConfigCFG=true
        if(unik.fileExist('./tcpclient.conf')){
            let data=unik.getFile('./tcpclient.conf')

            let lines=data.split('\n')
            nioqml.user=lines[0].replace('user=', '')
            //nioqml.host=lines[1].replace('ip=', '')
            if(localhost){
                nioqml.host='127.0.0.1'
            }else{
                nioqml.host=lines[1].replace('ip=', '')
            }
            if(!setPortByConfigCFG)nioqml.port=parseInt(lines[2].replace('port=', ''))

            //log.lv('User: ['+nioqml.user+']')
            //log.lv('Host: ['+nioqml.host+']')
            //log.lv('Port: ['+nioqml.port+']')
        }

            if(setPortByConfigCFG){
                let portByCfg=unik.getFile('/home/ns/.config/nodeiosport.cfg').replace(/\n/g,'')
               nioqml.port=parseInt(portByCfg)
            }
            nioqml.init()



        let v=unik.getFile('./version')
        app.version=v.replace(/\n/g, '')
        if(app.version!==apps.lastVersion || app.dev){
            apps.lastVersion=app.version
            let c='import QtQuick 2.0\n'
            c+='import ZoolNewsAndUpdates 3.4\n'
            c+='ZoolNewsAndUpdates{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'znaucode')
            obj.z=log.z+1
        }


        //Argumentos
        var i=0
        for(i=0;i<args.length;i++){
            let a=args[i]
            if(a.indexOf('-title=')>=0){
                let mt=a.split('-title=')
                app.title=mt[1]
            }
        }

        //Check apps.jsonsFolderTemp
        if(apps.jsonsFolder===''){
            let jft=unik.getPath(3)+'/Zool/Temp'
            unik.mkdir(jft)
            apps.jsonsFolderTemp=jft
        }
        if(apps.isJsonsFolderTemp){
            let jsonF=apps.jsonsFolder
            let jsonFT=apps.jsonsFolderTemp
            apps.jsonsFolder=jsonFT
            apps.jsonsFolderTemp=jsonF
        }

        if(app.dev){
            log.ls('\nRunning as Dev', 0, xLatIzq.width)
            //log.ls('\nVersion:\n'+version, log.x,
            log.ls('\nunik.currentFolderPath():\n'+unik.currentFolderPath(), log.x, log.width)
            log.ls('\nunik.getPath(4):\n'+unik.getPath(4), log.x, log.width)
            log.ls('\napps.jsonsFolder:\n'+apps.jsonsFolder, log.x, log.width)
            log.ls('\nDocumentPath:\n'+documentsPath, log.x, log.width)
        }

        app.mainLocation=unik.getPath(5)
        if(Qt.platform.os==='windows'){
            app.mainLocation="\""+app.mainLocation+"\""
        }
        console.log('app.mainLocation: '+app.mainLocation)
        console.log('documentsPath: '+documentsPath)
        console.log('Init app.url: '+app.url)
        let fileLoaded=false
        let appArgs=Qt.application.arguments
        let arg=''
        for(i=0;i<appArgs.length;i++){
            let a=appArgs[i]
            if(a.indexOf('file=')>=0){
                let ma=a.split('=')
                if(ma.length>1){
                    arg=ma[1]
                    //log.ls('File: '+arg, 0, xApp.width*0.5)
                    zm.loadJsonFromFilePath(arg)
                    fileLoaded=true
                }
            }
        }
        if(!fileLoaded){
            //let fp=
            if(apps.url!==''&&unik.fileExist(apps.url)&&apps.jsonsFolder!==''){
                console.log('Cargando al iniciar: '+apps.url)
                //Detalles Técnicos extras
                if(app.dev){
                    log.visible=true
                    log.l('\nEl módulo Python SwissEph se encuentra instalado en '+app.pythonLocation)
                    log.l('\nEl módulo MinymaClient se conecta mediante el host: '+minymaClient.host)
                }
                zm.loadJsonFromFilePath(apps.url)
            }else{
                if(!unik.fileExist(apps.url)){
                    log.lv('El archivo '+apps.url+' que se intenta cargar, no existe o ha sido eliminado. Se procede a cargar los tránsitos actuales.')
                    zm.loadNow(false)
                    /*let sep='Sinastría'
                    let aL=[]
                    aL.push('Trásitos de Ahora')
                    let aR=[]
                    zoolDataView.setDataView(sep, aL, aR)*/
                }
                if(app.dev){
                    log.visible=true
                    log.l('\nEl módulo Python SwissEph se encuentra instalado en '+app.pythonLocation)
                    log.l('\nEl módulo MinymaClient se conecta mediante el host: '+minymaClient.host)
                    log.l('\napp.url: '+app.url)
                    log.l('\napp.url exist: '+unik.fileExist(apps.url))
                }
                JS.firstRunTime()
            }
        }
        //JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/zool', setHost)
        apps.host='https://zool.loca.lt'
        JS.loadModules()
        app.requestActivate()
        //log.focus=true
    }
}
