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
        if(visible){
            if(lv.count===0&&tiEdad.text===''){
                let d=new Date(Date.now())
                tiEdad.text=d.getFullYear()
                setListLunar(d.getFullYear())
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
                spacing: app.fs*0.1
                width: r.width
                height: r.height-xTit.height-xCtrls.height//-xRetSolar.height
                anchors.horizontalCenter: parent.horizontalCenter
                delegate: compItemList
                model: lm
                //cacheBuffer: 150
                //displayMarginBeginning: cacheBuffer*app.fs*3
                clip: true
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
            id: item
            width: lv.width-r.border.width*2
            height: txtData.contentHeight+app.fs
            color: apps.backgroundColor
            border.width: !selected?1:3
            border.color: apps.fontColor
            property bool selected: lv.currentIndex===index
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    let j=zfdm.getJsonAbs()
                    //j.params=zfdm.getJsonAbs().params
                    j.params.d=json.d
                    j.params.m=json.m
                    j.params.a=json.a
                    j.params.h=json.h
                    j.params.min=json.min
                    j.params.t='trans'
                    //let json2={}
                    //json2.params=j.params
                    //zm.ev=true
                    //log.lv('j:'+JSON.stringify(j, null, 2))
                    zm.loadBack(j)
                    //return
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
                    let strEdad='Edad: '+zm.getEdad(d, m, a, h, min)+' años'
                    if(t==='rs'){
                        let currentAnio=new Date(app.currentDate).getFullYear()
                        strEdad='Edad: '+parseInt(a - currentAnio)+' años'
                        //strEdad='Edad: '+Math.abs(parseInt(currentAnio - a))+' años'
                    }
                    let ms=j.params.ms
                    let aL=zoolDataView.atLeft
                    let aR=[]
                    let strSep='?'
                    if(t==='sin'){
                        strSep='Sinastría'
                    }else if(t==='trans'){
                        strSep='Tránsitos'
                    }else{
                        strSep='Indefinido!'
                    }
                    //zoolDataView.stringMiddleSeparator=t

                    //aR.push('<b>'+nom+'</b>')
                    aR.push(''+d+'/'+m+'/'+a)
                    //aR.push(stringEdad)
                    aR.push(''+h+':'+min+'hs')
                    aR.push('<b>GMT:</b> '+gmt)
                    aR.push('<b>Ubicación:</b> '+ciudad)
                    aR.push('<b>Lat:</b> '+parseFloat(lat).toFixed(2))
                    aR.push('<b>Lon:</b> '+parseFloat(lon).toFixed(2))
                    aR.push('<b>Alt:</b> '+alt)

                    zoolDataView.setDataView(strSep, aL, aR)
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
                if(json.isEvent===0){
                    xLuna.t=0
                    sd+='<b>Luna Nueva</b><br>'
                }
                if(json.isEvent===1){
                    xLuna.t=1
                    sd+='<b>Luna Creciente</b><br>'
                }
                if(json.isEvent===2){
                    xLuna.t=2
                    sd+='<b>Luna Llena</b><br>'
                }
                if(json.isEvent===3){
                    xLuna.t=3
                    sd+='<b>Luna Menguante</b><br>'
                }
                sd+='<b>Fecha</b>: '+d+'/'+m+'/'+a+' '
                txtData.text=sd
            }
        }
    }



    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Lista Lunar')
    }
    function setListLunar(anio){
        lm.clear()
        let finalCmd=''
        finalCmd+=''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/getMoons.py" '+anio+' ciclos'
        console.log('finalCmd: '+finalCmd)
        let c=''
        //+'  if(logData.length<=3||logData==="")return\n'
            +'  let j\n'
            +'  try {\n'
            +'      j=JSON.parse(logData)\n'
            +'      procesarDatos(j)\n'
        //+'  logData=""\n'
            +'  } catch(e) {\n'
            +'      console.log(e+" "+logData);\n'
            +'  }\n'
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
    function procesarDatos(j){
        //log.lv('json: '+JSON.stringify(j, null, 2))
        for(var i=0;i<12;i++){
            let mes=j.meses[i]
            //log.lv('mes '+i+': '+JSON.stringify(mes, null, 2))
            for(var i2=0;i2<Object.keys(mes.ciclos).length;i2++){
                let ciclo=mes.ciclos[i2]
                //log.lv('ciclo '+i2+': '+JSON.stringify(ciclo, null, 2))
                if(ciclo.isEvent>=0){
                    //log.lv('ciclo '+i2+': '+JSON.stringify(ciclo, null, 2))
                    lm.append(lm.addItem(ciclo))
                }
            }
        }

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
                    //                    }else if(a===parseInt(tiEdad.text)){

                    //                    }
                    //                    aDataTipos.push(tipo)
                }
            }
        }

    }
    function prepareLoad(){
        //tiEdad.focus=false
        if(!checkBoxRetSolar){
            r.ulat=zm.currentLat
            r.ulon=zm.currentLon
            if(apps.dev){
                log.lv('r.ulat: '+r.ulat)
                log.lv('r.ulon: '+r.ulon)
            }
            //lv.itemAtIndex(lv.currentIndex).loadRs(0, app.currentLat, app.currentLon, app.currentAlt)
            lv.itemAtIndex(lv.currentIndex).loadRs(0, zm.currentLat, zm.currentLon, zm.currentAlt)
        }else{
            r.ulat=zm.currentLat
            r.ulon=zm.currentLon
            if(apps.dev){
                log.lv('r.ulat: '+r.ulat)
                log.lv('r.ulon: '+r.ulon)
            }
            lv.itemAtIndex(lv.currentIndex).loadRs(0, zm.currentLat, zm.currentLon, zm.currentAlt)
            //lv.itemAtIndex(lv.currentIndex).loadRs(app.currentGmt, app.currentLat, app.currentLon, app.currentAlt)
        }
    }
    function enter(){
        //log.lv('Ejecutando List Lunar: '+tiEdad.text)
        setListLunar(tiEdad.text)
        //if(apps.dev)log.lv('ZoolRevolutionList.enter()... lv.currentIndex: '+lv.currentIndex)
        /*if(lv.currentIndex<=0 && lv.count<1){
            //log.lv('0 ZoolRevolutionList enter()...')
            xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
            return
        }else{
            //log.lv('1 ZoolRevolutionList enter()...')
            r.prepareLoad()
        }*/
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
}
