import QtQuick 2.12
import QtQuick.Controls 2.12
import "Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property alias currentIndex: lv.currentIndex
    property alias listModel: lm

    property int currentIndexSearching: 0
    property int currentAnioSearching: 0
    property int  uAnioSearch: -1

    property var aAspNames: ['Oposición', 'Conjunción', 'Trígono', 'Cuadratura', 'Sextil']
    property var aAspNamesRes: ['Opp','Con', 'Tri', 'Squ', 'Sex']
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            setSpinBoxs()
            //            sbDesde.from =app.currentDate.getFullYear()
//            sbDesde.to =sbDesde.from + 150 - 1
//            sbDesde.value = app.currentDate.getFullYear()
//            sbHasta.from=0//sbDesde.from
//            sbHasta.to= sbDesde.from + 150//apps.currentAspCantAniosSearch
//            sbHasta.value = apps.currentAspCantAniosSearch
//            //log.l('apps.currentAspCantAniosSearch:'+apps.currentAspCantAniosSearch)
//            //log.visible=true
//            loadItemsYears()
        }
    }
    Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Column{
        spacing: app.fs*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: colCbs
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Item{width: 1; height: app.fs*0.5}
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ComboBox{
                    id: cbP1
                    model: app.planetasAS
                    width: r.width*0.5-app.fs*0.5
                    font.pixelSize: app.fs*0.5
                    currentIndex: apps.currentIndexP1
                    onCurrentIndexChanged: {
                        apps.currentIndexP1=currentIndex
                        lv.currentIndex=0
                        loadItemsYears()
                    }
                }
                ComboBox{
                    id: cbP2
                    model: app.planetasAS
                    width: r.width*0.5-app.fs*0.5
                    font.pixelSize: app.fs*0.5
                    currentIndex: apps.currentIndexP2
                    onCurrentIndexChanged: {
                        apps.currentIndexP2=currentIndex
                        lv.currentIndex=0
                        loadItemsYears()
                    }
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                ComboBox{
                    id: cbAsp
                    model: r.aAspNames
                    width: r.width-botSearchAsp.width-app.fs
                    font.pixelSize: app.fs*0.5
                    currentIndex: apps.currentIndexAsp
                    onCurrentIndexChanged: {
                        apps.currentIndexAsp=currentIndex
                        lv.currentIndex=0
                        loadItemsYears()
                    }
                }

            }
            Column{
                spacing: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Desde: '
                    color: apps.fontColor
                    font.pixelSize: app.fs*0.5
                }
                SpinBox{
                    id: sbDesde
                    font.pixelSize: app.fs*0.5
                    //from: 2000
                    //value: 2.000//r.uAnioSearch>0?r.uAnioSearch:2020
                }
            }
            Column{
                spacing: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    text: 'Buscar durante'
                    color: apps.fontColor
                    font.pixelSize: app.fs*0.5
                    textFormat: Text.RichText
                }
                Row{
                    spacing: app.fs*0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    SpinBox{
                        id: sbHasta
                        font.pixelSize: app.fs*0.5
                        onValueChanged: {
                            apps.currentAspCantAniosSearch=value
                        }
                    }
                    Text{
                        text: 'años.'
                        color: apps.fontColor
                        font.pixelSize: app.fs*0.5
                        textFormat: Text.RichText
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Button{
                    id: botSearchAsp
                    text: 'Buscar'
                    font.pixelSize: app.fs*0.5
                    visible: cbP1.currentIndex!==cbP2.currentIndex
                    onClicked: {
                        r.currentIndexSearching=0
                        r.currentAnioSearching=parseInt((''+sbDesde.value).replace('.', ''))
                        r.uAnioSearch=parseInt((''+sbDesde.value).replace('.', ''))
                        //                        for(var i=0;i<lm.count;i++){
                        //                            let item=lv.itemAtIndex(i)
                        //                            item.json=JSON.parse('{}')
                        //                        }
                        loadItemsYears()
                        search()
                    }
                }
            }
            Text{
                text: 'Buscando '+r.currentAnioSearching
                color: apps.fontColor
                font.pixelSize: app.fs*0.5
                textFormat: Text.RichText
                //anchors.verticalCenter: parent.verticalCenter
            }
            //Text{text: 'Años: '+lv.count; color: apps.fontColor; font.pixelSize: app.fs*0.5;}
        }
        ListView{
            id: lv
            width: r.width
            height: r.height-colCbs.height-app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            cacheBuffer: 150
            displayMarginBeginning: cacheBuffer*app.fs*3
            clip: true
            Behavior on contentY{NumberAnimation{duration: app.msDesDuration}}
            onCurrentIndexChanged: {
                //contentY=lv.itemAtIndex(currentIndex).y+lv.itemAtIndex(currentIndex).height-r.height*0.5
            }
        }
    }
    ListModel{
        id: lm
        function addItem(a){
            return {
                anio: a
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: item
            width: lv.width-r.border.width*2
            height: visible?(lvAspDates.count<=0?app.fs*1.5:colAspDates.height+app.fs*0.25):0
            color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            property var json
            property int cantAsps: 0
            //visible: false
            visible: opacity===1.0
            opacity: 0.5
            anchors.horizontalCenter: parent?parent.horizontalCenter:undefined
            onJsonChanged:{
                if(json && Object.keys(item.json).length-1 >0){
                    //                    if(json === {}){
                    //                        opacity=0.5
                    //                        return
                    //                    }
                    item.cantAsps=Object.keys(item.json).length-1
                    lv.currentIndex=index
                    opacity=1.0
                }
                //                log.l(JSON.stringify(json))
                //                log.visible=true
                //                log.width=xApp.width*0.2
                //                log.ww=false
            }
            Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            Behavior on opacity{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(lv.currentIndex===index){
                        lv.currentIndex=-1
                    }else{
                        lv.currentIndex=index
                    }
                    r.currentAnioSearching=parseInt(anio)
                    lmAspDates.clear()
                    //log.l('d---->'+JSON.stringify(item.json))
                    //log.l('d---->'+Object.keys(item.json).length)
                    //log.l('d2---->'+JSON.stringify(item.json['item0']))
                    //log.visible=true
                    //log.ww=false
                    //log.width=xApp.width*0.2
                    for(var i=0; i<Object.keys(item.json).length-1;i++){
                        const ia =item.json['item'+i]
                        if(ia){
                            //log.l('d2 '+i+'---->'+ia.d)
                            lmAspDates.append(lmAspDates.addItem(ia.d, ia.m, anio, ia.h, ia.min))
                        }
                    }
                }
            }
            Column{
                id: colAspDates
                anchors.centerIn: parent
                Row{
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: colInfo1.height
                    spacing: app.fs*0.5
                    Column{
                        id: colInfo1
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            id: txtData
                            text: '<b>'+parseInt(anio - 1)+'</b> '//+lmAspDates.count
                            font.pixelSize: app.fs*0.5
                            width: contentWidth.width//+app.fs
                            wrapMode: Text.WordWrap
                            //textFormat: Text.RichText
                            horizontalAlignment: Text.AlignHCenter
                            color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
                        }
                        Text {
                            text: 'Edad: '+parseInt(anio - 1 - r.uAnioSearch)
                            font.pixelSize: app.fs*0.35
                            width: contentWidth.width//+app.fs
                            horizontalAlignment: Text.AlignHCenter
                            color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
                        }
                    }

                    Rectangle{
                        width: item.border.width
                        height: parent.height
                        color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
                    }
                    Text {
                        //text: 'Hay un total de <b>'+item.cantAsps+'</b><br />aspectos detectados.'
                        text: item.cantAsps===1?'<b>'+item.cantAsps+'</b> aspecto detectado.':'<b>'+item.cantAsps+'</b> aspectos detectados.'
                        font.pixelSize: app.fs*0.5
                        width: contentWidth//item.width-txtData.width
                        wrapMode: Text.WordWrap
                        //textFormat: Text.RichText
                        horizontalAlignment: Text.AlignHCenter
                        color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
                        visible: item.cantAsps>0
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ListView{
                    id: lvAspDates
                    width: item.width
                    height: app.fs*count-1//+app.fs//+app.fs*0.1*count
                    model: lmAspDates
                    delegate: compAspDate
                    //anchors.top: txtData.bottom
                    //spacing: app.fs*0.1
                    clip: true
                    boundsBehavior: ListView.StopAtBounds
                    //opacity: 0.5
                    visible: item.cantAsps>0
                    ListModel{
                        id: lmAspDates
                        function addItem(d, m, a, h, min){
                            return {
                                vdia: d,
                                vmes: m,
                                vanio: a,
                                vhora: h,
                                vminuto: min
                            }
                        }
                    }
                    Component{
                        id: compAspDate
                        Rectangle{
                            width: lv.width-item.border.width*2
                            height: botCargar.height+app.fs*0.2
                            border.width: 1
                            border.color: lvAspDates.currentIndex===index?apps.backgroundColor:apps.fontColor
                            color: lvAspDates.currentIndex===index?apps.fontColor:apps.backgroundColor
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    lvAspDates.currentIndex=index
                                }
                            }
                            Row{
                                anchors.centerIn: parent
                                spacing: app.fs*0.5
                                Text{
                                    //text:  vdia+'/'+vmes+'/'+parseInt(vanio - 1)+' '+vhora+':'+vminuto
                                    text:  vdia+'/'+vmes+' '+vhora+':'+vminuto
                                    font.pixelSize: app.fs*0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: lvAspDates.currentIndex===index?apps.backgroundColor:apps.fontColor
                                }
                                Button{
                                    id: botCargar
                                    text: 'Cargar'
                                    width: app.fs*2
                                    height: app.fs
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: lvAspDates.currentIndex===index
                                    onClicked: {
                                        let d1 = new Date(parseInt(vanio - 1) , vmes - 1, vdia, vhora, vminuto)
                                        JS.loadFromArgs(d1.getDate(), parseInt(d1.getMonth() +1),d1.getFullYear(), d1.getHours(), d1.getMinutes(),app.currentGmt, app.currentLat,app.currentLon, 0, "Aspectos "+d1.getDate()+"-"+parseInt(d1.getMonth() +1)+"-"+d1.getFullYear(), ''+app.currentLugar, "trans", true)
                                    }
                                }
                                Button{
                                    id: botCargarBack
                                    text: 'Cargar Ext'
                                    width: app.fs*3
                                    height: app.fs
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: lvAspDates.currentIndex===index
                                    onClicked: {
                                        let d1 = new Date(parseInt(vanio - 1) , vmes - 1, vdia, vhora, vminuto)
                                        JS.loadFromArgsBack(d1.getDate(), parseInt(d1.getMonth() +1),d1.getFullYear(), d1.getHours(), d1.getMinutes(),app.currentGmt, app.currentLat,app.currentLon, 0, "Aspectos "+d1.getDate()+"-"+parseInt(d1.getMonth() +1)+"-"+d1.getFullYear(), ''+app.currentLugar, "trans", true)
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
    }
    Item{id: xuqp}
    Timer{
        id: tSetSpinBoxs
        running: sbDesde.value<0
        repeat: true
        interval: 500
        onTriggered: setSpinBoxs()
    }
    function setSpinBoxs(){
        sbDesde.from =app.currentDate.getFullYear()
        sbDesde.to =sbDesde.from + 150 - 1
        sbDesde.value = app.currentDate.getFullYear()
        sbHasta.from=0//sbDesde.from
        sbHasta.to= sbDesde.from + 150//apps.currentAspCantAniosSearch
        sbHasta.value = apps.currentAspCantAniosSearch
        loadItemsYears()
    }
    function loadItemsYears(){
        lm.clear()
        let ai=parseInt((''+sbDesde.value).replace('.', ''))
        for(var i=0; i < apps.currentAspCantAniosSearch; i++){
            lm.append(lm.addItem(ai + 1))
            ai++
        }
    }
    function search(){
        loadAspsYears(r.currentAnioSearching)
    }
    function loadAspsYears(y){
        let cd3= new Date(app.currentDate)
        //Ejemplo
        //python3 ./astrologica_trans.py 20 6 1975 23 04 -3 -35.47857 -69.61535 Pluto Moon Squ 1985 '/home/ns/Descargas/ast73src/astrolog'
        const str1 = app.planetasResAS[apps.currentIndexP1]
        const p1= str1.charAt(0).toUpperCase() + str1.slice(1);
        const str2 = app.planetasResAS[apps.currentIndexP2]
        const p2= str2.charAt(0).toUpperCase() + str2.slice(1);
        let astrologPath=''

        if(Qt.platform.os==='windows'){
            let ml0=app.mainLocation.replace(/\"/g, '')
            var m0=ml0.split('/')
            var np=''
            for(var i=0;i<m0.length;i++){
                np+=m0[i]+'\\\\'
            }

            var nppyl=ml0+'/Python/python.exe'
            np+='ast72cli\\\\astrolog.exe'
            //            log.l('np:'+np)
            //            log.visible=true
            //            log.width=xApp.width*0.2
            var m1=nppyl.split('/')
            var nppython=""
            for(i=0;i<m1.length;i++){
                if(i!==0){
                    nppython+='\\\\'+m1[i]
                }else{
                    nppython+=m1[i]
                }

            }
            nppython="\""+nppython+"\""
            //log.l('nppython:'+nppython)
            astrologPath=np//(""+app.mainLocation+"").replace('/\//g', '\\\\')+'\\\\ast72cli\\\\astrolog.exe'//.replace('\\', '\\\\')//.replace('/', '\\\\')
        }
        if(Qt.platform.os==='linux'){
            let ml0=app.mainLocation.replace(/\"/g, '')

            nppython='python3'

            //log.l('nppython:'+nppython)
            //astrologPath=app.mainLocation+"").replace('/\//g', '\\\\')+'\\\\ast72cli\\\\astrolog.exe'//.replace('\\', '\\\\')//.replace('/', '\\\\')
            astrologPath=app.mainLocation+'/astrolog/astrolog'
        }
        let finalCmd=''
        //+nppython+' '+app.mainLocation+'/py/astrologica_trans.py '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+y+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+p1+' '+p2+' '+r.aAspNamesRes[cbAsp.currentIndex]+' '+y+' "'+astrologPath+'"'
            +nppython+' '+app.mainLocation+'/py/astrologica_trans.py 1 1 '+y+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+p1+' '+p2+' '+r.aAspNamesRes[cbAsp.currentIndex]+' '+y+' "'+astrologPath+'" '+unik.currentFolderPath()
        console.log('cmd astrolog: '+finalCmd)
        //        log.l('cmd: '+finalCmd)
        //        log.visible=true
        //        log.width=xApp.width*0.8
        //        log.x=xApp.width*0.2
        let c=''
            +'  if(logData.length<=3||logData==="")return\n'
            +'  let j\n'
            +'try {\n'
            +'  j=JSON.parse(logData)\n'
        //+'  let item=lv.itemAtIndex(r.currentIndexSearching)\n'
            +'  let item=lv.contentItem.children[r.currentIndexSearching]\n'
            +'  item.json=j\n'
        //+'  log.l(JSON.stringify(j))\n'
        //+'  log.l(logData)\n'
        //+'  log.visible=true\n'
        //+'  log.width=xApp.width*0.5\n'
            +'  logData=""\n'
        //+'  r.currentIndexSearching++\n'
            +'  r.currentAnioSearching=parseInt(lm.get(r.currentIndexSearching).anio - 1)\n'
            +'      if(r.currentIndexSearching<lv.count){\n'
            +'          r.search()\n'
            +'      }\n'
            +'  r.currentIndexSearching++\n'
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
        c+='import "Funcs.js" as JS\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        '+code+'\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        run(\''+finalCmd+'\')\n'
        c+='    }\n'
        c+='}\n'
        //console.log(c)
        let comp=Qt.createQmlObject(c, item, 'uqpcodecmdrslist')
    }
    function clear(){
        lm.clear()
        r.state='hide'
    }
    function enter(){
        //Qt.quit()
        //        if(xTit.showTi){
        //            xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
        //            xTit.showTi=false
        //            return
        //        }
        //        if(lv.count>=1){
        //            xBottomBar.objPanelCmd.makeRSBack(lv.itemAtIndex(lv.currentIndex).rsDate)
        //        }
    }
}
