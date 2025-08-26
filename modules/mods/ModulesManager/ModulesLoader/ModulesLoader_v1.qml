import QtQuick 2.0
import QtQuick.Controls 2.0

import comps.FocusSen 1.0
import ZoolButton 1.0
import ZoolText 1.2
import ZoolTextInput 1.0

Rectangle{
    id: r
    width: parent.width//-app.fs*0.5
    height: parent.height//+app.fs*0.5
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    color: 'transparent'
    onVisibleChanged: {
        //loadModulesList()
    }
    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs*0.5
        Item{width: 1; height: app.fs*0.5}
        Text{
            id: txtTit
            text:'<b>Lista de Modulos</b>'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        //Item{width: 1; height: app.fs*0.5}
        ListView{
            id: lv
            width: r.width-app.fs*0.5
            height: r.height-txtTit.contentHeight-col.spacing-app.fs*1.5
            model: lm
            delegate: compItemList
            ListModel{
                id: lm
                function addItem(json){
                    return {
                        j: json
                    }
                }
            }
            Component{
                id: compItemList
                Rectangle{
                    id: xItem
                    width: lv.width
                    height: txt1.contentHeight+app.fs*0.5
                    color: !xItem.selected?apps.backgroundColor:apps.fontColor
                    border.width: 1
                    border.color: xItem.selected?apps.backgroundColor:apps.fontColor
                    property bool selected: index===lv.currentIndex

                    Row{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Text{
                            id: txt1
                            font.pixelSize: app.fs*0.5
                            color: xItem.selected?apps.backgroundColor:apps.fontColor
                            wrapMode: Text.WordWrap
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            text: 'Cargar'
                            font.pixelSize: app.fs*0.5
                            onClicked: loadModule(index)
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Component.onCompleted: {
                        txt1.text=j.name
                    }
                }
            }
        }


    }
    Component.onCompleted: {
        loadModulesList()
    }

    //-->Teclado
    function toEnter(ctrl){
        //log.lv('ConfigFiles.toEnter('+ctrl+')')
        if(!u.folderExist(tiJsonsFolder.text)){
            u.mkdir(tiJsonsFolder.text)
            if(!u.folderExist(tiJsonsFolder.text)){
                tiJsonsFolder.t.color='red'
            }else{
                tiJsonsFolder.t.color=apps.fontColor
                apps.workSpace=tiJsonsFolder.text
                status.s=s+'\n\nLa carpeta no existía y se ha creado correctamente.'
            }
        }else{
            t.color=apps.fontColor
            apps.workSpace=tiJsonsFolder.text
        }
    }
    function clear(){

    }
    function toLeft(ctrl){
        if(!ctrl){

        }else{

        }
    }
    function toRight(ctrl){
        if(!ctrl){

        }else{

        }
    }
    function toUp(){

    }
    function toDown(){

    }
    function toTab(){
        //zpn.log('ConfigFiles.toTab()')
        tiJsonsFolder.t.focus=true
        tiJsonsFolder.t.selectAll()
    }
    function toEscape(){
        lv.currentIndex=0
    }
    function isFocus(){
        return lv.currentIndex>=0
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda para realizar ajustes en Archivos</h2><br><br><b>Presionar TAB: </b>Para saltar de un campo de introducción de datos a otro.<br><br><b>Presionar CTRL+ENTER: </b>Se graba o define el dato y se salta hacia el otro campo de introducción de datos.<br><br><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

            let c='import comps.ItemHelp 1.0\n'
            c+='ItemHelp{\n'
            c+='    text:"'+text+'"\n'
            c+='    ctx: "'+zsm.cPanelName+'"\n'
            c+='    objectName: "ItemHelp_'+app.j.qmltypeof(r)+'"\n'
            c+='}\n'
            let comp=Qt.createQmlObject(c, zsm, 'itemhelpcode')
        }
    }
    //<--Teclado

    //-->Funciones ModulesLoader
    function getJsonModules(){
        let j={}
        j.modules=[]

        let m={}
        m.name="InterLink"
        m.version='1.0'
        m.des="Módulo que permite ver los puntos de unión entre cuerpo, signo y casa para realizar una interpretación desde un punto de vista o inteligencia asociativa."
        j.modules.push(m)

        return j
    }
    function loadModulesList(){
        let j = getJsonModules()
        //zpn.log('json: '+JSON.stringify(j, null, 2))
        for(var i=0;i<j.modules.length;i++){
            lm.append(lm.addItem(j.modules[i]))
        }
    }
    function loadModule(index){
        let j = getJsonModules().modules[index]
        //zpn.log('j: '+JSON.stringify(j, null, 2))
        zsm.getPanel('ModulesManager').loadModule(j.name, j.version)
    }
    //<--Funciones ModulesLoader
}
