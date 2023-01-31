function firstRunTime(){
    log.ls('\n\nBienvenido!.\n', 0, xLatIzq.width)
    if(apps.jsonsFolder===''){
        let jsonFolder=unik.getPath(3)+'/Zool'
        apps.jsonsFolder=jsonFolder
        if(!unik.fileExist(jsonFolder)){
            log.ls('\nCreando carpeta de archivos:\n'+apps.jsonsFolder, log.x, log.width)
            unik.mkdir(jsonFolder)
        }
    }
    console.log('Loading United Kingston now...')
    console.log('JsonFolder: '+apps.jsonsFolder)

    let d=new Date(Date.now())
    let currentUserHours=d.getHours()
    let diffHours=d.getUTCHours()
    let currentGmtUser=0
    if(currentUserHours>diffHours){
        currentGmtUser=parseFloat(currentUserHours-diffHours)
    }else{
        currentGmtUser=parseFloat(0-(diffHours-currentUserHours)).toFixed(1)
    }

    //log.ls('currentGmtUser: '+currentGmtUser, 0, xLatIzq.width)
    let dia=d.getDate()
    let mes=d.getMonth()+1
    let anio=d.getFullYear()
    let nom="Primer Inicio de Zool"
    JS.loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), currentGmtUser,0.0,0.0,6, nom, "United Kingston", "vn", true)

    log.ls('Al parecer es la primera vez que inicia Zool en su equipo.\n\n', 0, xLatIzq.width)
    //apps.url=apps.jsonsFolder+'/Primer_Inicio_de_Zool.json'
    log.ls('Cargando el archivo '+apps.url+' creado por primera y única vez a modo de ejemplo.\n\n', 0, xLatIzq.width)
    log.l('\nZool se está ejecutando en la carpeta'+unik.currentFolderPath())
}
function setFs() {
    let w = Screen.width
    let h = Screen.height
    if(w===1920 && h === 1080){
        app.fs = w*0.031
    }
    if(w===1680 && h === 1050){
        app.fs = w*0.036
    }
    if(w===1400 && h === 1050){
        app.fs = w*0.041
    }
    if(w===1600 && h === 900){
        app.fs = w*0.031
    }
    if(w===1280 && h === 1024){
        app.fs = w*0.045
    }
    if(w===1440 && h === 900){
        app.fs = w*0.035
    }
    if(w===1280 && h === 800){
        app.fs = w*0.035
    }
    if(w===1152 && h === 864){
        app.fs = w*0.042
    }
    if(w===1280 && h === 720){
        app.fs = w*0.03
    }
}

function resetGlobalVars(){
    app.currentPlanetIndex=-1
    app.currentPlanetIndexBack=-1
    app.currentHouseIndex=-1
    app.currentHouseIndexBack=-1
    app.currentSignIndex= 0
    app.currentNom= ''
    app.currentNomBack= ''
    app.currentFecha= ''
    app.currentFechaBack= ''
    app.currentGradoSolar= -1
    app.currentGradoSolarBack= -1
    app.currentMinutoSolar= -1
    app.currentMinutoSolarBack= -1
    app.currentSegundoSolar= -1
    app.currentSegundoSolarBack= -1
    app.currentGmt= 0.0
    app.currentGmtBack= 0.0
    app.currentLon= 0.0
    app.currentLonBack= 0.0
    app.currentLat= 0.0
    app.currentLatBack= 0.0
    app.uSon=''
    app.uSonBack=''
    //panelControlsSign.state='hide'
    apps.showAspPanelBack=false
    app.ev=false
    apps.urlBack=''
    apps.showAspPanelBack=false
    apps.showAspCircleBack=false
}

//Funciones de Cargar Datos Interior
function loadFromArgs(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, save){
    app.ev=false
    apps.urlBack=''
    let dataMs=new Date(Date.now())
    let j='{"params":{"tipo":"'+tipo+'","ms":'+dataMs.getTime()+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"alt":'+alt+',"ciudad":"'+ciudad+'"}}'
    let setTitleMod=1
    if(tipo==='pron')setTitleMod=2
    setTitleData(nom, d, m, a, h, min, gmt, ciudad, lat, lon, setTitleMod)

    if(save){
        let fn=apps.jsonsFolder+'/'+nom.replace(/ /g, '_')+'.json'
        console.log('loadFromArgs('+d+', '+m+', '+a+', '+h+', '+min+', '+gmt+', '+lat+', '+lon+', '+alt+', '+nom+', '+ciudad+', '+save+'): '+fn)
        unik.setFile(fn, j)
        loadJson(fn)
        return
    }
    //xDataBar.state='show'
    //xDataBar.opacity=1.0
    //app.currentData=j
    app.fileData=j
    app.currentData=j
    runJsonTemp()
}

//Funciones de Cargar Datos Exterior
function loadFromArgsBack(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, save){
    app.ev=true

    let nGmt=gmt
    //IMPORTANTE
    //GMT A 0 SI ES RS
    if(tipo==='rs')nGmt=0

    let dataMs=new Date(Date.now())
    let j='{"paramsBack":{"tipo":"'+tipo+'","ms":'+dataMs.getTime()+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+nGmt+',"lat":'+lat+',"lon":'+lon+',"alt":'+alt+',"ciudad":"'+ciudad+'"}}'
    app.mod=tipo
    //setTitleData(nom, d, m, a, h, min, gmt, ciudad, lat, lon, 1)
    if(tipo==='sin'){
        xDataBar.stringMiddleSeparator='Sinastría'

        app.currentNomBack=nom
        app.currentFechaBack=d+'/'+vm+'/'+va
        app.currentLugarBack=ciudad
        app.currentGmtBack=gmt
        app.currentLonBack=lon
        app.currentLatBack=lat

        addTitleData(nom, d, m, a, h, min, gmt, ciudad, lat, lon, 1)
    }
    if(tipo==='rs'){
        xDataBar.stringMiddleSeparator='Rev. Solar '+a+' de '+nom
        xDataStatusBar.currentIndex=1
        setTitleDataRs(nom, d, m, a, h, min, gmt, ciudad, lat, lon)
    }
    if(tipo==='trans'){
        xDataBar.stringMiddleSeparator='Tránsitos'
        xDataStatusBar.currentIndex=2
        setTitleDataRs(nom, d, m, a, h, min, gmt, ciudad, lat, lon)
    }

    if(save){
        let fn=apps.jsonsFolder+'/'+nom.replace(/ /g, '_')+'.json'
        console.log('loadFromArgs('+d+', '+m+', '+a+', '+h+', '+min+', '+gmt+', '+lat+', '+lon+', '+alt+', '+nom+', '+ciudad+', '+save+'): '+fn)
        unik.setFile(fn, j)
        loadJsonBack(fn)
        return
    }
    app.currentDataBack=j
    sweg.loadBack(JSON.parse(j), tipo)
    //runJsonTempBack()
}

