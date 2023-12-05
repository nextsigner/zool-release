import QtQuick 2.0
import ZoolMap.ZoolMapSignCircle 1.0
import ZoolMap.ZoolMapHousesCircle 1.0
import ZoolMap.ZoolMapPlanetsCircle 1.0

Item{
    id: r
    height: parent.height-app.fs*0.25
    width: height
    anchors.centerIn: parent

    property alias objSignCircle: signCircle
    property alias objHousesCircle: housesCircle
    //property alias objHousesCircleBack: housesCircleBack

    property bool showZonas: true

    property int zodiacBandWidth: app.fs
    property int housesNumWidth: app.fs
    property int housesNumMargin: app.fs*0.25
    property int planetsPadding: app.fs*8
    property real dirPrimRot: 0.00

    property bool enableLoad: true
    property var aTexts: []

    MouseArea{
        anchors.fill: z0
        onDoubleClicked: r.showZonas=!r.showZonas
    }
    //Tamaño total
    Rectangle{
        id: z0
        anchors.fill: parent
        radius: width*0.5
        color: 'gray'
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
        visible: r.showZonas
    }
    //Tamaño de Rueda Zodiacal
    Rectangle{
        id: z2
        width: z0.width-r.housesNumWidth*2-r.housesNumMargin*2
        height: width
        color: 'red'
        radius: width*0.5
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
        visible: r.showZonas
    }
    //Tamaño de Circulo de Planetas Interior
    Rectangle{
        id: z3
        width: z2.width-r.zodiacBandWidth*2
        height: width
        color: 'blue'
        radius: width*0.5
        border.width: 0
        border.color: apps.fontColor
        anchors.centerIn: parent
        visible: r.showZonas
    }
    //Tamaño de Circulo Aspecto
    Rectangle{
        id: z1
        width: z0.width-r.planetsPadding*2
        height: width
        color: apps.backgroundColor
        radius: width*0.5
        border.width: 1
        border.color: apps.fontColor
        anchors.centerIn: parent
        visible: r.showZonas
    }

    Item{id:xuqp}
    ZoolMapSignCircle{id: signCircle; width: z2.width; /*onRotChanged: housesCircle.rotation=rot*/}
    ZoolMapHousesCircle{id: housesCircle; width: z0.width}
    ZoolMapPlanetsCircle{
        id: planetsCircle
        width: z3.width
        //rotation:signCircle.rot
    }

    function load(j){
        //console.log('Ejecutando SweGraphic.load()...')
        r.dirPrimRot=0

        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let vd=j.params.d
        let vm=j.params.m
        let va=j.params.a
        let vh=j.params.h
        let vmin=j.params.min
        let vgmt=j.params.gmt
        let vlon=j.params.lon
        let vlat=j.params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=j.params.hsys?j.params.hsys:apps.currentHsys
        if(j.params.hsys)hsys=j.params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        c+='        if(!r.enableLoad)return\n'
        c+='        let json=(\'\'+logData)\n'
        c+='        //log.lv(\'JSON: \'+json)\n'
        c+='        loadSweJson(json)\n'
        c+='        //swegz.sweg.loadSweJson(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        console.log(\'zoolMap.load() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' '+unik.currentFolderPath()+'\')\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\')\n'
        //c+='        Qt.quit()\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.mod=j.params.tipo
        app.fileData=JSON.stringify(j)
    }
    function loadBack(j){
        //console.log('Ejecutando SweGraphic.load()...')
        r.dirPrimRot=0
        for(var i=0;i<xuqp.children.length;i++){
            xuqp.children[i].destroy(0)
        }
        let params
        params=j.params

        let vd=params.d
        let vm=params.m
        let va=params.a
        let vh=params.h
        let vmin=params.min
        let vgmt=params.gmt
        let vlon=params.lon
        let vlat=params.lat
        let d = new Date(Date.now())
        let ms=d.getTime()
        let hsys=apps.currentHsys
        app.currentFechaBack=vd+'/'+vm+'/'+va
        if(params.hsys)hsys=params.hsys
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='UnikQProcess{\n'
        c+='    id: uqp'+ms+'\n'
        c+='    onLogDataChanged:{\n'
        //c+='        if(!r.enableLoadBack)return\n'
        c+='        let json=(\'\'+logData)\n'
        //c+='        log.lv(\'JSON Back: \'+json)\n'
        //c+='        console.log(\'JSON Back: \'+json)\n'
        c+='        loadSweJsonBack(json)\n'
        c+='        app.ev=true\n'
        c+='        app.objZoolFileExtDataManager.updateList()\n'
        c+='        //swegz.sweg.loadSweJsonBack(json)\n'
        c+='        uqp'+ms+'.destroy(3000)\n'
        c+='    }\n'
        c+='    Component.onCompleted:{\n'
        c+='        let cmd=\'sweg.loadBack() '+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\'\n'
        c+='    if(apps.showLog){\n'
        c+='        log.ls(cmd, 0, xApp.width)\n'
        c+='    }\n'
        c+='        run(\''+app.pythonLocation+' "'+unik.currentFolderPath()+'/py/'+app.sweBodiesPythonFile+'" '+vd+' '+vm+' '+va+' '+vh+' '+vmin+' '+vgmt+' '+vlat+' '+vlon+' '+hsys+' "'+unik.currentFolderPath()+'"\')\n'
        c+='    }\n'
        c+='}\n'
        let comp=Qt.createQmlObject(c, xuqp, 'uqpcode')
        app.mod=j.params.tipo
        app.fileDataBack=JSON.stringify(j)
    }
    function loadSweJson(json){
        //console.log('JSON::: '+json)
        //log.visible=true
        //log.l(JSON.stringify(json))
        var scorrJson=json.replace(/\n/g, '')
        //app.currentJson=JSON.parse(scorrJson)
        //aspsCircle.clear()
        //zsm.getPanel('ZoolRevolutionList').clear()
        //panelRsList.clear()
        //planetsCircleBack.visible=false
        app.ev=false
        apps.urlBack=''
        //panelAspectsBack.visible=false
        app.currentPlanetIndex=-1
        app.currentPlanetIndexBack=-1
        app.currentHouseIndex=-1
        app.currentHouseIndexBack=-1
        //sweg.objHousesCircle.currentHouse=-1
        //swegz.sweg.objHousesCircle.currentHouse=-1
        app.currentPlanetIndex=-1
        app.currentHouseIndex=-1

        //console.log('json: '+json)
        var j
        //try {

        //log.l(scorrJson)
        //log.visible=true
        //log.width=xApp.width*0.4
        j=JSON.parse(scorrJson)

        //r.aTexts[] reset
        let nATexts=[]
        for(var i=0;i<Object.keys(j.pc).length;i++){
            nATexts.push('')
        }
        r.aTexts=nATexts

        app.currentJson=j
        signCircle.rot=parseFloat(j.ph.h1.gdec).toFixed(2)
        //ascMcCircle.loadJson(j)
        housesCircle.loadHouses(j)

        //dinHousesCircle.loadHouses(j)
        planetsCircle.loadJson(j)
        //panelAspects.load(j)
        //zoolDataBodies.loadJson(j)
        //aspsCircle.load(j)
        //zoolElementsView.load(j, false)
        //eclipseCircle.arrayWg=housesCircle.arrayWg
        //eclipseCircle.isEclipse=-1
        //r.v=true
        /*let sabianos=zsm.getPanel('ZoolSabianos')
        sabianos.numSign=app.currentJson.ph.h1.is
        sabianos.numDegree=parseInt(app.currentJson.ph.h1.rsgdeg - 1)
        sabianos.loadData()
        if(apps.sabianosAutoShow){
            //panelSabianos.state='show'
            zsm.currentIndex=1
        }*/
    }
    function loadSweJsonBack(json){
        //console.log('JSON::: '+json)
        app.currentJsonBack=JSON.parse(json)
        //        if(app.dev)
        //            log.lv('ZoolBodies.loadSweJsonBack(json): '+json)
        //            log.lv('ZoolBodies.loadSweJsonBack(json) app.currentJsonBack: '+app.currentJsonBack)
        let scorrJson=json.replace(/\n/g, '')
        //console.log('json: '+json)
        let j=JSON.parse(scorrJson)
        //signCircle.rot=parseInt(j.ph.h1.gdec)
        //planetsCircleBack.rotation=parseFloat(j.ph.h1.gdec).toFixed(2)
        if(r.objectName==='sweg'){
            panelAspectsBack.visible=true
        }
        panelAspectsBack.load(j)
        aspsCircle.add(j)
        if(app.mod!=='rs'){
            //panelElementsBack.load(j)
            zoolElementsView.load(j, true)
            //panelElementsBack.visible=true
            //Qt.quit()
        }else{
            //panelElementsBack.visible=false
        }
        housesCircleBack.loadHouses(j)
        dinHousesCircleBack.loadHouses(j)

        //if(app.mod==='dirprim')housesCircleBack.rotation-=360-housesCircle.rotation
        //if(JSON.parse(app))
        planetsCircleBack.loadJson(j)
        //        if(app.mod==='dirprim'){
        //            log.lv('is dirprim')
        //        }
        zoolDataBodies.loadJsonBack(j)
        //panelDataBodiesV2.loadJson(j)
        let isSaved=false
        if(app.fileDataBack){
            isSaved=JSON.parse(app.fileDataBack).ms>=0
        }
        app.backIsSaved=isSaved
        //if(app.dev)log.lv('sweg.loadSweJsonBack() isSaved: '+isSaved)
        app.ev=true
        //centerZoomAndPos()
    }

}
