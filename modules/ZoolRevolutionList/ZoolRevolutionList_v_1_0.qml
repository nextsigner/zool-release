import QtQuick 2.7
import QtQuick.Controls 2.0
import "../../js/Funcs.js" as JS
import "../../comps" as Comps

import ZoolText 1.0

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
    property int svIndex: sv.currentIndex
    property int itemIndex: -1
    visible: itemIndex===sv.currentIndex
    onSvIndexChanged: {
        if(svIndex===itemIndex){
            if(edadMaxima<=0)xTit.showTi=true
            tF.restart()
        }else{
            tF.stop()
            tiEdad.focus=false
        }
    }
    Timer{
        id: tF
        running: svIndex===itemIndex
        repeat: false
        interval: 1500
        onTriggered: {
            tiEdad.focus=true
        }
    }
    Behavior on x{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Behavior on height{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id:xTit
            width: lv.width
            height: app.fs*1.5
            color: apps.fontColor
            border.width: 2
            border.color: txtLabelTit.focus?'red':'white'
            anchors.horizontalCenter: parent.horizontalCenter
            property bool showTit: true
            property bool showTi: false
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
                    tShowXTit.start()
                }
                onExited: {
                    xTit.showTit=false
                    tShowXTit.start()
                }
                onClicked: xTit.showTi=true
            }
            Rectangle{
                color: parent.color
                anchors.fill: parent
                border.width: xTit.border.width
                border.color: xTit.border.color
                visible: xTit.showTi
                Row{
                    anchors.centerIn: parent
                    spacing: app.fs*0.5
                    Text{id: label; text:'<b>Edad:</b>';anchors.verticalCenter: parent.verticalCenter;color: apps.backgroundColor;font.pixelSize: app.fs*0.5}
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
                                xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
                                xTit.showTi=false
                            }
                        }
                    }
                    Comps.ButtonIcon{
                        text: '<b>B</b>'
                        width: app.fs
                        height: width
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            r.enter()
                        }
                    }
                }
            }
            ZoolText{
                id: txtLabelTit
                text: parent.showTit?'Revoluciones Solares hasta los '+r.edadMaxima+' años':'Click para cargar'
                font.pixelSize: app.fs*0.5
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                color: apps.backgroundColor
                //focus: true
                anchors.centerIn: parent
                visible: !xTit.showTi
            }
            Timer{
                id: tShowXTit
                running: false
                repeat: false
                interval: 3000
                onTriggered: parent.showTit=true
            }
        }
        ListView{
            id: lv
            width: r.width
            height: r.height-xTit.height
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
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            property int is: -1
            property var rsDate
            onIsChanged:{
                iconoSigno.source="./resources/imgs/signos/"+is+".svg"
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
                onClicked: {
                    lv.currentIndex=index
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
                                font.pixelSize: index!==lv.currentIndex?app.fs*0.35:app.fs*0.6
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
                            width: itemRS.width*0.2
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
                        Comps.ButtonIcon{
                            text: '<b>I</b>'
                            width: app.fs
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: index===lv.currentIndex
                            onClicked: {
                                JS.loadRs(itemRS.rsDate)
                                //xBottomBar.objPanelCmd.makeRSBack(itemRS.rsDate)
//                                let date=new Date(itemRS.rsDate)
//                                let d=date.getDate()
//                                let m=date.getMonth()// + 1
//                                let a=date.getFullYear()
//                                let h=date.getHours()
//                                let min=date.getMinutes()
//                                let gmt=app.currentGmt
//                                let lat=app.currentLat
//                                let lon=app.currentLon
//                                let nom=app.currentNom
//                                let ciudad=app.currentLugar
//                                let tipo='rs'//app.currentJson.params.tipo
//                                let alt=app.currentJson.params.alt?app.currentJson.params.alt:0
//                                JS.loadFromArgs(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, false)
                            }
                        }
                        Comps.ButtonIcon{
                            text: '<b>E</b>'
                            width: app.fs
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: false//index===lv.currentIndex
                            onClicked: {
                                let date=new Date(itemRS.rsDate)
                                let d=date.getDate()
                                let m=date.getMonth()// + 1
                                let a=date.getFullYear()
                                let h=date.getHours()
                                let min=date.getMinutes()
                                let gmt=app.currentGmt
                                let lat=app.currentLat
                                let lon=app.currentLon
                                let nom=app.currentNom
                                let ciudad=app.currentLugar
                                let tipo='rs'//app.currentJson.params.tipo
                                let alt=app.currentJson.params.alt?app.currentJson.params.alt:0
                            JS.loadFromArgsBack(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, false)
                            }
                        }
                    }
                }
            }
            Component.onCompleted: {
                //console.log('jjj:'+json)
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
            }
        }
    }
    Item{id: xuqp}
    function setRsList(edad){
        r.jsonFull=''
        r.edadMaxima=edad-1
        lm.clear()
        let cd3= new Date(app.currentDate)
        //let hsys=apps.currentHsys
        let finalCmd=''
            +app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol_time.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+edad+' "'+unik.currentFolderPath()+'"'//+' '+hsys
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
        c+='import "./js/Funcs.js" as JS\n'
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
    function loadJson(json){
        lm.clear()
        for(var i=0;i<Object.keys(json).length;i++){
            let j=json['rs'+i]
            lm.append(lm.addItem(JSON.stringify(j)))
        }
    }
    function enter(){
        //Qt.quit()
        if(xTit.showTi){
            xBottomBar.objPanelCmd.runCmd('rsl '+tiEdad.text)
            xTit.showTi=false
            return
        }
        if(lv.count>=1){
            xBottomBar.objPanelCmd.makeRSBack(lv.itemAtIndex(lv.currentIndex).rsDate)
        }
    }
    function desactivar(){
        tiEdad.focus=false
    }
}
