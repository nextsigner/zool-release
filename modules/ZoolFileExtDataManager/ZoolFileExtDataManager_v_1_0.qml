import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.12
import ZoolButton 1.0
import ZoolText 1.0
import ZoolButton 1.2
import Qt.labs.settings 1.1


Rectangle {
    id: r
    width: xLatIzq.width
    height: xLatIzq.height-xPanelesTits.height-app.fs*0.5
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    property string uFileLoaded: ''

    property alias currentIndex: lv.currentIndex
    property alias listModel: lm

    property int svIndex: sv.currentIndex
    property int itemIndex: -1

    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }
    Timer{
        id: tUpDate
        running: r.uFileLoaded !== apps.url
        repeat: false
        interval: 1000
        onTriggered: {
            updateList()
        }
    }
    Column{
        id: col
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: colTopElements
            Item{width: 1; height: app.fs*2; visible: colXConfig.visible}
            Column{
                id: colXConfig
                anchors.horizontalCenter: parent.horizontalCenter
                visible: zoolFileManager.s.showConfig
            }
            //Item{width: 1; height: app.fs; visible: zoolFileManager.s.showConfig}
            Row{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText{
                    text:'Mostrar datos en el<br/>centro de la pantalla:'
                    fs: app.fs*0.5
                    anchors.verticalCenter: parent.verticalCenter
                }
                CheckBox{
                    width: app.fs*0.5
                    checked: s.showToolItem
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: s.showToolItem=checked
                }
            }
            //Item{width: 1; height: app.fs; visible: zoolFileManager.s.showConfig}
            ZoolButton{
                visible: app.dev
                text: 'Prueba'
                onClicked: {
                    let tipo='sin'
                    let d=new Date(Date.now())
                    let nom="PPP"
                    let vd=8
                    let vm=9
                    let va=1980
                    let vh=17
                    let vmin=0
                    let vgmt=-3
                    let vlat=-34.769249
                    let vlon=-58.6480318
                    let valt=0
                    let vCiudad='Catann'
                    let edad='42'
                    let numEdad=getEdad(parseInt(va), parseInt(vm), parseInt(vd), parseInt(vh),
                                        parseInt(vmin))
                    let stringEdad=edad.indexOf('NaN')<0?edad:''
                    //loadFromArgsBack(d, m, a, h, min, gmt, lat, lon, alt, nom, ciudad, tipo, save)
                    //app.j.loadFromArgsBack(vd, vm, va, vh, vmin, vgmt, vlat, vlon, valt, nom, vCiudad, 'sin', false)
                    let js='{"params":{"tipo":"'+tipo+'","ms":'+d.getTime()+',"n":"'+nom+'","d":'+vd+',"m":'+vm+',"a":'+va+',"h":'+vh+',"min":'+vmin+',"gmt":'+vgmt+',"lat":'+vlat+',"lon":'+vlon+',"alt":'+valt+',"ciudad":"'+vCiudad+'"}}'
                    let json=JSON.parse(js)
                    sweg.loadBack(json, 'sin')
                }
            }
            Rectangle{
                id:xTit
                width: lv.width
                height: app.fs*1.5
                color: apps.backgroundColor
                border.width: 2
                border.color: apps.fontColor//txtDataSearch.focus?'red':'white'
                anchors.horizontalCenter: parent.horizontalCenter
                ZoolText {
                    id: txtFileName
                    text: '?'
                    font.pixelSize: app.fs*0.5
                    //width: parent.width-app.fs
                    w: parent.width-app.fs
                    wrapMode: Text.WordWrap
                    color: apps.fontColor
                    focus: r.itemIndex===r.svIndex
                    anchors.centerIn: parent
                    Rectangle{
                        width: parent.width+app.fs
                        height: parent.height+app.fs
                        color: 'transparent'
                        //border.width: 2
                        //border.color: 'white'
                        z: parent.z-1
                        anchors.centerIn: parent
                    }
                }
            }
        }
        ListView{
            id: lv
            width: r.width
            //height: r.height-xTit.height-xTitInf.height
            height: r.height-colTopElements.height
            anchors.horizontalCenter: parent.horizontalCenter
            delegate: compItemList
            model: lm
            clip: true
            onCurrentIndexChanged: {
                if(!lm.get(currentIndex) || !lm.get(currentIndex).fileName)return
                r.currentFile=lm.get(currentIndex).fileName
            }
        }
    }
    ListModel{
        id: lm
        function addItem(vFileName, vData, vTipo){
            return {
                fileName: vFileName,
                dato: vData,
                tipo: vTipo
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: xDatos
            width: lv.width
            height: colDatos.height+app.fs
            color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            border.width: index===lv.currentIndex?4:2
            border.color: 'white'
            property bool selected: index===lv.currentIndex
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lv.currentIndex=index
                    if(!s.showToolItem)return
                    for(var i=0; i<xItemView.children.length;i++){
                        xItemView.children[i].destroy(0)
                    }
                    let comp=compItemView.createObject(xItemView, {
                                                           fileName: fileName,
                                                           dato: dato,
                                                           tipo: tipo})
                }
                onDoubleClicked: {
                    app.j.loadJson(fileName)
                }
            }
            Column{
                id: colDatos
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Text {
                    id: txtData
                    //text: dato
                    font.pixelSize: app.fs*0.5
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataExtra
                    font.pixelSize: app.fs*0.35
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: xDatos.selected && !s.showToolItem
                    //anchors.centerIn: parent
                }
                ZoolButton{
                    id: btnLoadExt
                    text:'Cargar como Sinastría'
                    anchors.right: parent.right
                    anchors.rightMargin: app.fs*0.1
                    visible: index===lv.currentIndex && !s.showToolItem && tipo !== 'rs'  && tipo !== 'sin'
                    colorInverted: true
                    onClicked: {
                        loadAsSin(fileName)
                    }
                }
            }
            Rectangle{
                width: txtDelete.contentWidth+app.fs*0.35
                height: width
                radius: app.fs*0.3
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.3
                anchors.top: parent.top
                anchors.topMargin: app.fs*0.3
                color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                visible: index===lv.currentIndex
                Text {
                    id: txtDelete
                    text: 'X'
                    font.pixelSize: app.fs*0.25
                    anchors.centerIn: parent
                    color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
                }
                MouseArea{
                    anchors.fill: parent
                    onDoubleClicked: deleteVnData(fileName)
                }
            }
            Component.onCompleted: {
                let m0=dato.split('<!-- extra -->')
                txtData.text=m0[0]
                txtDataExtra.text=m0[1]
            }
        }
    }
    Component{
        id: compItemView
        Rectangle{
            id: xDatosView
            width: app.fs*30
            height: colDatos.height+app.fs
            color: apps.backgroundColor
            //border.width: 2
            border.color: 'white'
            anchors.centerIn: parent
            property int fs: xDatosView.width*0.075
            property string fileName: ''
            property string dato: ''
            property string tipo: ''
            MouseArea{
                anchors.fill: parent
                onClicked: lv.currentIndex=index
                onDoubleClicked: {
                    app.j.loadJson(fileName)
                    //r.state='hide'
                }
            }
            Column{
                id: colDatos
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Text {
                    id: txtData
                    text: dato
                    font.pixelSize: xDatosView.fs*0.5
                    width: xDatosView.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataExtra
                    font.pixelSize: xDatosView.fs*0.35
                    width: xDatosView.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Row{
                    spacing: xDatosView.fs
                    ZoolButton{
                        text:'Eliminar Archivo'
                        colorInverted: true
                        fs: xDatosView.fs*0.25
                        onClicked: {
                            deleteVnData(fileName)
                        }
                    }
                    ZoolButton{
                        text:'Cargar como Sinastría'
                        colorInverted: true
                        fs: xDatosView.fs*0.25
                        onClicked: {
                            //let fromTipo='vn'
                            let tipo=JSON.parse(app.currentData).params.tipo
                            if(tipo==='vn'){
                                //xDataBar.stringMiddleSeparator='Sinastría'
                                app.mod='sin'
                                JSON.parse(app.currentData).params.tipo='sin'
                            }
                            app.j.loadJsonBack(fileName, 'sin')
                            //r.state='hide'
                        }
                    }
                }
            }
            Rectangle{
                width: txtDelete.contentWidth+app.fs*0.35
                height: width
                radius: app.fs*0.3
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.3
                anchors.top: parent.top
                anchors.topMargin: app.fs*0.3
                color: apps.backgroundColor
                Text {
                    id: txtDelete
                    text: 'X'
                    font.pixelSize: xDatosView.fs*0.25
                    anchors.centerIn: parent
                    color: apps.fontColor
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        for(var i=0; i<xItemView.children.length;i++){
                            xItemView.children[i].destroy(0)
                        }
                        lv.currentIndex=-1
                    }
                }
            }
            Component.onCompleted: {
                let m0=dato.split('<!-- extra -->')
                txtData.text=m0[0]
                txtDataExtra.text=m0[1]
            }
        }
    }
    Rectangle{
        id: xItemView
        width: !visible?1:parent.width
        height: !visible?1:parent.height
        color: apps.backgroundColor
        anchors.centerIn: parent
        visible: r.visible && lv.currentIndex>=0 && s.showToolItem
        parent: visible?xMed:r
    }
    function deleteVnData(fileName){
        unik.deleteFile(fileName)
        let fn=fileName.replace('cap_', '').replace('.png', '')
        let jsonFileName=fn+'.json'
        unik.deleteFile(jsonFileName)
        updateList()
    }
    function getEdad(dateString) {
        let hoy = new Date()
        let fechaNacimiento = new Date(dateString)
        let edad = hoy.getFullYear() - fechaNacimiento.getFullYear()
        let diferenciaMeses = hoy.getMonth() - fechaNacimiento.getMonth()
        if (
                diferenciaMeses < 0 ||
                (diferenciaMeses === 0 && hoy.getDate() < fechaNacimiento.getDate())
                ) {
            edad--
        }
        return edad
    }
    function updateList(){
        lv.currentIndex=-1
        lm.clear()
        txtFileName.text=zfdm.getParam('n').replace(/_/g, ' ')
        let exts=zfdm.getExts()
        if(app.dev)log.lv('Object.keys(exts).length: '+Object.keys(exts).length)
//        for(var i=0;i<flm.count;i++){
//            let file=apps.jsonsFolder+'/'+flm.get(i, 'fileName')
//            let fn=file//.replace('cap_', '').replace('.png', '')
//            let jsonFileName=fn
//            //console.log('FileName: '+jsonFileName)

//            let jsonFileData
//            if(unik.fileExist(jsonFileName)){
//                jsonFileData=unik.getFile(jsonFileName)
//            }else{
//                continue
//            }
//            jsonFileData=jsonFileData.replace(/\n/g, '')
//            //console.log(jsonFileData)
//            if(jsonFileData.indexOf(':NaN,')>=0)continue
//            let jsonData
//            try {
//                jsonData=JSON.parse(jsonFileData)
//                let nom=''+jsonData.params.n.replace(/_/g, ' ')
//                if((jsonData.params.tipo==='rs' && jsonData.paramsBack) || (jsonData.params.tipo==='sin' && jsonData.paramsBack)){
//                    nom=''+jsonData.paramsBack.n.replace(/_/g, ' ')
//                }
//                if(nom.toLowerCase().indexOf(txtDataSearch.text.toLowerCase())>=0){
//                    if(jsonData.asp){
//                        //console.log('Aspectos: '+JSON.stringify(jsonData.asp))
//                    }
//                    let vd=jsonData.params.d
//                    let vm=jsonData.params.m
//                    let va=jsonData.params.a
//                    let vh=jsonData.params.h
//                    let vmin=jsonData.params.min
//                    let vgmt=jsonData.params.gmt
//                    let vlon=jsonData.params.lon
//                    let vlat=jsonData.params.lat
//                    let vCiudad=jsonData.params.ciudad.replace(/_/g, ' ')
//                    let edad=' <b>Edad:</b> '+getEdad(""+va+"/"+vm+"/"+vd+" "+vh+":"+vmin+":00")
//                    let stringEdad=edad.indexOf('NaN')<0?edad:''

//                    //Date of Make File
//                    let d=new Date(jsonData.params.ms)
//                    let dia=d.getDate()
//                    let mes=d.getMonth() + 1
//                    let anio=d.getFullYear()
//                    let hora=d.getHours()
//                    let minuto=d.getMinutes()
//                    let sMkFile='<b>Creado: </b>'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto+'hs'
//                    let sModFile='<b>Modificado:</b> Nunca'
//                    if(jsonData.params.msmod){
//                        d=new Date(jsonData.params.ms)
//                        dia=d.getDate()
//                        mes=d.getMonth() + 1
//                        anio=d.getFullYear()
//                        hora=d.getHours()
//                        minuto=d.getMinutes()
//                        sModFile='<b>Modificado: </b>'+dia+'/'+mes+'/'+anio+' '+hora+':'+minuto+'hs'
//                    }
//                    let sDataFile='<b>Tiene información:</b> No'
//                    if(jsonData.params.data){
//                        sDataFile='<b>Tiene información:</b> Si'
//                    }
//                    let stipo=''
//                    if(jsonData.params.tipo==='vn'){
//                        stipo='Carta Natal'
//                    }else if(jsonData.params.tipo==='sin'){
//                        stipo='Sinastría'
//                    }else if(jsonData.params.tipo==='rs'){
//                        stipo='Revolución Solar'
//                    }else if(jsonData.params.tipo==='trans'){
//                        stipo='Tránsitos'
//                    }else{
//                        stipo='Desconocido'
//                    }

//                    let textData=''
//                        +'<b>'+nom+'</b>'
//                        +'<p style="font-size:'+parseInt(app.fs*0.5)+'px;">'+vd+'/'+vm+'/'+va+' '+vh+':'+vmin+'hs GMT '+vgmt+stringEdad+'</p>'
//                        +'<p style="font-size:20px;"><b> '+vCiudad+'</b></p>'
//                        +'<!-- extra -->'
//                        +'<b>Tipo: </b>'+stipo
//                        +'<p style="font-size:'+parseInt(app.fs*0.35)+'px;"> <b>long:</b> '+vlon+' <b>lat:</b> '+vlat+'</p>'
//                        +sMkFile+'<br>'
//                        +sModFile+'<br>'
//                        +sDataFile+'<br>'
//                        +'<b>Archivo: </b>'+file
//                    //xNombre.nom=textData
//                    lm.append(lm.addItem(file,textData, jsonData.params.tipo))
//                }
//                if(r.itemIndex===r.svIndex)txtDataSearch.focus=true
//                //txtDataSearch.selectAll()
//            } catch (e) {
//                console.log('Error Json panelFileLoader: ['+file+'] '+jsonFileData)
//                continue
//                //return false;
//            }
//        }
    }
    function enter(){
        app.j.loadJson(r.currentFile)
        r.currentIndex=-1
        //r.state='hide'
    }
    function setInitFocus(){
        txtDataSearch.focus=true
        txtDataSearch.selectAll()
    }
}
