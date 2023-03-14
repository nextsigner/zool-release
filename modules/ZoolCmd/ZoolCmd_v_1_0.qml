import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import "../../comps" as Comps
import "../../js/Funcs.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: app.fs
    border.width: 2
    border.color: 'white'
    color: 'black'
    //y:r.parent.height
    property real lat
    property real lon

    property string uCmd: ''

    state: 'hide'
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                y:0//r.parent.height-r.height
                //z:1000
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                y:r.height
            }
        }
    ]
    Behavior on y{enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration}}
    onStateChanged: {
        if(state==='show')tiCmd.t.focus=true
        JS.raiseItem(r)
    }
    onXChanged: {
        if(x===0){
            //txtDataSearch.selectAll()
            //txtDataSearch.focus=true
        }
    }
    Comps.XTextInput{
        id: tiCmd
        width: r.width
        height: r.height
        t.font.pixelSize: app.fs*0.65
        //bw.width: 0
        //anchors.verticalCenter: parent.verticalCenter
        anchors.centerIn: parent
        onPressed: {
            addJsonCmds(text)
            runCmd(text)
        }
        property int cmdIndex: 0
        onDownPressed:{
            if(Object.keys(getJsonCmds().cmds).length===0)return
            tiCmd.text=getJsonCmd(tiCmd.cmdIndex)
            if(tiCmd.cmdIndex<Object.keys(getJsonCmd().cmds).length-1){
                tiCmd.cmdIndex++
            }else{
                tiCmd.cmdIndex=0
            }
        }
    }
    Item{id: xuqp}
    Component.onCompleted: app.cmd=r
    function runCmd(cmdarg){
        let cmd=(''+cmdarg)
        let help=''
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let finalCmd=''
        let c=''
        let comando=cmd.split(' ')
        if(comando.length<1)return

        let com=cmd.substring(0, 2)
        let codeCom=cmd.substring(2, cmd.length)
        //log.ls('com:::['+com+']', 0, 500)
        //log.ls('codeCom:::'+codeCom, 0, 500)
        if(com==='c '){
            runQml(codeCom)
        }
        if(parseInt(cmd.substring(0, 4))<=Object.keys(getJsonCmds().cmds).length){
            tiCmd.text=getJsonCmd(parseInt(cmd.substring(0, 4)))
        }

        if(comando[0]==='temp'||comando[0]==='temp-silent'){
            apps.isJsonsFolderTemp=!apps.isJsonsFolderTemp
            if(comando[0]==='temp'){
                log.visible=true
                if(apps.isJsonsFolderTemp){
                    log.l('Los archivos se guardarán en la carpeta temporal '+apps.jsonsFolder)
                }else{
                    log.l('Los archivos se guardarán en la carpeta '+apps.jsonsFolder)
                }
            }
            return
        }
        if(comando[0]==='logFileData'){
            log.visible=true
            log.l('Datos del archivo '+apps.url+':')
            let fd=unik.getFile(apps.url)
            log.l(fd)
            return
        }
        if(comando[0]==='logFileDataBack'){
            log.visible=true
            log.l('Datos del archivo '+apps.urlBack+':')
            let fd=unik.getFile(apps.urlBack)
            log.l(fd)
            return
        }
        if(comando[0]==='logJsonData'){
            log.visible=true
            log.l('app.currentData del archivo '+apps.url+':')
            log.l(JSON.stringify(JSON.parse(app.currentData), null, 2))
            return
        }
        if(comando[0]==='logJsonDataBack'){
            log.visible=true
            log.l('app.currentDataBack del archivo '+apps.url+':')
            log.l(JSON.stringify(JSON.parse(app.currentDataBack), null, 2))
            return
        }
        if(comando[0]==='setzmt'){
            if(comando.length<4){
                console.log('Error al setear el panelZonaMes: Faltan argumentos. setCurrentTime(q,m,y)')
                return
            }
            panelZonaMes.setCurrentTime(comando[1], comando[2], comando[3])
            return
        }

        if(comando[0]==='eclipse'){
            if(comando.length<5)return
            c='log.l(logData)
log.visible=true

let json=JSON.parse(logData)
r.state="hide"
sweg.objEclipseCircle.setEclipse(json.gdec, json.rsgdeg, json.gdeg, json.mdeg, json.is)
sweg.objEclipseCircle.typeEclipse='+comando[4]+''
            app.currentHouseIndex=-1
            app.currentHouseIndexBack=-1
            //sweg.objHousesCircle.currentHouse=-1

            finalCmd=''
                    +app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_eclipses.py" '+comando[1]+' '+comando[2]+' '+comando[3]+' '+comando[4]+' '+comando[5]+' "'+unik.currentFolderPath()+'"'
        }
        if(comando[0]==='rs'){
            if(comando.length<1)return
            let cd=app.currentDate
            cd = cd.setFullYear(parseInt(comando[1]))
            let cd2=new Date(cd)
            cd2 = cd2.setDate(cd2.getDate() - 1)
            let cd3=new Date(cd2)
            let hsys=apps.currentHsys
            finalCmd=''
                    +app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+hsys+' "'+unik.currentFolderPath()+'"'
            //console.log('finalCmd: '+finalCmd)
            c=''
            c+=''
                    +'  let s=""+logData\n'
                    +'  //console.log("RS: "+s)\n'
                    +'  r.state="hide"\n'
                    +'  app.mod="rs"\n'
                    +'  sweg.loadSweJson(s)\n'
                    +'  //swegz.sweg.loadSweJson(s)\n'
                    +'  let j=JSON.parse(s)\n'
                    +'  let o=j.params\n'
                    +'  let m0=o.sdgmt.split(" ")\n'
                    +'  let m1=m0[0].split("/")\n'
                    +'  let m2=m0[1].split(":")\n'
                    +'  JS.setTitleData("Revolución Solar '+comando[1]+' de '+app.currentNom+'",  m1[0],m1[1], m1[2], m2[0], m2[1], '+app.currentGmt+', "'+app.currentLugar+'", '+app.currentLat+','+app.currentLon+', 1)\n'
        }
        if(comando[0]==='rsl'){
            if(cmd===r.uCmd){
                //panelRsList.state=panelRsList.state==='show'?'hide':'show'
                zsm.getPanel('ZoolRevolutionList').state=zsm.getPanel('ZoolRevolutionList').state==='show'?'hide':'show'
                return
            }
            if(comando.length<1)return
            if(parseInt(comando[1])>=1){
                //panelRsList.setRsList(parseInt(comando[1])+ 1)
                zsm.getPanel('ZoolRevolutionList').setRsList(parseInt(comando[1])+ 1)
                //panelRsList.state='show'
                //zsm.currentIndex=4
            }
        }

        //Set app.uson and Show IW
        if(comando[0]==='data'){
            if(comando.length<1)return
            if(log.visible){
                log.visible=false
            }else{
                log.l(JSON.stringify(app.currentJson))
                log.visible=true
            }

            return
        }

        //Set app.uson and Show IW
        if(comando[0]==='info'){
            if(comando.length<1)return
            app.uSon=comando[1]
            JS.showIW()
            return
        }

        //Get sh python cmd
        if(comando[0]==='sh'){
            //if(comando.length<1)return
            console.log('json: '+app.currentData)
            let j=JSON.parse(app.currentData)
            let hsys=apps.defaultHsys
            if(j.params.hsys)hsys=j.params.hsys
            let sh='python3 "'+unik.currentFolderPath()+'/py/astrologica_swe.py" '+j.params.d+' '+j.params.m+' '+j.params.a+' '+j.params.h+' '+j.params.min+' '+j.params.gmt+' '+j.params.lat+' '+j.params.lon+' '+hsys+' "'+unik.currentFolderPath()+'"'
            //unik.clipboard
            console.log('sh: '+sh)
            tiCmd.text=sh
            return
        }
        //Get sh python cmd
        if(comando[0]==='showLog'){
            apps.showLog=!apps.showLog
            return
        }

        //Set MinymaClient Host
        if(comando[0]==='minyma'){
            if(comando.length===1){
                help='\n\nPara utilizar el comando minyma se esperan los siguientes argumentos:\n\n'
                help+='minyma sethost ws://xxx.xxx.xxx (host del servidor sin puerto)\n\n'
                help+='minyma setip xxx.xxx.xxx (sole el ip del servidor)\n\n'
                help+='minyma setport xxxx (número del puerto del servidor)\n\n'
                log.clear()
                log.ls(help, 0, xLatIzq.width)
                return
            }
            if(comando[1]==='sethost'){
                apps.minymaClientHost=comando[2]
                log.ls('Nuevo host de minymaClient: '+apps.minymaClientHost, 0, xLatIzq.width)

            }
            if(comando[1]==='setip'){
                apps.minymaClientHost='ws://'+comando[2]
                log.clear()
                log.ls('Nuevo host de minymaClient: '+apps.minymaClientHost, 0, xLatIzq.width)

            }
            if(comando[1]==='setport'){
                apps.minymaClientPort=comando[2]
                log.clear()
                log.ls('Nuevo puerto de minymaClient: '+apps.minymaClientPort, 0, xLatIzq.width)
            }
            //Minyma Send: minyma send to data
            if(comando[1]==='send'&&comando.length===4){
                minymaClient.sendData('zool', comando[2], ''+(comando[3]).replace(/\"/g, '')+'')
                log.clear()
                log.ls('minymaClient ha enviado a '+comando[2]+' el dato '+comando[3], 0, xLatIzq.width)
            }
            return
        }
        mkCmd(finalCmd, c)
        r.uCmd=cmd
    }
    function runQml(code){
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='Item{\n'
        c+='    id: item'+ms+'\n'
        c+='    Component.onCompleted:{\n'
        c+='        '+code+'\n'
        c+='    }\n'
        c+='}\n'
        //log.ls('Run Qml Code: '+c, 0, xLatIzq.width)
        let comp=Qt.createQmlObject(c, xuqp, 'runqmlcode')
    }
    function mkCmd(finalCmd, code){
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
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
        c+='        uqp'+ms+'.destroy(0)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        run(\''+finalCmd+'\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcodecmd')
    }
    function enter(){
        runCmd(tiCmd.text)
    }
    function makeRS(date){
        let cd=date
        cd = cd.setFullYear(date.getFullYear())
        let cd2=new Date(cd)
        cd2 = cd2.setDate(cd2.getDate() - 1)
        let cd3=new Date(cd2)
        let hsys=apps.currentHsys
        let finalCmd=''
            +app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+hsys+' "'+unik.currentFolderPath()+'"'
        //console.log('finalCmd: '+finalCmd)
        let c=''
        c+=''
                +'  if(logData.length<=3||logData==="")return\n'
                +'  let j\n'
                +'try {\n'
                +'      let s=""+logData\n'
                +'      //console.log("RS: "+s)\n'
                +'      r.state="hide"\n'
                +'      app.mod="rs"\n'
                +'      sweg.loadSweJson(s)\n'
                +'      //swegz.sweg.loadSweJson(s)\n'
                +'      let j=JSON.parse(s)\n'
                +'      let o=j.params\n'
                +'      let m0=o.sdgmt.split(" ")\n'
                +'      let m1=m0[0].split("/")\n'
                +'      let m2=m0[1].split(":")\n'
                +'      JS.setTitleData("Revolución Solar '+date.getFullYear()+' de '+app.currentNom+'",  m1[0],m1[1], m1[2], m2[0], m2[1], '+app.currentGmt+', "'+app.currentLugar+'", '+app.currentLat+','+app.currentLon+', 1)\n'
                +'      logData=""\n'
                +'} catch(e) {\n'
                +'  console.log("Error makeRS Code: "+e+" "+logData);\n'
                +'  //unik.speak("error");\n'
                +'}\n'

        mkCmd(finalCmd, c)
    }
    function makeRSBack(date){
        let cd=date
        cd = cd.setFullYear(date.getFullYear())
        let cd2=new Date(cd)
        cd2 = cd2.setDate(cd2.getDate() - 1)
        let hsys=apps.currentHsys
        let cd3=new Date(cd2)

        //Momento de creación de RS
        let nDateNow= new Date(Date.now())

        let nDate= new Date(date)
        let dia=nDate.getDate()
        let mes=nDate.getMonth() + 1
        let anio=nDate.getFullYear()
        let hora=nDate.getHours()
        let minuto=nDate.getMinutes()
        let j='{"paramsBack":{"tipo":"rs","ms":'+nDateNow.getTime()+',"n":"Revolución Solar '+anio+' de '+app.currentNom+'","d":'+dia+',"m":'+mes+',"a":'+anio+',"h":'+hora+',"min":'+minuto+',"gmt":'+app.currentGmt+',"lat":'+app.currentLat+',"lon":'+app.currentLon+',"alt":0,"ciudad":"'+app.currentLugar+'"}}'
        app.currentDataBack=j
        let finalCmd=''
            +app.pythonLocation+' "'+unik.currentFolderPath()+'/py/astrologica_swe_search_revsol.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+hsys+' "'+unik.currentFolderPath()+'"'
        //console.log('finalCmd: '+finalCmd)
        let c=''
        c+=''
                +'  if(logData.length<=3||logData==="")return\n'
                +'  let j\n'
                +'try {\n'
                +'      let s=""+logData\n'
                +'      //console.log("RS: "+s)\n'
                +'      r.state="hide"\n'
                +'      app.mod="rs"\n'
        //+'      app.currentFechaBack=\'20/06/1975 22:03\'\n'
                +'      sweg.loadSweJsonBack(s)\n'
                +'      //swegz.sweg.loadSweJsonBack(s)\n'
                +'      let j=JSON.parse(s)\n'
                +'      let o=j.params\n'
                +'      let m0=o.sdgmt.split(" ")\n'
                +'      let m1=m0[0].split("/")\n'
                +'      let m2=m0[1].split(":")\n'
                +'      JS.setTitleData("Revolución Solar '+date.getFullYear()+' de '+app.currentNom+'",  m1[0],m1[1], m1[2], m2[0], m2[1], '+app.currentGmt+', "'+app.currentLugar+'", '+app.currentLat+','+app.currentLon+', 1)\n'
                +'      logData=""\n'
                +'} catch(e) {\n'
                +'  console.log("Error makeRS Code: "+e+" "+logData);\n'
                +'  //unik.speak("error");\n'
                +'}\n'

        mkCmd(finalCmd, c)
    }
    function getJsonCmds(){
        let jsonString='{"cmds":[]}'
        let jsonFilePath='./modules/ZoolCmd/cmds.json'
        if(!unik.fileExist(jsonFilePath)) return JSON.parse(jsonString)
        jsonString=unik.getFile(jsonFilePath)
        return JSON.parse(jsonString)
    }
    function addJsonCmds(cmd){
        let json = getJsonCmds()
        let jsonCount=Object.keys(json.cmds).length
        for(var i=0;i<jsonCount;i++){
            if(cmd===json.cmds[i].cmd){
                log.ls('Ya existe: '+cmd, 0, 500)
                return
            }
        }
        json.cmds[jsonCount]={}
        json.cmds[jsonCount].cmd=cmd
        log.ls('New json: '+JSON.stringify(json), 0, 500)
        saveJsonCmds(json)
    }
    function getJsonCmd(index){
        let json = getJsonCmds()
        return json.cmds[index].cmd
    }
    function saveJsonCmds(json){
        let jsonFilePath='./modules/ZoolCmd/cmds.json'
        unik.setFile(jsonFilePath, JSON.stringify(json))
    }
}
