import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12
import ZoolTextInput 1.0
import comps.FocusSen 1.0

Rectangle {
    id: r
    width: parent.width
    height: app.fs
    border.width: 0
    border.color: 'white'
    color: 'black'
    //y:r.parent.height
    anchors.verticalCenter: parent.verticalCenter

    property alias ti: tiCmd.t
    property string jsonFilePath: u.getPath(4)+'/cmds.json'



    property real lat
    property real lon

    property string uCmd: ''

    ZoolTextInput{
        id: tiCmd
        width: r.width-padding*0.5
        height: r.height-padding*0.5
        t.font.pixelSize: app.fs*0.65
        t.parent.width: r.width//-app.fs*0.5
        //t.focus: r.visible//apps.showCmd
        anchors.horizontalCenter: parent.horizontalCenter
        //KeyNavigation.tab: cbGenero//controlTimeFecha
        t.maximumLength: 300
        borderColor:apps.fontColor
        borderRadius: app.fs*0.25
        //padding: app.fs*0.25
        horizontalAlignment: TextInput.AlignLeft
        anchors.verticalCenter: parent.verticalCenter
        property int cmdIndex: 0
        //onTextChanged: if(cbPreview.checked)loadTemp()
        onEnterPressed: {
            toEnter()
        }
        FocusSen{
            width: parent.width
            height: parent.height
            radius: parent.r.radius
            border.width: 2
            anchors.centerIn: parent
            visible: parent.t.focus
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

        //-->Comandos sin argumentos
        if(comando.length===1){
            if(comando[0]==='update'){
                zmu.checkRemoteVersion()
                return
            }
            if(comando[0]==='ee'){
                apps.showQmlErrors=!apps.showQmlErrors
                return
            }
            if(comando[0]==='ve'){
                log.clear()
                log.lv('\n\nErrores: '+qmlErrorLogger.messages.toString()+'\n\n')
                return
            }
            if(comando[0]==='test'){
                log.lv('Test: \n')
                log.lv('Archivo Python SWE Principal: '+u.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'\n')
                log.lv('Probando Python: '+app.pythonLocation+'\n')


                //Python
                let idName='probePython'
                let c=getUqpCode(idName, app.pythonLocation+' --version', 'log.lv("Versión: "+logData)\n', '', '')
                let comp=Qt.createQmlObject(c, xuqp, idName+'-qml-code')

                //PySwisEph
                idName='probePySwisEph'
                c=getUqpCode(idName, app.pythonLocation+' -m pip show pyswisseph', 'log.lv("Pyswisseph Versión: "+logData)\n', '', '')
                comp=Qt.createQmlObject(c, xuqp, idName+'-qml-code')

                //Swe
                log.lv('\nSwe Folder: '+app.sweFolder+'\n')

                //GeoPy
                idName='probeGeoPy'
                c=getUqpCode(idName, app.pythonLocation+' -m pip show geopy', 'log.lv("GeoPy Versión: "+logData)\n', '', '')
                comp=Qt.createQmlObject(c, xuqp, idName+'-qml-code')

                //7z
                log.lv('\n7-Zip: '+zmu.zm.app7ZipPath+'\n')
                idName='probe7z'
                c=getUqpCode(idName, zmu.zm.app7ZipPath, 'let m0=logData.split("Usage")\nlog.lv("7-Zip Versión: "+m0[0])\n', '', '')
                comp=Qt.createQmlObject(c, xuqp, idName+'-qml-code')

                //Curl
                log.lv('\nCurl: '+zmu.zm.curlPath+'\n')
                idName='probeCurl'
                c=getUqpCode(idName, zmu.zm.curlPath+' --version', 'log.lv(logData)\n', '', '')
                comp=Qt.createQmlObject(c, xuqp, idName+'-qml-code')

                return
            }
        }
        //<--Comandos sin argumentos

        if(comando.length<1)return

        let com=cmd.substring(0, comando[0].length)
        let codeCom=cmd.substring(comando[0].length+1, cmd.length)
        //log.lv('com:::['+com+']', 0, 500)
        //log.lv('codeCom:['+codeCom+']', 0, 500)

        //Crear Mapa
        if(com==='crear'){
            log.clear()
            let codeComCorr1=codeCom.replace(/, /g, ',')
            let mParams=codeComCorr1.split(',')
            if(mParams.length<10){
                log.lv('Faltan parámetros.\n')
                log.lv('Parámetros requeridos: 12')
                log.lv('Hay '+mParams.length+' parámetros.\n')
                log.lv('Se requiere: Nombre, día, mes, año, hora, minuto, gmt, latitud, longitud, altitud, lugar de nacimiento, Género f o m)')
                return
            }
            //log.lv('mParams: '+mParams)
            let vd=parseInt(mParams[1])
            if(isNaN(vd)){
                log.lv('Error! El número del día no es válido.')
                return
            }
            let vm=parseInt(mParams[2])
            if(isNaN(vm)){
                log.lv('Error! El número del mes no es válido.')
                return
            }
            let va=parseInt(mParams[3])
            if(isNaN(va)){
                log.lv('Error! El número del año no es válido.')
                return
            }
            let vh=parseInt(mParams[4])
            if(isNaN(vh)){
                log.lv('Error! El número de la hora no es válido.')
                return
            }
            let vmin=parseInt(mParams[5])
            if(isNaN(vmin)){
                log.lv('Error! El número del minuto no es válido.')
                return
            }
            let vgmt=parseInt(mParams[6])
            if(isNaN(vgmt)){
                log.lv('Error! El número del GMT no es válido.')
                return
            }
            let vlat=parseInt(mParams[7])
            if(isNaN(vlat)){
                log.lv('Error! El número de la latitud no es válido.')
                return
            }
            let vlon=parseInt(mParams[8])
            if(isNaN(vlon)){
                log.lv('Error! El número de la longitud no es válido.')
                return
            }
            let valt=parseInt(mParams[9])
            if(isNaN(valt)){
                log.lv('Error! El número de la altura sobre el nivel del mar no es válido.')
                return
            }
            log.visible=false
            let panel=zsm.getPanel('ZoolFileManager')
            let section=panel.getSection('ZoolFileMaker')
            section.setNewJsonFileDataFromArgs('vn', mParams[0], vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, mParams[10], 'T', mParams[11], '', true)
            return
        }

        //Ver un error QML
        if(com==='ve'){
            log.clear()
            let num=parseInt(codeCom)
            if(isNaN(num)){
                log.lv('Este comando funciona con "ve" o "ve <numero de error>"\nPara buscar un error por el nombre hay que usar "fe <nombre de error>"')
                return
            }else{
                log.lv('num: '+num)
            }


            log.lv('Errores:\nMostrando error N°'+parseInt(codeCom)+' de '+qmlErrorLogger.messages.length)
            log.lv('\n'+qmlErrorLogger.messages[num]+'\n')
            return
        }

        //Buscar un error QML
        if(com==='fe'){
            log.clear()
            let s=''
            let cant=0
            for(i=0;i<qmlErrorLogger.messages.length;i++){
                if(qmlErrorLogger.messages[i].indexOf(codeCom)>=0){
                    s+=qmlErrorLogger.messages[i]+'\n\n'
                    cant++
                }
            }
            log.lv('Errores:\nMostrando '+cant+' error encontrados de "'+codeCom+'"\n\n'+s)
            return
        }

        //Ejecutar código QML
        if(com==='c'){
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
                    log.l('Los archivos se guardarán en la carpeta temporal '+apps.workSpace)
                }else{
                    log.l('Los archivos se guardarán en la carpeta '+apps.workSpace)
                }
            }
            return
        }
        if(comando[0]==='logFileData'){
            log.visible=true
            log.l('Datos del archivo '+apps.url+':')
            let fd=u.getFile(apps.url)
            log.l(fd)
            return
        }
        if(comando[0]==='logFileDataBack'){
            log.visible=true
            log.l('Datos del archivo '+apps.urlBack+':')
            let fd=u.getFile(apps.urlBack)
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
                    +app.pythonLocation+' "'+u.currentFolderPath()+'/py/astrologica_swe_search_eclipses.py" '+comando[1]+' '+comando[2]+' '+comando[3]+' '+comando[4]+' '+comando[5]+' "'+u.currentFolderPath()+'"'
        }
        if(comando[0]==='rs'){
            if(comando.length<1)return
            let cd=zm.currentDate
            cd = cd.setFullYear(zm.currentDate.getFullYear()+parseInt(comando[1]), 1, 1)
            let cd2=new Date(cd)
            let hsys=apps.currentHsys
            finalCmd=''
                    +app.pythonLocation+' "'+u.currentFolderPath()+'/py/getRs.py" '+zm.currentGradoSolar+' '+zm.currentMinutoSolar+' '+zm.currentSegundoSolar+' '+cd2.getFullYear()+' '+zm.currentGmt+' '+zm.currentLat+' '+zm.currentLon+' '+zm.currentAlt+' "'+app.sweFolder+'"'
            console.log('ZoolCmd::runCmd:finalCmd: '+finalCmd)
            c=''
            c+=''
                    //+'  let s=""+logData\n'
                    +'  zsm.getPanel(\'ZoolRevolutionList\').loadRsExt(logData, zm.currentGmt, zm.currentLat, zm.currentLon, 0)\n'

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
            app.j.showIW()
            return
        }

        //Get sh python cmd
        if(comando[0]==='sh'){
            //if(comando.length<1)return
            console.log('json: '+app.currentData)
            let j=JSON.parse(app.currentData)
            let hsys=apps.defaultHsys
            if(j.params.hsys)hsys=j.params.hsys
            let sh='python3 "'+u.currentFolderPath()+'/py/astrologica_swe.py" '+j.params.d+' '+j.params.m+' '+j.params.a+' '+j.params.h+' '+j.params.min+' '+j.params.gmt+' '+j.params.lat+' '+j.params.lon+' '+hsys+' "'+u.currentFolderPath()+'"'
            //u.clipboard
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
            +app.pythonLocation+' "'+u.currentFolderPath()+'/py/astrologica_swe_search_revsol.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+hsys+' "'+u.currentFolderPath()+'"'
        //console.log('finalCmd: '+finalCmd)
        let c=''
        c+=''
                +'  if(logData.length<=3||logData==="")return\n'
                +'  let j\n'
                +'try {\n'
                +'      let s=""+logData\n'
                +'      //console.log("RS: "+s)\n'
                +'      r.state="hide"\n'
                +'      app.t="rs"\n'
                +'      sweg.loadSweJson(s)\n'
                +'      //swegz.sweg.loadSweJson(s)\n'
                +'      let j=JSON.parse(s)\n'
                +'      let o=j.params\n'
                +'      let m0=o.sdgmt.split(" ")\n'
                +'      let m1=m0[0].split("/")\n'
                +'      let m2=m0[1].split(":")\n'
                +'      app.j.setTitleData("Revolución Solar '+date.getFullYear()+' de '+app.currentNom+'",  m1[0],m1[1], m1[2], m2[0], m2[1], '+app.currentGmt+', "'+app.currentLugar+'", '+app.currentLat+','+app.currentLon+', 1)\n'
                +'      logData=""\n'
                +'} catch(e) {\n'
                +'  console.log("Error makeRS Code: "+e+" "+logData);\n'
                +'  //u.speak("error");\n'
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
        let j='{"paramsBack":{"t":"rs","ms":'+nDateNow.getTime()+',"n":"Revolución Solar '+anio+' de '+app.currentNom+'","d":'+dia+',"m":'+mes+',"a":'+anio+',"h":'+hora+',"min":'+minuto+',"gmt":'+app.currentGmt+',"lat":'+app.currentLat+',"lon":'+app.currentLon+',"alt":0,"c":"'+app.currentLugar+'"}}'
        app.currentDataBack=j
        let finalCmd=''
            +app.pythonLocation+' "'+u.currentFolderPath()+'/py/astrologica_swe_search_revsol.py" '+cd3.getDate()+' '+parseInt(cd3.getMonth() +1)+' '+cd3.getFullYear()+' '+cd3.getHours()+' '+cd3.getMinutes()+' '+app.currentGmt+' '+app.currentLat+' '+app.currentLon+' '+app.currentGradoSolar+' '+app.currentMinutoSolar+' '+app.currentSegundoSolar+' '+hsys+' "'+u.currentFolderPath()+'"'
        console.log('finalCmd: '+finalCmd)
        let c=''
        c+=''
                +'  if(logData.length<=3||logData==="")return\n'
                +'  let j\n'
                +'try {\n'
                +'      let s=""+logData\n'
                +'      //console.log("RS: "+s)\n'
                +'      r.state="hide"\n'
                +'      app.t="rs"\n'
        //+'      app.currentFechaBack=\'20/06/1975 22:03\'\n'
                +'      sweg.loadSweJsonBack(s)\n'
                +'      //swegz.sweg.loadSweJsonBack(s)\n'
                +'      let j=JSON.parse(s)\n'
                +'      let o=j.params\n'
                +'      let m0=o.sdgmt.split(" ")\n'
                +'      let m1=m0[0].split("/")\n'
                +'      let m2=m0[1].split(":")\n'
                +'      app.j.setTitleData("Revolución Solar '+date.getFullYear()+' de '+app.currentNom+'",  m1[0],m1[1], m1[2], m2[0], m2[1], '+app.currentGmt+', "'+app.currentLugar+'", '+app.currentLat+','+app.currentLon+', 1)\n'
                +'      logData=""\n'
                +'} catch(e) {\n'
                +'  console.log("Error makeRS Code: "+e+" "+logData);\n'
                +'  //u.speak("error");\n'
                +'}\n'

        mkCmd(finalCmd, c)
    }
    function getJsonCmds(){
        let jsonString='{"cmds":[]}'
        if(!u.fileExist(r.jsonFilePath)) return JSON.parse(jsonString)
        jsonString=u.getFile(r.jsonFilePath)
        return JSON.parse(jsonString)
    }
    function addJsonCmds(cmd){
        let json = getJsonCmds()
        let jsonCount=Object.keys(json.cmds).length
        for(var i=0;i<jsonCount;i++){
            if(cmd===json.cmds[i].cmd){
                //log.ls('Ya existe: '+cmd, 0, 500)
                return
            }
        }
        json.cmds[jsonCount]={}
        json.cmds[jsonCount].cmd=cmd
        //log.ls('New json: '+JSON.stringify(json), 0, 500)
        saveJsonCmds(json)
    }
    function getJsonCmd(index){
        //log.lv('getJsonCmd('+index+')')
        let json = getJsonCmds()
        return json.cmds[index].cmd
    }
    function saveJsonCmds(json){
        u.setFile(r.jsonFilePath, JSON.stringify(json))
    }
    function getLastJsonCmd(){
        let json = getJsonCmds()
        let jsonCount=Object.keys(json.cmds).length
        let uCom=json.cmds[jsonCount-1].cmd
        return uCom
    }
    function getUqpCode(idName, cmd, onLogDataCode, onFinishedCode, onCompleteCode){
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='    UnikQProcess{\n'
        c+='        id: '+idName+'\n'
        c+='        onFinished:{\n'
        c+='        '+onFinishedCode
        c+='        '+idName+'.destroy(0)\n'
        c+='        }\n'
        c+='        onLogDataChanged:{\n'
        c+='        '+onLogDataCode
        c+='        }\n'
        c+='        Component.onCompleted:{\n'
        c+='        '+onCompleteCode
        c+='            let cmd=\''+cmd+'\'\n'
        c+='            if(r.dev)console.log("cmd '+idName+': "+cmd)\n'
        c+='            if(r.dev)log.lv(cmd)\n'
        c+='            run(cmd)\n'
        c+='        }\n'
        c+='    }\n'
        c+='}\n'
        return c
    }

    //-->Teclado
    function toEnter(){
        if(tiCmd.t.text===''){
            tiCmd.t.text=getLastJsonCmd()
            tiCmd.t.selectAll()
            tiCmd.t.focus=true
            return
        }
        addJsonCmds(tiCmd.t.text)
        runCmd(tiCmd.t.text)
    }
    function toUp(){
        //if(Object.keys(getJsonCmds(tiCmd.cmdIndex).cmds).length===0)return
        tiCmd.text=getJsonCmd(tiCmd.cmdIndex)
        if(tiCmd.cmdIndex>0){
            tiCmd.cmdIndex--
        }else{
            tiCmd.cmdIndex=Object.keys(getJsonCmds().cmds).length-1
        }
    }
    function toDown(){
        //if(Object.keys(getJsonCmds(tiCmd.cmdIndex).cmds).length===0)return
        tiCmd.text=getJsonCmd(tiCmd.cmdIndex)
        if(tiCmd.cmdIndex<Object.keys(getJsonCmds().cmds).length-1){
            tiCmd.cmdIndex++
        }else{
            tiCmd.cmdIndex=0
        }
    }
    //<--Teclado
}
