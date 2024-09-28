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
                if(apps.dev)log.lv('itemRs.loadRs()... gmt: '+gmt+' lat:'+lat+' lon: '+lon+' alt: '+alt)
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



    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Lista Lunar')
    }
    function setListLunar(anio){
        lm.clear()
        let finalCmd=''
        finalCmd+=''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/getMoonsAtYear.py" '+anio+' ciclos'
        console.log('finalCmd: '+finalCmd)
        let c=''
            +'  if(logData.length<=3||logData==="")return\n'
            +'  let j\n'
            +'try {\n'
            +'  j=JSON.parse(logData)\n'
            +'  procesarDatos(j)\n'
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
        let a=[]
        let t=Object.keys(j)[0]
        if(t==='ciclos'){
            for(var i=0;Object.keys(j).length;i++){
                let tipo=j[t][i].t
                let d=j[t][i].d
                let m=j[t][i].m
                let a=j[t][i].a
                let s=d+'-'+m+'-'+a
                if(a.indexOf(s)<0){
                    log.lv('tipo: '+tipo+' s: '+s)
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
        log.lv('Ejecutando List Lunar: '+tiEdad.text)
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
