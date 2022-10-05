function captureSweg(){
    let isDev=app.dev
    app.dev=false
    app.capturing=true
    let m0=apps.url.split('/')
    let folderName=m0[m0.length-1].replace('.json', '')
    let folder=apps.jsonsFolder+'/caps/'+folderName
    if(!unik.folderExist(folder)){
        unik.mkdir(folder)
    }
    let imgFileName='cap_'
    if(app.currentPlanetIndex>=0&&app.currentPlanetIndex<15){
        let json=app.currentJson
        let p=app.planetas[app.currentPlanetIndex]
        let s=json.pc['c'+app.currentPlanetIndex].is
        let h=json.pc['c'+app.currentPlanetIndex].ih

        imgFileName+=p+'_en_'
        imgFileName+='_'+app.signos[s]
        imgFileName+='_en_casa_'+parseInt(h + 1)
    }else if(app.currentPlanetIndex===15){
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
        app.capturing=false
        app.dev=isDev
    });
}