function loadTransFromTime(date){
    let j=JSON.parse(app.currentData)
    let p=j.params
    let d=new Date(date.getTime())
    let dia=d.getDate()
    let mes=d.getMonth() + 1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    loadFromArgsBack(dia, mes, anio, hora, minuto, p.gmt, p.lat, p.lon, p.alt?p.alt:0, 'Tránsitos '+dia+'-'+mes+'-'+anio+' '+hora+':'+minuto, p.ciudad, 'trans', false)
    app.currentGmtBack=app.currentGmt
    //app.currentDateBack=d
}

function loadTransNow(){
    let j=JSON.parse(app.currentData)
    let p=j.params
    let d=new Date(Date.now())
    let dia=d.getDate()
    let mes=d.getMonth() + 1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    loadFromArgsBack(dia, mes, anio, hora, minuto, p.gmt, p.lat, p.lon, p.alt?p.alt:0, 'Tránsitos '+dia+'-'+mes+'-'+anio+' '+hora+':'+minuto, p.ciudad, 'trans', false)
    app.currentGmtBack=app.currentGmt
    app.currentDateBack=d
}

//VNA
function showIW(){
    console.log('uSon: '+app.uSon)
    let m0=app.uSon.split('_')
    let fileLocation='./iw/main.qml'
    let comp=Qt.createComponent(fileLocation)

    //Cuerpo en Casa
    let nomCuerpo=m0[0]!=='asc'?app.planetas[app.planetasRes.indexOf(m0[0])]:'Ascendente'
    let jsonFileName=m0[0]!=='asc'?quitarAcentos(nomCuerpo.toLowerCase())+'.json':'asc.json'
    let jsonFileLocation='./quiron/data/'+jsonFileName
    //    if(!unik.fileExist(jsonFileLocation)){
    //        let obj=comp.createObject(app, {textData:'No hay datos disponibles.', width: sweg.width, height: sweg.height, x:0, y:0, fs: app.fs*0.5, title:'Sin datos'})
    //    }else{
    let numHome=m0[0]!=='asc'?-1:1
    let vNumRom=['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    numHome=parseInt(m0[2])//vNumRom.indexOf(m0[2])+1
    console.log('::::Abriendo signo: '+app.objSignsNames.indexOf(m0[1])+' casa: '+numHome+' nomCuerpo: '+nomCuerpo)
    getJSON(jsonFileName, comp, app.objSignsNames.indexOf(m0[1])+1, numHome, nomCuerpo)
    //}
}
function showIWFromCtxMenuBar(){
    //log.ls('app.uSonFCMB: '+app.uSonFCMB, 500, 500)
    let m0=app.uSonFCMB.split('_')
    let fileLocation='./iw/main.qml'
    let comp=Qt.createComponent(fileLocation)

    //Cuerpo en Casa
    let nomCuerpo=m0[0]!=='asc'?app.planetas[app.planetasRes.indexOf(m0[0])]:'Ascendente'
    let jsonFileName=m0[0]!=='asc'?quitarAcentos(nomCuerpo.toLowerCase())+'.json':'asc.json'
    let jsonFileLocation='./quiron/data/'+jsonFileName
    //    if(!unik.fileExist(jsonFileLocation)){
    //        let obj=comp.createObject(app, {textData:'No hay datos disponibles.', width: sweg.width, height: sweg.height, x:0, y:0, fs: app.fs*0.5, title:'Sin datos'})
    //    }else{
    let numHome=m0[0]!=='asc'?-1:1
    let vNumRom=['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    numHome=parseInt(m0[2])//vNumRom.indexOf(m0[2])+1
    console.log('::::Abriendo signo: '+app.objSignsNames.indexOf(m0[1])+' casa: '+numHome+' nomCuerpo: '+nomCuerpo)
    getJSON(jsonFileName, comp, app.objSignsNames.indexOf(m0[1])+1, numHome, nomCuerpo)
    //}
}
function showEditor(j){
    let json=JSON.parse(j)
    let fileLocation='./editor/main.qml'
    let comp=Qt.createComponent(fileLocation)
    let data=''
    if(json.params.data){
        data=json.params.data
    }
    let title=('Editando '+json.params.n).replace(/_/g,' ')
    let obj=comp.createObject(app, {width: app.width*0.6, x:app.width*0.2, fs: app.fs*0.5, title: title, data: data})
}
function getJSON(fileLocation, comp, s, c, nomCuerpo) {
    var request = new XMLHttpRequest()

    //Url File Local Data
    //'file:///home/ns/Documentos/unik/quiron/data/neptuno.json'

    //let jsonFileUrl='file:./quiron/data/'+fileLocation
    let msr=new Date(Date.now()).getTime()
    let jsonFileUrl=apps.hostQuiron+'/'+fileLocation+'?r='+msr

    console.log('jsonFileUrl: '+jsonFileUrl)
    request.open('GET', jsonFileUrl, true);
    //request.open('GET', 'https://github.com/nextsigner/quiron/raw/main/data/'+cbPlanetas.currentText+'.json', true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                //console.log(":::", request.responseText)
                var result = JSON.parse(parseRetRed(request.responseText.replace(/\n/g, '')))
                if(result){
                    console.log('getJSON result: '+result)
                    //console.log('Abriendo casa de json: '+c)
                    //console.log('Abriendo dato signo:'+s+' casa:'+c+'...')
                    let dataJson0=''
                    let dataList=[]
                    //Dato Global
                    if(result['sg']){
                        let dataJsonG=result['sg'].split('|')
                        dataList.push('<h2>Significado de '+nomCuerpo+'</h2>')
                        for(i=0;i<dataJsonG.length;i++){
                            dataList.push(dataJsonG[i])
                        }
                    }else{
                        //log.l('Dato sg no existe! '+jsonFileUrl)
                        //log.visible=true
                    }

                    if(result['h'+c]){
                        console.log('Abriendo dato de casa... ')
                        dataJson0=result['h'+c].split('|')
                        dataList.push('<h2>'+nomCuerpo+' en casa '+c+'</h2>')
                        for(var i=0;i<dataJson0.length;i++){
                            dataList.push(dataJson0[i])
                        }
                    }

                    //console.log('Signo para mostar: '+s)
                    if(result['s'+s]){
                        console.log('Abriendo dato de signo... ')




                        dataJson0=result['s'+s].split('|')
                        dataList.push('<h2>'+nomCuerpo+' en '+app.signos[s - 1]+'</h2>')
                        for(i=0;i<dataJson0.length;i++){
                            dataList.push(dataJson0[i])
                        }
                    }
                    let obj=comp.createObject(app, {dataList: dataList, width: apps.iwWidth, x:app.width*0.2, fs: app.fs*0.5, title: nomCuerpo+' en '+app.signos[s - 1]+' en casa '+c, xOffSet: app.fs*6})
                }
                //console.log('Data-->'+JSON.stringify(result))
            } else {
                console.log("HTTP:", request.status, request.statusText)
                JS.showMsgDialog('Error! - Zool Informa', 'Error! Al acceder al repositorio Quirón. Problemas de conexión a internet', 'No se ha podido obtener datos de la base de datos del Repositorio Quirón.\n\nPor alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }
    request.send()
}
function showSABIANOS(numSign, numDegree){
    panelSabianos.numSign=numSign
    panelSabianos.numDegree=numDegree
    panelSabianos.state='show'
    panelSabianos.loadData()
}
function quitarAcentos(cadena){
    const acentos = {'á':'a','é':'e','í':'i','ó':'o','ú':'u','Á':'A','É':'E','Í':'I','Ó':'O','Ú':'U'};
    return cadena.split('').map( letra => acentos[letra] || letra).join('').toString();
}
function setInfo(i1, i2, i3, son){
    if(son){
        infoCentral.info1=i1
        infoCentral.info2=i2
        infoCentral.info3=i3
        app.uSon=son
    }
}
function getEdad(d, m, a, h, min) {
    let hoy = new Date(Date.now())
    let fechaNacimiento = new Date(a, m, d, h, min)
    fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
    let fechaNacimiento2 = new Date(fechaNacimiento)
    let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
    let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
    if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
        edad--
    }
    return edad
}
function getEdadRS(d, m, a, h, min) {
    let hoy = app.currentDate//new Date(Date.now())
    let fechaNacimiento = new Date(a, m, d, h, min)
    fechaNacimiento=fechaNacimiento.setMonth(fechaNacimiento.getMonth() - 1)
    let fechaNacimiento2 = new Date(fechaNacimiento)
    let edad = hoy.getFullYear() - fechaNacimiento2.getFullYear()
    let diferenciaMeses = hoy.getMonth() - fechaNacimiento2.getMonth()
    if(diferenciaMeses < 0 ||(diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento2.getDate())){
        edad--
    }
    return edad
}
function runCmd(){
    let c='import unik.UnikQProcess 1.0\n'
        +'UnikQProcess{\n'
        +'  '
        +'}\n'
}
function deg_to_dms (deg) {
    var d = Math.floor (deg);
    var minfloat = (deg-d)*60;
    var m = Math.floor(minfloat);
    var secfloat = (minfloat-m)*60;
    var s = Math.round(secfloat);
    // After rounding, the seconds might become 60. These two
    // if-tests are not necessary if no rounding is done.
    if (s==60) {
        m++;
        s=0;
    }
    if (m==60) {
        d++;
        m=0;
    }
    return [d, m, s]
}


//Zool
function loadJson(file){
    //Global Vars Reset
    app.setFromFile=true
    //apps.enableFullAnimation=false

    resetGlobalVars()

    apps.url=file
    let fn=apps.url
    let jsonFileName=fn
    let jsonFileData=unik.getFile(jsonFileName).replace(/\n/g, '')
    app.fileData=jsonFileData
    app.currentData=app.fileData
    if(jsonFileData.length<10){
        log.l('Error al cargar el archivo '+file)
        log.l('Datos: '+jsonFileData)
        log.visible=true

        return
    }
    let jsonData=JSON.parse(jsonFileData)
    if(jsonData.params.tipo){
        app.mod=jsonData.params.tipo
    }else{
        app.mod='vn'
    }
    if(parseInt(jsonData.params.ms)===0||jsonData.params.tipo==='pron'){
        if(jsonData.params.tipo==='pron'){
            let dd = new Date(Date.now())
            let ms=dd.getTime()
            let nom=jsonData.params.n
            let d=jsonData.params.d
            let m=jsonData.params.m
            let a=jsonData.params.a
            let h=0
            let min=0
            let lat=jsonData.params.lat
            let lon=jsonData.params.lon
            let gmt=jsonData.params.gmt
            let ciudad=' '
            let j='{"params":{"tipo": "pl", "ms":'+ms+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"ciudad":"'+ciudad+'"}}'
            app.fileData=j
            jsonData=JSON.parse(j)
        }else{
            d=new Date(Date.now())
            jsonData.params.d=d.getDate()
            jsonData.params.m=d.getMonth()+1
            jsonData.params.a=d.getFullYear()
            jsonData.params.h=d.getHours()
            jsonData.params.min=d.getMinutes()
        }
        sweg.loadSign(jsonData)
    }else{
        //log.ww=false
        //log.ls('sweg.load(jsonData): '+JSON.stringify(jsonData), 0, 500)
        sweg.load(jsonData)
    }
    if(jsonData.params.fileNamePath){
        panelPronEdit.loadJson(jsonData.params.fileNamePath)
    }

    let params

    if((jsonData.params.tipo==='rs' && jsonData.paramsBack) || (jsonData.params.tipo==='sin' && jsonData.paramsBack) ){
        params=jsonData.paramsBack
    }else{
        params=jsonData.params
    }

    //if(params.tipo==='rs'){
    //if(app.dev)log.l('RS params:'+JSON.stringify(params, null, 2), 0, log.width)
    //}

    let nom=params.n.replace(/_/g, ' ')
    let vd=params.d
    let vm=params.m
    let va=params.a
    let vh=params.h
    let vmin=params.min
    let vgmt=params.gmt
    let vlon=params.lon
    let vlat=params.lat
    let vCiudad=params.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    if(params.tipo==='rs'){
        let edadRs=47
        //stringEdad=edadRs
        //log.l('RS params:'+params+' --->'+stringEdad, 0, log.width)
    }

    //Seteando datos globales de mapa energético
    app.currentDate= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
    //console.log('2 main.loadJson('+file+'): '+app.currentDate.toString())

    //getCmdData.getData(vd, vm, va, vh, vmin, vlon, vlat, 0, vgmt)
    app.currentNom=nom
    app.currentFecha=vd+'/'+vm+'/'+va
    app.currentLugar=vCiudad
    app.currentGmt=vgmt
    app.currentLon=vlon
    app.currentLat=vlat


    if(jsonData.params.tipo==='sin' && jsonData.paramsBack){
        let m0NomCorr=nom.split(' - ')
        nom=m0NomCorr[0].replace('Sinastría ', '')
        vd=jsonData.params.d
        vm=jsonData.params.m
        va=jsonData.params.a
        vh=jsonData.params.h
        vmin=jsonData.params.min
        vgmt=jsonData.params.gmt
        vlon=jsonData.params.lon
        vlat=jsonData.params.lat
        vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
        edad=''
        numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
        stringEdad=edad.indexOf('NaN')<0?edad:''
        setTitleData('Interior: '+nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)

        //Preparando datos para addTitle de tipo sin.
        nom=jsonData.paramsBack.n.replace(/_/g, ' ')
        if(m0NomCorr.length>1){
            nom=m0NomCorr[1].replace('Sinastría ', '')
        }
        vd=jsonData.paramsBack.d
        vm=jsonData.paramsBack.m
        va=jsonData.paramsBack.a
        vh=jsonData.paramsBack.h
        vmin=jsonData.paramsBack.min
        vgmt=jsonData.paramsBack.gmt
        vlon=jsonData.paramsBack.lon
        vlat=jsonData.paramsBack.lat
        vCiudad=jsonData.paramsBack.ciudad.replace(/_/g, ' ')
        edad=''
        numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
        stringEdad=edad.indexOf('NaN')<0?edad:''

        app.currentNomBack=nom
        app.currentFechaBack=vd+'/'+vm+'/'+va
        app.currentLugarBack=vCiudad
        app.currentGmtBack=vgmt
        app.currentLonBack=vlon
        app.currentLatBack=vlat

        addTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)
    }else{
        setTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)
    }
    //    if(jsonData.params.tipo==='sin'){
    //        nom=jsonData.paramsBack.n.replace(/_/g, ' ')
    //        vd=jsonData.paramsBack.d
    //        vm=jsonData.paramsBack.m
    //        va=jsonData.paramsBack.a
    //        vh=jsonData.paramsBack.h
    //        vmin=jsonData.paramsBack.min
    //        vgmt=jsonData.paramsBack.gmt
    //        vlon=jsonData.paramsBack.lon
    //        vlat=jsonData.paramsBack.lat
    //        let valt=0
    //        if(jsonData.paramsBack.alt){
    //            valt=jsonData.paramsBack.alt
    //        }
    //        vCiudad=jsonData.paramsBack.ciudad.replace(/_/g, ' ')
    //        //let edad=''
    //        //numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    //        //let stringEdad=edad.indexOf('NaN')<0?edad:''

    //        loadFromArgsBack(vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, nom, vCiudad, 'sin', false)
    //        //log.l('Cargando sinastría...')
    //        //log.visible=true
    //    }
    //xDataBar.titleData=textData
    xDataBar.state='show'
    xDataStatusBar.currentIndex=-1
    app.setFromFile=false
    sweg.centerZoomAndPos()
}
function loadJsonBack(file, tipo){
    //Global Vars Reset
    app.setFromFile=true
    //apps.enableFullAnimation=false
    app.currentPlanetIndexBack=-1
    app.currentHouseIndexBack=-1
    app.currentSignIndex= 0
    app.currentNomBack= ''
    app.currentFechaBack= ''
    app.currentGradoSolarBack= -1
    app.currentMinutoSolarBack= -1
    app.currentSegundoSolarBack= -1
    app.currentGmtBack= 0.0
    app.currentLonBack= 0.0
    app.currentLatBack= 0.0
    app.uSonBack=''
    //panelControlsSign.state='hide'
    app.ev=true

    apps.urlBack=file
    let fn=apps.urlBack
    let jsonFileName=fn
    let jsonFileData=unik.getFile(jsonFileName).replace(/\n/g, '')
    app.fileDataBack=jsonFileData
    log.ls('app.fileDataBack:'+app.fileDataBack, 0, 500)
    app.currentJsonBack=app.fileDataBack
    let jsonData=JSON.parse(jsonFileData)
    if(jsonData.params.tipo){
        app.mod=jsonData.params.tipo
    }else{
        app.mod='vn'
    }
    if(parseInt(jsonData.params.ms)===0||jsonData.params.tipo==='pron'){
        if(jsonData.params.tipo==='pron'){
            let dd = new Date(Date.now())
            let ms=dd.getTime()
            let nom=jsonData.params.n
            let d=jsonData.params.d
            let m=jsonData.params.m
            let a=jsonData.params.a
            let h=0
            let min=0
            let lat=jsonData.params.lat
            let lon=jsonData.params.lon
            let gmt=jsonData.params.gmt
            let ciudad=' '
            let j='{"params":{"tipo": "pl", "ms":'+ms+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"ciudad":"'+ciudad+'"}}'
            app.fileDataBack=j
            jsonData=JSON.parse(j)
        }else{
            d=new Date(Date.now())
            jsonData.params.d=d.getDate()
            jsonData.params.m=d.getMonth()+1
            jsonData.params.a=d.getFullYear()
            jsonData.params.h=d.getHours()
            jsonData.params.min=d.getMinutes()
        }
        sweg.loadSign(jsonData)
    }else{
        sweg.loadBack(jsonData, tipo)
    }
    if(jsonData.params.fileNamePath){
        panelPronEdit.loadJson(jsonData.params.fileNamePath)
    }
    let nom=jsonData.params.n.replace(/_/g, ' ')
    let vd=jsonData.params.d
    let vm=jsonData.params.m
    let va=jsonData.params.a
    let vh=jsonData.params.h
    let vmin=jsonData.params.min
    let vgmt=jsonData.params.gmt
    let vlon=jsonData.params.lon
    let vlat=jsonData.params.lat
    let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''

    //Seteando datos globales de mapa energético
    app.currentDateBack= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
    //console.log('2 main.loadJson('+file+'): '+app.currentDate.toString())

    //getCmdData.getData(vd, vm, va, vh, vmin, vlon, vlat, 0, vgmt)
    app.currentNomBack=nom
    app.currentFechaBack=vd+'/'+vm+'/'+va
    app.currentLugarBack=vCiudad
    app.currentGmtBack=vgmt
    app.currentLonBack=vlon
    app.currentLatBack=vlat

    addTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)
    //xDataBar.titleData=textData
    xDataBar.state='show'
    xDataStatusBar.currentIndex=0
    app.setFromFile=false
}
function loadJsonFromParamsBack(json){
    //Global Vars Reset
    app.setFromFile=true
    //apps.enableFullAnimation=false
    app.currentPlanetIndexBack=-1
    app.currentHouseIndexBack=-1
    app.currentSignIndex= 0
    app.currentNomBack= ''
    app.currentFechaBack= ''
    app.currentGradoSolarBack= -1
    app.currentMinutoSolarBack= -1
    app.currentSegundoSolarBack= -1
    app.currentGmtBack= 0.0
    app.currentLonBack= 0.0
    app.currentLatBack= 0.0
    app.uSonBack=''
    //panelControlsSign.state='hide'

    //apps.urlBack=file
    app.fileDataBack=JSON.stringify(json)
    //if(app.dev)log.ls('loadJsonFromParamsBack(json): '+JSON.stringify(json, null, 2), 0, log.width)
    //app.currentJsonBack=app.fileDataBack
    let jsonData=json
    let params
    if(jsonData.paramsBack){
        params=jsonData.paramsBack
    }else{
        params=jsonData.params
    }
    if(params.tipo){
        app.mod=params.tipo
    }else{
        app.mod='vn'
    }
    sweg.loadBack(jsonData, params.tipo)
    let nom=params.n.replace(/_/g, ' ')
    let vd=params.d
    let vm=params.m
    let va=params.a
    let vh=params.h
    let vmin=params.min
    let vgmt=params.gmt
    let vlon=params.lon
    let vlat=params.lat
    let vCiudad=params.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''

    //Seteando datos globales de mapa energético
    app.currentDateBack= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
    //console.log('2 main.loadJson('+file+'): '+app.currentDate.toString())

    //getCmdData.getData(vd, vm, va, vh, vmin, vlon, vlat, 0, vgmt)
    app.currentNomBack=nom
    app.currentFechaBack=vd+'/'+vm+'/'+va
    app.currentLugarBack=vCiudad
    app.currentGmtBack=vgmt
    app.currentLonBack=vlon
    app.currentLatBack=vlat

    addTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)
    //xDataBar.titleData=textData
    xDataBar.state='show'
    //if(params.tipo==='trans')xDataStatusBar.currentIndex=2
    app.setFromFile=false
}

