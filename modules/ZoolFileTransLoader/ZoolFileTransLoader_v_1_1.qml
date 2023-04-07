import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps

import ZoolText 1.1
import ZoolTextInput 1.0
import ZoolButton 1.2
import ZoolControlsTime 1.0

Rectangle {
    id: r
    width: xLatIzq.width
    height: zsm.getPanel('ZoolFileManager').hp
    visible: false
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    clip: true

    property alias xCfgItem: colXConfig

    property alias tiC: tiCiudad.t

    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property string uParamsLoaded: ''
    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible)zoolVoicePlayer.speak('Sección para cargar tránsitos.', true)
    }
    Timer{
        running: r.uParamsLoaded!==''
        repeat: false
        interval: 100
        onTriggered: r.loadJsonFromArgsBack()
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }

    Settings{
        id: settings
        fileName: 'zoolFileTransLoader.cfg'
        property bool showModuleVersion: false
        property bool inputCoords: false
    }
    ZoolText{
        text: 'ZoolFileMaker v1.0'
        font.pixelSize: app.fs*0.5
        color: apps.fontColor
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.1
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.1
        opacity: settings.showModuleVersion?1.0:0.0
        MouseArea{
            anchors.fill: parent
            onClicked: settings.showModuleVersion=!settings.showModuleVersion
        }
    }
    ZoolButton{
        text:'\uf013'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        z: col.z+1
        onClicked:{
            zoolFileManager.s.showConfig=!zoolFileManager.s.showConfig
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
                        //JS.showMsgDialog('Zool Informa', 'El sistema de casas ha cambiado.', 'Se ha seleccionado el sistema de casas '+app.ahysNames[currentIndex]+' ['+app.ahys[currentIndex]+'].')
                        //sweg.load(JSON.parse(app.currentData))
                        //JS.loadJson(apps.url)
                    }
                }

            }
            Column{
                spacing: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolControlsTime{
                    id: controlTimeFecha
                    gmt: 0
                    labelText: 'Momento de tránsitos'
                    KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    //enableGMT:false
                    onCurrentDateChanged: {
                        let d = new Date(currentDate)
                        if(app.currentGmt>0){
                            d.setHours(d.getHours()+app.currentGmt)
                        }else{
                            d.setHours(d.getHours()-app.currentGmt)
                        }
                        controlTimeFechaUTC.currentDate=d
                        controlTimeFechaUTC.gmt=0
                        //if(app.dev)log.lv('controlTimeFechaUTC.currentDate:'+controlTimeFechaUTC.currentDate.toString())
                        sweg.enableLoadBack=false
                        tUpdateParams.restart()
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
                    gmt: app.currentGmt
                    labelText: 'UTC - Tiempo Universal'
                    //KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    enableGMT:true
                    locked: true
                    onCurrentDateChanged: {
                        //sweg.enableLoadBack=false
                        //tUpdateParams.restart()
                    }
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
            Comps.XMarco{
                Row{
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    ZoolText{
                        text: 'Crear archivo nuevo únicamente de los tránsitos actuales.'
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
                        text: 'Crear'
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked:{
                            app.j.loadNow()
                            //controlTimeFecha.currentDate=new Date(Date.now())
                        }
                    }
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolButton{
                    text: 'Ahora'
                    onClicked:{
                        controlTimeFecha.currentDate=new Date(Date.now())
                    }
                }
                ZoolButton{
                    text: 'Recargar Hora de Archivo'
                    onClicked:{
                        let json=JSON.parse(app.currentData)
                        let d=new Date(json.params.a, parseInt(json.params.m - 1), json.params.d, json.params.h, json.params.min)
                        controlTimeFecha.currentDate=d
                        controlTimeFecha.gmt=0//json.params.gmt
                    }
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Utilizar las coordenadas\ndel esquema interior.\nLatitud: '+app.currentLat+'\nLongitud: '+app.currentLon
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    id: cbUseIntCoords
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged:{
                        if(app.dev){
                            log.lv('UTC checkbox app.currentLat: '+app.currentLat)
                            log.lv('UTC checkbox app.currentLon: '+app.currentLon)
                        }
                        if(checked){
                            r.ulat=app.currentLat
                            r.ulon=app.currentLon
                            r.lat=app.currentLat
                            r.lon=app.currentLon
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
                        if(!settings.inputCoords){
                            searchGeoLoc(true)
                        }else{
                            r.lat=parseFloat(tiLat.t.text)
                            r.lon=parseFloat(tiLon.t.text)
                            r.ulat=r.lat
                            r.ulon=r.lon
                            updateUParams()
                            //loadJsonFromArgsBack()
                            //setNewJsonFileData()
                        }
                    }

                    //                Timer{
                    //                    running: r.state==='show'
                    //                    repeat: true
                    //                    interval: 1000
                    //                    onTriggered: {
                    //                        let nom=tiNombre.t.text.replace(/ /g, '_')
                    //                        let fileName=apps.jsonsFolder+'/'+nom+'.json'
                    //                        if(unik.fileExist(fileName)){
                    //                            r.uFileNameLoaded=tiNombre.text
                    //                            let jsonFileData=unik.getFile(fileName)
                    //                            let j=JSON.parse(jsonFileData)
                    //                            let dia=''+j.params.d
                    //                            if(parseInt(dia)<=9){
                    //                                dia='0'+dia
                    //                            }
                    //                            let mes=''+j.params.m
                    //                            if(parseInt(mes)<=9){
                    //                                mes='0'+mes
                    //                            }
                    //                            let hora=''+j.params.h
                    //                            if(parseInt(hora)<=9){
                    //                                hora='0'+hora
                    //                            }
                    //                            let minuto=''+j.params.min
                    //                            if(parseInt(minuto)<=9){
                    //                                minuto='0'+minuto
                    //                            }
                    //                            let nt=new Date(parseInt(j.params.a), parseInt(mes - 1), parseInt(dia), parseInt(hora), parseInt(minuto))
                    //                            controlTimeFecha.currentDate=nt
                    //                            controlTimeFecha.gmt=j.params.gmt
                    //                            if(tiCiudad.text.replace(/ /g, '')===''){
                    //                                tiCiudad.text=j.params.ciudad
                    //                            }
                    //                            r.lat=j.params.lat
                    //                            r.lon=j.params.lon
                    //                            r.ulat=j.params.lat
                    //                            r.ulon=j.params.lon
                    //                            let vd=parseInt(tiFecha1.t.text)
                    //                            let vm=parseInt(tiFecha2.t.text)
                    //                            let vh=parseInt(tiHora1.t.text)
                    //                            let vmin=parseInt(tiHora2.t.text)
                    //                            let vgmt=controlTimeFecha.gmt//tiGMT.t.text
                    //                            let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
                    //                            if(j.params.d!==vd||j.params.m!==vm||j.params.a!==va||j.params.h!==vh||j.params.min!==vmin||r.lat!==r.ulat||r.lon!==r.ulon){
                    //                                botCrear.text='Modificar'
                    //                            }else{
                    //                                botCrear.text='[Crear]'
                    //                            }
                    //                        }else{
                    //                            botCrear.text='Crear'
                    //                        }
                    //                    }
                    //                }

                }
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
            //c+='                    setNewJsonFileData()\n'
            //c+='                if(tiGMT.t.text===""){\n'
            //c+='                    tiGMT.t.text=parseFloat(r.ulat / 10).toFixed(1)\n'
            //c+='                }\n'
        }
        c+='                }\n'
        c+='        }else{\n'
        c+='            console.log(\'No se encontraron las cordenadas.\')\n'
        c+='        }\n'
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        //c+='        console.log(\''+app.pythonLocation+' '+app.mainLocation+'/py/astrologica_swe.py '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+'\')\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/geoloc.py" "'+tiCiudad.t.text+'" "'+unik.currentFolderPath()+'"\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodenewvn')
    }

    //    function setNewJsonFileData(){
    //        console.log('setNewJsonFileData...')
    //        let unom=r.uFileNameLoaded.replace(/ /g, '_')
    //        let fileName=apps.jsonsFolder+'/'+unom+'.json'
    //        console.log('setNewJsonFileData() fileName: '+fileName)
    //        if(unik.fileExist(fileName)){
    //            //unik.deleteFile(fileName)
    //        }
    //        let d = new Date(Date.now())
    //        let ms=d.getTime()
    //        let nom=tiNombre.t.text.replace(/ /g, '_')

    //        //let m0=tiFecha.t.text.split('/')
    //        //if(m0.length!==3)return
    //        //let vd=parseInt(tiFecha1.t.text)
    //        //let vm=parseInt(tiFecha2.t.text)
    //        //let va=parseInt(tiFecha3.t.text)

    //        //m0=tiHora.t.text.split(':')
    //        //let vh=parseInt(tiHora1.t.text)
    //        //let vmin=parseInt(tiHora2.t.text)

    //        let vd=controlTimeFecha.dia
    //        let vm=controlTimeFecha.mes
    //        let va=controlTimeFecha.anio
    //        let vh=controlTimeFecha.hora
    //        let vmin=controlTimeFecha.minuto

    //        let vgmt=controlTimeFecha.gmt//tiGMT.t.text
    //        let vlon=r.lon
    //        let vlat=r.lat
    //        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
    //        let j='{'
    //        j+='"paramsBack":{'
    //        j+='"tipo":"vn",'
    //        j+='"ms":'+ms+','
    //        j+='"n":"'+nom+'",'
    //        j+='"d":'+vd+','
    //        j+='"m":'+vm+','
    //        j+='"a":'+va+','
    //        j+='"h":'+vh+','
    //        j+='"min":'+vmin+','
    //        j+='"gmt":'+vgmt+','
    //        j+='"lat":'+vlat+','
    //        j+='"lon":'+vlon+','
    //        j+='"ciudad":"'+vCiudad+'"'
    //        j+='}'
    //        j+='}'
    //        app.currentData=j
    //        nom=tiNombre.t.text.replace(/ /g, '_')
    //        unik.setFile(apps.jsonsFolder+'/'+nom+'.json', app.currentData)
    //        //apps.url=app.mainLocation+'/jsons/'+nom+'.json'
    //        JS.loadJson(apps.jsonsFolder+'/'+nom+'.json')
    //        //runJsonTemp()
    //    }
    function updateUParams(){
        if(r.ulat===-100.00&&r.ulon===-100.00)return
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        sweg.enableLoadBack=true
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
        //if(app.dev)log.ls('loadJsonFromArgsBack()...', 0, log.width)
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
            lat=app.currentLat
            lon=app.currentLon
        }
        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')

        let nom='Tránsito '+d+'.'+m+'.'+a+' '+h+'.'+m+' GMT.'+gmt+' '+tiCiudad.text

        let strEdad='Edad: '+app.j.getEdad(d, m, a, h, min)+' años'
        let aR=[]
        app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, vCiudad, strEdad, t, hsys, -1, aR)
        /*let d = new Date(Date.now())
        let ms=d.getTime()

        let vd=controlTimeFecha.dia
        let vm=controlTimeFecha.mes
        let va=controlTimeFecha.anio
        let vh=controlTimeFecha.hora
        let vmin=controlTimeFecha.minuto


        let vgmt=controlTimeFecha.gmt//tiGMT.t.text

        let vlat
        let vlon
        if(!cbUseIntCoords.checked){
            vlat=r.lat
            vlon=r.lon
        }else{
            vlat=app.currentLat
            vlon=app.currentLon
        }
        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')

        let nom='Tránsito '+vd+'.'+vm+'.'+va+' '+vh+'.'+vm+' GMT.'+vgmt+' '+tiCiudad.text

        let j='{'
        j+='"paramsBack":{'
        j+='"tipo":"trans",'
        j+='"ms":'+ms+','
        j+='"n":"'+nom+'",'
        j+='"d":'+vd+','
        j+='"m":'+vm+','
        j+='"a":'+va+','
        j+='"h":'+vh+','
        j+='"min":'+vmin+','
        j+='"gmt":'+vgmt+','
        j+='"lat":'+vlat+','
        j+='"lon":'+vlon+','
        j+='"ciudad":"'+vCiudad+'"'
        j+='}'
        j+='}'
        app.currentDataBack=j
        //if(app.dev)log.ls('loadJsonFromArgsBack() app.currentDataBack: '+app.currentDataBack, 0, log.width)
        app.j.loadJsonFromParamsBack(JSON.parse(app.currentDataBack))*/
    }
    function enter(){
        if(botCrear.focus&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''){
            searchGeoLoc(true)
        }
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
    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }

}
