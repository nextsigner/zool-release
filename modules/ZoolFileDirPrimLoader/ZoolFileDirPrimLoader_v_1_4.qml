import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import "../../comps" as Comps
import "../../js/Funcs.js" as JS

import ZoolText 1.0
import ZoolTextInput 1.0
import ZoolButton 1.0
import ZoolControlsTime 1.0
import ZoolLogView 1.0

Rectangle {
    id: r
    width: xLatIzq.width
    height: xLatIzq.height-xPanelesTits.height-app.fs*0.5
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property alias ctFecha: controlTimeFecha
    property alias xCfgItem: colXConfig

    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00

    property string uParamsLoaded: ''

    property bool loadingFromExternal: false

    Timer{
        id: tWaitLoadExterior
        running: false
        repeat: false
        interval: 3000
        onTriggered: {
            if(app.dev)log.lv('tWaitLoadExterior...')
            r.setDirPrimRotation()
        }
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }

    Settings{
        id: settings
        fileName: 'zoolFileDirPrimLoader.cfg'
        property bool showModuleVersion: false
        property bool inputCoords: false
    }
    ZoolText{
        text: 'ZoolFileDirPrimLoader v1.0'
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
    /*ZoolButton{
        text:'\uf013'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        z: col.z+1
        onClicked:{
            zoolFileManager.s.showConfig=!zoolFileManager.s.showConfig
        }
    }*/

    Flickable{
        id: flk
        width: r.width-app.fs
        height: r.height
        contentWidth: col.width
        contentHeight: col.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Item{width: 1; height: app.fs; visible: colXConfig.visible}
            Column{
                id: colXConfig
                anchors.horizontalCenter: parent.horizontalCenter
            }
            ZoolText{
                //t.width:r.width-app.fs
                text: '<b>Crear Direcciones Primarias</b>'
                w: r.width-app.fs
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            Column{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                //width: r.width-app.fs
                ZoolText{
                    id: labelCbHSys
                    text: 'Sistema de Casas:'
                    //w: app.fs*3
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox{
                    id: cbHsys
                    width: r.width-app.fs//-labelCbHSys.width-parent.spacing
                    height: app.fs*0.75
                    font.pixelSize: app.fs*0.5
                    model: app.ahysNames
                    currentIndex: app.ahys.indexOf(apps.currentHsys)
                    anchors.horizontalCenter: parent.horizontalCenter
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
                    labelText: 'Momento de tránsitos'
                    //KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    enableGMT:false
                    visible: false
                    //                    onCurrentDateChanged: {
                    //                        let d = new Date(currentDate)
                    //                        if(app.currentGmt>0){
                    //                            d.setHours(d.getHours()+app.currentGmt)
                    //                        }else{
                    //                            d.setHours(d.getHours()-app.currentGmt)
                    //                        }
                    //                        controlTimeFechaUTC.currentDate=d
                    //                        controlTimeFechaUTC.gmt=0
                    //                        //if(app.dev)log.lv('controlTimeFechaUTC.currentDate:'+controlTimeFechaUTC.currentDate.toString())
                    //                        sweg.enableLoadBack=false
                    //                        tUpdateParams.restart()
                    //                    }
                    //                    Timer{
                    //                        id: tUpdateParams
                    //                        running: false
                    //                        repeat: false
                    //                        interval: 1500
                    //                        onTriggered: updateUParams()
                    //                    }
                }
                ZoolButton{
                    text:!app.ev?'Cargar Exterior':'Recargar Exterior'
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:{
                        if(app.ev){
                            controlTimeFechaEvento.visible=false
                            controlTimeFechaEvento.currentDate=app.currentDate
                        }

                        r.loadJsonFromArgsBack()
                    }
                }
                ZoolControlsTime{
                    id: controlTimeFechaEvento
                    gmt: 0
                    labelText: 'Momento del evento'
                    //KeyNavigation.tab: tiCiudad.t
                    setAppTime: false
                    enableGMT:false
                    visible: false
                    onCurrentDateChanged: {
                        //if(!visible || !r.loadingFromExternal)return
                        if(!r.visible && !r.loadingFromExternal)return
                        //if(app.dev)log.lv('controlTimeFechaEvento--> onCurrentDateChanged...'+currentDate.toString())
                        if(app.j.eventoEsMenorAInicio(app.currentDate, currentDate)){
                            currentDate=app.currentDate
                            return
                        }
                        if(!app.ev){
                            r.loadJsonFromArgsBack()
                            tWaitLoadExterior.start()                            
                        }else{
                            setDirPrimRotation()
                        }
                    }
                    Timer{
                        id: tUpdateParamsEvento
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: updateUParams()
                    }
                }

                ZoolButton{
                    text:'Guardar'
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:{
                        //app.j.loadBack(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, edad, tipo, hsys, ms, vAtRigth)

                        let vd=controlTimeFecha.dia
                        let vm=controlTimeFecha.mes
                        let va=controlTimeFecha.anio
                        let vh=controlTimeFecha.hora
                        let vmin=controlTimeFecha.minuto

                        let vgmt=app.currentGmt//controlTimeFecha.gmt//tiGMT.t.text
                        let vlon=app.currentLon
                        let vlat=app.currentLat
                        let valt=app.currentAlt
                        let vCiudad=app.currentLugar
                        let vhsys=apps.currentHsys

                        let vdEvento=controlTimeFechaEvento.dia
                        let vmEvento=controlTimeFechaEvento.mes
                        let vaEvento=controlTimeFechaEvento.anio
                        let vhEvento=controlTimeFechaEvento.hora
                        let vminEvento=controlTimeFechaEvento.minuto

                        let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))

                        let nom='Dir. Prim de '+app.currentNom+' '+vaEvento+'/'+vmEvento+'/'+vdEvento
                        let aR=[]
                        aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
                        aR.push('<b>Edad:</b> '+edad+' años')
                        app.j.loadBack(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, edad, 'dirprim', vhsys, -1, aR)
                    }
                }
                //ZoolLogView
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
        }
    }
    Item{id: xuqp}

    function updateUParams(){
        controlTimeFecha.gmt=app.currentGmt
        controlTimeFechaEvento.gmt=app.currentGmt
        if(r.ulat===-100.00&&r.ulon===-100.00)return
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        //sweg.enableLoadBack=true
        let vd=controlTimeFecha.dia
        let vm=controlTimeFecha.mes
        let va=controlTimeFecha.anio
        let vh=controlTimeFecha.hora
        let vmin=controlTimeFecha.minuto

        let vdEvento=controlTimeFechaEvento.dia
        let vmEvento=controlTimeFechaEvento.mes
        let vaEvento=controlTimeFechaEvento.anio
        let vhEvento=controlTimeFechaEvento.hora
        let vminEvento=controlTimeFechaEvento.minuto

        let vgmt=app.currentGmt//controlTimeFecha.gmt//tiGMT.t.text
        let vlon=r.lon
        let vlat=r.lat
        let vCiudad=app.currentLugar
        //r.uParamsLoaded='params_fecha_inicio_'+vd+'.'+vm+'.'+va+'.'+vh+'.'+vmin+'_fecha_evento_'+vdEvento+'.'+vmEvento+'.'+vaEvento+'.'+vhEvento+'.'+vminEvento+'.'+vgmt+'.'+vlat+'.'+vlon+'.'+vCiudad+'.'+apps.currentHsys

        r.uParamsLoaded='params_fecha_inicio_'+vd+'.'+vm+'.'+va+'.'+vh+'.'+vmin+'.'+vgmt+'.'+vlat+'.'+vlon+'.'+vCiudad+'.'+apps.currentHsys

        /*let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))
        let aR=[]
        aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
        aR.push('<b>Edad:</b> '+edad+' años')
        zoolDataView.setDataView('Dir. Primarias', zoolDataView.atLeft, aR)*/

    }
    function setDirPrimRotation(){
        //if(!r.visible  && !r.loadingFromExternal)return
        if(app.dev)log.lv('setDirPrimRotation()... r.loadingFromExternal: '+r.loadingFromExternal)
        r.ulat=app.currentLat
        r.ulon=app.currentLon
        r.lat=app.currentLat
        r.lon=app.currentLon

        let j=app.currentJson
        if(!j)return
        let signCircleRot=parseFloat(j.ph.h1.gdec).toFixed(2)
        //l.lv('signCircleRot:'+signCircleRot)

        //El astrólogo y matemático alemán Valentín Naibod cree perfeccionar la clave de Ptolomeo.
        let claveNaibodDeg=[0, 59, 8.33]
        let claveNaibodDec=0.9856481481481388
        let da = new Date(controlTimeFecha.currentDate)//Momento de inicio o nacimiento.
        let db = new Date(controlTimeFechaEvento.currentDate)//Momento de evento.
        let msAnioInicio=da.getTime()
        let msAnioEvento=db.getTime()
        let resSegA=msAnioInicio / 1000 //Cálculo de segundos de inicio.
        let resSegB=msAnioEvento / 1000 //Cálculo de segundos de evento.
        let resMinA=resSegA / 60 //Cálculo de minutos de inicio.
        let resMinB=resSegB / 60 //Cálculo de minutos de evento.
        let resHoraA=resMinA / 60 //Cálculo de horas de inicio.
        let resHoraB=resMinB / 60 //Cálculo de horas de evento.
        let resDiffHoras=resHoraB-resHoraA //Cálculo de diferencia de horas.
        let resDias=resDiffHoras / 24 //Cálculo de días de diferencia.
        let resAnio=parseFloat(resDias / 365.25).toFixed(2) //Cálc. diferencia en años entre inicio y evento.
        let diffAnio=resAnio*claveNaibodDec //Cálculo de diferencia de años en clave Naibod.
        let pcBackRot=parseFloat(parseFloat(signCircleRot)-parseFloat(diffAnio))

        //Cálculo de rotacion del esquema exterior para el método de Direcciones Primarias.
        let hcRot=parseFloat(parseFloat(90)-parseFloat(diffAnio))
        let hcBackRot=0.0-parseFloat(diffAnio)
        sweg.objHousesCircleBack.rotation=hcBackRot
        sweg.objPlanetsCircleBack.rotation=hcBackRot

        let vdEvento=controlTimeFechaEvento.dia
        let vmEvento=controlTimeFechaEvento.mes
        let vaEvento=controlTimeFechaEvento.anio
        let vhEvento=controlTimeFechaEvento.hora
        let vminEvento=controlTimeFechaEvento.minuto

        //if(app.dev)log.lv('controlTimeFechaEvento.onCurrentDateChanged...')
        let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))
        let aR=[]
        aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
        aR.push('<b>Edad:</b> '+edad+' años')
        zoolDataView.setDataView('Dir. Primarias', zoolDataView.atLeft, aR)

        if(app.ev&&app.mod==='dirprim')return
        tUpdateParamsEvento.restart()
        r.loadingFromExternal=true
    }

    function setDirPrimRotationFromExternalItem(dateInicio, dateEvento){
        r.lat=app.currentLat
        r.lon=app.currentLon
        r.ulat=app.currentLat
        r.lon=app.currentLon
        controlTimeFecha.gmt=app.currentGmt
        controlTimeFechaEvento.gmt=app.currentGmt
        controlTimeFecha.currentDate=dateInicio
        r.loadingFromExternal=true
        controlTimeFechaEvento.currentDate=dateEvento
        //loadJsonFromArgsBack()
        //return

        //Qt.quit()
        r.ulat=app.currentLat
        r.ulon=app.currentLon
        r.lat=app.currentLat
        r.lon=app.currentLon

        let j=app.currentJson
        if(!j)return
        let signCircleRot=parseFloat(j.ph.h1.gdec).toFixed(2)
        //l.lv('signCircleRot:'+signCircleRot)

        //El astrólogo y matemático alemán Valentín Naibod cree perfeccionar la clave de Ptolomeo.
        let claveNaibodDeg=[0, 59, 8.33]
        let claveNaibodDec=0.9856481481481388
        let da = new Date(dateInicio)//Momento de inicio o nacimiento.
        let db = new Date(dateEvento)//Momento de evento.
        let msAnioInicio=da.getTime()
        let msAnioEvento=db.getTime()
        let resSegA=msAnioInicio / 1000 //Cálculo de segundos de inicio.
        let resSegB=msAnioEvento / 1000 //Cálculo de segundos de evento.
        let resMinA=resSegA / 60 //Cálculo de minutos de inicio.
        let resMinB=resSegB / 60 //Cálculo de minutos de evento.
        let resHoraA=resMinA / 60 //Cálculo de horas de inicio.
        let resHoraB=resMinB / 60 //Cálculo de horas de evento.
        let resDiffHoras=resHoraB-resHoraA //Cálculo de diferencia de horas.
        let resDias=resDiffHoras / 24 //Cálculo de días de diferencia.
        let resAnio=parseFloat(resDias / 365.25).toFixed(2) //Cálc. diferencia en años entre inicio y evento.
        let diffAnio=resAnio*claveNaibodDec //Cálculo de diferencia de años en clave Naibod.
        let pcBackRot=parseFloat(parseFloat(signCircleRot)-parseFloat(diffAnio))

        //Cálculo de rotacion del esquema exterior para el método de Direcciones Primarias.
        let hcRot=parseFloat(parseFloat(90)-parseFloat(diffAnio))
        let hcBackRot=0.0-parseFloat(diffAnio)
        sweg.objHousesCircleBack.rotation=hcBackRot
        sweg.objPlanetsCircleBack.rotation=hcBackRot

        let vdEvento=controlTimeFechaEvento.dia
        let vmEvento=controlTimeFechaEvento.mes
        let vaEvento=controlTimeFechaEvento.anio
        let vhEvento=controlTimeFechaEvento.hora
        let vminEvento=controlTimeFechaEvento.minuto

        //if(app.dev)log.lv('controlTimeFechaEvento.onCurrentDateChanged...')
        let edad=app.j.getEdadDosFechas(app.currentDate, new Date(vaEvento, vmEvento-1, vdEvento, vhEvento, vminEvento))
        let aR=[]
        aR.push('<b>Fecha:</b> '+vdEvento+'/'+vmEvento+'/'+vaEvento)
        aR.push('<b>Edad:</b> '+edad+' años')
        zoolDataView.setDataView('Dir. Primarias', zoolDataView.atLeft, aR)

        if(app.ev&&app.mod==='dirprim')return
        tUpdateParamsEvento.restart()
    }



    function loadJsonFromArgsBack(){
        //if(app.dev)log.ls('loadJsonFromArgsBack()...', 0, log.width)
        if(!r.visible && !r.loadingFromExternal)return
        r.uParamsLoaded=''

        let vtipo='dirprim'

        let d = new Date(Date.now())
        let ms=d.getTime()

        let vd=controlTimeFecha.dia
        let vm=controlTimeFecha.mes
        let va=controlTimeFecha.anio
        let vh=controlTimeFecha.hora
        let vmin=controlTimeFecha.minuto

        let vdEvento=controlTimeFechaEvento.dia
        let vmEvento=controlTimeFechaEvento.mes
        let vaEvento=controlTimeFechaEvento.anio
        let vhEvento=controlTimeFechaEvento.hora
        let vminEvento=controlTimeFechaEvento.minuto

        let vgmt=app.currentGmt//controlTimeFecha.gmt//tiGMT.t.text

        let vlat
        let vlon
        let valt=0

        vlat=app.currentLat
        vlon=app.currentLon

        let vCiudad=app.currentLugar.replace(/_/g, ' ')

        let nom='Direcciones Primarias '+vd+'.'+vm+'.'+va+' '+vh+'.'+vm

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
        j+='"ciudad":"'+vCiudad+'",'
        j+='"hsys":"'+vhsys+'",'
        j+='"extId":"'+extId+'"'
        j+='},'
        j+='"exts":[]'
        j+='}'
        app.currentDataBack=j

        app.j.loadBack(nom, vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, vCiudad, '0', vtipo, vhsys, -1, [])

        //if(app.dev)log.lv('loadJsonFromArgsBack():\n'+app.fileData)
        //let json=JSON.parse(app.currentJsonData)
        //xArcsBack.rotation=360-jsonData.ph.h1.gdec+signCircle.rot//+1
        let rotSignCircle=sweg.objSignsCircle.rot
        let rotPlanetsCircle=rotSignCircle
        let rotHousesCircle=360-rotSignCircle//360-json.ph.h1.gdec+rotPlanetsCircle
        sweg.objHousesCircleBack.rotation=rotHousesCircle
        controlTimeFechaEvento.visible=true
        if(r.loadingFromExternal){
            tWaitLoadExterior.restart()
        }
        r.loadingFromExternal=false
    }
    function enter(){
        if(botCrear.focus&&tiNombre.text!==''&&tiFecha1.text!==''&&tiFecha2.text!==''&&tiFecha3.text!==''&&tiHora1.text!==''&&tiHora2.text!==''&&tiGMT.text!==''&&tiCiudad.text!==''){
            //searchGeoLoc(true)
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