function mkSinFile(file){
    let jsonFileDataInterior=app.fileData
    let json=JSON.parse(jsonFileDataInterior)
    let jsonFileDataExt=unik.getFile(file).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileDataExt)
    json.params.tipo='sin'
    json.paramsBack=jsonExt.params
    json.paramsBack.tipo='sin'
    json.paramsBack.n='Sinastría '+json.params.n+' - '+json.paramsBack.n

    let cNom=json.paramsBack.n
    let nFileName=(apps.jsonsFolder+'/'+cNom+'.json').replace(/ /g,'_')
    let e=unik.fileExist(nFileName)
    if(e){
        //log.l('Existe')
        loadJson(nFileName)
    }else{
        //log.l('No Existe')
        unik.setFile(nFileName, JSON.stringify(json))
        xEditor.visible=true
        loadJson(nFileName)
    }
}
function mkRsFile(file){
    let jsonFileDataInterior=app.fileData
    let json=JSON.parse(jsonFileDataInterior)
    let jsonFileDataExt=JSON.stringify(JSON.parse(app.currentDataBack))//unik.getFile(file).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileDataExt)
    log.ls('jsonExt: '+jsonFileDataExt, 0, log.width)
    json.params.n='Rev. Solar de '+json.params.n+' - Año '+jsonExt.paramsBack.a
    json.params.tipo='rs'
    json.paramsBack={}
    json.paramsBack=jsonExt.paramsBack
    json.paramsBack.tipo='rs'
    json.paramsBack.n=json.params.n

    let cNom=json.params.n
    let nFileName=(apps.jsonsFolder+'/'+cNom+'.json').replace(/ /g,'_')
    log.ls('nFileName: '+nFileName, 0, log.width)
    let e=unik.fileExist(nFileName)
    if(e){
        log.l('Existe')
        loadJson(nFileName)
    }else{
        log.l('No Existe')
        unik.setFile(nFileName, JSON.stringify(json))
        xEditor.visible=true
        loadJson(nFileName)
    }
}
function mkTransFile(){
    let jsonFileDataInterior=app.fileData
    let json=JSON.parse(jsonFileDataInterior)
    let jsonFileDataExt=JSON.stringify(JSON.parse(app.currentDataBack))//unik.getFile(file).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileDataExt)
    if(app.dev)log.lv('jsonExt: '+JSON.stringify(jsonExt))
    json.params.n=json.params.n+' - '+jsonExt.params.n
    if(app.dev)log.lv('json.params.n: '+json.params.n)
    json.params.tipo='trans'
    if(json.params[app.stringRes+'zoompos']){
        delete json.params[app.stringRes+'zoompos']
    }
    json.paramsBack={}
    json.paramsBack=jsonExt.params//Back
    json.paramsBack.tipo='trans'
    json.paramsBack.n=json.params.n

    let cNom=json.params.n
    let nFileName=(apps.jsonsFolder+'/'+cNom+'.json').replace(/ /g,'_')
    log.lv('nFileName: '+nFileName)
    let e=unik.fileExist(nFileName)
    if(e){
        log.l('Existe')
        loadJson(nFileName)
    }else{
        log.l('No Existe')
        unik.setFile(nFileName, JSON.stringify(json))
        xEditor.visible=true
        loadJson(nFileName)
    }
}

