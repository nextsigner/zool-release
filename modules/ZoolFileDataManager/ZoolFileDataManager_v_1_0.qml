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
}
