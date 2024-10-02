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

    property int uAnio: -1

    property var uJson: ({})


    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex
    onSvIndexChanged: {
        //        if(svIndex===itemIndex){
        //            if(edadMaxima<=0)xTit.showTi=true
        //            tF.restart()
        //        }else{
        //            tF.stop()
        //            tiAnio.focus=false
        //        }
    }
    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible){
            if(lv.count===0){
                setListLunar(parseInt(tiAnio.text), showAll.checked)
            }
            zoolVoicePlayer.speak('Sección de Lista de Eventos Lunares.', true)
        }
    }
    Item{id:xuqp}

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
                        tiAnio.focus=true
                        tiAnio.text=r.edadMaxima
                        tiAnio.selectAll()
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
                            text:'<b>Año:</b>'
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
                                id: tiAnio
                                color: apps.backgroundColor
                                font.pixelSize: app.fs*0.5
                                width: parent.width*0.8
                                height: parent.height
                                anchors.centerIn: parent
                                validator: IntValidator {bottom: 1000; top: 3000}
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
                                setListLunar(parseInt(tiAnio.text), showAll.checked)
                            }
                        }
                        Row{
                            spacing: app.fs*0.1
                            anchors.verticalCenter: parent.verticalCenter
                            ZoolText{
                                text:showAll.checked?'<b>Ver Solo</b><br><b>Eclipses</b>':'<b>Ver todas</b><br><b>las lunas</b>'
                                anchors.verticalCenter: parent.verticalCenter
                                color: apps.backgroundColor
                                font.pixelSize: app.fs*0.5
                            }
                            CheckBox{
                                id: showAll
                                checked: true
                                onCheckedChanged: {
                                    setListLunar(tiAnio.text, checked)
                                }
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
                    opacity: lv.currentIndex>=0?1.0:0.0
                }
                ZoolButton{
                    text:'\uf061'
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        if(lv.currentIndex<lv.count-1)lv.currentIndex++
                    }
                }