function loadRs(date, gmt, lat, lon, alt){
    /*let cd=date
    cd = cd.setFullYear(date.getFullYear())
    let cd2=new Date(cd)
    cd2 = cd2.setDate(cd2.getDate() - 1)
    let cd3=new Date(cd2)
    let hsys=apps.currentHsys
    let ad=getADate(cd3)*/

    let nDateNow= new Date(Date.now())

    let nDate= new Date(date)
    let dia=nDate.getDate()
    let mes=nDate.getMonth() + 1
    let anio=nDate.getFullYear()
    let hora=nDate.getHours()
    let minuto=nDate.getMinutes()


    let ad=getADate(nDate)
    //log.ls('nDate:'+ad.toString(), 0, 500)
    setTitleDataTo1()
    xDataStatusBar.currentIndex=1
    //loadFromArgsBack(ad[0], ad[1], ad[2], ad[3], ad[4], app.currentGmt, app.currentLat, app.currentLon, app.currentAlt, app.currentNom, app.currentLugar, 'rs', false)
    loadFromArgsBack(ad[0], ad[1], ad[2], ad[3], ad[4], gmt, lat, lon, alt, app.currentNom, app.currentLugar, 'rs', false)
}
function runJsonTemp(){
    var jsonData
    try
    {
        jsonData=JSON.parse(app.currentData)
    }
    catch (e)
    {
        console.log('Json Fallado: '+app.currentData)
        log.lv('Ha fallado la carga del archivo '+apps.url)
        log.lv('Error de Json.parse(): '+e)
        //log.ls(JSON.stringify(JSON.parse(app.currentData), null, 2), 0, xApp.width)
        //unik.speak('Error in Json file')
        return
    }

    let nom=jsonData.params.n.replace(/_/g, ' ')
    let vd=jsonData.params.d
    let vm=jsonData.params.m
    let va=jsonData.params.a
    let vh=jsonData.params.h
    let vmin=jsonData.params.min
    let vgmt=app.currentGmt
    let vlon=jsonData.params.lon
    let vlat=jsonData.params.lat
    let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    if(jsonData.params.tipo==='pron')numEdad=0
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''
    app.currentFecha=vd+'/'+vm+'/'+va
    //xDataBar.state='show'
    sweg.load(jsonData)
    //swegz.sweg.load(jsonData)
}
function runJsonTempBack(){
    var jsonData
    //let jss=app.currentDataBack.replace(/\n/g, '')
    let jss=app.currentData.replace(/\n/g, '')
    try
    {
        jsonData=JSON.parse(jss)
    }catch(e){
        console.log('Json Fallado: '+app.currentDataBack)
        if(app.dev){
            log.lv('Ha fallado la carga del archivo BACK '+apps.url)
            log.lv(JSON.stringify(JSON.parse(app.currentDataBack), null, 2))
        }
        //unik.speak('Error in Json file')
        return
    }

    let params
    if(jsonData.paramsBack){
        params=jsonData.paramsBack
    }else{
        params=jsonData.params
    }
    if(params.tipo==='vn'){
        if(app.dev)log.lv('No se carga params back porque es tipo VN.')
        return
    }
    let nom=params.n.replace(/_/g, ' ')
    let vd=params.d
    let vm=params.m
    let va=params.a
    let vh=params.h
    let vmin=params.min
    let vgmt=app.currentGmt
    let vlon=params.lon
    let vlat=params.lat
    let vCiudad=params.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''

    app.currentFechaBack=vd+'/'+vm+'/'+va
    //xDataBar.state='show'
    sweg.loadBack(jsonData, params.tipo)
    //app.currentDateBack=new Date(vd, vm, va, vh, vmin)
    //swegz.sweg.load(jsonData)
}
function setNewTimeJsonFileData(date){
    let jsonData=JSON.parse(app.fileData)
    //console.log('json: '+JSON.stringify(jsonData))
    //console.log('json2: '+jsonData.params)
    let d = new Date(Date.now())
    let ms=jsonData.params.ms
    let nom=jsonData.params.n.replace(/_/g, ' ')

    console.log('Date: '+date.toString())
    let vd=date.getDate()
    let vm=date.getMonth()+1
    let va=date.getFullYear()
    let vh=date.getHours()
    let vmin=date.getMinutes()

    let vgmt=app.currentGmt
    let vlon=jsonData.params.lon
    let vlat=jsonData.params.lat
    let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
    let vZoomAndPos={}
    let j='{'
    j+='"params":{'
    j+='"tipo":"'+app.mod+'",'
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

    let json=JSON.parse(j)
    if(jsonData[app.stringRes+'zoompos']){
        json[app.stringRes+'zoompos']=jsonData[app.stringRes+'zoompos']
    }
    if(jsonData.rots){
        json.rots=jsonData.rots
    }

    app.currentData=JSON.stringify(json)
    //console.log('j: '+j)
    //console.log('fd: '+app.fileData)
}
function setNewTimeJsonFileDataBack(date){
    //log.l('app.fileDataBack: '+app.fileDataBack)
    //log.visible=true
    //log.width=xApp.width*0.2
    //log.ls('setNewTimeJsonFileDataBack(date): '+date, 0, 500)
    //log.ls('app.fileDataBack: '+app.fileDataBack, 0, 500)
    if(app.fileDataBack===''&&app.dev){
        if(app.dev)log.lv('app.fileDataBack is empty.')
        return
    }
    let jsonData=JSON.parse(app.fileDataBack)
    //console.log('json: '+JSON.stringify(jsonData))
    //console.log('json2: '+jsonData.params)
    let d = new Date(Date.now())
    let params
    if(jsonData.paramsBack){
        params=jsonData.paramsBack
    }else{
        params=jsonData.params
    }
    let ms=params.ms
    let nom=params.n.replace(/_/g, ' ')

    console.log('Date: '+date.toString())
    let vd=date.getDate()
    let vm=date.getMonth()+1
    let va=date.getFullYear()
    let vh=date.getHours()
    let vmin=date.getMinutes()

    let vgmt=app.currentGmtBack
    let vlon=params.lon
    let vlat=params.lat
    let vCiudad=params.ciudad.replace(/_/g, ' ')
    let j='{'
    j+='"params":{'
    j+='"tipo":"'+app.mod+'",'
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
    //    log.l('cjb:'+app.currentDataBack)
    //    log.width=xApp.width*0.2
    //    log.visible=true
    //console.log('j: '+j)
    //console.log('fd: '+app.fileData)
}
function saveJson(){
    app.fileData=app.currentData
    let jsonFileName=apps.url
    let json=JSON.parse(app.fileData)
    if(unik.fileExist(apps.url.replace('file://', ''))){
        let dataModNow=new Date(Date.now())
        json.params.msmod=dataModNow.getTime()
    }
    unik.setFile(jsonFileName, JSON.stringify(json))
    loadJson(apps.url)
}
function saveJsonBack(){
    app.fileData=app.currentData
    let json=JSON.parse(app.currentData)
    json.params.tipo='rs'
    //log.ls('app.currentDataBack: '+app.currentDataBack, 0, 500)
    //json['paramsBack']={}
    let pb=JSON.parse(app.currentDataBack)
    json['paramsBack']={}=pb.paramsBack
    if(unik.fileExist(apps.url.replace('file://', ''))){
        let dataModNow=new Date(Date.now())
        json.params.msmod=dataModNow.getTime()
    }
    log.ww=false
    log.ls('app.fileData: '+JSON.stringify(json), 0, 500)
    let jsonFileName=apps.jsonsFolder+'/'+(''+pb.paramsBack.n).replace(/ /g, '_')+'.json'
    apps.url=jsonFileName
    log.ls('apps.url: '+apps.url, 0, 500)
    unik.setFile(jsonFileName, JSON.stringify(json))
    //loadJson(apps.url)
}
function saveJsonAs(newUrl){
    app.fileData=app.currentData
    let jsonFileName=newUrl
    unik.setFile(jsonFileName, app.currentData)
    if(unik.fileExist(jsonFileName)){
        unik.deleteFile(apps.url)
        apps.url=newUrl
        loadJson(apps.url)
    }
}
function deleteJsonBackHidden(){
    if(app.dev)log.lv('JSON.parse(app.fileData).paramsBack: '+JSON.parse(app.fileData).paramsBack)
    let json=JSON.parse(app.fileData)
    if(app.dev)log.lv('deleteJsonBackHidden() app.currentData: '+JSON.stringify(json.params, null, 2))
    if(app.dev&&json.paramsBack){
        log.lv('deleteJsonBackHidden() app.fileData: '+JSON.stringify(json.paramsBack, null, 2))
    }
    delete json['paramsBack'];
    let fp=(''+apps.url).replace('file://', '')
    unik.setFile(fp, JSON.stringify(json))
    loadJson(apps.url)
}
function loadJsonNow(file){
    let fn=file
    let jsonFileName=fn
    let jsonFileData=unik.getFile(jsonFileName).replace(/\n/g, '')
    //console.log('main.loadJson('+file+'):'+jsonFileData)

    let json=JSON.parse(jsonFileData)
    let d=new Date(Date.now())
    let o=json.params
    o.ms=d.getTime()
    o.d=d.getDate()
    o.m=d.getMonth()
    o.a=d.getFullYear()
    o.h=d.getHours()
    o.min=d.getMinutes()
    o.n=(o.n+' '+o.d+'-'+o.m+'-'+o.a+'-'+o.h+':'+o.min).replace(/Ahora/g, '').replace(/ahora/g, '')
    json.params=o
    sweg.loadSign(json)
    //swegz.sweg.loadSign(json)
    let nom=o.n.replace(/_/g, ' ')
    let vd=o.d
    let vm=o.m
    let va=o.a
    let vh=o.h
    let vmin=o.min
    let vgmt=o.gmt
    let vlon=o.lon
    let vlat=o.lat
    let vCiudad=o.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''

    //    textData=''
    //            +'<b>'+nom+'</b> '
    //            +''+vd+'/'+vm+'/'+va+' '+vh+':'+vmin+'hs GMT '+vgmt+stringEdad+' '
    //            +'<b> Edad:</b>'+getEdad(vd, vm, va, vh, vmin)+' '
    //            +'<b> '+vCiudad+'</b> '
    //            +'<b>lon:</b> '+vlon+' <b>lat:</b> '+vlat+' '

    setTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, mod)

    //Seteando datos globales de mapa energético
    app.currentDate= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
    //console.log('2 main.loadJson('+file+'): '+app.currentDate.toString())

    //getCmdData.getData(vd, vm, va, vh, vmin, vlon, vlat, 0, vgmt)
    app.currentNom=nom
    app.currentFecha=vd+'/'+vm+'/'+va
    app.currentGmt=vgmt
    app.currentLon=vlon
    app.currentLat=vlat

    xDataBar.fileData=textData
    xDataBar.state='show'
    app.currentData=app.fileData
    app.fileData=jsonFileData
}
function setTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, mod){
    //mod 0=cn, mod 1=rs

    let numEdad=getEdad(vd, vm, va, vh, vmin)//getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringTiempo=''
    //console.log('Edad: '+numEdad)
    if(mod===0){
        stringTiempo='<b> Edad:</b>'+getEdad(vd, vm, va, vh, vmin)+' '
    }else if(mod===2){
        stringTiempo=''
    }else{
        let nAnio=Math.abs(getEdadRS(vd, vm, va, vh, vmin))
        stringTiempo='<b> Edad:</b> '+nAnio+' años '
    }
    let a=[]
    a.push('<b>'+nom+'</b>')
    a.push(vd+'/'+vm+'/'+va)
    a.push(vh+':'+vmin+'hs')
    a.push('GMT '+vgmt)
    a.push(stringTiempo)
    a.push('<b> '+vCiudad+'</b>')
    a.push('<b>lat:</b> '+parseFloat(vlat).toFixed(2))
    a.push('<b>lon:</b> '+parseFloat(vlon).toFixed(2))
    xDataBar.at=a
    zoolDataView.setDataView('', a, [])
}
function addTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, mod){
    //mod 0=cn, mod 1=rs

    let numEdad=getEdad(vd, vm, va, vh, vmin)//getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringTiempo=''
    //console.log('Edad: '+numEdad)
    if(mod===0){
        stringTiempo='<b> Edad:</b>'+getEdad(vd, vm - 1, va, vh, vmin)+' '
    }else if(mod===2){
        stringTiempo=''
    }else{
        let nAnio=Math.abs(getEdadRS(vd, vm - 1, va, vh, vmin))
        stringTiempo='<b> Edad:</b> '+nAnio+' años '
    }
    let a=[]
    //a.push('@')
    let ni=0
    if(xDataBar.at[0]==='@'){
        ni=1
    }
    a.push(xDataBar.at[ni])
    a.push(xDataBar.at[ni+1])
    a.push(xDataBar.at[ni+2])
    a.push(xDataBar.at[ni+3])
    a.push(xDataBar.at[ni+4])
    a.push(xDataBar.at[ni+5])
    a.push(xDataBar.at[ni+6])
    a.push(xDataBar.at[ni+7])
    a.push('@')
    let sTipo='Sinastría'
    if(app.mod==='trans')sTipo='Tránsitos'
    a.push('Exterior: <b>'+nom+'</b>')
    a.push(vd+'/'+vm+'/'+va)
    a.push(vh+':'+vmin+'hs')
    a.push('GMT '+vgmt)
    a.push(stringTiempo)
    a.push('<b> '+vCiudad+'</b>')
    a.push('<b>lat:</b> '+parseFloat(vlat).toFixed(2))
    a.push('<b>lon:</b> '+parseFloat(vlon).toFixed(2))
    xDataBar.at=a
    zoolDataView.setDataView('', a, [])
}

