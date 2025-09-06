import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../../../comps" as Comps

import comps.FocusSen 1.0
import ZoolText 1.2
import ZoolTextInput 1.0
import ZoolButton 1.2
import ZoolControlsTime 1.0
import ZoolSectionsManager.ZoolMods.ZoolFileTransLoader.BodiesButtons 2.0
import ZoolSectionsManager.ZoolMods.ZoolFileTransLoader.TransList 1.0

Rectangle {
    id: r
    width: xLatIzq.width
    height: zsm.getPanel('ZoolMods').hp
    visible: false
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    clip: true

    property alias xCfgItem: colXConfig

    property alias tiC: tiCiudad.t

    property alias objBB: bb

    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property string uParamsLoaded: ''

    property var cDateDesde: zm.currentDate //Search trans
    property var cDateHasta: zm.currentDate

    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        //if(visible)zoolVoicePlayer.speak('Sección para cargar tránsitos.', true)
    }
    onCDateDesdeChanged: {

        setInfoDesdeHasta()
    }
    onCDateHastaChanged: setInfoDesdeHasta()
    Timer{
        running: r.uParamsLoaded!==''
        repeat: false
        interval: 100
        onTriggered: r.loadJsonFromArgsBack()
    }

    //Timer para adelantar y separar los tiempos DESDE y HASTA
    Timer{
        running: cDateDesde.getTime()>=cDateHasta.getTime()
        repeat: false
        interval: 1000
        onTriggered: {
            let myDate = new Date(cDateDesde);
            myDate.setFullYear(myDate.getFullYear() + 2);
            cDateHasta=myDate
        }
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }

    Settings{
        id: settings
        fileName: u.getPath(4)+'/zoolFileTransLoader.cfg'
        property bool showModuleVersion: false
        property bool inputCoords: false
    }
    ZoolButton{
        text:'\uf013'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        z: col.z+1
        onClicked:{
            zoolMods.s.showConfig=!zoolMods.s.showConfig
        }
    }
    Flickable{
        id: fl
        anchors.fill: parent
        contentWidth: r.width
        contentHeight: col.height+app.fs*3
        Column{
            id: col
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Item{width: 1; height: app.fs; visible: colXConfig.visible}
            Column{
                id: colXConfig
                anchors.horizontalCenter: parent.horizontalCenter
            }
            ZoolText{
                //t.width:r.width-app.fs
                text: '<b>Crear Carta de Tránsitos</b>'
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText{
                    id: labelCbHSys
                    text: 'Sistema de Casas:'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                ComboBox{
                    id: cbHsys
                    width: r.width-app.fs-labelCbHSys.width-parent.spacing
                    height: app.fs*0.75
                    font.pixelSize: app.fs*0.5
                    model: app.ahysNames
                    currentIndex: app.ahys.indexOf(apps.currentHsys)
                    anchors.verticalCenter: parent.verticalCenter
                    onCurrentIndexChanged: {
                        if(currentIndex===app.ahys.indexOf(apps.currentHsys))return
                        apps.currentHsys=app.ahys[currentIndex]
                        updateUParams()
                    }
                }
            }
            Column{
                spacing: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolControlsTime{
                    id: controlTimeFecha
                    gmt: zm.currentGmt
                    labelText: 'Momento de tránsitos'
                    KeyNavigation.tab: tiCiudad.t
                    fs:r.width*0.07
                    setAppTime: false
                    //enableGMT:false
                    function setChanges(){
                        let d = new Date(controlTimeFecha.currentDate)
                        if(zm.currentGmt>0){
                            d.setHours(d.getHours()+zm.currentGmt)
                        }else{
                            d.setHours(d.getHours()-zm.currentGmt)
                        }
                        controlTimeFechaUTC.currentDate=d
                        controlTimeFechaUTC.gmt=0
                        //if(apps.dev)log.lv('controlTimeFechaUTC.currentDate:'+controlTimeFechaUTC.currentDate.toString())
                        zm.enableLoadBack=false
                        tUpdateParams.restart()
                    }
                    onGmtChanged: {
                        setChanges()
                    }
                    onCurrentDateChanged: {
                        setChanges()
                    }
                    Timer{
                        id: tUpdateParams
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: updateUParams()
                    }
                }
                ZoolControlsTime{
                    id: controlTimeFechaUTC
                    gmt: zm.currentGmt
                    labelText: 'UTC - Tiempo Universal'
                    //KeyNavigation.tab: tiCiudad.t
                    fs:r.width*0.07
                    setAppTime: false
                    enableGMT:true
                    locked: true
                    visible: cbUseUtc.checked
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Utilizar UTC'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: cbUseUtc
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged:{

                    }
                    //onCheckedChanged: settings.inputCoords=checked
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolButton{
                    text: 'Ahora'
                    onClicked:{
                        controlTimeFecha.currentDate=new Date(Date.now())
                        loadTrans()
                    }
                }
                ZoolButton{
                    text: 'Recargar Hora de Archivo'
                    onClicked:{
                        let json=JSON.parse(zm.currentData)
                        let d=new Date(json.params.a, parseInt(json.params.m - 1), json.params.d, json.params.h, json.params.min)
                        controlTimeFecha.currentDate=d
                        controlTimeFecha.gmt=json.params.gmt
                        loadTrans()
                    }
                }
            }
            Comps.XMarco{
                id: xm1
                width: r.width-app.fs*0.5
                height: col2.height+app.fs*0.4
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    id: col2
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*0.2
                    Text{
                        text: '<b>Buscar tránsitos</b>'
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                    }
                    ZoolControlsTime{
                        id: controlTimeFechaForBB
                        gmt: zm.currentGmt
                        labelText: 'Buscar Tránsito'
                        fs:xm1.width*0.07
                        setAppTime: false
                        visible: false
                    }
                    Column{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            ZoolButton{
                                id: botSetDesde
                                text: 'DESDE'
                                checkable: true
                                enabled: !botSetHasta.checked
                                onClicked:{
                                    //cDateDesde=controlTimeFechaSetDesdeHasta.currentDate
                                }
                                onCheckedChanged: {
                                    if(checked)controlTimeFechaSetDesdeHasta.t=1
                                    bb.bsel1=-1
                                    bb.bsel2=-1
                                }
                                FocusSen{
                                    width: parent.width+4
                                    height: parent.height+4
                                    border.width:2
                                    anchors.centerIn: parent
                                    visible: parent.checked
                                }
                                Text{
                                    id: lDesde
                                    font.pixelSize: app.fs*0.5
                                    color: apps.fontColor
                                    anchors.top: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            Item{width:app.fs; height: 1}
                            ZoolButton{
                                id: botSetHasta
                                text: 'HASTA'
                                checkable: true
                                enabled: !botSetDesde.checked
                                onClicked:{
                                    //cDateDesde=controlTimeFechaSetDesdeHasta.currentDate
                                }
                                onCheckedChanged: {
                                    if(checked)controlTimeFechaSetDesdeHasta.t=2
                                    bb.bsel1=-1
                                    bb.bsel2=-1
                                }
                                FocusSen{
                                    width: parent.width+4
                                    height: parent.height+4
                                    border.width:2
                                    anchors.centerIn: parent
                                    visible: parent.checked
                                }
                                Text{
                                    id: lHasta
                                    font.pixelSize: app.fs*0.5
                                    color: apps.fontColor
                                    anchors.top: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                        }
                        Item{width: 1; height: app.fs*0.5}
                        ZoolControlsTime{
                            id: controlTimeFechaSetDesdeHasta
                            gmt: zm.currentGmt
                            labelText: botSetDesde.ckecked?'Definir Fecha de Inicio':'Definir Fecha de Final'
                            fs:xm1.width*0.07
                            setAppTime: false
                            visible: botSetDesde.checked || botSetHasta.checked
                            property int t: -1
                            onVisibleChanged:{
                                if(visible){
                                    if(botSetDesde.checked){
                                        currentDate=r.cDateDesde
                                        return
                                    }
                                    if(botSetHasta.checked){
                                        currentDate=r.cDateHasta
                                        return
                                    }
                                }else{
                                    if(t===1){
                                        cDateDesde=currentDate
                                    }
                                    if(t===2){
                                        cDateHasta=currentDate
                                    }
                                }
                            }
                        }
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            ZoolButton{
                                text: 'Ahora'
                                visible: botSetDesde.checked || botSetHasta.checked
                                onClicked:{
                                    controlTimeFechaSetDesdeHasta.currentDate=new Date(Date.now())
                                }
                            }
                            ZoolButton{
                                text: 'Recargar desde Interior'
                                visible: botSetDesde.checked || botSetHasta.checked
                                onClicked:{
                                    //let json=JSON.parse(zm.currentData)
                                    let json=zm.currentJson
                                    let d=new Date(json.params.a, parseInt(json.params.m - 1), json.params.d, json.params.h, json.params.min)
                                    controlTimeFechaSetDesdeHasta.currentDate=d
                                    controlTimeFechaSetDesdeHasta.gmt=json.params.gmt
                                    //initSearch()
                                }
                            }


                        }
                    }
                    BodiesButtons{
                        id: bb
                        width: xm1.width-app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        onSelected:{
                            tl.clear()
                            if(!is1){
                                initSearch()
                            }else{
                                if(bsel1===-1&&bsel2===-1){
                                    botCancel.visible=false
                                    controlTimeFechaForBB.currentDate=r.cDateDesde
                                }else{
                                    controlTimeFechaForBB.currentDate=r.cDateDesde
                                }
                            }

                        }
                    }
                    TransList{
                        id: tl
                        width: bb.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        onSelected:{
                            setSearchBodieDateFronLongResult(JSON.parse(j))
                        }
                    }
                    Row{
                        ZoolButton{
                            id: botCancel
                            text: 'Detener Búsqueda'
                            visible: false
                            onClicked:{
                                botCancel.visible=false
                            }
                        }
                        ZoolButton{
                            id: botReanudar
                            text: 'Reanudar'
                            visible: xuqp.children.length===0 && (bb.bsel1>-1 && bb.bsel2>-1 ) && !botCancel.visible
                            onClicked:{
                                initSearch()
                            }
                        }
                        ZoolButton{
                            id: botRestart
                            text: 'Reiniciar'
                            visible: xuqp.children.length===0 && (bb.bsel1>-1 && bb.bsel2>-1 ) && !botCancel.visible
                            onClicked:{
                                tl.clear()
                                controlTimeFechaForBB.currentDate=r.cDateDesde
                                initSearch()
                            }
                        }
                        ZoolButton{
                            id: botMkText
                            text: 'Copiar'
                            visible: tl.olm.count>0
                            onClicked:{
                                let s=tl.getData(bb.bsel1)
                                clipboard.setText(s)
                            }
                        }
                    }
                    Item{
                        width: parent.width
                        height: app.fs*3
                        Text{
                            id: rTxt
                            text: "Esperando consulta."
                            width: bb.width
                            wrapMode: Text.WordWrap
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                        }
                    }
                    Row{
                        spacing: app.fs*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        ZoolButton{
                            text: 'Guardar'
                            visible: tl.olv.currentIndex>=0 && zm.ev
                            onClicked:{
                                let pExt=zm.currentJsonBack.params
                                let n=''
                                let b1=zm.aBodies[bb.bsel1]
                                let b2
                                let bInt=zm.currentJson.pc['c'+bb.bsel1]
                                let bExt
                                if(bb.bsel2>=0){
                                    b2=zm.aBodies[bb.bsel2]
                                    bExt=zm.currentJsonBack.pc['c'+bb.bsel2]
                                }else{
                                    b2=zm.aBodies[bb.bsel1]
                                    bExt=zm.currentJsonBack.pc['c'+bb.bsel1]
                                }
                                //lolv('json: '+JSON.stringify(, null, 2))
                                let is=zm.getIndexSign(bInt.gdec)
                                let aspIndex=zm.objAspsCircle.getAsp(bInt.gdec, bExt.gdec)
                                let aspName=zm.objAspsCircle.getAspName(aspIndex)
                                let dms=zm.getDDToDMS(bExt.gdec)
                                let dmsDeg=dms.deg-(30*aspIndex)
                                let dmsMin=dms.min
                                let dmsSec=parseInt(dms.sec)
                                n+=''+b2+' '+aspName+' '+b1+' '+pExt.d+'/'+pExt.m+'/'+pExt.a
                                let data=''+b2+' transitando en '+aspName+' con '+b1+' en el signo '+zm.aSigns[is]+' por el grado °'+dmsDeg+' \''+dmsMin+' \'\''+dmsSec


                                saveAsExt(n, data)
                            }
                        }
                    }
                }
            }

            Comps.XMarco{
                Column{
                    anchors.centerIn: parent
                    ZoolText{
                        text: '<b>Utilizar los parámetros actuales</b>'
                        fs: app.fs*0.5
                        padding: app.fs*0.25
                        r.width: w
                        w: r.width-app.fs//*0.2
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                        //visible: false
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        ZoolText{
                            text: 'Cargar tránsitos actuales.'
                            fs: app.fs*0.5
                            padding: app.fs*0.25
                            r.width: w
                            w: r.width-app.fs*3
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ZoolButton{
                            id: btnCrearActual
                            text: 'Cargar'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked:{
                                zm.loadNow(false)
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        ZoolText{
                            text: 'Cargar tránsitos actuales en el exterior.'
                            fs: app.fs*0.5
                            padding: app.fs*0.25
                            r.width: w
                            w: r.width-app.fs*3
                            textFormat: Text.PlainText
                            wrapMode: Text.WordWrap
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ZoolButton{
                            id: btnCrearActualExt
                            text: 'Cargar'
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked:{
                                zm.loadNow(true)
                            }
                        }
                    }
                }
            }

            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Utilizar las coordenadas\ndel esquema interior.\nLatitud: '+zm.currentLat+'\nLongitud: '+zm.currentLon
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: cbUseIntCoords
                    checked: true
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged:{
                        if(apps.dev){
                            log.lv('UTC checkbox zm.currentLat: '+zm.currentLat)
                            log.lv('UTC checkbox zm.currentLon: '+zm.currentLon)
                        }
                        if(checked){
                            r.ulat=zm.currentLat
                            r.ulon=zm.currentLon
                            r.lat=zm.currentLat
                            r.lon=zm.currentLon
                        }
                    }
                    //onCheckedChanged: settings.inputCoords=checked
                }
            }
            ZoolTextInput{
                id: tiCiudad
                width:r.width-app.fs*0.5
                t.width: r.width-app.fs*0.25
                t.font.pixelSize: app.fs*0.65;
                labelText: 'Lugar, ciudad, provincia,\nregión y/o país de desde donde se obsevan los tránsitos'
                borderWidth: 2
                borderColor: apps.fontColor
                borderRadius: app.fs*0.1
                KeyNavigation.tab: settings.inputCoords?tiLat.t:(botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear)
                t.maximumLength: 50
                visible: !cbUseIntCoords.checked
                onTextChanged: {
                    tSearch.restart()
                    t.color='white'
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !cbUseIntCoords.checked
                Text{
                    text: 'Ingresar coordenadas\nmanualmente'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    checked: settings.inputCoords
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: settings.inputCoords=checked
                }
            }
            Column{
                id: colTiLonLat
                anchors.horizontalCenter: parent.horizontalCenter
                visible: settings.inputCoords && !cbUseIntCoords.checked

                Row{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Comps.XTextInput{
                        id: tiLat
                        width: r.width*0.5-app.fs*0.5
                        t.font.pixelSize: app.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                        KeyNavigation.tab: tiLon.t
                        t.maximumLength: 10
                        t.validator: RegExpValidator {
                            regExp: RegExp(/^(\+|\-)?0*(?:(?!999\.9\d*$)\d{0,3}(?:\.\d*)?|999\.0*)$/)
                        }
                        property bool valid: false
                        Timer{
                            running: r.visible && settings.inputCoords
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
                        onPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
                        }
                        Text {
                            text: 'Latitud'
                            font.pixelSize: app.fs*0.5
                            color: 'white'
                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                        }
                    }
                    Comps.XTextInput{
                        id: tiLon
                        width: r.width*0.5-app.fs*0.5
                        t.font.pixelSize: app.fs*0.65
                        anchors.verticalCenter: parent.verticalCenter
                        KeyNavigation.tab: botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear
                        t.maximumLength: 10
                        t.validator: RegExpValidator {
                            regExp: RegExp(/^(\+|\-)?0*(?:(?!999\.9\d*$)\d{0,3}(?:\.\d*)?|999\.0*)$/)
                        }
                        property bool valid: false
                        Timer{
                            running: r.visible && settings.inputCoords
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
                        onPressed: {
                            //controlTimeFecha.focus=true
                            //controlTimeFecha.cFocus=0
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
                Item{width: 1; height: app.fs*0.5;visible: settings.inputCoords}
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
                    visible: settings.inputCoords
                }
            }

            /*Button{
                text: 'Buscar'
                onClicked: {
                    searchBodieDateFronLong(4, 150.00, 2025, 1, 1, 2026, 1, 1, 0.1)
                }
            }*/
            Column{
                id: colLatLon
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.lat===r.ulat&&r.lon===r.ulon && !cbUseIntCoords.checked
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
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*0.25
                Button{
                    id: botClear
                    text: 'Limpiar'
                    font.pixelSize: app.fs*0.5
                    opacity:  r.lat!==-100.00||r.lon!==-100.00||tiCiudad.text!==''?1.0:0.0
                    enabled: opacity===1.0
                    visible: !cbUseIntCoords.checked
                    onClicked: {
                        clear()
                    }
                }
                Button{
                    id: botCrear
                    text: 'Cargar'
                    font.pixelSize: app.fs*0.5
                    KeyNavigation.tab: tiCiudad.t
                    visible: !cbUseIntCoords.checked?r.ulat!==-1&&r.ulon!==-1&&tiCiudad.text!=='':true
                    onClicked: {
                        loadTrans()
                    }
                }
            }
            ZoolText{
                text: 'ZoolFileTransLoader v1.3'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
    Timer{
        id: tSearch
        running: false
        repeat: false
        interval: 2000
        onTriggered: searchGeoLoc(false)
    }
    Item{id: xuqp}
    function searchGeoLoc(crear){
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='            console.log(logData)\n'
        c+='        let result=(\'\'+logData).replace(/\\n/g, \'\')\n'
        c+='        let json=JSON.parse(result)\n'
        c+='        if(json){\n'
        //c+='            console.log(JSON.stringify(json))\n'

        c+='                if(r.lat===-1&&r.lon===-1){\n'
        c+='                   tiCiudad.t.color="red"\n'
        c+='                }else{\n'
        c+='                   tiCiudad.t.color=apps.fontColor\n'
        if(crear){
            c+='                r.lat=json.coords.lat\n'
            c+='                r.lon=json.coords.lon\n'
            c+='                    updateUParams()//loadJsonFromArgsBack()\n'
            c+='                    //setNewJsonFileData()\n'
            c+='                    //r.state=\'hide\'\n'
        }else{
            c+='                r.ulat=json.coords.lat\n'
            c+='                r.ulon=json.coords.lon\n'
        }
        c+='                }\n'
        c+='        }else{\n'
        c+='            console.log(\'No se encontraron las cordenadas.\')\n'
        c+='        }\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\''+app.pythonLocation+' "'+u.currentFolderPath()+'/py/geoloc.py" "'+tiCiudad.t.text+'" "'+u.currentFolderPath()+'"\')\n'
        c+='        run(\''+app.pythonLocation+' "'+u.currentFolderPath()+'/py/geoloc.py" "'+tiCiudad.t.text+'" "'+u.currentFolderPath()+'"\')\n'
        c+='    }\n'
        c+='}\n'
        if(apps.dev)log.lv('\n\n'+c+'\n\n')
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodenewtrans')
    }
    function loadTrans(){
        if(!settings.inputCoords){
            if(cbUseIntCoords.checked){
                //log.lv('Preparado para cargar con las coordenadas del del mapa actual (Interior).')
                r.lat=zm.currentLat
                r.lon=zm.currentLon
                r.ulat=r.lat
                r.ulon=r.lon
                updateUParams()
                loadJsonFromArgsBack()
            }else{
                //log.lv('Buscando coordenadas antes de cargar tránsitos...')
                searchGeoLoc(true)
            }
        }else{
            //log.lv('Cargando tránsitos...')
            r.lat=parseFloat(tiLat.t.text)
            r.lon=parseFloat(tiLon.t.text)
            r.ulat=r.lat
            r.ulon=r.lon
            updateUParams()

            //loadJsonFromArgsBack()
            //setNewJsonFileData()
        }
    }
    function updateUParams(){
        if(r.ulat===-100.00&&r.ulon===-100.00)return
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        zm.enableLoadBack=true
        let vd=controlTimeFecha.dia
        let vm=controlTimeFecha.mes
        let va=controlTimeFecha.anio
        let vh=controlTimeFecha.hora
        let vmin=controlTimeFecha.minuto


        let vgmt=controlTimeFecha.gmt//tiGMT.t.text
        let vlon=r.lon
        let vlat=r.lat
        let vCiudad=tiCiudad.t.text
        r.uParamsLoaded='params_'+vd+'.'+vm+'.'+va+'.'+vh+'.'+vmin+'.'+vgmt+'.'+vlat+'.'+vlon+'.'+vCiudad+'.'+apps.currentHsys

    }
    function loadJsonFromArgsBack(){
        //if(apps.dev)log.ls('loadJsonFromArgsBack()...', 0, log.width)
        r.uParamsLoaded=''
        let t='trans'
        let hsys=apps.currentHsys
        let d=controlTimeFecha.dia
        let m=controlTimeFecha.mes
        let a=controlTimeFecha.anio
        let h=controlTimeFecha.hora
        let min=controlTimeFecha.minuto


        let gmt=controlTimeFecha.gmt//tiGMT.t.text

        let lat
        let lon
        let alt=0
        if(!cbUseIntCoords.checked){
            lat=r.lat
            lon=r.lon
        }else{
            lat=zm.currentLat
            lon=zm.currentLon
        }
        //log.lv('loadJsonFromArgsBack()...\nlat: '+lat+' lon:'+lon)
        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')

        let nom='Tránsito '+d+'.'+m+'.'+a+' '+h+'.'+min+' GMT.'+gmt+' '+tiCiudad.text

        let strEdad='Edad: '+zm.getEdad(d, m, a, h, min)+' años'
        let aR=[]
        zm.loadBackFromArgs(nom, d, m, a, h, min, gmt, lat, lon, alt, vCiudad, strEdad, t, hsys, -1, aR)
    }
    //Crear Proceso para searchBodieDateFronLong.py
    function initSearch(){
        if(bb.bsel1<0||bb.bsel<0)return
        botCancel.visible=true
        let numAstroBuscado=-1
        let b

        if(bb.bsel2>=0){
            b=zm.currentJson.pc['c'+bb.bsel1]
            numAstroBuscado=bb.bsel2
        }else{
            numAstroBuscado=bb.bsel1
            b=zm.currentJson.pc['c'+bb.bsel1]
        }
        let dHasta=new Date(r.cDateHasta)
        searchBodieDateFronLong(numAstroBuscado, b.gdec, controlTimeFechaForBB.anio, controlTimeFechaForBB.mes, controlTimeFechaForBB.dia, controlTimeFechaForBB.anio+1, 1, 1, 0.1)
        //searchBodieDateFronLong(numAstroBuscado, b.gdec, controlTimeFechaForBB.anio, controlTimeFechaForBB.mes, controlTimeFechaForBB.dia, dHasta.getFullYear(), dHasta.getMonth()+1, dHasta.getDate(), 0.1)
        //let fyd= new Date(r.cDateDesde)
        //let fy=fyd.getFullYear()
        //searchBodieDateFronLong(numAstroBuscado, b.gdec, fy, 1, 1, fy+1, 1, 1, 0.1)
    }
    function searchBodieDateFronLong(numAstro, g, ai, mi, di, af, mf, df, tol){
        let jNot={}
        jNot.id='trans_rev'
        if(!botCancel.visible){
            for(var i=0;i<xuqp.children.length;i++){
                xuqp.children[i].destroy(0)
            }
            jNot.text='Busqueda de tránsitos cancelada.'
            zpn.addNot(jNot, true, 15000)
            return
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='            console.log(logData)\n'
        c+='        let result=(\'\'+logData).replace(/\\n/g, \'\')\n'
        c+='        let json=JSON.parse(result)\n'
        c+='        if(json){\n'
        c+='            revSearchBodieDateFronLongResult(json)\n'
        c+='        }else{\n'
        c+='            log.lv(\'Error al consultar: searchBodieDateFronLong.py.\')\n'
        c+='        }\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\''+app.pythonLocation+' "'+u.currentFolderPath()+'/py/searchBodieDateFronLong.py" "'+app.sweFolder+'" '+numAstro+' '+g+' '+ai+' '+mi+' '+di+' '+af+' '+mf+' '+df+' '+tol+'\'\n'
        c+='        console.log(cmd)\n'
        c+='        run(cmd)\n'
        c+='    }\n'
        c+='}\n'
        if(apps.dev)log.lv('\n\n'+c+'\n\n')
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodenewtrans')
    }
    function revSearchBodieDateFronLongResult(j){
        let jNot={}
        jNot.id='trans_rev'
        if(!botCancel.visible){
            for(var i=0;i<xuqp.children.length;i++){
                xuqp.children[i].destroy(0)
            }
            jNot.text='Busqueda de tránsitos cancelada.'
            zpn.addNot(jNot, true, 15000)
            return
        }
        let d1=new Date(controlTimeFechaForBB.currentDate)

        let sfecha=''
        let strRTxt1='Buscando en fecha '+controlTimeFechaForBB.dia+'/'+controlTimeFechaForBB.mes+'/'+controlTimeFechaForBB.anio+'...'//+controlTimeFechaForBB.dia+'/'+controlTimeFechaForBB.mes+'/'+parseInt(controlTimeFechaForBB.anio + 1)
        if(j.isData){            
            let gred=redondearPersonalizado(j.gr)
            //log.lv('Grados: '+j.gb+' <--> '+gred)
            sfecha+=''+j.d+'/'+j.m+'/'+j.a+' '+j.h+':'+j.min
            if(j.gb>gred && j.tol < 0.005){
                jNot.text='Tránsito: Calculando'
                searchBodieDateFronLong(j.numAstro, j.gb, j.ai, j.mi, j.di, j.af, j.mf, j.df, j.tol*0.5)
            }else{
                //setSearchBodieDateFronLongResult(j)
                if(!tl.isDateInList(j)){
                    tl.addItem(j)
                    jNot.text='Tránsito: Fecha obtenida'
                }

                let d2=new Date(r.cDateHasta)
                let d3=new Date(j.a, j.m-1, j.d, j.h, j.min)
                //log.lv('d1: '+d1.toString())
                //log.lv('d2: '+d2.toString())
                //log.lv('d3: '+d3.toString())
                //if(controlTimeFechaForBB.anio<cDateHasta.getFullYear()){
                if(d3.getTime()<d2.getTime()){
                    let myDate = new Date(controlTimeFechaForBB.currentDate);
                    myDate.setDate(myDate.getDate() + 20);
                    controlTimeFechaForBB.currentDate=myDate
                    //d3=d3.setMonth(d3.getMonth()+1)
                    //controlTimeFechaForBB.currentDate=d3
                    //controlTimeFechaForBB.mes++
                    //controlTimeFechaForBB.anio=j.a
                    //controlTimeFechaForBB.mes=j.m
                    //controlTimeFechaForBB.dia=j.d
                    initSearch()
                    return
                }
            }
            jNot.text+=' '+sfecha
            //rTxt.text=strRTxt1+'\n'+jNot.text+'\nBúsqueda Finalizada.'
            rTxt.text='Búsqueda Finalizada.\nSe han encontrado un total de '+tl.olm.count+' aspectos (ángulos de incidencia) entre el '+zm.aBodies[bb.bsel2]+' transitando con respecto al '+zm.aBodies[bb.bsel1]+' natal o de origen.'
            botCancel.visible=false
        }else{
            let sfi=''+j.di+'/'+j.mi+'/'+j.ai
            let sff=''+j.df+'/'+j.mf+'/'+j.af
            jNot.text='En las fechas '+sfi+' y '+sff+', no hay ningún tránsito de '+zm.aBodies[bb.bsel2]+' sobre '+zm.aBodies[bb.bsel1]
            rTxt.text=strRTxt1+'\n'+jNot.text
            //if(controlTimeFechaForBB.currentDate.getTime()<cDateHasta.getTime()){
                //controlTimeFechaForBB.anio++
               //controlTimeFechaForBB.mes++
            //d1=d1.setMonth(d1.getMonth()+1)
            //controlTimeFechaForBB.currentDate=d1
            let myDate = new Date(controlTimeFechaForBB.currentDate);
            myDate.setDate(myDate.getDate() + 20);
            controlTimeFechaForBB.currentDate=myDate
                initSearch()
            //}
        }
        zpn.addNot(jNot, true, 15000)
    }
    function setSearchBodieDateFronLongResult(j){
        controlTimeFecha.currentDate=new Date(j.a, j.m-1, j.d, j.h, j.min)
        loadTrans()
    }
    function saveAsExt(n, data){
        let sp=zm.fileDataBack
        let p=JSON.parse(sp)
        let nd=new Date(Date.now())
        p.params.ms=nd.getTime()
        p.params.n=n
        p.params.data=data
        if(!p.params.c){
            p.params.c=zm.currentLugar
        }
        zfdm.addExtDataAndSave(p)
        zm.fileDataBack=JSON.stringify(p, null, 2)
    }
    function setInfoDesdeHasta(){
        let d=cDateDesde.getDate()
        let m=cDateDesde.getMonth()+1
        let a=cDateDesde.getFullYear()
        lDesde.text=''+d+'/'+m+'/'+a

        d=cDateHasta.getDate()
        m=cDateHasta.getMonth()+1
        a=cDateHasta.getFullYear()
        lHasta.text=''+d+'/'+m+'/'+a
    }
    function redondearPersonalizado(numero) {
        const factor = Math.pow(10, 2); // Factor para dos decimales
        const numeroString = numero.toString();
        const partes = numeroString.split('.');

        if (partes.length === 2 && partes[1].length > 3) {
            const cuartoDecimal = parseInt(partes[1][3]);
            if (cuartoDecimal >= 9) {
                return (Math.floor(numero * factor) + 1) / factor;
            }
        }
        return Math.round(numero * factor) / factor;
    }
    function clear(){
        r.ulat=-100
        r.ulon=-100
        tiNombre.t.text=''
        tiFecha1.t.text=''
        tiFecha2.t.text=''
        tiFecha3.t.text=''
        //tiHora1.t.text=''
        tiHora2.t.text=''
        tiCiudad.t.text=''
        tiGMT.t.text=''
    }
    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }
    function setFromExt(date){
        controlTimeFecha.currentDate=date
        loadTrans()
    }
    function getCurrentDate(){
        return controlTimeFecha.currentDate
    }

    //-->Teclado
    function enter(){
        if(botCrear.focus&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''){
            searchGeoLoc(true)
        }
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
    }
    function toDown(){
        if(controlTimeFecha.focus){
            controlTimeFecha.toDown()
        }
    }
    function isFocus(){
        return false
    }
    function toEscape(){
        //return false
    }
    property bool hasUnUsedFunction: true
    function unUsed(){
        //log.lv(app.j.qmltypeof(r)+'.unUsed()...')
    }
    //-->Teclado
}
