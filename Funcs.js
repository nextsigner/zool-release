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

//Funciones de Cargar Datos Interior
function loadFromArgs(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, save){
    app.ev=false
    apps.urlBack=''
    let dataMs=new Date(Date.now())
    let j='{"params":{"tipo":"'+tipo+'","ms":'+dataMs.getTime()+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"alt":'+alt+',"ciudad":"'+ciudad+'"}}'
    setTitleData(nom, d, m, a, h, min, gmt, ciudad, lat, lon, 1)
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
    runJsonTemp()
}

//Funciones de Cargar Datos Exterior
function loadFromArgsBack(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, save){
    app.ev=true
    let dataMs=new Date(Date.now())
    let j='{"params":{"tipo":"'+tipo+'","ms":'+dataMs.getTime()+',"n":"'+nom+'","d":'+d+',"m":'+m+',"a":'+a+',"h":'+h+',"min":'+min+',"gmt":'+gmt+',"lat":'+lat+',"lon":'+lon+',"alt":'+alt+',"ciudad":"'+ciudad+'"}}'
    app.mod=tipo
    //setTitleData(nom, d, m, a, h, min, gmt, ciudad, lat, lon, 1)
    addTitleData(nom, d, m, a, h, min, gmt, ciudad, lat, lon, 1)
    if(save){
        let fn=apps.jsonsFolder+'/'+nom.replace(/ /g, '_')+'.json'
        console.log('loadFromArgs('+d+', '+m+', '+a+', '+h+', '+min+', '+gmt+', '+lat+', '+lon+', '+alt+', '+nom+', '+ciudad+', '+save+'): '+fn)
        unik.setFile(fn, j)
        loadJsonBack(fn)
        return
    }
    //xDataBar.state='show'
    //xDataBar.opacity=1.0
    //app.currentData=j
    //    log.l('loadFromArgsBack: '+j)
    //    log.visible=true
    //    log.width=xApp.width*0.2
    app.currentDataBack=j
    runJsonTempBack()
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
    app.currentPlanetIndex=-1
    app.currentSignIndex= 0
    app.currentNom= ''
    app.currentFecha= ''
    app.currentGradoSolar= -1
    app.currentMinutoSolar= -1
    app.currentSegundoSolar= -1
    app.currentGmt= 0.0
    app.currentLon= 0.0
    app.currentLat= 0.0
    app.uSon=''
    panelControlsSign.state='hide'
    apps.showAspPanelBack=false
    app.ev=false
    apps.urlBack=''
    apps.showAspPanelBack=false
    apps.showAspCircleBack=false

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
        sweg.load(jsonData)
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
    app.currentDate= new Date(parseInt(va), parseInt(vm) - 1, parseInt(vd), parseInt(vh), parseInt(vmin))
    //console.log('2 main.loadJson('+file+'): '+app.currentDate.toString())

    //getCmdData.getData(vd, vm, va, vh, vmin, vlon, vlat, 0, vgmt)
    app.currentNom=nom
    app.currentFecha=vd+'/'+vm+'/'+va
    app.currentLugar=vCiudad
    app.currentGmt=vgmt
    app.currentLon=vlon
    app.currentLat=vlat

    setTitleData(nom, vd, vm, va, vh, vmin, vgmt, vCiudad, vlat, vlon, 0)

    if(jsonData.params.tipo==='sin'){
        nom=jsonData.paramsBack.n.replace(/_/g, ' ')
        vd=jsonData.paramsBack.d
        vm=jsonData.paramsBack.m
        va=jsonData.paramsBack.a
        vh=jsonData.paramsBack.h
        vmin=jsonData.paramsBack.min
        vgmt=jsonData.paramsBack.gmt
        vlon=jsonData.paramsBack.lon
        vlat=jsonData.paramsBack.lat
        let valt=0
        if(jsonData.paramsBack.alt){
            valt=jsonData.paramsBack.alt
        }
        vCiudad=jsonData.paramsBack.ciudad.replace(/_/g, ' ')
        //let edad=''
        //numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh), parseInt(vmin))
        //let stringEdad=edad.indexOf('NaN')<0?edad:''

        loadFromArgsBack(vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, nom, vCiudad, 'sin', false)
        //log.l('Cargando sinastría...')
        //log.visible=true
    }
    //xDataBar.titleData=textData
    xDataBar.state='show'
    app.setFromFile=false
}
function loadJsonBack(file){
    //Global Vars Reset
    app.setFromFile=true
    //apps.enableFullAnimation=false
    app.currentPlanetIndexBack=-1
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
    panelControlsSign.state='hide'
    app.ev=true

    apps.urlBack=file
    let fn=apps.urlBack
    let jsonFileName=fn
    let jsonFileData=unik.getFile(jsonFileName).replace(/\n/g, '')
    app.fileDataBack=jsonFileData
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
        sweg.loadBack(jsonData)
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
    app.setFromFile=false
}
function loadJsonFromParamsBack(json){
    //Global Vars Reset
    app.setFromFile=true
    //apps.enableFullAnimation=false
    app.currentPlanetIndexBack=-1
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
    panelControlsSign.state='hide'

    //apps.urlBack=file
    app.fileDataBack=JSON.stringify(json)
    //app.currentJsonBack=app.fileDataBack
    let jsonData=json
    if(jsonData.params.tipo){
        app.mod=jsonData.params.tipo
    }else{
        app.mod='vn'
    }
    sweg.loadBack(jsonData)
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
    app.setFromFile=false
}