function setTitleDataRs(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon){
    let numEdad=getEdad(vd, vm, va, vh, vmin)//getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringTiempo=''
    //console.log('Edad: '+numEdad)
    if(mod===0){
        stringTiempo='<b> Edad:</b>'+getEdad(vd, vm - 1, va, vh, vmin)+' '
    }else if(mod===2){
        stringTiempo=''
    }else{
        let nAnio=Math.abs(getEdadRS(vd, vm - 1, va, vh, vmin))
        stringTiempo='<b> Edad:</b> '+nAnio+' años '
    }
    let a=[]
    a.push('@')
    let ni=0
    if(xDataBar.at[0]==='@'){
        ni=1
    }
    //a.push(xDataBar.at[ni])
    a.push(xDataBar.at[ni+1])
    a.push(xDataBar.at[ni+2])
    a.push(xDataBar.at[ni+3])
    a.push(xDataBar.at[ni+4])
    a.push(xDataBar.at[ni+5])
    a.push(xDataBar.at[ni+6])
    a.push(xDataBar.at[ni+7])
    a.push('@')
    a.push('Exterior')
    a.push(vd+'/'+vm+'/'+va)
    a.push(vh+':'+vmin+'hs')
    a.push('GMT '+vgmt)
    a.push(stringTiempo)
    a.push('<b> '+vCiudad+'</b>')
    a.push('<b>lat:</b> '+parseFloat(vlat).toFixed(2))
    a.push('<b>lon:</b> '+parseFloat(vlon).toFixed(2))
    xDataBar.at=a
    zoolDataView.setDataView(app.tipo, a, [])

    let aR=[]
    aR.push('Exterior')
    aR.push(vd+'/'+vm+'/'+va)
    aR.push(vh+':'+vmin+'hs')
    aR.push('GMT '+vgmt)
    aR.push(stringTiempo)
    aR.push('<b> '+vCiudad+'</b>')
    aR.push('<b>lat:</b> '+parseFloat(vlat).toFixed(2))
    aR.push('<b>lon:</b> '+parseFloat(vlon).toFixed(2))
    zoolDataView.setDataView(app.tipo, a, aR)
}

