import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.12
import ZoolButton 1.0
import ZoolText 1.0
import ZoolButton 1.2
import Qt.labs.settings 1.1


Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor

    visible: zsm.aPanelsIds.indexOf(app.j.qmltypeof(r))===zsm.currentIndex//itemIndex===zsm.currentIndex

    property string uFileLoaded: ''

    property alias currentIndex: lv.currentIndex
    property alias listModel: lm

    property int svIndex: zsm.currentIndex
    property int itemIndex: -1

    property int fs: app.fs*s.fzoom

    onVisibleChanged: {
        //if(visible)zoolVoicePlayer.stop()
        if(visible){
            updateList()
            zoolVoicePlayer.speak('Sección para gestionar mapas externos.', true)
        }
    }

    MouseArea{
        anchors.fill: parent
        onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }
    Settings{
        id: s
        property real fzoom: 1.0
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
            Row{
                spacing: app.fs*0.25
                anchors.right: parent.right
                visible: apps.dev
                ZoolButton{
                    visible: apps.dev
                    text: 'Prueba'
                    onClicked: {
                        let t='sin'
                        let hsys=apps.currentHsys
                        let nom="Pablo"
                        let d=8
                        let m=6
                        let a=1991
                        let h=10
                        let min=45
                        let gmt=-3
                        let lat=-34.769249
                        let lon=-58.6480318
                        let alt=0
                        let ciudad='I. Casanova'
                        let strEdad='Edad: '+zm.getEdad(d, m, a, h, min)+' años'
                        let aR=[]
                        app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, strEdad, t, hsys, -1, aR)
                    }
                }
                ZoolButton{
                    visible: apps.dev
                    text: 'UpdateList'
                    onClicked: {
                        r.updateList()
                    }
                }
            }
        }
        ListView{
            id: lv
            width: r.width-app.fs*0.5
            height: r.height-xTit.height
            spacing: app.fs*0.25
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
            //color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            color: apps.backgroundColor
            border.width: index===lv.currentIndex?4:2
            //border.color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
            border.color: apps.fontColor
            radius: app.fs*0.25
            property bool selected: index===lv.currentIndex
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons;
                onClicked: {
                    if (mouse.button === Qt.RightButton   && (mouse.modifiers & Qt.ControlModifier)) {

                        if(s.fzoom>3.0)return
                        s.fzoom+=0.05
                    } else if (mouse.button === Qt.LeftButton   && (mouse.modifiers & Qt.ControlModifier)) {
                        if(s.fzoom<=1.0)return
                        s.fzoom-=0.05
                    }else{
                        lv.currentIndex=index
                    }

                }
                onDoubleClicked: {
                    //app.j.loadJson(fileName)
                    zm.loadJsonFromFilePath(fileName)
                }
            }
            Column{
                id: colDatos
                spacing: app.fs*0.1
                anchors.centerIn: parent
                Text {
                    id: txtDataTipo
                    font.pixelSize: r.fs*0.75
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: xDatos.border.color
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataNom
                    font.pixelSize: r.fs//*0.5
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: xDatos.border.color
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: txtDataParams
                    font.pixelSize: r.fs*0.5
                    width: xDatos.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: xDatos.border.color
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: index===lv.currentIndex
                    //anchors.centerIn: parent
                }
                Row{
                    spacing: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: index===lv.currentIndex
                    ZoolButton{
                        id: btnDelete
                        text:'Eliminar'
                        //colorInverted: true
                        onClicked: {
                            zfdm.deleteExt(j.ms)
                            updateList()
                        }
                    }
                    ZoolButton{
                        id: btnLoadExt
                        text:'Cargar'
                        //colorInverted: true
                        visible: index===lv.currentIndex
                        onClicked: {
                            let json={}
                            json.params=j
                            //zm.ev=true
                            zm.loadBack(json)
                            //return
                            let t=j.t
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
                            let ciudad=j.c
                            let strEdad='Edad: '+zm.getEdad(d, m, a, h, min)+' años'
                            if(t==='rs'){
                                let currentAnio=new Date(app.currentDate).getFullYear()
                                strEdad='Edad: '+parseInt(a - currentAnio)+' años'
                                //strEdad='Edad: '+Math.abs(parseInt(currentAnio - a))+' años'
                            }
                            let ms=j.ms
                            let aL=zoolDataView.atLeft
                            let aR=[]
                            let strSep='?'
                            if(t==='sin'){
                                strSep='Sinastría'
                            }else if(t==='trans'){
                                strSep='Tránsitos'
                            }else if(t==='rs'){
                                strSep='Rev. Solar'
                            }else{
                                strSep='Indefinido!'
                            }
                            //zoolDataView.stringMiddleSeparator=t

                            //aR.push('<b>'+nom+'</b>')
                            aR.push(''+d+'/'+m+'/'+a)
                            //aR.push(stringEdad)
                            aR.push(''+h+':'+min+'hs')
                            aR.push('<b>GMT:</b> '+gmt)
                            aR.push('<b>Ubicación:</b> '+ciudad)
                            aR.push('<b>Lat:</b> '+parseFloat(lat).toFixed(2))
                            aR.push('<b>Lon:</b> '+parseFloat(lon).toFixed(2))
                            aR.push('<b>Alt:</b> '+alt)

                            zoolDataView.setDataView(strSep, aL, aR)

                            if(t==='dirprim'){
//                                let vDirPrimA=j.dirprimA
//                                let vDirPrimM=j.dirprimM
//                                let vDirPrimD=j.dirprimD
//                                let vDirPrimH=j.dirprimH
//                                let vDirPrimMin=j.dirprimMin
//                                let dateEvento=new Date(1976, 5,20,23,4)
                                let dateEvento=new Date(a, m, d, h,min)
                                let section=zsm.getPanel('ZoolFileManager').getSection('ZoolFileDirPrimLoader')
                                section.setDirPrimRotationFromExternalItem(app.currentDate, dateEvento)
                            }else{
                                if(apps.dev)log.lv('ZoolFileExtDataManager Boton Cargar... gmt: '+gmt)
                                //app.j.loadBack(nom, d, m, a, h, min, gmt, lat, lon, alt, ciudad, strEdad, t, hsys,ms, aR)
                            }
                        }
                    }
                }

            }            
            /*Rectangle{
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
                    font.pixelSize: r.fs*0.25
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
            }*/
            Component.onCompleted: {
                //let nom=j.n
                let tipo=''
                if(j.t==='sin')tipo='Sinastría'
                if(j.t==='rs')tipo='Revolución Solar'
                if(j.t==='trans')tipo='Tránsitos'
                txtDataTipo.text='<b>'+tipo+'</b>'
                txtDataNom.text='<b>'+j.n+'</b>'
                let sParams=''+j.d+'/'+j.m+'/'+j.a+' '
                sParams+=''+j.h+':'+j.min+'hs<br><br>'
                sParams+='<b>Ubicación:</b> '+j.c+'<br><br>'
                sParams+='<b>Gmt:</b> '+j.gmt+'<br><br>'
                sParams+='<b>Lat:</b> '+j.lat+' '
                sParams+='<b>Long:</b> '+j.lon+' '
                sParams+='<b>Alt:</b> '+j.alt+'<br><br>'
                let d=new Date(j.ms)
                let sd=d.getDate()+'/'+parseInt(d.getMonth() + 1)+'/'+d.getFullYear()+' '+d.getHours()+':'+d.getMinutes()+'hs.'
                sParams+='<b>Cread:</b> '+sd+'<br>'
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
                    //app.j.loadJson(fileName)
                    zm.loadJsonFromFilePath(fileName)
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
                    font.pixelSize: r.fs*0.5
                    width: xDatosView.width-app.fs
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                }
                Text {
                    id: txtDataExtra
                    font.pixelSize: r.fs*0.35
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
                        visible: index===lv.currentIndex
                        onClicked: {
                            let tipo=JSON.parse(app.currentData).params.t
                            if(tipo==='vn'){
                                //xDataBar.stringMiddleSeparator='Sinastría'
                                app.t='sin'
                                JSON.parse(app.currentData).params.t='sin'
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
                    font.pixelSize: r.fs*0.25
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
    Text{
        text: 'LV.count: '+lv.count
        font.pixelSize: app.fs*2
        color: 'red'
        anchors.centerIn: parent
        visible: apps.dev
    }
    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Lista de Exteriores')
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
        if(!zfdm.getParam('n')){
            return
        }
        txtFileName.text=zfdm.getParam('n').replace(/_/g, ' ')
        //Filtrado de los valores null
        let exts=zfdm.getExts()
        if(!exts){
            return
        }else{
            exts=zfdm.getExts().filter(Boolean);
        }
        //exts=exts.filter(Object)
        //if(apps.dev)log.lv('Object.keys(exts).length: '+Object.keys(exts).length)
        for(var i=0;i<Object.keys(exts).length;i++){
            if(exts[i]){
                let json=exts[i].params
                lm.append(lm.addItem(json))
            }
        }
    }
    function enter(){
        //app.j.loadJson(r.currentFile)
        zm.loadJsonFromFilePath(r.currentFile)
        r.currentIndex=-1
        //r.state='hide'
    }
    function setInitFocus(){
        txtDataSearch.focus=true
        txtDataSearch.selectAll()
    }
}
