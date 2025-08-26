import QtQuick 2.0

Item{
    id: r
    property string currentUrl: apps.url
    property var j: ({})
    property var ja: ({})
    property var jaExt: ({})

    //Retorna string con el contenido del archivo actual
    function getData(){
        //if(apps.dev)log.lv('zfdm.getData( '+r.currentUrl+' )')
        return u.getFile(r.currentUrl)
    }
    //Retorna json con el contenido del archivo actual
    function getJson(){
        return JSON.parse(getData())
    }
    //Retorna json con los parámetros interior o exterior.
    /*function getJsonParams(isExt){
        let p
        if(isExt){
            p=getJson().paramsBack
        }
        p=getJson().params
        return p
    }*/
    //Carga archivo
    function loadFile(url){
        //zpn.log('loadFile ('+url+')')
        let ret=false
        r.currentUrl=url
        if(getData()==='error'){
            if(apps.dev)log.lv(' Error de carga de archivo! zfdm.loadFile( '+url+' )')
            return ret
        }
        let j = getJson()
        if(!j){
            if(apps.dev)log.lv(' Error carga y formato de archivo! zfdm.loadFile( '+url+' )')
            return ret
        }
        setJsonAbs(j)
        ret=true
        return ret
    }
    //-->Comienza Json Abstracto.
    function setJsonAbs(j){
        let exts=j.exts
        if(!exts){
            j.exts=[]
        }
        r.ja=j
        //log.lv('r.ja: '+JSON.stringify(r.ja, null, 2))
    }
    function getJsonAbs(){
        return r.ja
    }
    function getJsonAbsExt(){
        return r.jaExt
    }
    function getJsonAbsParams(isBack){
        if(!isBack){
            return r.ja.params
        }
        //if(isBack && !r.ja.paramsBack) return ({})
        return r.jaExt.params
    }
    function setJsonAbsParams(params, isBack){
        if(!isBack){
            r.ja.params=params
        }
        if(isBack){
            r.jaExt.params=params
        }
    }
    //<--Finaliza Json Abstracto.


    //-->Administración de archivos
    function mkFileAndLoad(j, isTemp){
        let r=true
        let mf=mkFile(j, isTemp)
        if(mf[0]===true){
            if(apps.dev)log.lv('mkFileAndLoad(...) app.j.loadJson( '+mf[1]+')')
            //app.j.loadJson(mf[1])
            zm.loadJsonFromFilePath(mf[1])
            return r
        }else{
            log.lv('Error al crear el archivo: '+mf[1])
            log.lv('El archivo: '+mf[1]+' no se ha cargado.')
            r=false
        }
        return r
    }
    function mkFile(j, isTemp){
        let r=false
        let s=JSON.stringify(j)
        let fn=(''+app.j.quitarAcentos(j.params.n)).replace(/ /g, '_')
        fn=fn.replace(/\//g, '_')
        fn=fn.replace(/:/g, '_')
        let f=apps.workSpace+'/'+fn+'.json'
        if(isTemp){
            f=u.getPath(2)+'/temp.json'
        }

        u.setFile(f, s)
        if(u.fileExist(f)){
            r=true
            if(apps.enableShareInServer && j.params.shared){
                zsfdm.save(j)
            }
        }
        return [r, f]
    }
    //<--Administración de archivos

    //-->Get Json Data
    //    function getJson(){
    //        return r.ja
    //    }
    function saveJson(json){
        r.ja=json
        let saved = u.setFile(apps.url, JSON.stringify(r.ja, null, 2))
        if(saved){
            let njson=JSON.stringify(json)
            zm.fileData=njson
            zsm.getPanel('ZoolFileExtDataManager').updateList()
            if(apps.enableShareInServer){
                zsfdm.save(json)
            }
            return true
        }
        return false
    }
    function setFavoriteDataJson(url, f){
        let jsonData=u.getFile(url)
        let json=JSON.parse(jsonData)
        json.params.f=f
        let saved = u.setFile(url, JSON.stringify(json, null, 2))
        if(saved){
            return true
        }
        return false
    }
    function deleteCurrentJson(){
        let deleted = u.deleteFile(apps.url)
        zm.loadNow(false)
        if(apps.enableShareInServer){
            //zsfdm.save(json)
        }
    }
    function getParam(p){
        return r.ja.params[''+p]
    }
    function updateParams(params, save){
        let json=zfdm.getJson()
        json.params=params
        if(u.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        return saveJson(json)
    }
    function getExts(){
        let sd=u.getFile(apps.url)
        let json=JSON.parse(sd)
        return json.exts
        //let exts=[]
        //if(r.ja.exts)exts=r.ja.exts
        //return exts
    }
    function isExtId(extId){
        let ret=false
        let o=r.ja.exts
        if(!o)return ret
        for(var i=0;i<Object.keys(o).length;i++){
            let json=o[i].params
            if(json.extId===extId){
                ret=true
                break
            }
        }
        return ret
    }
    function addExtDataAndSave(p){
        let sd=u.getFile(apps.url)
        let json=JSON.parse(sd)
        json.exts.push(p)
        u.setFile(apps.url, JSON.stringify(json, null, 2))
        //log.lv('json: '+JSON.stringify(json, null, 2))
    }
    //    function addExtData(json){
//        if(apps.dev)log.lv('zfdm.addExtData( '+JSON.stringify(json, null, 2)+' )')
//        let o=r.ja.exts
//        if(apps.dev)log.lv('r.ja.exts= '+JSON.stringify(o, null, 2)+'')
//        if(!o)return
//        let nIndex=Object.keys(o).length
//        o[nIndex]={}
//        o[nIndex]=json
//        if(apps.dev)log.lv('adding ext data:'+JSON.stringify(r.ja, null, 2))
//    }
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
        if(apps.dev)log.lv('saveExtToJsonFile( '+extId+'): Nuevo Json: '+JSON.stringify(njson, null, 2))
        let isSaved=u.setFile(apps.url, JSON.stringify(njson))
        if(isSaved)zsm.getPanel('ZoolFileExtDataManager').updateList()
        return isSaved
    }

//    function deleteExtToJsonFile(extId){
//        let njson={}
//        njson.params={}
//        njson.params=r.ja.params
//        njson.exts=[]
//        let o=r.ja.exts
//        if(apps.dev)log.lv('o:'+o.toString())
//        o=o.filter(Boolean)
//        if(apps.dev)log.lv('o2:'+o.toString())
//        for(var i=0;i<Object.keys(o).length;i++){
//            let json=o[i].params
//            if(o[i]){
//                if(json.extId!==extId){
//                    njson.exts[i]={}
//                    njson.exts[i].params={}
//                    njson.exts[i].params=o[i].params
//                }
//            }
//        }
//        njson.exts=njson.exts.filter(Boolean)
//        if(apps.dev)log.lv('deleteExtToJsonFile( '+extId+'): Nuevo Json: '+JSON.stringify(njson, null, 2))
//        let seted=u.setFile(apps.url, JSON.stringify(njson))
//        if(seted)r.ja=njson
//        let forReload=extId===zoolDataView.uExtIdLoaded
//        if(apps.dev)log.lv('deleteExtToJsonFile( '+extId+' )\nzoolDataView.uExtIdLoaded: '+zoolDataView.uExtIdLoaded+'\nforReload: '+forReload)

//        let reLoaded=forReload?r.loadFile(apps.url):true
//        if(forReload)app.j.loadJson(apps.url)
//        let allTaskReady=(seted && reLoaded)?true:false
//        return allTaskReady
//    }

    function deleteExt(ms){
        let jsonData=u.getFile(apps.url)
        let json=JSON.parse(jsonData)
        let data={}
        data.exts=json.exts
        data.exts = data.exts.filter(function(ext) {
          return ext.params.ms !== ms;
        });
        json.exts=data.exts
        u.setFile(apps.url, JSON.stringify(json, null, 2))
    }
    function setExt(ext, index){
        let jsonData=u.getFile(apps.url)
        let json=JSON.parse(jsonData)
        let exts=json.exts
        exts[index]=ext
        //log.lv('exts: '+JSON.stringify(exts, null, 2))
        u.setFile(apps.url, JSON.stringify(json, null, 2))
    }
    function saveChanges(){
        let date=new Date(Date.now())
        let msmod=date.getTime()
        let json=zm.currentJson.params

        let cjson=zfdm.getJsonAbs()
        let j=zm.getParamsFromArgs(cjson.params.n, json.d, json.m, json.a, json.h, json.min, json.gmt, json.lat, json.lon, json.alt, cjson.params.c, cjson.params.t, json.hsys, cjson.params.ms, msmod, cjson.params.f, cjson.params.g)
        if(zfdm.updateParams(j.params, true)){
            zm.loadJsonFromFilePath(apps.url)
        }else{
            //Error 594
            log.lv('Error N° 594 al guardar archivo.')
        }
    }
    //<--Get Json Data

    //-->Info Data Params Man
    function getInfo(isExt){
        let p=getJsonAbsParams(isExt)
        let info=""
        if(p.info)info=p.info
        return info
    }
    function setInfo(isExt, data){
        let j=getJsonAbs()
        let p=getJsonAbsParams(isExt)
        let info=data
        p.info=info
        j.params.info=info
        saveJson(j)
    }
    //<--Info Data Params Man
}