function setTitleDataTo1(){
    let jsonData=app.currentData
    let json=JSON.parse(jsonData)
    let nom=json.params.n.replace(/_/g, ' ')
    let vd=json.params.d
    let vm=json.params.m
    let va=json.params.a
    let vh=json.params.h
    let vmin=json.params.min
    let vgmt=json.params.gmt
    let vlon=json.params.lon
    let vlat=json.params.lat
    let vCiudad=json.params.ciudad.replace(/_/g, ' ')
    let edad=''
    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    setTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)
}
//Funciones de Internet
function getRD(url, item){//Remote Data
    var request = new XMLHttpRequest()
    request.open('GET', url, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                /*let d=request.responseText
                if(d.indexOf('redirected')>=0&&d.indexOf('</html>')>=0){
                    let m0=d.split('</html>')
                     item.setData(m0[1], true)
                }else{
                     item.setData(d, true)
                }*/
                item.setData(parseRetRed(request.responseText), true)
            } else {
                item.setData("Url: "+url+" Status:"+request.status+" HTTP: "+request.statusText, false)
            }
        }
    }
    request.send()
}
function parseRetRed(d){
    if(d.indexOf('redirected')>=0&&d.indexOf('</html>')>=0){
        let m0=d.split('</html>')
        return m0[1]
    }else{
        return d
    }
}
function getADate(date){
    let d=date.getDate()
    let m=date.getMonth() + 1
    let a=date.getFullYear()
    let h=date.getHours()
    let min=date.getMinutes()
    return [d, m, a, h, min]
}
//Funciones de GUI
function showMsgDialog(title, text, itext){
    let c='import QtQuick 2.0\n'
        +'import QtQuick.Dialogs 1.1\n'
        +'MessageDialog {\n'
        +'      visible: true\n'
        +'       title: "'+title+'"\n'
        +'      standardButtons:  StandardButton.Close\n'
        +'      icon: StandardIcon.Information\n'
        +'     text: "                   '+text+'                  "\n'
        +'     informativeText: "'+itext+'"\n'
        +'    onAccepted: {\n'
        +'       close()\n'
        +'   }\n'
        +'}\n'
    console.log(c)
    let comp=Qt.createQmlObject(c, app, 'codeshowMsgDialog')
}
function raiseItem(item){
    let z=0
    for(let i=0;i<item.parent.children.length;i++){
        //console.log('id:'+item.parent.children[i].objectName)
        if(item.parent.children[i]!==item&&item.parent.children[i].objectName!=='swegzcontainer'){
            item.parent.children[i].state='hide'
        }
    }
    item.state='show'
}

