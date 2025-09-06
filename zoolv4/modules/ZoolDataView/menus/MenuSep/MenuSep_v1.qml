import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

import ZoolTextInput 1.0
import ZoolButton 1.2

ZoolMenus{
    id: r
    title: 'Menu Separador'
    property string stringMiddleSep: 'Menu Separador'
    //property int currentIndexHouse: -1
    //property var aMI: []
    //property bool isBack: false


    Action {text: qsTr("Guardar "+r.stringMiddleSep); onTriggered: {
            let sp=zm.fileDataBack
            let p=JSON.parse(sp)
            let nd=new Date(Date.now())
            p.params.ms=nd.getTime()
            //log.lv('app.t: '+app.t)
            if(app.t==='dirprim'){
                p.params.dirPrimRot=zm.dirPrimRot
            }
            zfdm.addExtDataAndSave(p)
        }
    }
    Action {text: qsTr("Guardar "+r.stringMiddleSep+" como..."); onTriggered: {
            let comp=compSetName.createObject(capa101, {})
        }
    }
    function mkHtml(sexo){
        let j=zfdm.getJsonAbs().params
        let n=(j.n).replace(/_/g, '+')
        let d=j.d
        let m=j.m
        let a=j.a
        let h=j.h
        let min=j.min
        let gmt=j.gmt
        let ciudad=(j.c).replace(/_/g, '+')
        let lat=j.lat
        let lon=j.lon
        let alt=0
        if(j.alt)alt=j.alt
        let url='http://www.zool.ar/getZoolDataMapFull?n='+n+'&d='+d+'&m='+m+'&a='+a+'&h='+h+'&min='+min+'&gmt='+gmt+'&lugarNacimiento='+ciudad+'&lat='+lat+'&lon='+lon+'&alt='+alt+'&ciudad='+ciudad+'&ms=0&msReq=0&adminId=zoolrelease&sexo='+sexo
        Qt.openUrlExternally(url)
    }
    Component{
        id: compSetName
        Item{
            id: xSetName
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                opacity: 0.75
                color: apps.backgroundColor
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    xSetName.destroy(0)
                }
            }
            Column{
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Text{
                    text: "<b>Definir el nombre del tránsito</b>"
                    color: apps.fontColor
                    font.pixelSize: app.fs*0.75
                }
                Item{width: 1; height: app.fs}
                ZoolTextInput{
                    id: tiNombre
                    width: app.fs*20
                    t.font.pixelSize: app.fs*0.65
                    anchors.horizontalCenter: parent.horizontalCenter
                    //KeyNavigation.tab: controlTimeFecha
                    t.maximumLength: 30
                    borderColor:apps.fontColor
                    borderRadius: app.fs*0.25
                    padding: app.fs*0.25
                    horizontalAlignment: TextInput.AlignLeft
                    //onTextChanged: if(cbPreview.checked)loadTemp()
                    onEnterPressed: {
                        setNom()
                    }
                    Text {
                        text: 'Nombre de Tránsito'
                        font.pixelSize: app.fs*0.5
                        color: 'white'
                        anchors.bottom: parent.top
                    }
                }
                Column{
                    Text {
                        text: "Información"
                        font.pixelSize: app.fs*0.5
                        color: apps.fontColor
                    }
                    Rectangle{
                        width: app.fs*20
                        height: app.fs*10
                        border.width: 1
                        border.color: apps.fontColor
                        color: 'transparent'
                        clip: true
                        radius: app.fs*0.1
                        Flickable{
                            contentWidth: width
                            contentHeight: taInfo.contentHeight+app.fs
                            anchors.fill: parent
                            TextArea{
                                id: taInfo
                                width: parent.width-app.fs*0.5
                                height: parent.height
                                color: apps.fontColor
                                wrapMode: TextArea.WordWrap
                            }
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    ZoolButton{
                        text: 'Cancelar'
                        onClicked:{
                            xSetName.destroy(0)
                        }
                    }
                    ZoolButton{
                        text: 'Guardar'
                        onClicked:{
                            setNom()                    }
                    }
                }

            }
            Component.onCompleted: {
                let sp=zm.fileDataBack
                let p=JSON.parse(sp)
                tiNombre.t.text=p.params.n
            }
            function setNom(){

//                let panel=zsm.getPanel('ZoolMods')
//                let section=panel.getSection('ZoolFileDirPrimLoader')
//                if(app.t==='trans'){
//                    panel.getSection('ZoolFileTransLoader')
//                }
                let cjb=zm.currentJsonBack.params
                let currentDate=new Date(cjb.a, cjb.m-1, cjb.d, cjb.h, cjb.min)
                //zpn.log(''+app.t+': '+currentDate.toString())

                let sp=zm.fileDataBack
                let p=JSON.parse(sp)
                let nd=new Date(Date.now())
                p.params.t=app.t
                p.params.ms=nd.getTime()
                p.params.n=tiNombre.t.text
                p.params.d=currentDate.getDate()
                p.params.m=currentDate.getMonth()+1
                p.params.a=currentDate.getFullYear()
                p.params.data=taInfo.text
                if(!p.params.c){
                    p.params.c=zm.currentLugar
                }
                //log.lv('app.t: '+app.t)
                if(app.t==='dirprim'){
                    p.params.dirPrimRot=zm.dirPrimRot
                }
                zfdm.addExtDataAndSave(p)
                zm.fileDataBack=JSON.stringify(p, null, 2)
                xSetName.destroy(0)
            }
        }
    }
}
