var itemCap
function captureToPng(fileUrl, item, openInExternal){
    itemCap=item
    if(fileUrl!==''){
        app.c.savePng(fileUrl, openInExternal)
    }else{
        let c=''
        c+='import QtQuick 2.0\n'
        c+='import QtQuick.Dialogs 1.3\n'
        c+='    FileDialog {\n'
        c+='        id: fileDialog\n'
        //c+='        width: 800\n'
        //c+='        height: 500\n'
        c+='        modality: Qt.Window\n'
        c+='        folder: "'+unik.getPath(3)+'"\n'
        c+='        title: "Escribir el nombre del archivo de imagen."\n'
        c+='        selectExisting: false\n'
        c+='        nameFilters: ["Imagen PNG (*.png)"]\n'
        c+='        onAccepted: {\n'
        //c+='            log.lv(fileUrl)\n'
        c+='            app.c.savePng(fileUrl+".png")\n'
        c+='            fileDialog.destroy(10000)\n'
        c+='        }\n'
        c+='        onRejected: {\n'
        c+='            fileDialog.destroy(10000)\n'
        c+='        }\n'
        //c+='    }\n'
        c+='    Component.onCompleted:{\n'
        //c+='        log.lv("Capture!")\n'
        c+='        fileDialog.visible=true\n'
        c+='    }\n'
        c+='}\n'
        let obj=Qt.createQmlObject(c, app, 'itemCapturecode')
    }
}
function savePng(fileUrl, openInExternal){
    itemCap.grabToImage(function(result) {
        let fn=fileUrl
        fn=fn.replace('file://', '')
        result.saveToFile(fn);
        if(openInExternal)Qt.openUrlExternally(fileUrl)
        zm.capturing=false
    });
}
function captureSweg(){
    let d = new Date(Date.now())
    let dia=d.getDate()
    let mes=d.getMonth()+1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    let sCapDate='Fecha de Captura\n'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto
    capDate.text=sCapDate

    let isDev=apps.dev
    apps.dev=false
    zm.capturing=true
    let m0=apps.url.split('/')
    let folderName=m0[m0.length-1].replace('.json', '')
    let folder=apps.workSpace+'/caps/'+folderName
    if(!unik.folderExist(folder)){
        unik.mkdir(folder)
    }
    let imgFileName='cap_'
    if(app.currentPlanetIndex>=0&&app.currentPlanetIndex<20){
        let json=app.currentJson
        let p=app.planetas[app.currentPlanetIndex]
        let s=json.pc['c'+app.currentPlanetIndex].is
        let h=json.pc['c'+app.currentPlanetIndex].ih

        imgFileName+=p+'_en_'
        imgFileName+='_'+app.signos[s]
        imgFileName+='_en_casa_'+parseInt(h + 1)
    }else if(app.currentPlanetIndex===20){
        imgFileName+='_ascendente'
    }else if(app.currentPlanetIndex===16){
        imgFileName+='_medio_cielo'
    }else{
        imgFileName+='_carta'
    }
    imgFileName+='.png'
    //log.l('Nombre de archivo de imagen: '+imgFileName)
    xSwe1.grabToImage(function(result) {
        result.saveToFile(folder+"/"+imgFileName);
        zm.capturing=false
        apps.dev=isDev
    });
}

function captureSwegBack(){
    let isDev=apps.dev
    zm.capturing=true
    let m0=apps.url.split('/')
    let folderName=m0[m0.length-1].replace('.json', '')
    let folder=apps.workSpace+'/caps/'+folderName
    if(!unik.folderExist(folder)){
        unik.mkdir(folder)
    }
    let imgFileName='cap_'+app.t+'_'
    if(app.currentPlanetIndexBack>=0&&app.currentPlanetIndexBack<20){
        let json=app.currentJson
        let p=app.planetas[app.currentPlanetIndexBack]
        let s=json.pc['c'+app.currentPlanetIndexBack].is
        let h=json.pc['c'+app.currentPlanetIndexBack].ih

        imgFileName+=p+'_en_'
        imgFileName+='_'+app.signos[s]
        imgFileName+='_en_casa_'+parseInt(h + 1)
    }else if(app.currentPlanetIndex===20){
        imgFileName+='_ascendente'
    }else if(app.currentPlanetIndex===16){
        imgFileName+='_medio_cielo'
    }else{
        imgFileName+='_carta'
    }
    imgFileName+='.png'
    //log.l('Nombre de archivo de imagen: '+imgFileName)
    xSwe1.grabToImage(function(result) {
        result.saveToFile(folder+"/"+imgFileName);
        zm.capturing=false
        apps.dev=isDev
    });
}

function capturePlanet(){
    let d = new Date(Date.now())
    let dia=d.getDate()
    let mes=d.getMonth()+1
    let anio=d.getFullYear()
    let hora=d.getHours()
    let minuto=d.getMinutes()
    let sCapDate='Fecha de Captura\n'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto
    //capDate.text=sCapDate

    zm.capturing=true
    let params=zfdm.getJsonAbs().params
    let m0=apps.url.split('/')
    let folderName=m0[m0.length-1].replace('.json', '')
    let folder=unik.getPath(3)//apps.workSpace+'/caps/'+folderName

    let json=zm.currentJson

    let imgFileName='cap_'+(''+params.n).replace(/ /g, '_')+'_'
    if(zm.currentPlanetIndex>=0&&zm.currentPlanetIndex<20){

        let p=zm.aBodies[zm.currentPlanetIndex]
        let s=json.pc['c'+zm.currentPlanetIndex].is
        let h=json.pc['c'+zm.currentPlanetIndex].ih

        imgFileName+=p+'_en_'
        imgFileName+='_'+zm.aSigns[s]
        imgFileName+='_en_casa_'+parseInt(h + 1)
    }else if(zm.currentPlanetIndex===20){
        imgFileName+='_ascendente'
    }else if(zm.currentPlanetIndex===16){
        imgFileName+='_medio_cielo'
    }else{
        imgFileName+='_carta'
    }
    imgFileName+='.png'
    //log.l('Nombre de archivo de imagen: '+imgFileName)
    xSwe1.grabToImage(function(result) {
        result.saveToFile(folder+"/"+imgFileName);
        zm.capturing=false
    });
}