//Funciones SWEG
function saveZoomAndPos(){
    if(app.currentPlanetIndex>=0&&app.currentXAs){
        if(app.currentPlanetIndex===15||app.currentPlanetIndex===16){
            if(app.currentPlanetIndex===16){
                app.currentXAs.saveZoomAndPos('mc')
            }
            if(app.currentPlanetIndex===15){
                app.currentXAs.saveZoomAndPos('asc')
            }
        }else{
            app.currentXAs.saveZoomAndPos()
        }
        //Cap.captureSweg()
        return
    }
    if(app.currentPlanetIndexBack>=0&&app.currentXAsBack){
        if(app.currentPlanetIndexBack===16||app.currentPlanetIndexBack===15){
            if(app.currentPlanetIndexBack===16){
                app.currentXAs.saveZoomAndPos('mcBack')
            }
            if(app.currentPlanetIndexBack===15){
                app.currentXAsBack.saveZoomAndPos('ascBack')
            }
        }else{
            app.currentXAsBack.saveZoomAndPos()
        }
        //Cap.captureSweg()
        return
    }
}

//Numerologia
function getNums(fecha){
    let d=''
    let nf=0
    let nf10=false
    let f=fecha
    let m0=f.split('/')
    let m1=m0[0].split('')
    let m2=m0[1].split('')
    let m3=m0[2].split('')
    nf+=parseInt(m1[0])
    if(m1.length>1){
        nf+=parseInt(m1[1])
    }
    nf+=parseInt(m2[0])
    if(m2.length>1){
        nf+=parseInt(m2[1])
    }
    nf+=parseInt(m3[0])
    if(m3.length>3){
        nf+=parseInt(m3[1])
        nf+=parseInt(m3[2])
        nf+=parseInt(m3[3])
    }
    if(nf===10)nf10=true
    if(nf>9&&nf!==11&&nf!==22&&nf!==33&&nf!==44){
        let m4=(''+nf).split('')
        let nnf=parseInt(m4[0])
        if(m4.length>1){
            nnf+=parseInt(m4[1])
        }
        nf=nnf
    }
    d=''+parseInt(m0[0])
    if(parseInt(m0[0])>9){
        let m5=d.split('')
        let nfd=parseInt(m5[0])
        if(m5.length>1){
            nfd+=parseInt(m5[1])
        }
        d+='-'+nfd
    }
    if(nf===10)nf10=true
    if(nf>9){
        let m6=(''+nf).split('')
        let nnf6=parseInt(m6[0])
        if(m6.length>1){
            nnf6+=parseInt(m6[1])
        }
        nf=nnf6
    }
    let numArbolGen=-1
    if(!nf10){
        if(nf===1||nf===6||nf===8)numArbolGen=0
        if(nf===2||nf===5||nf===9)numArbolGen=1
        if(nf===3||nf===4)numArbolGen=2
        if(nf===7)numArbolGen=3
    }else{
        numArbolGen=2
    }
    return [nf, d, numArbolGen]
}

