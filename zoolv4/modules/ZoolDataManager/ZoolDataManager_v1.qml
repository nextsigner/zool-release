import QtQuick 2.0
import QtQuick.Window 2.0

Item{
    id: r

    //Capitalize First Letter
    function cfl(string) {
        if (!string) return "";
        return string.charAt(0).toUpperCase() + string.slice(1);
    }


    //First Run
    function firstRunTime(){
        log.ls('\n\nBienvenido!.\n', 0, xLatIzq.width)
        if(apps.workSpace===''){
            let jsonFolder=u.getPath(3)+'/Zool'
            apps.workSpace=jsonFolder
            if(!u.fileExist(jsonFolder)){
                log.ls('\nCreando carpeta de archivos:\n'+apps.workSpace, log.x, log.width)
                u.mkdir(jsonFolder)
            }
        }
        console.log('Loading United Kingdom now...')
        console.log('JsonFolder: '+apps.workSpace)

        let d=new Date(Date.now())
        let currentUserHours=d.getHours()
        let diffHours=d.getUTCHours()
        let currentGmtUser=0
        if(currentUserHours>diffHours){
            currentGmtUser=parseFloat(currentUserHours-diffHours)
        }else{
            currentGmtUser=parseFloat(0-(diffHours-currentUserHours)).toFixed(1)
        }




        log.ls('Al parecer es la primera vez que inicia Zool en su equipo.\n\n', 0, xLatIzq.width)
        //apps.url=apps.workSpace+'/Primer_Inicio_de_Zool.json'
        log.ls('Cargando el archivo '+apps.url+' creado por primera y única vez a modo de ejemplo.\n\n', 0, xLatIzq.width)
        log.l('\nZool se está ejecutando en la carpeta'+u.currentFolderPath())
        setAndLoadExample()
    }
    function setAndLoadExample(){
        let s='{"params":{"t":"vn","ms":1733708978071,"n":"Aplicación_Zool","g":"n","f":false,"d":26,"m":8,"a":2021,"h":8,"min":55,"gmt":-3,"lat":-34.7504785, "data":"Carta Natal de esta aplicación Zool.", "lon":-58.5846362,"alt":12,"c":"Gregorio de Laferrere Buenos Aires","hsys":"T","shared":false,"extId":"id_26_8_2021_8_55_-3_-34.7504785_-58.5846362_12_vn_T"},"exts":[]}'
        let p=u.getPath(3)+'/Zool'
        if(!u.folderExist(p)){
            u.mkdir(p)
        }
        let fn='Aplicacion_Zool.json'
        let fp=p+'/'+fn
        u.setFile(fp, s)
        apps.url=fp
        zm.loadJsonFromFilePath(apps.url)
    }

    //--->Conversores
    //Convertir Date a String día/mes/año
    function dateToDMA(d, sep){
        if(!sep)sep='/'
        let r=''
        r+=d.getDate()+sep
        r+=parseInt(d.getMonth()+1)+sep
        r+=d.getFullYear()
        return r
    }
    //Convertir Date a String hora:minuto
    function dateToHMS(d){
        let r=''
        r+=d.getHours()+':'
        r+=d.getMinutes()
        return r
    }
    //Convertir Date a Día de la semana
    function obtenerDiaDeLaSemana(fecha) {
      const dias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
      const diaIndice = fecha.getDay();
      return dias[diaIndice];
    }
    //-->Conversores

    //-->GUI
    function showMsgBox(title, text, width, height){
        zm.mkWindowDataView(title, text, width, height, width, height, app, app.fs*0.75)

    }
    //<--GUI

}
