import QtQuick 2.0
import QtQuick.Controls 2.0

import comps.FocusSen 1.0
import ZoolButton 1.0
import ZoolText 1.2
import ZoolTextInput 1.0

Rectangle{
    id: r
    width: parent.width-app.fs*0.5
    height: col.height+app.fs*0.5
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    color: 'transparent'
    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs*0.5
        Text{
            text:'<b>Tamaño de Elementos</b>'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
        Row{
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                text: "Reducir"
                font.pixelSize: app.fs*0.5
                onClicked: {
                    if(apps.fs>15){
                       apps.fs=apps.fs-1
                    }
                }
            }
            Button{
                text: "Agrandar"
                font.pixelSize: app.fs*0.5
                onClicked: {
                    if(apps.fs<70){
                       apps.fs=apps.fs+1
                    }
                }
            }
        }
        //Item{width: 1; height: app.fs*0.5}

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
        tiJsonsFolder.text=apps.workSpace
        tiJsonsFolder.t.focus=false
    }
    function isFocus(){
        return tiJsonsFolder.t.focus
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
}