//Modules
function loadModules(){
    let d='{"modules":['

    d+='{"enabled": true, "name":"Contexto de Namimiento", "url": "https://github.com/nextsigner/ZoolCtxNac.git"}'
    d+=',{"enabled": false, "name":"Modulo inexistente", "url": "https://github.com/nextsigner/inexistente.git"}'

    d+=']}'
    let jsonFileData=d
    let json=JSON.parse(jsonFileData)
    for(var i=0;i<json.modules.length;i++){
        if(json.modules[i].enabled){
            //log.ls('Modules: '+json.modules[i].name, 0, 500)
            let url=json.modules[i].url
            let f=(''+url.split('/')[url.split('/').length - 1]).replace('.git', '')
            //let folder=unik.getPath(5)+'/modules'//+f
            let folder=unik.getPath(4)+'/modules'//+f
            //log.ls('Modules Folder: '+folder, 0, 500)
            if(!unik.folderExist(folder)){
                unik.mkdir(folder)
                //let download=unik.downloadGit(url, folder)
                //log.ls('Modules Folder not exist making: '+folder, 0, 500)
            }else{
                //log.ls('Modules Folder exist: '+folder, 0, 500)
            }
            //loadModule(f)
            //            let download=unik.downloadGit(url, folder)
            //            if(download){
            //                loadModule(f)
            //            }
            loadModule(f)
        }else{
            //log.ls('Modules disabled: '+json.modules[i].name, 0, 500)
        }
    }
}
function loadModule(module){
    //log.ls('loadModule('+folder+')...', 0, xLatIzq.width)
    //engine.addImportPath(unik.getPath(4)+'/modules/'+folder);
    let c='import QtQuick 2.0\n'
    //c+='import "'+unik.currentFolderPath()+'/zool-modules/'+folder+'" as Module\n'
    //c+='import "'+unik.getPath(4)+'/modules/'+folder+'" as Module\n'
    //c+='import "'+unik.getPath(4)+'/modules/'+folder+'" as Module\n'
    //c+='import "'+unik.getPath(4)+'/modules/'+folder+'" as Module\n'
    c+='import '+module+' 1.0\n'
    c+='Item{\n'
    c+='    '+module+'{}\n'
    c+='}\n'
    //log.ls('code: '+c, 0, xLatIzq.width)
    let comp=Qt.createQmlObject(c, xApp, 'loadmodule')
    //log.ls('L1104 Funcs.js Current Path: '+unik.currentFolderPath(), 0, xApp.width*0.2)
}