//                ZoolText{
//                    text: r.currentAnioSelected//lv.currentIndex
//                    fs: app.fs*0.5
//                    anchors.verticalCenter: parent.verticalCenter
//                }
                ZoolButton{
                    id: btnLoad
                    text:'Cargar'
                    //height: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked:{
                        //setListLunar(parseInt(tiAnio.text), true)
                        //log.lv('c:'+JSON.stringify(lm.get(lv.currentIndex).json, null, 2))
                        loadToZm(lm.get(lv.currentIndex).json, lm.get(lv.currentIndex).ste)
                    }
                }
            }
            //}
            ListView{
                id: lv
                spacing: app.fs*0.1
                width: r.width
                height: r.height-xTit.height-xCtrls.height//-xRetSolar.height
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: compItemList
                model: lm
                //cacheBuffer: 150
                //displayMarginBeginning: cacheBuffer*app.fs*3
                clip: true
                Rectangle{
                    id: xLoading
                    anchors.fill: parent
                    color: 'red'//apps.backgroundColor
                    opacity: 0.5
                    visible: false
                    ZoolText{
                        text:'<b>Cargando...</b>'
                        color: apps.backgroundColor
                        font.pixelSize: app.fs*0.5
                        anchors.centerIn: parent
                    }
                }

            }
        }
    }
    ListModel{
        id: lm
        function addItem(vJson, vSTE){
            return {
                json: vJson,
                ste: vSTE
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: item
            width: lv.width-r.border.width*2
            height: txtData.contentHeight+app.fs
            color: apps.backgroundColor
            border.width: !selected?1:3
            border.color: apps.fontColor
            property bool selected: lv.currentIndex===index
            Rectangle{
                anchors.fill: parent
                color: parent.border.color
                opacity: 0.2
                visible: parent.selected
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    loadToZm(json, ste)
                }
            }
            Row{
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Item{
                    id: xLuna
                    width: app.fs
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    property int t: 0
                    Rectangle{
                        color: xLuna.t===0?'black':'white'
                        width: parent.width
                        height: width
                        radius: width*0.5
                        border.width: xLuna.t===0?1:0
                        border.color: 'white'
                        anchors.centerIn: parent
                        Rectangle{
                            color: 'black'
                            width: parent.width*1.2
                            height: width
                            radius: width*0.5
                            anchors.verticalCenter: parent.verticalCenter
                            x: 0-width+parent.width*0.5
                            visible: xLuna.t===1
                        }
                        Rectangle{
                            color: 'black'
                            width: parent.width*1.2
                            height: width
                            radius: width*0.5
                            anchors.verticalCenter: parent.verticalCenter
                            x: parent.width*0.5
                            visible: xLuna.t===3
                        }
                    }
                }
                Text{
                    id: txtData
                    text: 'Dato index: '+index
                    font.pixelSize: app.fs*0.65
                    color: apps.fontColor
                    width: parent.parent.width-xLuna.width-app.fs-app.fs*0.25
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Component.onCompleted: {
                //log.lv('json: '+JSON.stringify(json, null, 2))
                let sd=''
                let d=json.d
                let m=json.m
                let a=json.a
                let mste=ste.split('|')
                let te=mste[0]
                let matTe=mste[1].split('-')
                let hte=matTe[0]
                let minte=matTe[1]
                let sTimeEclipse=''

                let matDege=mste[2].split('-')
                let degDege=matDege[0]
                let minDege=matDege[1]

                if(json.isEvent===0){
                    xLuna.t=0
                    sd+=te===''?'<b>Luna Nueva</b><br>':(te==='lunar'?'<b>Eclipse Lunar</b><br>':'<b>Eclipse Solar</b><br>')
                }
                if(json.isEvent===1){
                    xLuna.t=1
                    sd+='<b>Luna Creciente</b><br>'
                }
                if(json.isEvent===2){
                    xLuna.t=2
                    sd+=te===''?'<b>Luna Llena</b><br>':(te==='lunar'?'<b>Eclipse Lunar</b><br>':'<b>Eclipse Solar</b><br>')
                }
                if(json.isEvent===3){
                    xLuna.t=3
                    sd+='<b>Luna Menguante</b><br>'
                }
                if(te!=='')sTimeEclipse=''+hte+':'+minte+'hs '
                sd+='<b>Fecha</b>: '+d+'/'+m+'/'+a+' '+sTimeEclipse
                if(te!==''){
                    let indexSign=zm.getIndexSign(parseInt(degDege))
                    let rsdeg=parseInt(degDege)-(30*indexSign)
                    sd+='<br><b>Signo:</b> '+zm.aSigns[indexSign]
                    sd+=' °'+rsdeg+' \''+minDege
                }
                txtData.text=sd
            }
        }
    }



    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Lista Lunar')
        let d = new Date(Date.now())
        r.uAnio=d.getFullYear()
        tiAnio.text=r.uAnio
    }
    function setListLunar(anio, onlyEclipses){
        if(parseInt(r.uAnio)===parseInt(anio) && JSON.stringify(r.uJson)!=='{}'){
            //log.lv('Cargando r.uJson de '+r.uAnio+'.')
            procesarDatos(r.uJson, onlyEclipses)
            return
        }
        //log.lv('Creando nuevo json de '+anio+'.')
        let finalCmd=''
        finalCmd+=''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/getMoonsV2.py" '+anio+' '+unik.getPath(5)
        //console.log('finalCmd: '+finalCmd)
        let c=''
        //+'  if(logData.length<=3||logData==="")return\n'
            +'  let j\n'
            +'  try {\n'
            +'      j=JSON.parse(logData)\n'
            +'      procesarDatos(j, '+onlyEclipses+')\n'
        //+'  logData=""\n'
            +'  } catch(e) {\n'
            +'      console.log(e+" "+logData);\n'
            +'  }\n'
        r.uAnio=parseInt(anio)
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
        //c+='import "../../js/Funcs.js" as JS\n'
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
    function procesarDatos(j, onlyEclipses){
        //log.lv('json: '+JSON.stringify(j, null, 2))
        //return
        //log.lv('onlyEclipses: '+onlyEclipses)
        r.uJson=j
        lm.clear()
        let eclipses=j.eclipses
        for(var i=0;i<12;i++){
            let mes=j.meses[i]
            //log.lv('mes '+i+': '+JSON.stringify(mes, null, 2))
            for(var i2=0;i2<Object.keys(mes.ciclos).length;i2++){
                let ciclo=mes.ciclos[i2]
                //log.lv('ciclo '+i2+': '+JSON.stringify(ciclo, null, 2))
                if(ciclo.isEvent>=0){
                    let te=''
                    let he=''
                    let dege=''
                    for(var i3=0;i3<Object.keys(eclipses).length;i3++){
                        let ds=eclipses['solar'][i3].d
                        let ms=eclipses['solar'][i3].m
                        let as=eclipses['solar'][i3].a
                        if(ds===ciclo.d && ms===ciclo.m && as===ciclo.a){
                            te='solar'
                            he=''+eclipses['solar'][i3].h+'-'+eclipses['solar'][i3].min
                            dege=''+ciclo.gs+'-'+ciclo.ms
                            break
                        }
                    }
                    for(i3=0;i3<Object.keys(eclipses).length;i3++){
                        let ds=eclipses['lunar'][i3].d
                        let ms=eclipses['lunar'][i3].m
                        let as=eclipses['lunar'][i3].a
                        if(ds===ciclo.d && ms===ciclo.m && as===ciclo.a){
                            te='lunar'
                            he=''+eclipses['lunar'][i3].h+'-'+eclipses['lunar'][i3].min
                            dege=''+ciclo.gl+'-'+ciclo.ml
                            break
                        }
                    }
                    if(onlyEclipses){
                        if(te!=='')lm.append(lm.addItem(ciclo, te+'|'+he+'|'+dege))
                    }else{
                        lm.append(lm.addItem(ciclo, te+'|'+he+'|'+dege))
                    }

                }
            }
        }
        //log.lv('eclipses: '+JSON.stringify(j.eclipses, null, 2))

        return
        let aData=[]
        let aDataTipos=[]
        let t=Object.keys(j)[0]
        let uTipo=''
        if(t==='ciclos'){
            for(var i=0;Object.keys(j).length;i++){
                let tipo=j[t][i].t
                let d=j[t][i].d
                let m=j[t][i].m
                let a=j[t][i].a
                let s=d+'-'+m+'-'+a
                if(aData.indexOf(s)<0){

                    aData.push(s)
                    if(uTipo!==tipo)lm.append(lm.addItem(j[t][i]))
                    uTipo=tipo
                    //                    if(i>0 && aDataTipos[i - 1].indexOf(tipo)<0){
                    //                        lm.append(lm.addItem(j[t][i]))
                    //                    }else if(a===parseInt(tiAnio.text)){

                    //                    }
                    //                    aDataTipos.push(tipo)
                }
            }
        }


    }
    function loadToZm(json, ste){
        let j=zfdm.getJsonAbs()
        //j.params=zfdm.getJsonAbs().params
        j.params.d=json.d
        j.params.m=json.m
        j.params.a=json.a
        if(ste!==''){
            let mste=ste.split('|')
            let te=mste[0]
            let matTe=mste[1].split('-')
            let hte=matTe[0]
            let minte=matTe[1]
            j.params.h=parseInt(hte)
            j.params.min=parseInt(minte)
            j.params.gmt=0
        }
        j.params.t='trans'
        zm.loadBack(j)
        let t=j.params.t
        let hsys=j.params.hsys
        let nom=j.params.n
        let d=j.params.d
        let m=j.params.m
        let a=j.params.a
        let h=j.params.h
        let min=j.params.min
        let gmt=j.params.gmt
        let lat=j.params.lat
        let lon=j.params.lon
        let alt=j.params.alt
        let ciudad=j.params.c

        let ms=j.params.ms
        let aL=zoolDataView.atLeft
        let aR=[]
        let strSep='?'
        strSep='Evento Lunar'
        let mste=ste.split('|')
        let te=mste[0]
        if(json.isEvent===0){
            strSep=te===''?'Luna Nueva':(te==='lunar'?'Eclipse Lunar':'Eclipse Solar')
        }
        if(json.isEvent===1){
            strSep='Luna Creciente'
        }
        if(json.isEvent===2){
            strSep=te===''?'Luna Llena':(te==='lunar'?'Eclipse Lunar':'Eclipse Solar')
        }
        if(json.isEvent===3){
            strSep='Luna Menguante'
        }

        //aR.push('<b>'+nom+'</b>')
        aR.push(''+d+'/'+m+'/'+a)
        aR.push(''+h+':'+min+'hs')
        aR.push('<b>GMT:</b> '+gmt)
        aR.push('<b>Ubicación:</b> '+ciudad)
        aR.push('<b>Lat:</b> '+parseFloat(lat).toFixed(2))
        aR.push('<b>Lon:</b> '+parseFloat(lon).toFixed(2))
        aR.push('<b>Alt:</b> '+alt)

        zoolDataView.setDataView(strSep, aL, aR)
    }
    function enter(){
        //log.lv('Ejecutando List Lunar: '+tiAnio.text)
        setListLunar(tiAnio.text, showAll.checked)
        //if(apps.dev)log.lv('ZoolRevolutionList.enter()... lv.currentIndex: '+lv.currentIndex)
        /*if(lv.currentIndex<=0 && lv.count<1){
            //log.lv('0 ZoolRevolutionList enter()...')
            xBottomBar.objPanelCmd.runCmd('rsl '+tiAnio.text)
            return
        }else{
            //log.lv('1 ZoolRevolutionList enter()...')
            r.prepareLoad()
        }*/
    }
    function insert(){
        tiAnio.focus=true
    }
    function up(){
        if(lv.currentIndex>0)lv.currentIndex--
    }
    function down(){
        if(lv.currentIndex<lv.count)lv.currentIndex++
    }
    function desactivar(){
        tiAnio.focus=false
    }
}
