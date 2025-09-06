import QtQuick 2.12
import ZoolButton 1.2

import comps.FormContactoPushOver 1.0

import ZoolSectionsManager.ZoolHelp.MenuGrupo 1.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int svIndex: zsm.currentIndex
    property int itemIndex: -1
    property int fs: app.fs*0.75
    property var aAsuntos: ['Inicio', 'Video Tutoriales', 'Cómo Usarlo', 'Teclado', 'Mouse', 'Mapa Astrológico', 'Aspectos', 'Panel Métodos', 'Panel Cuerpos', 'Panel Secciones', 'Sabianos', 'Evolutiva', 'Editar Archivo', 'Menú Archivo', 'Menú Ver', 'Comandos', 'Advertencias', 'Agradecimientos', 'Contacto', 'Sobre Qt']
    property string uAsunto: 'Inicio'
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
            height: r.height-xCab.height-app.fs*0.5
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            Flickable{
                id: flk
                anchors.fill: parent
                contentWidth: parent.width
                contentHeight: colAll.height+app.fs
                Column{
                    id: colAll
                    anchors.horizontalCenter: parent.horizontalCenter
                    Item{width: 1; height: app.fs*0.5}
                    Text{
                        id: txtData
                        text: '<b>Ayuda (Area en construcción)</b>'
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
                        width: parent.parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        FormContactoPushOver{
                            width: r.width-app.fs*0.5
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: r.uAsunto==='Contacto'
                        }
                        MenuGrupo{
                            width: r.width-app.fs*0.5
                            grupo: 'MenuArchivo'
                            aAsuntos: ['Recargar archivo interior']
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: r.uAsunto==='Menú Archivo'
                        }
                        MenuGrupo{
                            width: r.width-app.fs*0.5
                            grupo: 'MenuVer'
                            aAsuntos: ['Cambiar Colores', 'Mostrar grados']
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: r.uAsunto==='Menú Ver'
                        }
                        MenuGrupo{
                            width: r.width-app.fs*0.5
                            grupo: 'ComoUsarlo'
                            aAsuntos: ['Areas de la Aplicación']
                            anchors.horizontalCenter: parent.horizontalCenter
                            visible: r.uAsunto==='Cómo Usarlo'
                            onVisibleChanged:{
                                if(visible){
                                    let c='import QtQuick 2.0\n'
                                    c='import ZoolSectionsManager.ZoolHelp.BotZonas 1.0\n'
                                    c+='BotZonas{}'
                                    let comp=Qt.createQmlObject(c, cic, 'icicode')
                                }else{
                                    clearCIC()
                                }
                            }
                        }

                    }
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

    Component.onCompleted: {
        zsm.aPanelsIds.push(app.j.qmltypeof(r))
        zsm.aPanelesTits.push('Ayuda')
        getData(0)
    }
    function getData(index){
        let folder=''
        if(r.aAsuntos[index].indexOf('Menú')===0){
            folder=r.aAsuntos[index].replace(/ /g, '').replace(/ú/g, 'u')+'/'
        }
        if(!u.folderExist(u.getPath(5)+'/modules/ZoolSectionsManager/ZoolHelp/'+folder)){
            u.mkdir(u.getPath(5)+'/modules/ZoolSectionsManager/ZoolHelp/'+folder)
        }
        let fn=u.getPath(5)+'/modules/ZoolSectionsManager/ZoolHelp/'+folder+(r.aAsuntos[index]).replace(/ /g, '_')+'.md'
        if(!u.fileExist(fn)){
            let data='## '+r.aAsuntos[index]
            u.setFile(fn, data)
            txtData.text='Archivo creado: '+fn
            return
        }
        let fd=u.getFile(fn)
        txtData.text=fd
    }
    function mkTwichChat(){

    }
    function toEnter(){}
    function toLeft(){}
    function toRight(){}
    function toUp(){
        if(flk.contentY>0){
            flk.contentY-=app.fs
        }
    }
    function toDown(){
        if(flk.contentY<(flk.contentHeight-(flk.height-app.fs*3))){
            flk.contentY+=app.fs
        }
    }
    function isFocus(){
        return false
    }
    function toEscape(){

    }
    //-->Funciones de Control Focus y Teclado
    property bool hasUnUsedFunction: true
    function unUsed(){
        //                          log.lv(app.j.qmltypeof(r)+'.unUsed()...')
    }
    //-->Funciones de Control Focus y Teclado

    /*function toEnter(){}
    function toLeft(){}
    function toRight(){}
    function toUp(){}
    function toDown(){}*/

}
