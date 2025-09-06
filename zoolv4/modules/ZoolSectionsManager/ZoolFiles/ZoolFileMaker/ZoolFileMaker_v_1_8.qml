import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import ZoolControlsTime 1.1
import ZoolTextInput 1.0
//import "../../comps" as Comps
//import "../../js/Funcs.js" as JS

import ZoolText 1.2
import ZoolButton 1.2
import comps.FocusSen 1.0

Rectangle {
    id: r
    width: xLatIzq.width
    height: zsm.getPanel('ZoolFileManager').hp
    visible: false
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    //property alias xCfgItem: colXConfig

    property bool loadingCoords: false

    property alias tiN: tiNombre.t
    property alias tiC: tiCiudad.t

    property real lat:-100.00
    property real lon:-100.00
    property int alt:0

    property real ulat:-100.00
    property real ulon:-100.00
    property real ualt:0

    property string uFileNameLoaded: ''

    property alias cbp: cbPreview
    property bool modoTurbo: false

    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        //if(visible)zoolVoicePlayer.speak('Sección para crear archivos.', true)
    }
    onLoadingCoordsChanged: {
        txtLoadingCoords.text='Buscando coordenadas de '+tiCiudad.t.text
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }

    Settings{
        id: settings
        fileName: u.getPath(4)+'/zoolFileMaker.cfg'
        property bool showModuleVersion: false
        property bool inputCoords: false
    }
    //    Text{
    //        text: 'ZoolFileMaker v1.0'
    //        font.pixelSize: app.fs*0.5
    //        color: apps.fontColor
    //        anchors.left: parent.left
    //        anchors.leftMargin: app.fs*0.1
    //        anchors.top: parent.top
    //        anchors.topMargin: app.fs*0.1
    //        opacity: settings.showModuleVersion?1.0:0.0
    //        MouseArea{
    //            anchors.fill: parent
    //            onClicked: settings.showModuleVersion=!settings.showModuleVersion
    //        }
    //    }
    //    ZoolButton{
    //        text:'\uf013'
    //        anchors.right: parent.right
    //        anchors.rightMargin: app.fs*0.25
    //        anchors.top: parent.top
    //        anchors.topMargin: app.fs*0.25
    //        z: col.z+1
    //        onClicked:{
    //            zoolFileManager.s.showConfig=!zoolFileManager.s.showConfig
    //        }
    //    }
    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: col.height+app.fs*3
        clip: true
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: col
            spacing: app.fs*0.75
            anchors.horizontalCenter: parent.horizontalCenter
            Item{width: 1; height: 1;}
            Item{
                id: xth1
                width: r.width
                height: th1.contentHeight//+app.fs*0.5
                Text{
                    id: th1
                    text: 'Para ver la Ayuda presiona F1'
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
            //            Item{width: 1; height: app.fs; visible: colXConfig.visible}
            //            Column{
            //                id: colXConfig
            //                anchors.horizontalCenter: parent.horizontalCenter
            //            }
            Column{
                spacing: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText{
                    text: '<b>Crear una nueva carta</b>'
                    font.pixelSize: app.fs*0.65
                    color: 'white'
                }
                //                ZoolText{
                //                    text: 'Mediante este formulario usted puede crear un nuevo esquema o mapa  energético, carta natal u otros.'
                //                    w: r.width-app.fs
                //                    font.pixelSize: app.fs*0.5
                //                    color: 'white'
                //                }
            }
            Item{width: 1; height: 1;}
            ZoolTextInput{
                id: tiNombre
                width: r.width-app.fs*0.5
                t.font.pixelSize: app.fs*0.65
                t.parent.width: r.width-app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                KeyNavigation.tab: cbGenero//controlTimeFecha
                t.maximumLength: 30
                borderColor:apps.fontColor
                borderRadius: app.fs*0.25
                padding: app.fs*0.25
                horizontalAlignment: TextInput.AlignLeft
                onTextChanged: if(cbPreview.checked)loadTemp()
                onEnterPressed: {
                    cbGenero.focus=true
                    //controlTimeFecha.focus=true
                    //controlTimeFecha.cFocus=0
                }
                FocusSen{
                    width: parent.r.width
                    height: parent.r.height
                    radius: parent.r.radius
                    border.width:2
                    anchors.centerIn: parent
                    visible: parent.t.focus
                }
                Text {
                    text: 'Nombre'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText{
                    id: labelGenero
                    text: 'Género: '
                    w: app.fs*2.5
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.verticalCenter: parent.verticalCenter
                }
                ComboBox{
                    id: cbGenero
                    model: ['No Binario', 'Femenino', 'Masculino']
                    width: r.width-labelGenero.w-app.fs
                    font.pixelSize: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        width: parent.width+8
                        height: parent.height+8
                        color: 'transparent'
                        border.width: 4
                        anchors.centerIn: parent
                        visible: cbGenero.focus
                        SequentialAnimation on border.color{
                            running: parent.visible
                            loops: Animation.Infinite
                            ColorAnimation {
                                from: "red"
                                to: "yellow"
                                duration: 300
                            }
                            ColorAnimation {
                                from: "yellow"
                                to: "red"
                                duration: 300
                            }
                        }
                    }
                }
            }
            Row{
                spacing: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolControlsTime{
                    id: controlTimeFecha
                    gmt: 0
                    fs: r.width*0.07
                    restartCFocusFromZero: false
                    KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    onCFocusChanged:{
                        if(cFocus===-1){
                            tiCiudad.t.focus=true
                        }
                    }
                    onGmtChanged:{
                        if(cbPreview.checked){
                            loadTemp()
                        }
                    }
                    onCurrentDateChanged: {
                        if(cbPreview.checked){
                            loadTemp()
                        }
                        //log.l('PanelVN CurrenDate: '+currentDate.toString())
                        //log.visible=true
                        //log.x=xApp.width*0.2
                    }
                    Text {
                        text: 'Fecha'
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        anchors.bottom: parent.top
                    }
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText{
                    fs: app.fs*0.5
                    text: 'Vista Previa'
                }
                CheckBox{
                    id: cbPreview
                    width: app.fs
                    checked: zm.previewEnabled
                    onCheckedChanged: {
                        if(checked && tiCiudad.t.text===''){
                            tiCiudad.t.text='United Kingdom'
                            searchGeoLoc(false)
                        }
                        zm.previewEnabled=checked
                    }
                }
            }
            Item{width: 1;height: app.fs*0.25}
            ZoolTextInput{
                id: tiCiudad
                width: tiNombre.width
                t.parent.width: r.width-app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                t.font.pixelSize: app.fs*0.65;
                KeyNavigation.tab: cbInputCoords.checked?tiLat.t:tiAlt.t
                t.maximumLength: 50
                borderColor:apps.fontColor
                borderRadius: app.fs*0.25
                padding: app.fs*0.25
                horizontalAlignment: TextInput.AlignLeft
                onTextChanged: {
                    r.modoTurbo=false
                    if(text==='Ingresa un lugar aquí'){
                        selectAll()
                        return
                    }
                    settings.inputCoords=false
                    tSearch.restart()
                    t.color='white'
                }
                FocusSen{
                    width: parent.r.width
                    height: parent.r.height
                    radius: parent.r.radius
                    border.width:2
                    anchors.centerIn: parent
                    visible: parent.t.focus
                }
                Text {
                    text: 'Lugar, ciudad, provincia,\nregión y/o país de nacimiento'
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    anchors.bottom: parent.top
                }
            }
            Column{
                id: colTiLonLat
                anchors.horizontalCenter: parent.horizontalCenter
                visible: cbInputCoords.checked

                Row{
                    spacing: app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    ZoolTextInput{
                        id: tiLat
                        //width: r.width*0.5-app.fs*0.5
                        //width: r.width*0.15-app.fs*0.5
                        w: r.width*0.4-app.fs*0.5
                        t.font.pixelSize: app.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                        KeyNavigation.tab: tiLon.t
                        t.maximumLength: 10
                        t.validator: RegExpValidator {
                            regExp: RegExp(/^(\+|\-)?0*(?:(?!999\.9\d*$)\d{0,3}(?:\.\d*)?|999\.0*)$/)
                        }
                        borderColor:apps.fontColor
                        borderRadius: app.fs*0.25
                        padding: app.fs*0.25
                        horizontalAlignment: TextInput.AlignLeft
                        property bool valid: false
                        Timer{
                            running: r.visible && cbInputCoords.checked
                            repeat: true
                            interval: 100
                            onTriggered: {
                                parent.valid=parent.t.text===''?false:(parseFloat(parent.t.text)>=-180.00 && parseFloat(parent.t.text)<=180.00)
                                if(parent.valid){
                                    r.ulat=parseFloat(parent.t.text)
                                }else{
                                    r.ulat=-1
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width+border.width*2
                            height: parent.height+border.width*2
                            anchors.centerIn: parent
                            color: 'transparent'
                            border.width: 4
                            border.color: 'red'
                            visible: parent.t.text===''?false:!parent.valid
                        }
                        onEnterPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
                        }
                        FocusSen{
                            width: parent.r.width
                            height: parent.r.height
                            radius: parent.r.radius
                            border.width:2
                            anchors.centerIn: parent
                            visible: parent.t.focus
                        }
                        Text {
                            text: 'Latitud'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                        }
                    }
                    ZoolTextInput{
                        id: tiLon
                        //width: r.width*0.15-app.fs*0.5
                        w: r.width*0.4-app.fs*0.5
                        t.font.pixelSize: app.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                        KeyNavigation.tab: botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear
                        t.maximumLength: 10
                        t.validator: RegExpValidator {
                            regExp: RegExp(/^(\+|\-)?0*(?:(?!999\.9\d*$)\d{0,3}(?:\.\d*)?|999\.0*)$/)
                        }
                        borderColor:apps.fontColor
                        borderRadius: app.fs*0.25
                        padding: app.fs*0.25
                        horizontalAlignment: TextInput.AlignLeft
                        property bool valid: false
                        Timer{
                            running: r.visible && cbInputCoords.checked
                            repeat: true
                            interval: 100
                            onTriggered: {
                                parent.valid=parent.t.text===''?false:(parseFloat(parent.t.text)>=-180.00 && parseFloat(parent.t.text)<=180.00)
                                if(parent.valid){
                                    r.ulon=parseFloat(parent.t.text)
                                }else{
                                    r.ulon=-1
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width+border.width*2
                            height: parent.height+border.width*2
                            anchors.centerIn: parent
                            color: 'transparent'
                            border.width: 4
                            border.color: 'red'
                            visible: parent.t.text===''?false:!parent.valid
                        }
                        //onPressed: {
                        onEnterPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
                        }
                        FocusSen{
                            width: parent.r.width
                            height: parent.r.height
                            radius: parent.r.radius
                            border.width:2
                            anchors.centerIn: parent
                            visible: parent.t.focus
                        }
                        Text {
                            text: 'Longitud'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                        }
                    }
                }
                Item{width: 1; height: app.fs*0.5;visible: cbInputCoords.checked}
                Text{
                    text: tiLat.t.text===''&&tiLon.t.text===''?'Escribir las coordenadas geográficas.':
                                                                (
                                                                    tiLat.valid && tiLon.valid?
                                                                        'Estas coordenadas son válidas.':
                                                                        'Las coordenadas no son correctas'
                                                                    )
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: cbInputCoords.checked
                }
            }
            Column{
                id: colLatLon
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.lat===r.ulat&&r.lon===r.ulon
                //height: !visible?0:app.fs*3
                Text{
                    text: 'Lat:'+r.lat
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    opacity: r.lat!==-100.00?1.0:0.0
                }
                Text{
                    text: 'Lon:'+r.lon
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    opacity: r.lon!==-100.00?1.0:0.0
                }
            }
            Column{
                visible: !colLatLon.visible
                //height: !visible?0:app.fs*3
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Error: Corregir el nombre de ubicación'
                    font.pixelSize: app.fs*0.25
                    color: 'white'
                    visible: r.ulat===-1&&r.ulon===-1
                }
                Text{
                    text: 'Lat:'+r.ulat
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    opacity: r.ulat!==-100.00?1.0:0.0
                }
                Text{
                    text: 'Lon:'+r.ulon
                    font.pixelSize: app.fs*0.5
                    color: 'white'
                    opacity: r.ulon!==-100.00?1.0:0.0
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Item{
                    id: xAlt
                    width: app.fs*3
                    height: app.fs*3
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.horizontalCenter: parent.horizontalCenter
                    ZoolTextInput{
                        id: tiAlt
                        text: r.ualt
                        //width: app.fs*3
                        t.font.pixelSize: app.fs*0.65
                        anchors.centerIn: parent
                        //anchors.horizontalCenter: parent.horizontalCenter
                        KeyNavigation.tab: botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear

                        t.maximumLength: 4
                        borderColor:apps.fontColor
                        borderRadius: app.fs*0.25
                        padding: app.fs*0.25
                        horizontalAlignment: TextInput.AlignLeft
                        property int uNum: 0
                        onTextChanged:{
                            let t=text
                            t = t.replace(/[^\d]/g, '');
                            let num = parseInt(t);
                            if (isNaN(num) || num < 0 || num > 20000) {
                                r.ualt=0
                                r.alt=0
                            } else {
                                r.ualt=num
                                r.alt=num
                            }
                            t=''+num
                            if(t.indexOf('0')===0 && t.length>1){
                                t = t.substring(1, text.length-1)
                            }
                            text=isNaN(t)?'0':t
                            tiAlt.uNum=num
                        }
                        onEnterPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
                        }
                        FocusSen{
                            width: parent.r.width
                            height: parent.r.height
                            radius: parent.r.radius
                            border.width:2
                            anchors.centerIn: parent
                            visible: parent.t.focus
                        }
                        Text {
                            text: 'Altura'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    //anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text: 'Ingresar\ncoordenadas\nmanualmente'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    CheckBox{
                        id: cbInputCoords
                        checked: settings.inputCoords
                        anchors.verticalCenter: parent.verticalCenter
                        onCheckedChanged: settings.inputCoords=checked
                        FocusSen{
                            width: parent.width+4
                            height: parent.height+4
                            border.width:2
                            anchors.centerIn: parent
                            visible: parent.focus
                        }
                    }
                }
            }
            Column{
                id: colInforme
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Informe'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle{
                    id: xInforme
                    width: r.width-app.fs*0.5
                    height: app.fs*6
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    radius: app.fs*0.1
                    clip: true
                    FocusSen{
                        width: parent.width
                        height: parent.height
                        border.width:2
                        anchors.centerIn: parent
                        visible: taInforme.focus
                    }
                    Flickable{
                        contentWidth: xInforme.width
                        contentHeight: taInforme.contentHeight+app.fs
                        anchors.fill: parent
                        ScrollBar.vertical: ScrollBar{}
                        TextArea{
                            id: taInforme
                            width: xInforme.width-app.fs*0.5
                            height: parent.parent.height
                            font.pixelSize: app.fs*0.5
                            color: apps.fontColor
                            wrapMode: TextArea.WordWrap
                            Keys.onTabPressed: {
                                botCrear.focus=true
                            }
                        }
                    }
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*0.25
                visible: false
                ZoolText{
                    text: 'Compartir con la\ncomunidad Zool'
                    fs: app.fs*0.5
                    textFormat:Text.Normal
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: cbShared
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*0.25
                Button{
                    id: botClear
                    text: 'Limpiar'
                    font.pixelSize: app.fs*0.5
                    opacity:  r.lat!==-100.00||r.lon!==-100.00||tiNombre.text!==''||tiCiudad.text!==''?1.0:0.0
                    enabled: opacity===1.0
                    onClicked: {
                        clear()
                    }
                }
                Button{
                    id: botCrear
                    text: 'Crear'
                    font.pixelSize: app.fs*0.5
                    KeyNavigation.tab: tiNombre.t
                    visible: r.ulat!==-1&&r.ulon!==-1&&tiNombre.text!==''&&tiCiudad.text!==''
                    onFocusChanged: {
                        if(focus)flk.contentY=flk.contentHeight-flk.height
                    }
                    onClicked: {
                        toEnter()
                        //mk()
                    }
                    //
                    Timer{
                        running: r.visible
                        repeat: true
                        interval: 3000
                        onTriggered: {
                            let p=zfdm.getJsonAbs().params
                            let cNom=p.n.replace(/_/g, ' ')
                            let nom=tiNombre.t.text.replace(/_/g, ' ')
                            //log.lv('p.n: '+p.n)
                            //log.lv('nom: '+nom)
                            if(cNom===nom){
                                botCrear.text='Modificar'
                            }else{
                                botCrear.text='Crear'
                            }
                        }
                    }

                    //                    Timer{
                    //                        running: false//r.visible
                    //                        repeat: true
                    //                        interval: 1000
                    //                        onTriggered: {
                    //                            let nom=tiNombre.t.text.replace(/ /g, '_')
                    //                            let fileName=apps.workSpace+'/'+nom+'.json'
                    //                            if(u.fileExist(fileName)){
                    //                                r.uFileNameLoaded=tiNombre.text
                    //                                let jsonFileData=u.getFile(fileName)
                    //                                let j=JSON.parse(jsonFileData)
                    //                                let dia=''+j.params.d
                    //                                if(parseInt(dia)<=9){
                    //                                    dia='0'+dia
                    //                                }
                    //                                let mes=''+j.params.m
                    //                                if(parseInt(mes)<=9){
                    //                                    mes='0'+mes
                    //                                }
                    //                                let hora=''+j.params.h
                    //                                if(parseInt(hora)<=9){
                    //                                    hora='0'+hora
                    //                                }
                    //                                let minuto=''+j.params.min
                    //                                if(parseInt(minuto)<=9){
                    //                                    minuto='0'+minuto
                    //                                }
                    //                                let nt=new Date(parseInt(j.params.a), parseInt(mes - 1), parseInt(dia), parseInt(hora), parseInt(minuto))
                    //                                controlTimeFecha.currentDate=nt
                    //                                controlTimeFecha.gmt=j.params.gmt
                    //                                if(tiCiudad.text.replace(/ /g, '')===''){
                    //                                    tiCiudad.text=j.params.c
                    //                                }
                    //                                r.lat=j.params.lat
                    //                                r.lon=j.params.lon
                    //                                r.ulat=j.params.lat
                    //                                r.ulon=j.params.lon
                    //                                let vd=parseInt(tiFecha1.t.text)
                    //                                let vm=parseInt(tiFecha2.t.text)
                    //                                let vh=parseInt(tiHora1.t.text)
                    //                                let vmin=parseInt(tiHora2.t.text)
                    //                                let vgmt=controlTimeFecha.gmt//tiGMT.t.text
                    //                                let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
                    //                                if(j.params.d!==vd||j.params.m!==vm||j.params.a!==va||j.params.h!==vh||j.params.min!==vmin||r.lat!==r.ulat||r.lon!==r.ulon){
                    //                                    botCrear.text='Modificar'
                    //                                }else{
                    //                                    botCrear.text='[Crear]'
                    //                                }
                    //                            }else{
                    //                                botCrear.text='Crear'
                    //                            }
                    //                        }
                    //                    }

                    FocusSen{
                        width: parent.width+4
                        height: parent.height+4
                        border.width:2
                        anchors.centerIn: parent
                        visible: parent.focus
                    }
                }
            }
        }
    }
    Rectangle{
        id: rLoading
        color: apps.backgroundColor
        anchors.fill: parent
        visible: r.loadingCoords
        MouseArea{
            anchors.fill: parent
            onClicked: r.loadingCoords=false
        }
        Column{
            spacing: app.fs*0.5
            anchors.centerIn: parent
            Text{
                id: txtLoadingCoords
                color: apps.fontColor
                font.pixelSize: app.fs*0.5
                width: r.width-app.fs*2
                wrapMode: Text.WordWrap
            }
            Button{
                text: 'Cancelar'
                font.pixelSize: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    r.loadingCoords=false
                }
            }
        }
    }
    Item{
        id: xuqp
    }
    Timer{
        id: tSearch
        running: false
        repeat: false
        interval: 2000
        onTriggered: searchGeoLoc(false)
    }
    //    Timer{
    //        id: tLoadTemp
    //        running: false
    //        repeat: false
    //        interval: 2000
    //        onTriggered: {

    //        }
    //    }

    function searchGeoLoc(crear){
        r.loadingCoords=true
        const lugarABuscar = tiCiudad.t.text
        obtenerCoordenadas(lugarABuscar)
        .then(coordenadas => {
                  //console.log(`Las coordenadas de ${lugarABuscar} son:`);
                  //console.log(`Latitud: ${coordenadas.latitud}`);
                  //console.log(`Longitud: ${coordenadas.longitud}`);
                  //r.loadingCoords=false
                  if(!r.loadingCoords)return
                  if(coordenadas){
                      if(r.lat===-1&&r.lon===-1){
                          tiCiudad.t.color="red"
                      }else{
                          tiCiudad.t.color=apps.fontColor
                          if(crear){
                              r.lat=coordenadas.latitud
                              r.lon=coordenadas.longitud
                              setNewJsonFileData()
                              r.state='hide'
                          }else{
                              //r.modoTurbo=true
                              r.ulat=coordenadas.latitud
                              r.ulon=coordenadas.longitud
                          }
                      }
                  }else{
                      console.log('No se encontraron las cordenadas.')
                  }
              })
        .catch(error => {
                   //r.loadingCoords=false
                   console.error('Ocurrió un error:', error);
               });
    }
    function setNewJsonFileData(){
        let p=zfdm.getJsonAbs().params
        let vtipo='vn' //Esto luego lo programaré para EVENTOS tipo='even'

        let d = new Date(Date.now())
        let ms=d.getTime()
        let nom=tiNombre.t.text.replace(/ /g, '_')

        let vd=controlTimeFecha.dia
        let vm=controlTimeFecha.mes
        let va=controlTimeFecha.anio
        let vh=controlTimeFecha.hora
        let vmin=controlTimeFecha.minuto

        let vgmt=controlTimeFecha.gmt//tiGMT.t.text
        let vlon=r.lon
        let vlat=r.lat
        let valt=r.alt
        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')

        let vhsys=apps.currentHsys

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
        extId+='_'+vtipo
        extId+='_'+vhsys

        let json={}
        json.params={}
        json.params.t=vtipo
        json.params.ms=ms
        json.params.n=nom
        json.params.g='n'
        if(cbGenero.currentIndex===1)json.params.g='f'
        if(cbGenero.currentIndex===2)json.params.g='m'
        json.params.f=false
        if(botCrear.text==='Modificar'){
            json.params.f=p.f
        }
        json.params.data=taInforme.text

        if(cbPreview.checked){
            if(nom==='')nom='Sin Nombre'
            json.params.n='Vista Previa - '+nom
        }
        json.params.d=vd
        json.params.m=vm
        json.params.a=va
        json.params.h=vh
        json.params.min=vmin
        json.params.gmt=vgmt
        json.params.lat=vlat
        json.params.lon=vlon
        json.params.alt=valt
        json.params.c=vCiudad
        json.params.hsys=vhsys
        if(apps.enableShareInServer && cbShared.checked){
            json.params.shared=true
        }else{
            json.params.shared=false
        }
        json.params.extId=extId

        let currentExts=zfdm.getJsonAbs().exts
        if(currentExts){
            json.exts=currentExts
        }else{
            json.exts=[]
        }

        //let json=JSON.parse(j)
        let asTemp=true
        if(!cbPreview.checked || botCrear.text==='Modificar'){
            asTemp=false
        }
        if(zfdm.mkFileAndLoad(json, asTemp)){
            if(apps.dev)log.lv('Archivo creado: '+json.params.n)
        }else{
            if(apps.dev)log.lv('Archivo NO creado: '+json.params.n)
        }
    }
    function setNewJsonFileDataFromArgs(vtipo, nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, vhsys, gen, vdata, vpreview){
        let d = new Date(Date.now())
        let ms=d.getTime()

        let json={}
        json.params={}
        json.params.t=vtipo
        json.params.ms=ms
        json.params.n=nom
        json.params.g='n'
        if(gen==='f' || gen==='m'){
            json.params.g=gen
        }
        json.params.f=false
        json.params.data=vdata

        if(vpreview){
            if(nom==='')nom='Sin Nombre'
            json.params.n='Vista Previa - '+nom
        }
        json.params.d=vd
        json.params.m=vm
        json.params.a=va
        json.params.h=vh
        json.params.min=vmin
        json.params.gmt=vgmt
        json.params.lat=vlat
        json.params.lon=vlon
        json.params.alt=valt
        json.params.c=vCiudad
        json.params.hsys=vhsys
        if(apps.enableShareInServer && cbShared.checked){
            json.params.shared=true
        }else{
            json.params.shared=false
        }
        //json.params.extId=extId

        let currentExts=zfdm.getJsonAbs().exts
        if(currentExts){
            json.exts=currentExts
        }else{
            json.exts=[]
        }
        //let json=JSON.parse(j)
        let asTemp=true
        if(!cbPreview.checked || botCrear.text==='Modificar'){
            asTemp=false
        }
        if(zfdm.mkFileAndLoad(json, asTemp)){
            if(apps.dev)log.lv('Archivo creado: '+json.params.n)
        }else{
            if(apps.dev)log.lv('Archivo NO creado: '+json.params.n)
        }
    }
    function enter(){
        if(botCrear.focus&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''){
            searchGeoLoc(true)
        }
    }
    function clear(){
        r.ulat=-100
        r.ulon=-100
        r.ualt=0
        r.lat=-100
        r.lon=-100
        r.alt=0
        tiNombre.t.text=''
        tiCiudad.t.text=''
        tiAlt.t.text='0'
        cbShared.checked=false
        cbPreview.checked=false
        controlTimeFecha.gmt=0
        let d = new Date(Date.now())
        controlTimeFecha.dia=d.getDate()
        controlTimeFecha.mes=d.getMonth()
        controlTimeFecha.anio=d.getFullYear()
        controlTimeFecha.hora=d.getHours()
        controlTimeFecha.minuto=d.getMinutes()

        tiNombre.t.focus=true

    }
    function mk(){
        tiNombre.t.focus=false
        cbGenero.focus=false
        tiCiudad.t.focus=false
        tiLat.t.focus=false
        tiLon.t.focus=false
        tiAlt.t.focus=false
        cbPreview.checked=false
        botCrear.focus=false
        botClear.focus=false
        if(!cbInputCoords.checked && !r.modoTurbo){
            //log.lv('1 Creando....')
            searchGeoLoc(true)
        }else{
            //log.lv('2 Creando....')
            r.lat=parseFloat(tiLat.t.text)
            r.lon=parseFloat(tiLon.t.text)
            r.ulat=r.lat
            r.ulon=r.lon

            setNewJsonFileData()
        }
    }
    //-->Teclado
    function toEnter(){
        if(tiNombre.t.text===''){
            controlTimeFecha.cFocus=-1
            tiNombre.t.focus=true
            flk.contentY=0
        }else if(tiNombre.t.focus){
            controlTimeFecha.cFocus=-1
            cbGenero.focus=true
        }else if(cbGenero.focus){
            cbGenero.focus=false
            controlTimeFecha.cFocus=0
        }else if(controlTimeFecha.cFocus<5 && controlTimeFecha.cFocus!==-1){
            cbGenero.focus=false
            if(controlTimeFecha.cFocus>=0)controlTimeFecha.setEditData()
            controlTimeFecha.cFocus++
            //zpn.log('controlTimeFecha.cFocus: '+controlTimeFecha.cFocus)
        }else if(controlTimeFecha.cFocus===5){
            if(controlTimeFecha.cFocus===5)controlTimeFecha.setEditData()
            cbGenero.focus=false
            controlTimeFecha.cFocus=-1
            controlTimeFecha.setEditData()
            tiCiudad.t.focus=true
        }else if(tiCiudad.t.focus){
            cbGenero.focus=false
            controlTimeFecha.cFocus=-1
            tiCiudad.t.focus=false
            if(tiNombre.t.text===''){
                zpn.logTemp('Aún no se ha complatado el campo para el nombre.', 10000)
                tiNombre.t.focus=true
                flk.contentY=0
                return

            }
            if(tiCiudad.t.text===''){
                controlTimeFecha.cFocus=-1
                tiCiudad.t.text='Ingresa un lugar aquí'
                return
            }else{
                tiCiudad.t.focus=false
            }
            if(cbInputCoords.checked && !tiAlt.t.focus){
                tiCiudad.t.focus=false
                if(tiLat.t.focus){
                    tiLon.t.focus=true
                }else if(tiLon.t.focus){
                    tiAlt.t.focus=true
                    return
                }else if(tiAlt.t.focus){
                    cbInputCoords.focus=true
                    return
                }else{
                    tiLat.t.focus=true
                }
                flk.contentY=flk.contentHeight-flk.height
            }else{
                tiCiudad.t.focus=false
                if(tiAlt.t.focus){
                    tiAlt.t.focus=false
                    cbInputCoords.focus=true
                }else{
                    cbInputCoords.focus=false
                    tiAlt.t.focus=true
                }
                flk.contentY=flk.contentHeight-flk.height
                return
            }
            if(cbInputCoords.focus){
                cbInputCoords.focus=false
                botCrear.focus=true
            }
        }else{
            //log.lv('Entrando a tiNombre...')
            if(tiAlt.t.focus){
                tiAlt.t.focus=false
                cbInputCoords.focus=true
            }else if(cbInputCoords.focus){
                cbInputCoords.focus=false
                taInforme.focus=true
            }else if(taInforme.focus){
                cbInputCoords.focus=false
                botCrear.focus=true
            }else if(botCrear.focus){
                //mk()
                setNewJsonFileData()
            }else{
                cbInputCoords.focus=false
                tiNombre.t.focus=true
                flk.contentY=0
            }
        }
        /*if(tiNombre.t.text===''){
            tiNombre.t.focus=true
        }else if(cbGenero.currentText==='No Binario'){
            cbGenero.focus=true
        }else if(cbGenero.focus){
            controlTimeFecha.cFocus=0
        }else if(controlTimeFecha.cFocus<5 && controlTimeFecha.cFocus!==-1){
            controlTimeFecha.setEditData()
            controlTimeFecha.cFocus++
        }else if(controlTimeFecha.cFocus>=4){
            tiCiudad.t.focus=true
        }else if(tiCiudad.t.text===''){
            controlTimeFecha.setEditData()
            controlTimeFecha.cFocus=-1
            tiCiudad.t.focus=true
        }else if(tiCiudad.t.focus){
            //tiNombre.t.focus=true
            botCrear.focus=true
        }else if(botCrear.focus){
            mk()
        }else if(tiNombre.t.focus){
            cbGenero.focus=true
        }else{
            tiNombre.t.focus=true
            flk.contentY=0
        }*/
    }
    function toRight(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toRight()
        }
    }
    function toLeft(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toLeft()
        }
    }
    function toUp(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toUp()
        }
        if(cbGenero.focus){
            if(cbGenero.currentIndex>0){
                cbGenero.currentIndex--
            }else{
                cbGenero.currentIndex=cbGenero.model.length-1
            }
        }
    }
    function toDown(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toDown()
        }
        if(cbGenero.focus){
            if(cbGenero.currentIndex<cbGenero.model.length-1){
                cbGenero.currentIndex++
            }else{
                cbGenero.currentIndex=0
            }
        }
    }
    function toTab(){
        //log.lv('controlTimeFecha.cFocus: '+controlTimeFecha.cFocus)
        if(tiNombre.t.text===''){
            controlTimeFecha.cFocus=-1
            tiNombre.t.focus=true
            flk.contentY=0
        }else if(tiNombre.t.focus){
            controlTimeFecha.cFocus=-1
            cbGenero.focus=true
        }else if(cbGenero.focus){
            cbGenero.focus=false
            controlTimeFecha.cFocus=0
        }else if(controlTimeFecha.cFocus<5 && controlTimeFecha.cFocus!==-1){
            cbGenero.focus=false
            //if(controlTimeFecha.cFocus>=0)controlTimeFecha.setEditData()
            controlTimeFecha.cFocus++
        }else if(controlTimeFecha.cFocus===5){
            cbGenero.focus=false
            controlTimeFecha.cFocus=-1
            controlTimeFecha.setEditData()
            tiCiudad.t.focus=true
        }else if(tiCiudad.t.focus){
            cbGenero.focus=false
            controlTimeFecha.cFocus=-1
            tiCiudad.t.focus=false
            if(tiNombre.t.text===''){
                zpn.logTemp('Aún no se ha complatado el campo para el nombre.', 10000)
                tiNombre.t.focus=true
                flk.contentY=0
                return

            }
            if(tiCiudad.t.text===''){
                controlTimeFecha.cFocus=-1
                tiCiudad.t.text='Ingresa un lugar aquí'
                return
            }else{
                tiCiudad.t.focus=false
            }
            if(cbInputCoords.checked && !tiAlt.t.focus){
                tiCiudad.t.focus=false
                if(tiLat.t.focus){
                    tiLon.t.focus=true
                }else if(tiLon.t.focus){
                    tiAlt.t.focus=true
                    return
                }else if(tiAlt.t.focus){
                    cbInputCoords.focus=true
                    return
                }else{
                    tiLat.t.focus=true
                }
                flk.contentY=flk.contentHeight-flk.height
            }else{
                tiCiudad.t.focus=false
                if(tiAlt.t.focus){
                    tiAlt.t.focus=false
                    cbInputCoords.focus=true
                }else{
                    cbInputCoords.focus=false
                    tiAlt.t.focus=true
                }
                flk.contentY=flk.contentHeight-flk.height
                return
            }
            if(cbInputCoords.focus){
                cbInputCoords.focus=false
                botCrear.focus=true
            }
        }else{
            //log.lv('Entrando a tiNombre...')
            if(tiAlt.t.focus){
                tiAlt.t.focus=false
                cbInputCoords.focus=true
            }else if(cbInputCoords.focus){
                cbInputCoords.focus=false
                taInforme.focus=true
            }else if(taInforme.focus){
                cbInputCoords.focus=false
                botCrear.focus=true
            }else{
                cbInputCoords.focus=false
                tiNombre.t.focus=true
                flk.contentY=0
            }
        }
    }
    function toEscape(){
        tiNombre.t.focus=false
        cbGenero.focus=false
        controlTimeFecha.focus=false
        controlTimeFecha.cFocus=-1
        tiCiudad.t.focus=false
        tiLat.t.focus=false
        tiLon.t.focus=false
        tiAlt.t.focus=false
        botClear.focus=false
        botCrear.focus=false
        cbInputCoords.checked=false
        cbInputCoords.focus=false

    }
    function isFocus(){
        if(controlTimeFecha.isFocus())return true
        return false
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda para Crear Mapa o Carta</h2><br><br><b>Presionar TAB: </b>Para saltar de un campo de introducción de datos a otro.<br><br><b>Presionar CTRL+ENTER: </b>Se graba o define el dato y se salta hacia el otro campo de introducción de datos.<br><br><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

            let c='import comps.ItemHelp 1.0\n'
            c+='ItemHelp{\n'
            c+='    text:"'+text+'"\n'
            c+='    ctx: "'+zsm.cPanelName+'"\n'
            c+='    objectName: "ItemHelp_'+app.j.qmltypeof(r)+'"\n'
            c+='}\n'
            let comp=Qt.createQmlObject(c, zsm, 'itemhelpcode')
        }
    }
    //<--Teclado

    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }
    function loadTemp(){
        if(!cbInputCoords.checked){
            searchGeoLoc(true)
        }else{
            if(r.ulat===-1&&r.ulon===-1){
                r.lat=0.0
                r.lon=0.0
                r.ulat=0.0
                r.ulon=0.0
            }else{
                r.lat=parseFloat(tiLat.t.text)
                r.lon=parseFloat(tiLon.t.text)
                r.ulat=r.lat
                r.ulon=r.lon
            }
            setNewJsonFileData()
        }
    }
    function setForEdit(){
        zsm.currentIndex=0
        let panel=zsm.getPanel('ZoolFileManager')
        panel.showSection('ZoolFileMaker')
        let p=zfdm.getJsonAbs().params
        tiNombre.t.text=p.n.replace(/_/g,' ')
        controlTimeFecha.dia=p.d
        controlTimeFecha.mes=p.m
        controlTimeFecha.anio=p.a
        controlTimeFecha.hora=p.h
        controlTimeFecha.minuto=p.min
        controlTimeFecha.gmt=p.gmt
        let nCtDate= new Date(p.a, p.m-1, p.d, p.h, p.min)
        controlTimeFecha.currentDate=nCtDate
        tiCiudad.t.text=p.c
        cbInputCoords.checked=true
        r.ulat=p.lat
        r.ulon=p.lon
        if(p.alt){
            r.ualt=p.alt
        }else{
            r.ualt=0
        }
        r.lat=p.lat
        r.lon=p.lon
        if(p.alt){
            r.alt=p.alt
        }else{
            r.alt=0
        }
        tiLat.t.text=parseFloat(r.lat).toFixed(2)
        tiLon.t.text=parseFloat(r.lon).toFixed(2)
        tiAlt.t.text=''+r.alt

        if(p.g){
            if(p.g==='n'){
                cbGenero.currentIndex=0
            }
            if(p.g==='f'){
                cbGenero.currentIndex=1
            }
            if(p.g==='m'){
                cbGenero.currentIndex=2
            }
        }else{
            cbGenero.currentIndex=0
        }
        taInforme.text=p.data
        //log.lv('p:'+JSON.stringify(p, null, 2))
    }
    function obtenerCoordenadas(lugar) {
        return new Promise((resolve, reject) => {
                               const xhr = new XMLHttpRequest();
                               const url = `https://nominatim.openstreetmap.org/search?q=${encodeURIComponent(lugar)}&format=json`;

                               xhr.open('GET', url);

                               xhr.onload = function() {
                                   if (xhr.status >= 200 && xhr.status < 300) {
                                       try {
                                           const respuesta = JSON.parse(xhr.responseText);
                                           if(respuesta && respuesta.length > 0) {
                                           //if(false) {
                                               const latitud = parseFloat(respuesta[0].lat);
                                               const longitud = parseFloat(respuesta[0].lon);
                                               //zpn.logTemp('Latitud: '+latitud, 10000)
                                               //zpn.logTemp('Longitud: '+longitud, 10000)
                                               if(!r.loadingCoords)return
                                               r.lat=parseFloat(latitud)
                                               r.ulat=r.lat
                                               r.lon=parseFloat(longitud)
                                               r.ulon=r.lon
                                               r.loadingCoords=false
                                           }else{
                                               reject('No se encontraron coordenadas para el lugar
 especificado.');
                                               //log.clear()
                                               zpn.logTemp('No se encontraron las coordenadas de geolocalización de '+tiCiudad.text, 10000)
                                               if(Qt.platform.os==='linux' && u.folderExist('/home/ns')){
                                               //if(Qt.platform.os==='linux'){
                                                   searchCoordsTurbo()
                                               }
                                           }
                                       } catch (error) {
                                           reject('Error al parsear la respuesta JSON.');
                                           //log.clear()
                                           zpn.logTemp('Hay un error de red en estos momentos. Error al solicitar las coordenadas de geolocalización de '+tiCiudad.text, 10000)
                                           if(Qt.platform.os==='linux' && u.folderExist('/home/ns')){
                                           //if(Qt.platform.os==='linux'){
                                               searchCoordsTurbo()
                                           }
                                       }
                                   }else{
                                       reject(`Error en la petición: Código de estado ${xhr.status}`);
                                       //log.clear()
                                       zpn.logTemp('Hay un error de red en estos momentos. Error al solicitar las coordenadas de geolocalización de '+tiCiudad.text, 10000)
                                       if(Qt.platform.os==='linux' && u.folderExist('/home/ns')){
                                       //if(Qt.platform.os==='linux'){
                                           searchCoordsTurbo()
                                       }
                                   }
                               };

                               xhr.onerror = function() {
                                   reject('Error de red al realizar la petición.');
                                   //log.clear()
                                   zpn.logTemp('Hay un error de red en estos momentos. Error al solicitar las coordenadas de geolocalización de '+tiCiudad.text, 10000)
                               };

                               xhr.send();
                           });
    }


    //-->Funciones de Control Focus y Teclado
    property bool hasUnUsedFunction: true
    function unUsed(){
        //log.lv(app.j.qmltypeof(r)+'.unUsed()...')
    }
    //-->Funciones de Control Focus y Teclado

    function procResCoords(text){
        if(!r.loadingCoords)return
        const resp = JSON.parse(text.replace('```json', '').replace('```', ''));
        r.lat=resp.coords['lat']
        r.ulat=r.lat
        r.lon=resp.coords['lon']
        r.ulon=r.lon
        r.alt=resp.coords['alt']
        r.ualt=r.alt
        tiAlt.t.text=resp.coords['alt']
        r.loadingCoords=false
    }

    function getIAConsCoords(lugar){
        let ret=''
        ret+='Genera un archivo JSON con las coordenadas geográficas de '+lugar+' en el siguiente formato exacto, sin añadir comentarios antes o después del JSON:\n'

        ret+='{\n'
        ret+='  "coords": {\n'
        ret+='    "lat": <latirud en con 4 decimales>,\n'
        ret+='    "lon": <longitud en con 4 decimales>,\n'
        ret+='    "alt": <altitud>\n'
        ret+='  }\n'
        ret+='}\n'
        return "\""+ret+"\"" //.replace(/\n/g,'\\n')
        //return "\""+ret.replace(/\n/g,'\\n')+"\""
    }

    function searchCoordsTurbo(){
        if(!r.loadingCoords)return
        txtLoadingCoords.text='Buscando coordenadas de '+tiCiudad.t.text+' en modo TURBO...'
        r.modoTurbo=true
        let cmd='python3 /home/ns/gd/scripts/ds/ds.py /home/ns/gd/scripts/ds '+getIAConsCoords(tiCiudad.text)+'"\n'
        let onLogDataCode='zsm.getPanel(\'ZoolFileManager\').getSection(\'ZoolFileMaker\').procResCoords(logData)'
        let onFinishedCode='//Nada\n'
        let onCompleteCode='//Nada\n'
        app.j.runUqp(xuqp, 'searchCoordsDS', cmd, onLogDataCode, onFinishedCode, onCompleteCode)
    }

    // Ejemplo de uso:
    /*const lugarABuscar = "Malargue, Mendoza";
    obtenerCoordenadas(lugarABuscar)
      .then(coordenadas => {
        console.log(`Las coordenadas de ${lugarABuscar} son:`);
        console.log(`Latitud: ${coordenadas.latitud}`);
        console.log(`Longitud: ${coordenadas.longitud}`);
      })
      .catch(error => {
        console.error('Ocurrió un error:', error);
      });*/

}
