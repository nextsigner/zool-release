import QtQuick 2.0

Item{
    id: r
    property string currentUrl: apps.url
    property var j: ({})
    property var ja: ({})

    //Retorna string con el contenido del archivo actual
    function getData(){
        //if(app.dev)log.lv('zfdm.getData( '+r.currentUrl+' )')
        return unik.getFile(r.currentUrl)
    }
    //Retorna json con el contenido del archivo actual
    function getJson(){
        return JSON.parse(getData())
    }
    //Devuelve booleano verdadero si existen parámetros back.
    function isParamsBack(){
        let b=false
            if(getJson().paramsBack){
                b=true
            }
        return b
    }
    //Retorna json con los parámetros front o back.
    function getJsonParams(isBack){
        let p
        if(isBack){
            p=getJson().paramsBack
        }
        p=getJson().params
        return p
    }
    //Carga archivo
    function loadFile(url){
        let ret=false
        r.currentUrl=url
        if(getData()==='error'){
            if(app.dev)log.lv(' Error de carga de archivo! zfdm.loadFile( '+url+' )')
            return ret
        }
        let j = getJson()
        if(!j){
            if(app.dev)log.lv(' Error carga y formato de archivo! zfdm.loadFile( '+url+' )')
            return ret
        }
        setJsonAbs(j)
        ret=true
        return ret
    }
    //-->Comienza Json Abstracto.
    function setJsonAbs(j){
        r.ja=j
    }
    function getJsonAbs(){
        return r.ja
    }
    function isAbsParamsBack(){
        let b=false
            if(r.ja.paramsBack){
                b=true
            }
        return b
    }
    function getJsonAbsParams(isBack){
        if(!isBack){
            return r.ja.params
        }
        if(isBack && !r.ja.paramsBack) return ({})
        return r.ja.paramsBack
    }
    //<--Finaliza Json Abstracto.


    //-->Administración de archivos
    function mkFileAndLoad(j){
        let r=true
        let mf=mkFile(j)
        if(mf[0]===true){
            app.j.loadJson(mf[1])
            return r
        }else{
            log.lv('Error al crear el archivo: '+mf[1])
            log.lv('El archivo: '+mf[1]+' no se ha cargado.')
            r=false
        }
        return r
    }
    function mkFile(j){
        let r=false
        let s=JSON.stringify(j)
        let fn=(''+app.j.quitarAcentos(j.params.n)).replace(/ /g, '_')
        fn=fn.replace(/\//g, '_')
        fn=fn.replace(/:/g, '_')
        let f=apps.jsonsFolder+'/'+fn+'.json'

        unik.setFile(f, s)
        if(unik.fileExist(f)){
            r=true
        }
        return [r, f]
    }
    //<--Administración de archivos

    //-->Get Json Data
    function getParam(p){
        return r.ja.params[''+p]
    }
    function getExts(){
        return r.ja.exts
    }
    function isExtId(extId){
        let ret=false
        let o=r.ja.exts
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId){
                ret=true
                break
            }
        }
        return ret
    }
    function addExtData(json){
        let o=r.ja.exts
        let nIndex=Object.keys(o).length
        o[nIndex]={}
        o[nIndex]=json
        if(app.dev)log.lv('adding ext data:'+JSON.stringify(r.ja, null, 2))
    }
    function getParamExt(p,i){
        return r.ja.exts[i][''+p]
    }
    function getExtData(extId){
        let ret={}
        let o=r.ja.exts
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId){
                ret=json
                break
            }
        }
        return ret
    }
    function saveExtToJsonFile(extId){
        //let jsonActual=
        let njson={}
        njson.params={}
        njson.params=r.ja.params
        njson.exts=[]
        //njson.exts=
        let o=r.ja.exts
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId || json.ms>=0){
                njson.exts[i]={}
                njson.exts[i].params={}
                njson.exts[i].params=o[i].params
            }
            if(njson.exts[i].params.ms<0){
                let d = new Date(Date.now())
                njson.exts[i].params.ms=d.getTime()
            }
        }
        if(app.dev)log.lv('saveExtToJsonFile( '+extId+'): Nuevo Json: '+JSON.stringify(njson, null, 2))
        return unik.setFile(apps.url, JSON.stringify(njson))
        //return r.ja.exts[i][''+p]
    }
    function deleteExtToJsonFile(extId){
        //let jsonActual=
        let njson={}
        njson.params={}
        njson.params=r.ja.params
        njson.exts=[]
        //njson.exts=
        let o=r.ja.exts
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId!==extId){
                njson.exts[i]={}
                njson.exts[i].params={}
                njson.exts[i].params=o[i].params
            }
        }
        if(app.dev)log.lv('deleteExtToJsonFile( '+extId+'): Nuevo Json: '+JSON.stringify(njson, null, 2))
        let seted=unik.setFile(apps.url, JSON.stringify(njson))
        let reLoaded=r.loadFile(apps.url)
        //if(seted)r.getJson()
        let allTaskReady=(seted && reLoaded)?true:false
        return allTaskReady
    }
    //<--Get Json Data
}
