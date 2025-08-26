import QtQuick 2.12
import ZoolButton 1.2

Rectangle{
    id: r
    width: parent.width
    height: col0.height+app.fs
    color: 'transparent'
    property string grupo: ''
    property int fs: app.fs*0.75
    property var aAsuntos: []
    property string uAsunto: aAsuntos[0]
    property alias cic: colItemContainer
    onVisibleChanged: {
        if(visible){
            //r.grupo=app.j.qmltypeof(r)
            getData(0)
        }
    }

    Column{
        id: col0
        spacing: app.fs*0.25
        anchors.centerIn: parent
        Rectangle{
            id: xCab
            width: r.width-app.fs*0.5
            height: flow.height
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            Flow{
                id: flow
                spacing: app.fs*0.1
                width: r.width-app.fs
                anchors.centerIn: parent
                Repeater{
                    model: r.aAsuntos
                    ZoolButton{
                        text: modelData
                        colorInverted: r.uAsunto!==modelData
                        onClicked:{
                            r.uAsunto=modelData
                            getData(index)
                        }
                    }
                }
            }
        }
        Rectangle{
            id: xTxtData
            width: r.width-app.fs*0.5
            height: colAll.height//-xCab.height-app.fs*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                id: colAll
                anchors.horizontalCenter: parent.horizontalCenter
                Item{width: 1; height: app.fs*0.5}
                Text{
                    id: txtData
                    //text: '<b>Menú Ver</b>'
                    font.pixelSize: r.fs*0.65
                    color: apps.fontColor
                    textFormat: Text.MarkdownText
                    width: xTxtData.width-app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.centerIn: parent
                    //textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(link)
                }
                Column{
                    id: colItemContainer
                    width: parent.parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
//                    Rectangle{
//                        width: r.width-app.fs*0.5
//                        height: 300
//                        color: 'red'
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        visible: r.uAsunto==='Mostrar grados'
//                    }
                }
            }

        }

        //        ZoolButton{
        //            text: 'Activar Chat de Twitch'
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            onClicked:{
        //                mkTwichChat()
        //            }
        //        }

        //        TwitchChat_v_1_0{
        //            width: r.width
        //            height: app.fs*30
        //            anchors.horizontalCenter: parent.horizontalCenter
        //        }
    }
    function getData(index){
        if(!r.visible || r.grupo==='')return
        let folder=u.getPath(5)+'/modules/ZoolSectionsManager/ZoolHelp/'+r.grupo
        if(!u.folderExist(folder)){
            u.mkdir(folder)
        }
        let fn=u.getPath(5)+'/modules/ZoolSectionsManager/ZoolHelp/'+r.grupo+'/'+(r.aAsuntos[index]).replace(/ /g, '_')+'.md'
        //log.lv('Cargando: '+fn)
        if(!u.fileExist(fn)){
            let data='## '+r.aAsuntos[index]
            u.setFile(fn, data)
            txtData.text='Archivo creado: '+fn
            return
        }
        let fd=u.getFile(fn)
        txtData.text=fd
        //log.lv('txtData.text: '+txtData.text)
    }
    function clearCIC(){
        for(var i=0;i<colItemContainer.children.length;i++){
            colItemContainer.children[i].destroy(0)
        }
    }

}
