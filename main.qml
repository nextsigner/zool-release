import QtQuick 2.12
//import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import QtMultimedia 5.12
import Qt.labs.folderlistmodel 2.12
import Qt.labs.settings 1.1

import unik.UnikQProcess 1.0
import unik.Unik 1.0


import "./js/Funcs.js" as JS
import "./comps" as Comps

//Default Modules
import ZoolMainWindow 1.0
import ZoolTopMenuBar 1.0
import ZoolText 1.0
import ZoolDataBar 3.1
import ZoolDataText 1.0
import ZoolLogView 1.0
import ZoolBodies 1.2
import ZoolBodiesGuiTools 1.0
import ZoolFileManager 1.1
import ZoolFileLoader 1.0
import ZoolDataBodies 3.0
import ZoolSabianos 1.0
import ZoolRevolutionList 1.1
import ZoolNumPit 1.0
import ZoolMediaLive 1.0
import ZoolDataEditor 1.0
import ZoolVideoPlayer 1.0
import ZoolInfoDataView 1.0
import ZoolBottomBar 1.0




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
    //title:'sdsa'
    property bool dev: Qt.application.arguments.indexOf('-dev')>=0
    property string version: '0.0.-1'

    property string mainLocation: ''
    property string pythonLocation: Qt.platform.os==='linux'?'python3':pythonLocationSeted?'"'+pythonLocationSeted+'"':'"'+unik.getPath(4)+'/Python/python.exe'+'"'
    //property string pythonLocation: './Python/python.exe'
    property int fs: apps.fs//Qt.platform.os==='linux'?width*0.02:width*0.02
    property string stringRes: 'Screen'+Screen.width+'x'+Screen.height
    property string url
    property string mod: 'mi'

    property var objInFullWin
    property bool capturing: false

    property bool showCenterLine: false
    property bool enableAn: false
    property int msDesDuration: 500


    property string fileData: ''
    property string fileDataBack: ''
    property string currentData: ''
    property string currentDataBack: ''
    property var currentJson
    property var currentJsonBack
    property bool setFromFile: false

    //Para analizar signos y ascendentes por región
    property int currentIndexSignData: 0
    property var currentJsonSignData: ''

    property int currentPlanetIndex: -1
    property int currentPlanetIndexBack: -1
    property int currentSignIndex: 0

    property date currentDate
    property string currentNom: ''
    property string currentFecha: ''
    property string currentLugar: ''
    property int currentAbsolutoGradoSolar: -1
    property int currentGradoSolar: -1
    property int currentRotationxAsSol: -1
    property int currentMinutoSolar: -1
    property int currentSegundoSolar: -1
    property real currentGmt: 0
    property real currentLon: 0.0
    property real currentLat: 0.0
    property real currentAlt: 0

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
    property string uSon: ''
    property string uSonFCMB: ''
    property string uSonBack: ''

    property string uCuerpoAsp: ''

    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith']
    property var planetasArchivos: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'asc', 'mc']
    property var planetasRes: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'n', 's', 'hiron', 'selena', 'lilith']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    property var meses: ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

    //Asp Astrolog Search
    property var planetasAS: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte']
    property var planetasResAS: ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto', 'North Node']

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

    property int uAscDegreeTotal: -1
    property int uAscDegree: -1
    property int uMcDegree: -1
    //property string stringRes: "Res"+Screen.width+"x"+Screen.height

    property var cmd
    property bool ev: false //Exterior Visible

    //XAs
    property var currentXAs
    property bool showPointerXAs: true
    property var currentXAsBack
    property bool showPointerXAsBack: true

    property bool sspEnabled: false

    onCurrentPlanetIndexChanged: {
        panelDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>=0)app.currentPlanetIndexBack=-1
        if(sspEnabled){
            if(currentPlanetIndex>=-1&&currentPlanetIndex<10){
                app.ip.opacity=1.0
                app.ip.children[0].ssp.setPlanet(currentPlanetIndex)
            }else{
                app.ip.opacity=0.0
            }
        }
        //panelDataBodies.currentIndex=currentPlanetIndex
        if(currentPlanetIndex>14){
            /*if(currentPlanetIndex===15){
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
        panelDataBodies.currentIndexBack=currentPlanetIndexBack
        if(currentPlanetIndexBack>=0)app.currentPlanetIndex=-1
    }
    onCurrentGmtChanged: {
        if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    onCurrentGmtBackChanged: {
        //if(app.currentData===''||app.setFromFile)return
        //xDataBar.currentGmtText=''+currentGmtBack
        tReloadBack.restart()
    }
    onCurrentDateChanged: {
        controlsTime.setTime(currentDate)
        if(app.currentData===''||app.setFromFile)return
        xDataBar.state='show'
        let a=currentDate.getFullYear()
        let m=currentDate.getMonth()
        let d=currentDate.getDate()
        let h=currentDate.getHours()
        let min=currentDate.getMinutes()
        //xDataBar.currentDateText=d+'/'+parseInt(m + 1)+'/'+a+' '+h+':'+min
        //xDataBar.currentGmtText=''+currentGmt
        tReload.restart()
    }
    onCurrentDateBackChanged: {
        controlsTimeBack.setTime(currentDateBack)
        if(app.mod==='trans'){
            JS.loadTransFromTime(app.currentDateBack)
        }
        xDataBar.state='show'
        let a=currentDateBack.getFullYear()
        let m=currentDateBack.getMonth()
        let d=currentDateBack.getDate()
        let h=currentDateBack.getHours()
        let min=currentDateBack.getMinutes()
        tReloadBack.restart()
    }

    FontLoader {name: "fa-brands-400";source: "./fonts/fa-brands-400.ttf";}
    FontLoader {name: "FontAwesome";source: "./fonts/fontawesome-webfont.ttf";}
    FontLoader {name: "ArialMdm";source: "./fonts/ArialMdm.ttf";}
    FontLoader {name: "TypeWriter";source: "./fonts/typewriter.ttf";}
    Unik{id: unik}
    Settings{
        id: apps
        //fileName:unik.getPath(4)+'/zool_'+Qt.platform.os+'.cfg'
        fileName:'zool_'+Qt.platform.os+'.cfg'

        //Minyma
        property string minymaClientHost: 'ws://127.0.0.1:12345'
        property int minymaClientPort: 12345
        property bool showLog: false
        property int fs: app.width*0.02
        property int fsSbValue: 50
        property string host: 'http://localhost'
        property string hostQuiron: 'https://github.com/nextsigner/quiron/raw/master/data'
        property bool newClosed: false

        property string url: ''
        property string urlBack: ''
        property bool showLatIzq: true
        property bool showTimes: false
        property bool showLupa: false
        property bool showSWEZ: true


        //Paneles
        property string panelRemotoState: 'show'
        property int currentSwipeViewIndex: 0
        property int currentZoolTextRectCamHeight: app.fs*6

        //Houses
        property string defaultHsys: 'P'
        property string currentHsys: 'P'
        property string houseColor: "#2CB5F9"
        property string houseColorBack: 'red'
        property bool showHousesAxis: false
        property int widthHousesAxis: 3.0
        property string houseLineColor: 'white'
        property string houseLineColorBack: 'red'

        //XAs
        property color xAsColor: 'white'
        property color xAsColorBack: 'black'
        property color xAsBackgroundColorBack: 'white'
        property real xAsBackgroundOpacityBack: 0.5
        property bool anColorXAs: false
        property bool anRotation3CXAs: false
        property color pointerLineColor: 'red'
        property int pointerLineWidth: 4
        property bool xAsShowIcon: false

        //Asp
        property int aspLineWidth: 6
        property bool panelAspShowBg: true

        //Swe
        property string swegMod: 'ps'
        property bool showNumberLines: false
        property bool showDec: false
        property bool showXAsLineCenter: false
        property color xAsLineCenterColor: 'red'
        property real sweMargin: 1.8
        property real signCircleWidth: Screen.width*0.02
        property real signCircleWidthSbValue: 8000
        property int sweFs: Screen.width*0.020
        property bool showAspCircle: true
        property bool showAspCircleBack: true
        property bool showAspPanel: true
        property bool showAspPanelBack: true
        property bool enableWheelAspCircle: false

        //GUI
        property string zFocus: 'xLatIzq'

        //property bool showLog: false
        property bool showMenuBar: false
        property bool enableBackgroundColor: false
        property string backgroundColor: "black"
        property string fontFamily: "ArialMdm"
        property string fontColor: "white"
        property int fontSize: app.fs*0.5
        property int botSize: app.fs*0.5
        property int botSizeSpinBoxValue: 50
        property real elementsFs: Screen.width*0.02
        property bool xToolEnableHide: true

        //Reproductor de Lectura
        property bool repLectVisible: false
        property url repLectCurrentFolder: documentsPath
        property int repLectX: 0
        property int repLectY: Screen.height*0.7
        property int repLectW: Screen.width*0.21
        property int repLectH: Screen.width*0.15

        property string repLectCurrentVidIntro: ''
        property string repLectCurrentVidClose: ''

        //Reproductor Audio Texto a Voz
        property url repAudioTAVCurrentFolder: documentsPath+'/audio'


        property int lupaMod: 2
        property int lupaBorderWidth: 3
        property string lupaColor: "white"
        property real lupaOpacity: 0.5
        property int lupaRot: 0
        property int lupaX: Screen.width*0.5
        property int lupaY: Screen.height*0.5
        property int lupaAxisWidth: 1
        property int lupaCenterWidth: 20

        //IW
        property int iwFs: Screen.width*0.02
        property int iwWidth: Screen.width*0.5

        property int editorFs: Screen.width*0.01
        property bool editorShowNumberLines: false
        property int editorTextFormat: 0

        //Panel Sabianos
        property real panelSabianosFz: 1.0
        property bool sabianosAutoShow: false

        //Panel AspTrans
        property int currentIndexP1: 0
        property int currentIndexP2: 0
        property int currentIndexAsp: 0
        property int currentAspCantAniosSearch: 20
        property bool autoShow: false

        property bool chat: false

        property bool backgroundImagesVisible: false
        property bool lt:false
        property bool enableFullAnimation: false

        property string jsonsFolder: ''
        property string jsonsFolderTemp: ''
        property bool isJsonsFolderTemp: false

        //Num
        property string numCurrentFolder: unik.getPath(3)
        property string numUFecha
        property string numUNom
        property string numUFirma
        property bool numShowFormula: false
        property int numPanelLogFs: app.width*0.02
        onIsJsonsFolderTempChanged: {
            let jf=jsonsFolder
            let jft=jsonsFolderTemp
            if(isJsonsFolderTemp){
                jsonsFolder=jft
                jsonsFolderTemp=jf
            }else{
                jsonsFolder=jft
                jsonsFolderTemp=jf
            }
        }
        onZFocusChanged: {
            if(zFocus==='xMed'||zFocus==='xLatDer'){
                //zoolFileManager.ti.focus=false
                //panelRsList.desactivar()
            }else{
                if(sv.currentIndex===2){
                    //zoolFileManager.ti.focus=true
                }
            }
        }
        onShowLupaChanged: sweg.centerZoomAndPos()
        onEnableBackgroundColorChanged: {
            if(enableBackgroundColor){
                ip.hideSS()
            }else{
                ip.showSS()
            }
        }
    }
    menuBar: ZoolTopMenuBar {
        id: menuBar
    }
    Timer{
        id: tReload
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            JS.setNewTimeJsonFileData(app.currentDate)
            JS.runJsonTemp()
        }
    }
    Timer{
        id: tReloadBack
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            JS.setNewTimeJsonFileDataBack(app.currentDateBack)
            JS.runJsonTempBack()
        }
    }
    Item{
        id: xApp
        anchors.fill: parent
        Rectangle{
            id: xSwe1
            //width: xApp.width-xLatIzq.width-xLatDer.width
            width: sweg.width
            height: xLatIzq.height
            color: apps.backgroundColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: xLatIzq.visible?0:0-xLatIzq.width*0.5
            anchors.bottom: parent.bottom
            clip: xLatIzq.visible
            ZoolBodies{id: sweg;objectName: 'sweg'}
            Image {
                id: xDataBarUItemGrabber
                source: xDataBar.uItemGrabber
                width: parent.width
                fillMode: Image.PreserveAspectCrop
                visible: app.capturing
            }
            Image{
                id: xAspsUItemGrabber
                source: sweg.objZoolAspectsView.uItemGrabber
                width: parent.width*0.2
                height: parent.width*0.2
                fillMode: Image.PreserveAspectCrop
                anchors.bottom: parent.bottom
                visible: app.capturing
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
                source: sweg.objZoolAspectsViewBack.uItemGrabber
                width: parent.width*0.2
                height: parent.width*0.2
                fillMode: Image.PreserveAspectCrop
                anchors.top: parent.top
                visible: app.capturing && app.ev
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    border.width: 1
                    border.color: 'red'
                    visible: app.dev
                }
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
        ZoolDataBar{id: xDataBar}
        //ZoolDataBar{id: xDataBar;parent:xSwe1}
        Row{
            //anchors.centerIn: parent
            anchors.top: xDataBar.bottom
            anchors.bottom: xBottomBar.top
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.horizontalCenterOffset: xLatIzq.visible?0:0-xLatIzq.width
            Item{
                id: xLatIzq
                width: xApp.width*0.2
                height: parent.height
                visible: apps.showLatIzq
                //z: xMed.z+1
                //                Rectangle{
                //                    width: 8000
                //                    height: 100
                //                    color: 'red'
                //                    anchors.centerIn: parent
                //                }
                Column{
                    anchors.centerIn: parent
                    Rectangle{
                        id: xPanelesTits
                        width: xLatIzq.width
                        height: app.fs*0.6
                        color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        property var aPanelesTits: ['Información','Sabianos', 'Archivos', 'Revolución Solar', 'Módulos', 'Numerología', 'Funciones', 'Opciones', 'Texto a voz']
                        Text{
                            text: parseInt(sv.currentIndex + 1)+': '+xPanelesTits.aPanelesTits[sv.currentIndex]
                            color: apps.backgroundColor
                            font.pixelSize: app.fs*0.5
                            anchors.centerIn: parent
                        }
                    }
                    Item{
                        id: sv
                        property int currentIndex: apps.currentSwipeViewIndex
                        property int count: indicatorSV.count
                        onCurrentIndexChanged:{
                            apps.currentSwipeViewIndex=currentIndex
                            panelRsList.desactivar()
                        }
                        width: xApp.width*0.5
                        height: xLatIzq.height-indicatorSV.height-xPanelesTits.height
                        clip: true
                        Comps.XPaneles{ZoolDataText{id: panelZoolText;itemIndex: 0}}
                        Comps.XPaneles{ZoolSabianos{id: panelSabianos;itemIndex: 1}}
                        Comps.XPaneles{ZoolFileManager{id: zoolFileManager;itemIndex: 2}}
                        Comps.XPaneles{ZoolRevolutionList{id: panelRsList;itemIndex: 3}}
                        Comps.XPaneles{Comps.PanelZoolModules{id: panelZoolModules;itemIndex: 4}}
                        Comps.XPaneles{ZoolNumPit{id: ncv;itemIndex: 5}}
                        //XPaneles{PanelBotsFuncs{id: panelBotsFuncs;itemIndex: 6}}
                        Comps.XPaneles{Comps.PanelZoolData{id: panelZoolData;itemIndex: 6}}
                        //XPaneles{PanelVideoLectura{id: panelVideLectura;itemIndex: 9}}
                    }
                    Rectangle{
                        width: xLatIzq.width
                        height: indicatorSV.height
                        color: 'transparent'
                        anchors.horizontalCenter: parent.horizontalCenter
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                apps.zFocus='xLatIzq'
                            }
                        }
                        PageIndicator {
                            id: indicatorSV
                            interactive: true
                            count: sv.children.length
                            currentIndex: sv.currentIndex
                            anchors.centerIn: parent
                            onCurrentIndexChanged: sv.currentIndex=currentIndex
                            delegate: Rectangle{
                                width: app.fs*0.5
                                height: width
                                radius: width / 2
                                color: apps.fontColor
                                opacity: index === indicatorSV.currentIndex?0.95: pressed ? 0.7: 0.45
                                Text{
                                    text:'\uf26c'
                                    font.family: "FontAwesome"
                                    font.pixelSize: parent.width*0.6
                                    color: apps.backgroundColor
                                    anchors.centerIn: parent
                                    visible: index===0&&apps.repLectVisible
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        sv.currentIndex=index
                                        if (mouse.modifiers) {
                                            apps.repLectVisible=!apps.repLectVisible
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatIzq'
                }
            }
            Item{width: xLatIzq.width;height: 1;visible: !xLatIzq.visible}
            Item{
                id: xMed
                width: xApp.width-xLatIzq.width-xLatDer.width
                height: parent.height
                Comps.PanelElements{id: panelElements}
                Comps.PanelElementsBack{id: panelElementsBack}
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
                    Comps.ControlsTime{
                        id: controlsTime
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: app.currentGmt=gmt
                        Behavior on h{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
                    }

                }
                Item{
                    id: xControlsTimeBack
                    width: controlsTimeBack.width
                    height: controlsTimeBack.height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
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
                    Comps.ControlsTime{
                        id: controlsTimeBack
                        isBack: true
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: h
                        property int h: parent.showCT?0:0-height
                        setAppTime: true
                        onGmtChanged: app.currentGmtBack=gmt
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
            }
            Item{
                id: xLatDer
                width: xApp.width*0.2
                height: parent.height

                //Chat{id: chat; z: onTop?panelPronEdit.z+1:panelControlsSign.z-1}
                //PanelControlsSign{id: panelControlsSign}
                ZoolDataBodies{id: panelDataBodies}
                //PanelPronEdit{id: panelPronEdit;}
                Rectangle{
                    width: parent.width
                    height: 3
                    color: 'red'
                    anchors.bottom: parent.bottom
                    visible: apps.zFocus==='xLatDer'
                }
            }
        }
        Comps.XDataStatusBar{id: xDataStatusBar}
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
    }
    //Init{longAppName: 'Zool'; folderName: 'zool'}
    Comps.XSelectColor{
        id: xSelectColor
        width: app.fs*8
        height: app.fs*8
        c: 'backgroundColor'
    }
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
    ZoolLogView{id: log}

    //    Text{
    //        text: '->'+menuBar.expanded
    //        font.pixelSize: app.fs*3
    //        color: 'red'
    //    }
    Timer{
        id: tAutoMaticPlanets
        running: false
        repeat: true
        interval: 10000
        property string currentJsonData: ''
        onTriggered: {
            if(tAutoMaticPlanets.currentJsonData!==app.currentData){
                tAutoMaticPlanets.stop()
                return
            }
            if(app.currentPlanetIndex<16){
                app.currentPlanetIndex++
            }else{
                app.currentPlanetIndex=-1
            }
        }
    }
    Comps.MenuPlanets{id: menuPlanets}
    ZoolMediaLive{id: zoolMediaLive;parent: panelDataBodies}
    Comps.MinymaClient{
        id: minymaClient
        loginUserName: 'zool'+(app.dev?'-dev':'')
        host: apps.minymaClientHost
        port: apps.minymaClientPort
        onNewMessage: {
            //let json=JSON.parse(data)
            //log.ls('Minyma Recibe: '+data, 0, 500)
        }
        onNewMessageForMe: {
            //log.ls('Minyma For Me: '+data, 0, 500)
            if(data==='isWindowTool'){
                if(app.flags===Qt.Tool){
                    minymaClient.sendData(minymaClient.loginUserName, from, 'isWindowTool=true')
                }else{
                    minymaClient.sendData(minymaClient.loginUserName, from, 'isWindowTool=false')
                }
            }
            if(data==='windowToWindow'){
                app.flags=Qt.Window
            }
            if(data==='windowToTool'){
                app.flags=Qt.Tool
            }

            //To zoolMediaLive
            if(data==='zoolMediaLive.loadBodiesNow()'){
                zoolMediaLive.loadBodiesNow()
            }
            if(data==='zoolMediaLive.play()'){
                zoolMediaLive.play()
            }
            if(data==='zoolMediaLive.pause()'){
                zoolMediaLive.pause()
            }
            if(data==='zoolMediaLive.stop()'){
                zoolMediaLive.stop()
            }
            if(data==='zoolMediaLive.previous()'){
                zoolMediaLive.previous()
            }
            if(data==='zoolMediaLive.next()'){
                zoolMediaLive.next()
            }
        }
    }

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

        JS.setFs()

        //Check is dev with the arg -dev
        if(Qt.application.arguments.indexOf('-dev')>=0){
            app.dev=true
        }

        let v=unik.getFile('./version')
        app.version=v.replace(/\n/g, '')


        //Argumentos
        let args=Qt.application.arguments
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
                    JS.loadJson(arg)
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
                JS.loadJson(apps.url)
            }else{
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
        JS.loadModules()
    }
}