function mkSinFile(file){
    let jsonFileDataInterior=app.fileData
    let jsonInt=JSON.parse(jsonFileDataInterior)
    let fn=file
    let jsonFileName=fn
    let jsonFileData=unik.getFile(jsonFileName).replace(/\n/g, '')
    let jsonExt=JSON.parse(jsonFileData)
    jsonInt.tipo='sin'
    jsonExt.tipo='sin'
    let nJson=jsonInt
    nJson.paramsBack=jsonExt.params
    nJson.params.tipo='sin'
    nJson.params.n='Sinastría '+nJson.params.n+' - '+nJson.paramsBack.n
    nJson.paramsBack.tipo='sin'
    let sf=JSON.stringify(nJson)
    //log.l(sf)

    let nFileName=(apps.jsonsFolder+'/Sinastría_'+jsonInt.params.n+'_-_'+jsonExt.params.n+'.json').replace(/ /g,'_')
    //log.l(nFileName)
    let e=unik.fileExist(nFileName)
    if(e){
        //log.l('Existe')
        loadJson(nFileName)
    }else{
        //log.l('No Existe')
        unik.setFile(nFileName, sf)
        xEditor.visible=true
        loadJson(nFileName)
    }
    //log.visible=true
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
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''
    app.currentFecha=vd+'/'+vm+'/'+va
    //xDataBar.state='show'
    sweg.load(jsonData)
    //swegz.sweg.load(jsonData)
}
function runJsonTempBack(){
    var jsonData
    try
    {
        jsonData=JSON.parse(app.currentDataBack)
    }
    catch (e)
    {
        console.log('Json Fallado: '+app.currentDataBack)
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
    let stringEdad=edad.indexOf('NaN')<0?edad:''
    let textData=''




    app.currentFechaBack=vd+'/'+vm+'/'+va
    //xDataBar.state='show'
    sweg.loadBack(jsonData)
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
    if(jsonData.zoompos){
        json.zoompos=jsonData.zoompos
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
    let jsonData=JSON.parse(app.fileDataBack)
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

    let vgmt=app.currentGmtBack
    let vlon=jsonData.params.lon
    let vlat=jsonData.params.lat
    let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
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
    unik.setFile(jsonFileName, app.currentData)
    loadJson(apps.url)
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
    a.push('@')
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
    a.push('Exterior: <b>'+sTipo+'</b>')
    a.push(vd+'/'+vm+'/'+va)
    a.push(vh+':'+vmin+'hs')
    a.push('GMT '+vgmt)
    a.push(stringTiempo)
    a.push('<b> '+vCiudad+'</b>')
    a.push('<b>lat:</b> '+parseFloat(vlat).toFixed(2))
    a.push('<b>lon:</b> '+parseFloat(vlon).toFixed(2))
    xDataBar.at=a
}
function setTitleDataTo1(){
    let jsonData=app.currentJson
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

    d+='{"enabled": true, "name":"Contexto de Namimiento", "url": "https://github.com/nextsigner/zool-ctx-nac.git"}'
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
                let download=unik.downloadGit(url, folder)
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
function loadModule(folder){
    //log.ls('loadModule('+folder+')...', 0, xLatIzq.width)
    //engine.addImportPath(unik.getPath(4)+'/modules/'+folder);
    let c='import QtQuick 2.0\n'
    //c+='import "'+unik.currentFolderPath()+'/zool-modules/'+folder+'" as Module\n'
    c+='import "./modules/'+folder+'" as Module\n'
    //c+='import "'++'" as Module\n'
    c+='Item{\n'
    c+='    Module.ModuleMain{}\n'
    c+='}\n'
    //log.ls('code: '+c, 0, xLatIzq.width)
    let comp=Qt.createQmlObject(c, xApp, 'loadmodule')
}
