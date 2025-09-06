import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12

import unik.UnikQProcess 1.0
import u.Unik 1.0


import "./js/Funcs_v2.js" as JS
import "./js/Capture.js" as CAP
import "./comps" as Comps

//Default Modules
import comps.ZoolAppSettings 1.0
import comps.FocusSen 1.0
import ZoolNewsAndUpdates 3.4
import ZoolMainWindow 1.0

import ZoolText 1.2
import ZoolDataBar 3.1
import ZoolDataView 1.2
import ZoolEvolutionView 1.0
import ZoolLogView 1.0

import ZoolFileDataManager 1.0
import ZoolDataSheet 1.0
import web.ZoolServerFileDataManager 1.0
import comps.ZipDownloader 1.0
//import ZoolBodies 1.10
import ZoolMap 5.0
import ZoolBodiesGuiTools 1.0

//-->Menus
import ZoolMenus.ZoolTopMenuBar 1.1
import ZoolMenus.ZoolMenuCtxAs 1.0
import ZoolMenus.ZoolMapMenuCtx 1.0
import ZoolMenuCtxPlanetsAsc 1.0
import ZoolMenuCtxHouses 1.0
//<--Menus


import ZoolControlsTime 1.0

import ZoolSectionsManager 1.2

import gui.ZoolDataBodies 3.3

import comps.ZoolPanelNotifications 1.1
import web.ZoolWebStatusManager 1.0
import comps.ZoolIntSplash 1.0
//import MinymaClient 1.0

import ZoolDataManager 1.0
import ZoolDataEditor 1.0
import ZoolInfoDataView 1.0
import ZoolBottomBar 1.0

import NodeIOQml 1.1

import ZoolRemoteDataManager 1.0

import comps.PushOver 1.0


