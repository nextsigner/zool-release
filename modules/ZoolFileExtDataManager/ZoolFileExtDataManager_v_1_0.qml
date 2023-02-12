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
            Row{
                ZoolButton{
                    visible: app.dev
                    text: 'Prueba'
                    onClicked: {
                        let t='sin'
                        let hsys=apps.currentHsys
                        let nom="PPP"
                        let d=8
                        let m=9
                        let a=1980
                        let h=17
                        let min=0
                        let gmt=-3
                        let lat=-34.769249
                        let lon=-58.6480318
                        let alt=0
                        let ciudad='Catann'
                        let e='42'
                        app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, e, t, hsys, -1)
                    }
                }
                ZoolButton{
                    visible: app.dev
                    text: 'UpdateList'
                    onClicked: {
                        r.updateList()
                    }
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
        function addItem(json){
            return {
                j:json
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
            property bool saved: j.ms>=0
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
                    id: txtDataTipo
                    font.pixelSize: app.fs*0.5
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataNom
                    font.pixelSize: app.fs*0.5
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataParams
                    font.pixelSize: app.fs*0.35
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Row{
                    spacing: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    ZoolButton{
                        id: btnSave
                        text:'Guardar'
                        visible: !xDatos.saved
                        colorInverted: true
                        onClicked: {
                            btnSave.visible=!zfdm.saveExtToJsonFile(j.extId)
                        }
                    }
                }
                ZoolButton{
                    id: btnLoadExt
                    text:'Cargar'
                    colorInverted: true
                    onClicked: {
                        let t=j.tipo
                        let hsys=j.hsys
                        let nom=j.n
                        let d=j.d
                        let m=j.m
                        let a=j.a
                        let h=j.h
                        let min=j.min
                        let gmt=j.gmt
                        let lat=j.lat
                        let lon=j.lon
                        let alt=j.alt
                        let ciudad=j.ciudad
                        let e='-1'
                        let ms=j.ms
                        app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, e, t, hsys,ms)
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
                    onDoubleClicked: {
                        if(zfdm.deleteExtToJsonFile(j.extId)){
                            r.updateList()
                        }
                    }
                }
            }
            Component.onCompleted: {
                //let nom=j.n
                let tipo=''
                if(j.tipo==='sin')tipo='Sinastría'
                if(j.tipo==='rs')tipo='Revolución Solar'
                if(j.tipo==='trans')tipo='Tránsitos'
                txtDataTipo.text=tipo
                txtDataNom.text=j.n
                let sParams='<b>Fecha:</b> '+j.d+'/'+j.m+'/'+j.a+'<br>'
                sParams+='<b>Hora:</b> '+j.h+':'+j.min+'hs<br>'
                sParams+='<b>Ubicación:</b> '+j.ciudad+'<br>'
                sParams+='<b>Latitud:</b> '+j.lat+'<br>'
                sParams+='<b>Longitud:</b> '+j.lon+'<br>'
                sParams+='<b>Altitud:</b> '+j.alt+'<br>'
                txtDataParams.text=sParams
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
    Component.onCompleted: {
        app.objZoolFileExtDataManager=r
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
        for(var i=0;i<Object.keys(exts).length;i++){
            let json=exts[i].params
            lm.append(lm.addItem(json))
        }
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
