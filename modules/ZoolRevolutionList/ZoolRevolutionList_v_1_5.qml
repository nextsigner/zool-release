import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
//import "../../js/Funcs.js" as JS
import "../../comps" as Comps

import ZoolButton 1.2
import ZoolText 1.0
import ZoolTextInput 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property alias currentIndex: lv.currentIndex
    property alias listModel: lm
    property int edadMaxima: 0
    property string jsonFull: ''
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1

    property int currentAnioSelected: -1
    property int currentNumKarma: -1

    property real lat:-100.00
    property real lon:-100.00

    property real ulat:-100.00
    property real ulon:-100.00


    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex
    onSvIndexChanged: {
//        if(svIndex===itemIndex){
//            if(edadMaxima<=0)xTit.showTi=true
//            tF.restart()
//        }else{
//            tF.stop()
//            tiEdad.focus=false
//        }
    }
    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible)zoolVoicePlayer.speak('Sección para crear revoluciones solares.', true)
    }
    Item{id:xuqp}
    Settings{
        id: settings
        fileName: 'zoolRevolutionList.cfg'
        //property bool showModuleVersion: false
        property bool inputCoords: false
    }
    Timer{
        id: tF
        running: svIndex===itemIndex
        repeat: false
        interval: 1500
        onTriggered: {
            //tiEdad.focus=true
        }
    }
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Flickable{
        id: flk
        width: r.width
        height: r.height
        contentWidth: r.width
        contentHeight: colCentral.height+app.fs*2
        Column{
            id: colCentral
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: xRetSolar
                width: r.width-app.fs
                height: colRetSolar.height+app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                radius: app.fs*0.25
                Column{
                    id: colRetSolar
                    width: parent.width
                    anchors.centerIn: parent
                    spacing: app.fs*0.25
                    Row{
                        spacing: app.fs*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                        ZoolText{
                            id: txtLabelRetSolar
                            text: 'Recibir retorno solar en otro sitio'
                            font.pixelSize: app.fs*0.5
                            t.width: app.fs*5
                            wrapMode: Text.WordWrap
                            color: apps.fontColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        CheckBox{
                            id: checkBoxRetSolar
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Column{
                        id: col
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: app.fs
                        visible: checkBoxRetSolar.checked
                        ZoolText{
                            text: '<b>¿Donde se esperará el retorno solar?</b>'//+height
                            w: r.width-app.fs
                            font.pixelSize: app.fs*0.65
                            color: apps.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        ZoolTextInput{
                            id: tiCiudad
                            width: xRetSolar.width-app.fs
                            t.font.pixelSize: app.fs*0.65;
                            labelText: 'Lugar, ciudad, provincia,\nregión y/o país de nacimiento'

                            KeyNavigation.tab: settings.inputCoords?tiLat.t:(botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear)
                            t.maximumLength: 70
                            borderWidth: 2
                            borderColor: apps.fontColor
                            borderRadius: app.fs*0.1
                            anchors.horizontalCenter: parent.horizontalCenter
                            onTextChanged: {
                                //tSearch.restart()
                                t.color='white'
                            }
                        }
                        Row{
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: app.fs*0.5
                            ZoolTextInput{
                                id: tiGMT
                                w: app.fs*2
                                t.font.pixelSize: app.fs*0.65;
                                labelText: 'GMT'

                                //KeyNavigation.tab: settings.inputCoords?tiLat.t:(botCrear.visible&&botCrear.opacity===1.0?botCrear:botClear)
                                t.maximumLength: 4
                                borderWidth: 2
                                borderColor: apps.fontColor
                                borderRadius: app.fs*0.1
                                anchors.verticalCenter: parent.verticalCenter
                                onTextChanged: {
                                    //tSearch.restart()
                                    //t.color='white'
                                }
                            }
                            ZoolButton{
                                text: 'Buscar Coordenadas'
                                anchors.verticalCenter: parent.verticalCenter
                                visible:!checkBoxInsertarCoordMan.checked
                                onClicked: searchGeoLoc(false)
                            }
                        }
                        Row{
                            spacing: app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                text: 'Ingresar coordenadas\nmanualmente'
                                font.pixelSize: app.fs*0.5
                                color: apps.fontColor
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            CheckBox{
                                id: checkBoxInsertarCoordMan
                                checked: settings.inputCoords
                                anchors.verticalCenter: parent.verticalCenter
                                onCheckedChanged: settings.inputCoords=checked
                            }
                        }
                        Column{
                            id: colTiLonLat
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: settings.inputCoords

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
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: app.fs*0.25
                            Button{
                                id: botClear
                                text: 'Limpiar'
                                font.pixelSize: app.fs*0.5
                                opacity:  r.lat!==-100.00||r.lon!==-100.00||tiCiudad.text!==''?1.0:0.0
                                enabled: opacity===1.0
                                onClicked: {
                                    clear()
                                }
                            }
                            Button{
                                id: botCrear
                                text: 'Crear'
                                font.pixelSize: app.fs*0.5
                                KeyNavigation.tab: tiCiudad.t
                                visible: r.ulat!==-1&&r.ulon!==-1&&tiCiudad.text!==''
                                onClicked: {
                                    if(!settings.inputCoords){
                                        searchGeoLoc(true)
                                    }else{
                                        r.lat=parseFloat(tiLat.t.text)
                                        r.lon=parseFloat(tiLon.t.text)
                                        r.ulat=r.lat
                                        r.ulon=r.lon
                                        setNewJsonFileData()
                                    }
                                }

                                //                            Timer{
                                //                                running: r.state==='show'
                                //                                repeat: true
                                //                                interval: 1000
                                //                                onTriggered: {
                                //                                    let nom=tiNombre.t.text.replace(/ /g, '_')
                                //                                    let fileName=apps.jsonsFolder+'/'+nom+'.json'
                                //                                    if(unik.fileExist(fileName)){
                                //                                        r.uFileNameLoaded=tiNombre.text
                                //                                        let jsonFileData=unik.getFile(fileName)
                                //                                        let j=JSON.parse(jsonFileData)
                                //                                        let dia=''+j.params.d
                                //                                        if(parseInt(dia)<=9){
                                //                                            dia='0'+dia
                                //                                        }
                                //                                        let mes=''+j.params.m
                                //                                        if(parseInt(mes)<=9){
                                //                                            mes='0'+mes
                                //                                        }
                                //                                        let hora=''+j.params.h
                                //                                        if(parseInt(hora)<=9){
                                //                                            hora='0'+hora
                                //                                        }
                                //                                        let minuto=''+j.params.min
                                //                                        if(parseInt(minuto)<=9){
                                //                                            minuto='0'+minuto
                                //                                        }
                                //                                        let nt=new Date(parseInt(j.params.a), parseInt(mes - 1), parseInt(dia), parseInt(hora), parseInt(minuto))
                                //                                        controlTimeFecha.currentDate=nt
                                //                                        controlTimeFecha.gmt=j.params.gmt
                                //                                        if(tiCiudad.text.replace(/ /g, '')===''){
                                //                                            tiCiudad.text=j.params.ciudad
                                //                                        }
                                //                                        r.lat=j.params.lat
                                //                                        r.lon=j.params.lon
                                //                                        r.ulat=j.params.lat
                                //                                        r.ulon=j.params.lon
                                //                                        let vd=parseInt(tiFecha1.t.text)
                                //                                        let vm=parseInt(tiFecha2.t.text)
                                //                                        let vh=parseInt(tiHora1.t.text)
                                //                                        let vmin=parseInt(tiHora2.t.text)
                                //                                        let vgmt=controlTimeFecha.gmt//tiGMT.t.text
                                //                                        let vCiudad=tiCiudad.t.text.replace(/_/g, ' ')
                                //                                        if(j.params.d!==vd||j.params.m!==vm||j.params.a!==va||j.params.h!==vh||j.params.min!==vmin||r.lat!==r.ulat||r.lon!==r.ulon){
                                //                                            botCrear.text='Modificar'
                                //                                        }else{
                                //                                            botCrear.text='[Crear]'
                                //                                        }
                                //                                    }else{
                                //                                        botCrear.text='Crear'
                                //                                    }
                                //                                }
                                //                            }

                            }
                        }
                    }
                }
            }
            Rectangle{
                id:xTit
                width: lv.width
                height: app.fs*1.5
                color: apps.fontColor
                border.width: 2
                border.color: 'white'//txtLabelTit.focus?'red':'white'
                anchors.horizontalCenter: parent.horizontalCenter
                property bool showTit: false
                property bool showTi: false
                //visible: !checkBoxRetSolar.checked
                onShowTiChanged: {
                    if(showTi){
                        tiEdad.focus=true
                        tiEdad.text=r.edadMaxima
                        tiEdad.selectAll()
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        xTit.showTit=false
                        //tShowXTit.start()
                    }
                    onExited: {
                        //xTit.showTit=false
                        //tShowXTit.start()
                    }
                    //onClicked: xTit.showTi=true
                }

                Rectangle{
                    color: parent.color
                    anchors.fill: parent
                    border.width: xTit.border.width
                    border.color: xTit.border.color
                    //visible: xTit.showTi
                    Row{
                        anchors.centerIn: parent
                        spacing: app.fs*0.5
                        ZoolText{
                            id: label
                            text:!checkBoxRetSolar.checked?'<b>Edad:</b>':'<b>Año:</b>'
                            anchors.verticalCenter: parent.verticalCenter
                            color: apps.backgroundColor
                            font.pixelSize: app.fs*0.5
                        }
                        Rectangle{
                            width: app.fs*1.5
                            height: app.fs*0.7
                            anchors.verticalCenter: parent.verticalCenter
                            color: apps.fontColor
                            border.width: 1
                            border.color: apps.backgroundColor
                            TextInput{
                                id: tiEdad
                                color: apps.backgroundColor
                                font.pixelSize: app.fs*0.5
                                width: parent.width*0.8
                                height: parent.height
                                anchors.centerIn: parent
                                validator: IntValidator {bottom: 1; top: 150}
                                onTextChanged: {
                                    if(focus)apps.zFocus='xLatIzq'
                                }
                                Keys.onReturnPressed: {
                                    r.enter()
                                }
                                Keys.onEnterPressed: {
                                    r.enter()
                                }
                            }
                        }

                        Comps.ButtonIcon{
                            text: '\uf002'
                            width: app.fs
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
                            }
                        }
                    }
                }

//                ZoolText{
//                    id: txtLabelTit
//                    //text: parent.showTit?'Revoluciones Solares hasta los '+r.edadMaxima+' años':'Click para cargar'
//                    text: 'Revoluciones Solares hasta los '+r.edadMaxima+' años'
//                    font.pixelSize: app.fs*0.5
//                    width: parent.width-app.fs
//                    wrapMode: Text.WordWrap
//                    color: apps.backgroundColor
//                    //focus: true
//                    anchors.centerIn: parent
//                    visible: !xTit.showTi
//                }

//                Timer{
//                    id: tShowXTit
//                    running: false
//                    repeat: false
//                    interval: 3000
//                    onTriggered: parent.showTit=true
//                }

            }
            //        Item{
            //            id: xCtrls
            //            width: r.width
            //            height: app.fs
            //            visible: lv.count>0
            Row{
                id: xCtrls
                spacing: app.fs*0.25
                height: btnLoad.height+app.fs*0.2
                //anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter
                visible: lv.count>0
                ZoolButton{
                    text:'\uf060'
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        if(lv.currentIndex>0)lv.currentIndex--
                    }
                }
                ZoolText{
                    text: parseInt(lv.currentIndex + 1)+' de '+lv.count
                    //height:fs
                    fs: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
                ZoolButton{
                    text:'\uf061'
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        if(lv.currentIndex<lv.count-1)lv.currentIndex++
                    }
                }
                ZoolText{
                    text: r.currentAnioSelected//lv.currentIndex
                    fs: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
                ZoolButton{
                    id: btnLoad
                    text:'Cargar'
                    //height: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        r.prepareLoad()
                    }
                }
            }
            //}
            ListView{
                id: lv
                width: r.width
                height: r.height-xTit.height-xCtrls.height-xRetSolar.height
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: compItemList
                model: lm
                cacheBuffer: 150
                displayMarginBeginning: cacheBuffer*app.fs*3
                clip: true
                Behavior on contentY{NumberAnimation{duration: app.msDesDuration}}
                onCurrentIndexChanged: {
                    if(currentIndex>=0){
                        contentY=lv.itemAtIndex(currentIndex).y+lv.itemAtIndex(currentIndex).height-r.height*0.5
                    }
                }
            }
        }
    }
    ListModel{
        id: lm
        function addItem(vJson){
            return {
                json: vJson
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: itemRS
            width: lv.width-r.border.width*2
            //height: index!==lv.currentIndex?app.fs*1.5:app.fs*3.5+app.fs
            height: index===lv.currentIndex?colDatos.height+app.fs*2:app.fs*3
            color: 'transparent'//apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: selected?1.0:0.85
            property int is: -1
            property var rsDate
            property bool selected: lv.currentIndex===index
            onSelectedChanged: {
                if(selected){
                    let j=JSON.parse(json)
                    let params=j['ph']['params']
                    let sdgmt=params.sdgmt
                    let m0=sdgmt.split(' ')//20/6/1984 06:40
                    let m1=m0[0].split('/')
                    r.currentAnioSelected=parseInt(m1[2])
                    //itemRS.rsDate=new Date(m1[2],parseInt(m1[1]-1),m1[0],m2[0],m2[1])
                }
            }
            onIsChanged:{
                iconoSigno.source="../../resources/imgs/signos/"+is+".svg"
            }
            //Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            Behavior on opacity{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            Timer{
                running: false//bg.color==='black' || bg.color==='#000000'
                repeat: true
                interval: 1000
                onTriggered: {
                    //console.log('IS:'+itemRS.is+' Color:'+bg.color)
                    //return
                    /*let c='#00ff88'
                    if(itemRS.is===0||itemRS.is===4||itemRS.is===8){
                        c=app.signColors[0]
                    }
                    if(itemRS.is===1||itemRS.is===5||itemRS.is===9){
                        c=app.signColors[1]
                    }
                    if(itemRS.is===2||itemRS.is===6||itemRS.is===10){
                        c=app.signColors[2]
                    }
                    if(itemRS.is===3||itemRS.is===7||itemRS.is===11){
                        c=app.signColors[3]
                    }*/
                    bg.color=app.signColors[itemRS.is]
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: lv.currentIndex=index
                onDoubleClicked: {
                    r.prepareLoad()
                }
            }
            Rectangle{
                id: bg
                width: parent.width
                height: index!==lv.currentIndex?itemRS.height:itemRS.height-app.fs
                anchors.centerIn: parent
                color: app.signColors[itemRS.is]
                border.width: index===lv.currentIndex?4:0
                border.color: 'red'
                SequentialAnimation on border.color {
                    running: index===lv.currentIndex
                    loops: Animation.Infinite
                    ColorAnimation { from: apps.pointerLineColor; to: apps.fontColor; duration: 200 }
                    ColorAnimation { from: apps.fontColor; to: apps.pointerLineColor; duration: 200 }
                    ColorAnimation { from: apps.pointerLineColor; to: apps.backgroundColor; duration: 200 }
                    ColorAnimation { from: apps.backgroundColor; to: apps.pointerLineColor; duration: 200 }
                }
            }
            Column{
                id: colDatos
                anchors.centerIn: parent
                Row{
                    spacing: app.fs*0.25
                    Column{
                        id: row
                        spacing: app.fs*0.1
                        anchors.verticalCenter: parent.verticalCenter
                        Rectangle{
                            id: labelEdad
                            width: lv.width*0.8-app.fs*0.5
                            height: txtEdad.contentHeight+app.fs*0.25
                            color: 'black'
                            border.width: 1
                            border.color: 'white'
                            radius: app.fs*0.1
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text {
                                id: txtEdad
                                width: parent.width-app.fs*0.5 //app.fs*3.5
                                text: 'Desde <b>'+parseInt(index)+'</b> años<br>hasta <b>'+parseInt(index +1)+'</b>\n años'
                                color: 'white'
                                font.pixelSize: index!==lv.currentIndex?app.fs*0.35:app.fs*0.6
                                wrapMode: Text.WordWrap
                                textFormat: Text.RichText
                                horizontalAlignment: Text.AlignHCenter
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            id: labelFecha
                            width: lv.width*0.8-app.fs*0.5
                            height: txtData.contentHeight+app.fs*0.25
                            color: 'black'
                            border.width: 1
                            border.color: 'white'
                            radius: app.fs*0.1
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text {
                                id: txtData
                                font.pixelSize: index!==lv.currentIndex?app.fs*0.35:app.fs*0.5
                                width: parent.width
                                wrapMode: Text.WordWrap
                                textFormat: Text.RichText
                                horizontalAlignment: Text.AlignHCenter
                                color: 'white'
                                anchors.centerIn: parent
                            }
                        }
                    }
                    Column{
                        spacing: app.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        Rectangle{
                            width: itemRS.selected?itemRS.width*0.2:itemRS.width*0.1
                            height: width
                            border.width: 2
                            radius: width*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            Image {
                                id: iconoSigno
                                //source: indexSign!==-1?"./resources/imgs/signos/"+indexSign+".svg":""
                                width: parent.width*0.8
                                height: width
                                anchors.centerIn: parent
                            }
                        }
                        Rectangle{
                            width: itemRS.selected?itemRS.width*0.2:itemRS.width*0.1
                            height: width
                            radius: width*0.5
                            color: apps.backgroundColor
                            border.width: app.fs*0.1
                            border.color: apps.fontColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            ZoolText{
                                id: labelAnioPersonal
                                text: '7'
                                fs: parent.width*0.5
                                anchors.centerIn: parent
                            }
                            Rectangle{
                                width: parent.width*0.45
                                height: width
                                radius: width*0.5
                                color: apps.backgroundColor
                                border.width: app.fs*0.1
                                border.color: apps.fontColor
                                anchors.verticalCenter: parent.top
                                visible: itemRS.selected
                                ZoolText{
                                    id: labelNumKarma
                                    text: '7'
                                    fs: parent.width*0.5
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }
            function loadRs(gmt, lat, lon, alt){
                if(app.dev)log.lv('itemRs.loadRs()... gmt: '+gmt+' lat:'+lat+' lon: '+lon+' alt: '+alt)
                r.loadRs(itemRS.rsDate, index, gmt, lat, lon, alt)
            }
            Component.onCompleted: {
                let j=JSON.parse(json)
                let params=j['ph']['params']
                let sd=params.sd
                let sdgmt=params.sdgmt
                itemRS.is=j['ph']['h1']['is']

                txtData.text="GMT: "+sdgmt + "<br />UTC: "+sd

                let m0=sd.split(' ')//20/6/1984 06:40
                let m1=m0[0].split('/')
                let m2=m0[1].split(':')
                itemRS.rsDate=new Date(m1[2],parseInt(m1[1]-1),m1[0],m2[0],m2[1])

                m0=sdgmt.split(' ')//20/6/1984 06:40
                m1=m0[0].split('/')
                m2=m0[1].split(':')
                let itemRsGMT =new Date(m1[2],parseInt(m1[1]-1),m1[0],m2[0],m2[1])

                let d = itemRsGMT.getDate()
                let m = itemRsGMT.getMonth() + 1
                let a = itemRsGMT.getFullYear()
                let f = d + '/' + m + '/' + a
                let aGetNums=app.j.getNums(f)
                if(index===0){
                    r.currentNumKarma=aGetNums[0]
                    r.currentAnioSelected=parseInt(a)
                }
                labelAnioPersonal.text=aGetNums[0]
                labelNumKarma.text=r.currentNumKarma
                //txtData.text+='<br />N° Karma: '+r.currentNumKarma+' Año Personal: '+aGetNums[0]
            }
        }
    }

    Timer{
        id: tSetGui
        running: r.visible
        repeat: true
        interval: 500
        onTriggered: {
//            if(lv.count<1){
//                xTit.showTit=true
//                xTit.showTi=true
//            }else{
//                xTit.showTit=false
//                xTit.showTi=false
//            }
        }
    }

    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Revolución Solar')
    }
    function setRsList(edad){
        r.jsonFull=''
        r.edadMaxima=edad-1
        lm.clear()
        let cd3= new Date(app.currentDate)
        //let hsys=apps.currentHsys
        let finalCmd=''
        //finalCmd+=''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol_time.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+edad+' "'+unik.currentFolderPath()+'"'//+' '+hsys
        if(!checkBoxRetSolar.checked){
            finalCmd+=''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol_time.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+edad+' "'+unik.currentFolderPath()+'"'//+' '+hsys
        }else{
            finalCmd+=''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol_time.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+0+' '+r.ulat+' '+r.ulon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+edad+' "'+unik.currentFolderPath()+'"'//+' '+hsys
        }
        let c=''
            +'  if(logData.length<=3||logData==="")return\n'
            +'  let j\n'
            +'try {\n'
            +'  j=JSON.parse(logData)\n'
            +'  loadJson(j)\n'
            +'  logData=""\n'
            +'} catch(e) {\n'
            +'  console.log(e+" "+logData);\n'
            +'  //unik.speak("error");\n'
            +'}\n'
        mkCmd(finalCmd, c, xuqp)
    }
    function mkCmd(finalCmd, code, item){
        for(var i=0;i<item.children.length;i++){
            item.children[i].destroy(0)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='import "../../js/Funcs.js" as JS\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        '+code+'\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        //c+='        log.ls(\'finalCmdRS: '+finalCmd+'\', 0, 500)\n'
        c+='        run(\''+finalCmd+'\')\n'
        c+='    }\n'
        c+='}\n'
        //console.log(c)
        let comp=Qt.createQmlObject(c, item, 'uqpcodecmdrslist')
    }
    function clear(){
        r.edadMaxima=-1
        lm.clear()
        r.state='hide'
    }
    function prepareLoad(){
        //tiEdad.focus=false
        if(!checkBoxRetSolar){
            r.ulat=app.currentLat
            r.ulon=app.currentLon
            if(app.dev){
                log.lv('r.ulat: '+r.ulat)
                log.lv('r.ulon: '+r.ulon)
            }
            //lv.itemAtIndex(lv.currentIndex).loadRs(0, app.currentLat, app.currentLon, app.currentAlt)
            lv.itemAtIndex(lv.currentIndex).loadRs(0, app.currentLat, app.currentLon, app.currentAlt)
        }else{
            r.ulat=app.currentLat
            r.ulon=app.currentLon
            if(app.dev){
                log.lv('r.ulat: '+r.ulat)
                log.lv('r.ulon: '+r.ulon)
            }
            lv.itemAtIndex(lv.currentIndex).loadRs(0, app.currentLat, app.currentLon, app.currentAlt)
            //lv.itemAtIndex(lv.currentIndex).loadRs(app.currentGmt, app.currentLat, app.currentLon, app.currentAlt)
        }
    }
    function loadRs(date, index, gmt, lat, lon, alt){
        //if(app.dev)log.lv('1 loadRs()... gmt: '+gmt)
        let d = new Date(date)
        let ms=new Date(Date.now()).getTime()

        let vd=d.getDate()
        let vm=d.getMonth()+1
        let va=d.getFullYear()
        let vh=d.getHours()
        let vmin=d.getMinutes()

        let nom='Rev.Solar '+va

        let strEdad='Edad: '+index+' años'
        let ubicacion=app.currentLugar
        let aR=[]
        aR.push(''+va+'/'+vm+'/'+vd)
        aR.push(''+vh+':'+vmin)
        aR.push(ubicacion)
        aR.push('<b>GMT:</b>'+gmt)
        aR.push('<b>Lat:</b>'+lat)
        aR.push('<b>Lon:</b>'+lon)
        aR.push('<b>Alt:</b>'+alt)
        app.j.loadBack(nom, vd, vm, va, vh, vmin, gmt, lat, lon, alt, ubicacion, strEdad, 'rs', apps.currentHsys, -1, aR)
    }
    function loadJson(json){
        lm.clear()
        for(var i=0;i<Object.keys(json).length;i++){
            let j=json['rs'+i]
            lm.append(lm.addItem(JSON.stringify(j)))
        }
    }
    function enter(){
        if(app.dev)log.lv('ZoolRevolutionList.enter()... lv.currentIndex: '+lv.currentIndex)
        if(lv.currentIndex<=0 && lv.count<1){
            log.lv('0 ZoolRevolutionList enter()...')
            xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
            return
        }else{
            log.lv('1 ZoolRevolutionList enter()...')
            r.prepareLoad()
        }
    }
    function insert(){
        tiEdad.focus=true
    }
    function up(){
        if(lv.currentIndex>0)lv.currentIndex--
    }
    function down(){
        if(lv.currentIndex<lv.count)lv.currentIndex++
    }
    function desactivar(){
        tiEdad.focus=false
    }
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
        c+='            console.log(JSON.stringify(json))\n'

        c+='                if(r.lat===-1&&r.lon===-1){\n'
        c+='                   tiCiudad.t.color="red"\n'
        c+='                }else{\n'
        c+='                   tiCiudad.t.color=apps.fontColor\n'
        if(crear){
            c+='                r.lat=json.coords.lat\n'
            c+='                r.lon=json.coords.lon\n'
            c+='                    setNewJsonFileData()\n'
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
}