ZoolMainWindow{
    id: app
    visible: true
    visibility: "Maximized"
    width: Screen.width
    height: Screen.height
    minimumWidth: Screen.desktopAvailableWidth-app.fs*4
    minimumHeight: Screen.desktopAvailableHeight-app.fs*4
    color: apps.enableBackgroundColor?apps.backgroundColor:'black'
    title: 'Zool '+version
    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    //property var qmlListErrors: qmlErrorLogger.messages
    property string version: '0.0.-1'
    //property string sweBodiesPythonFile: Qt.platform.os==='linux'?'astrologica_swe_v4.py':'astrologica_swe.py'

    //Python
    property string sweFolder: Qt.platform.os==='windows'?'"'+u.getPath(1)+'/swe"':'/usr/share/ephe/swe'
    property string sweBodiesPythonFile: Qt.platform.os==='windows'?'astrologica_swe_v4.py':'zool_swe_portable_2.10.3.2_v1.py'
    property string pythonLocation: Qt.platform.os==='windows'?'"'+u.getPath(1).replace(/\"/g, '')+'/Python/python.exe"':'python3'

    property var j: JS
    property var c: CAP

    property string mainLocation: ''
    //property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+u.getPath(4)+'/Python/python.exe'+'"'

    //property string pythonLocation: Qt.platform.os==='linux'?'python3':'python'

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
            let c=u.getFile('./dev.qml')
            let comp=Qt.createQmlObject(c, xApp, 'devqmlcode')
        }
    }
    Connections {
        target: qmlErrorLogger
        onMessagesChanged: {
            if(apps.showQmlErrors)log.lv(qmlErrorLogger.messages[qmlErrorLogger.messages.length-1]);
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
    ZoolDataSheet{id: zds}
    ZoolServerFileDataManager{id: zsfdm}
    ZipDownloader{
        id: zipDownloader
        dev: true
        //version:'0.0.0.0'

        Component.onCompleted: {
            //let url = 'https://github.com/nextsigner/zool-release'
            //download(url)
        }
    }
    Rectangle{
        id: xVisibleItems
        color: apps.backgroundColor
        anchors.fill: parent
        Item{
            id: xApp
            anchors.fill: parent
            Rectangle{
                id: xZoolMap
                width: xMed.width
                height: xMed.height
                border.width: xZoolMap.showDevLines?10:0
                border.color: '#ff8833'
                color: xZoolMap.showDevLines?'gray':'transparent'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                property bool showDevLines: false
                Rectangle{
                    id: xSwe1
                    width: parent.width
                    height: parent.height
                    transform: Scale{ xScale: xZoolMap.showDevLines?0.25:1.0; yScale: xZoolMap.showDevLines?0.25:1.0 }
                    color: apps.backgroundColor
                    x: xZoolMap.showDevLines?(parent.width*0.5)-width*0.25*0.5:0
                    y: xZoolMap.showDevLines?(parent.height*0.5)-height*0.25*0.5:0
                    clip: true
                    //ZoolBodies{id: sweg;objectName: 'sweg'; visible: !apps.dev}
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
                    /*
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
                            visible: apps.dev
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
                            visible: apps.dev
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
                    */
                    Rectangle{
                        anchors.fill: parent
                        color: 'transparent'
                        border.width: 1
                        border.color: 'yellow'
                        visible: apps.dev
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
                    id: xDevLines
                    width: 4
                    height: parent.height*4
                    anchors.centerIn: parent
                    visible: xZoolMap.showDevLines
                    Rectangle{
                        width: parent.parent.width*4
                        height: 4
                        anchors.centerIn: parent
                    }
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

                    FocusSen{visible: apps.zFocus==='xLatIzq'}
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
                        visible: apps.dev
                    }
                    /*
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
                    */
                    FocusSen{visible: apps.zFocus==='xMed'}
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
                    ZoolBodiesGuiTools{
                        id: xTools
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        //anchors.rightMargin: app.width*0.2
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
                    FocusSen{visible: apps.zFocus==='xLatDer'}
                    ZoolPanelNotifications{
                        id: zpn
                        anchors.right: parent.right
                        anchors.rightMargin: apps.zFocus==='xLatDer'?xLatDer.width:0
                    }
                }
            }
            //Comps.XDataStatusBar{id: xDataStatusBar}

            ZoolBottomBar{id: xBottomBar}
            ZoolInfoDataView{id: xInfoData}
            ZoolDataEditor{id: xEditor}
            ZoolEvolutionView{id: zev}
            ZoolIntSplash{id: zis}
        }
        Comps.XSelectColor{
            id: xSelectColor
            width: app.fs*8
            height: app.fs*8
            c: 'backgroundColor'
        }
        ZoolLogView{
            id: log;
            width: xLatIzq.width
            height: xLatIzq.height
            anchors.bottom: parent.bottom
        }
        ZoolWebStatusManager{id: zwsm}
        ZoolDataManager{id: zdm}
    }
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
                app.j.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    PushOver{id: pushOver}
    //    Text{
    //        text: '->'+menuBar.expanded
    //        font.pixelSize: app.fs*3
    //        color: 'red'
    //    }
    //Comps.MenuPlanets{id: menuPlanets}
    ZoolMenuCtxAs{id: menuPlanets}
    ZoolMapMenuCtx{id: menuRuedaZodiacal}
    ZoolMenuPlanetsCtxAsc{id: menuPlanetsCtxAsc}
    ZoolMenuCtxHouses{id: menuCtxHouses}
    //ZoolMediaLive{id: zoolMediaLive;parent: zoolDataBodies}

    //Este esta en el centro
    Rectangle{
        id: centroideXMed
        visible: apps.dev
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
        visible: apps.dev
    }
    //    Timer{
    //        id: tLoadModules
    //        running: false
    //        repeat: false
    //        interval: 5000
    //        onTriggered: JS.loadModules()
    //    }


    Component.onCompleted: {
        if(Qt.platform.os==='linux' && !u.folderExist(app.sweFolder)){
            log.lv('Error de instalación de Zool para GNU/Linux.\nSwe no está instalado.')
            return

        }

        zipDownloader.curlPath=Qt.platform.os==='windows'?'"'+u.getPath(1)+'/curl-8.14.1_2-win64-mingw/bin/curl.exe"':'curl'
        zipDownloader.app7ZipPath=Qt.platform.os==='windows'?'"'+u.getPath(1)+'/7-Zip32/7z.exe"':'7z'

        let c='import ZoolDataManager 1.0\n'
        c+='ZoolDataManager{}'
        let obj=Qt.createQmlObject(c, capa101, 'ziscode')
        menuBar.aMenuItems.push(menuRuedaZodiacal)


        if(apps.workSpace==='')apps.workSpace=u.getPath(3)+'/Zool'
        if(!u.folderExist(u.getPath(3)+'/Zool')){
            u.mkdir(u.getPath(3)+'/Zool')
        }
        if(apps.dev)log.lv('Ultimo archivo cargado con anterioridad: '+apps.url)
        let args=Qt.application.arguments
        JS.setFs()
        zm.setTheme(apps.currentThemeIndex)
        //Check is dev with the arg -dev
        if(args.indexOf('-dev')>=0){
            apps.dev=true
        }





        let v=u.getFile('./version')
        app.version=v.replace(/\n/g, '')
        /*if(app.version!==apps.lastVersion || apps.dev){
            apps.lastVersion=app.version
            let c='import QtQuick 2.0\n'
            c+='import ZoolNewsAndUpdates 3.4\n'
            c+='ZoolNewsAndUpdates{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'znaucode')
            obj.z=log.z+1
        }*/
        //if(Qt.platform.os==='linux'){
        if(Qt.platform.os==='windows'){
            let c='import QtQuick 2.0\n'
            c+='import comps.ZoolWinUpdate 1.0\n'
            c+='ZoolWinUpdate{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'zoolwinupdatecode')
            obj.z=log.z+1
        }else{
            let c='import QtQuick 2.0\n'
            c+='import comps.ZoolLinuxUpdate 1.0\n'
            c+='ZoolLinuxUpdate{}\n'
            let obj=Qt.createQmlObject(c, xLatIzq, 'zoolwinupdatecode')
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

        //Check apps.workSpaceTemp
        if(apps.workSpace===''){
            let jft=u.getPath(3)+'/Zool/Temp'
            u.mkdir(jft)
            apps.workSpaceTemp=jft
        }
        if(apps.isJsonsFolderTemp){
            let jsonF=apps.workSpace
            let jsonFT=apps.workSpaceTemp
            apps.workSpace=jsonFT
            apps.workSpaceTemp=jsonF
        }

        if(apps.dev){
            log.ls('\nRunning as Dev', 0, xLatIzq.width)
            //log.ls('\nVersion:\n'+version, log.x,
            log.ls('\nu.currentFolderPath():\n'+u.currentFolderPath(), log.x, log.width)
            log.ls('\nu.getPath(4):\n'+u.getPath(4), log.x, log.width)
            log.ls('\napps.workSpace:\n'+apps.workSpace, log.x, log.width)
            log.ls('\nDocumentPath:\n'+documentsPath, log.x, log.width)
        }

        app.mainLocation=u.getPath(5)
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
                    if(apps.dev)log.lv('Cargando '+arg)
                    zm.loadJsonFromFilePath(arg)
                    fileLoaded=true
                }
            }
        }
        if(!fileLoaded){
            //let fp=
            if(apps.url!==''&&u.fileExist(apps.url)&&apps.workSpace!==''){
                console.log('Cargando al iniciar: '+apps.url)
                //Detalles Técnicos extras
                if(apps.dev){
                    log.visible=true
                    log.l('\nEl módulo Python SwissEph se encuentra instalado en '+app.pythonLocation)
                }
                if(apps.dev)log.lv('Cargando en modo desarrollo: '+apps.url)
                zm.loadJsonFromFilePath(apps.url)
            }else{
                if(apps.url===''){
                    zdm.firstRunTime()
                }else{
                    if(!u.fileExist(apps.url)){
                        log.lv('El archivo '+apps.url+' que se intenta cargar, no existe o ha sido eliminado. Se procede a cargar los tránsitos actuales.')
                        zm.loadNow(false)
                        /*let sep='Sinastría'
                    let aL=[]
                    aL.push('Trásitos de Ahora')
                    let aR=[]
                    zoolDataView.setDataView(sep, aL, aR)*/
                    }
                    if(apps.dev){
                        log.visible=true
                        log.l('\nEl módulo Python SwissEph se encuentra instalado en '+app.pythonLocation)
                        log.l('\nEl módulo MinymaClient se conecta mediante el host: '+minymaClient.host)
                        log.l('\napp.url: '+app.url)
                        log.l('\napp.url exist: '+u.fileExist(apps.url))
                    }
                }

            }
        }
        //JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/zool', setHost)
        apps.host='https://zool.loca.lt'
        //app.j.loadModules()
        app.requestActivate()
        //log.focus=true
    }
}
