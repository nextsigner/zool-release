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
            text:'<b>Carpeta de Archivos</b>'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
        Text{
            text:'<b>Carpeta actual:</b> '+apps.workSpace
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            width: r.width-app.fs
            wrapMode: Text.WordWrap
        }
        Item{width: 1; height: app.fs*0.5}

//        Row{
//            spacing: app.fs*0.25
//            anchors.horizontalCenter: parent.horizontalCenter
//            ZoolText{
//                text:'Usar Carpeta Temporal:'
//                fs: app.fs*0.5
//                anchors.verticalCenter: parent.verticalCenter
//            }
//            CheckBox{
//                width: app.fs*0.5
//                checked: apps.isJsonsFolderTemp
//                anchors.verticalCenter: parent.verticalCenter
//                onCheckedChanged:app.cmd.runCmd('temp-silent')
//            }
//        }
        ZoolTextInput{
            id: tiJsonsFolder
            text: apps.workSpace
            width: r.width-app.fs*0.5
            t.font.pixelSize: app.fs*0.65
            t.parent.width: r.width-app.fs*0.5
            t.focus: false
            anchors.horizontalCenter: parent.horizontalCenter
            //KeyNavigation.tab: cbGenero//controlTimeFecha
            t.maximumLength: 200
            borderColor:apps.fontColor
            borderRadius: app.fs*0.25
            padding: app.fs*0.25
            horizontalAlignment: TextInput.AlignLeft
            onTextChanged: {
                //if(cbPreview.checked)loadTemp()
                if(!u.folderExist(t.text)){
                    t.color='red'
                }else{
                    t.color=apps.fontColor
                }
            }
            onEnterPressed: {
                if(!u.folderExist(t.text)){
                    u.mkdir(t.text)
                    if(!u.folderExist(t.text)){
                        t.color='red'
                    }else{
                        t.color=apps.fontColor
                        apps.workSpace=text
                        status.s=s+'\n\nLa carpeta no existía y se ha creado correctamente.'
                    }

                }else{
                    t.color=apps.fontColor
                    apps.workSpace=text
                }

            }
            FocusSen{
                width: parent.r.width
                height: parent.r.height
                radius: parent.r.radius
                border.width:2
                anchors.centerIn: parent
                visible: parent.t.focus
            }
            Text {
                text: 'Cambiar a carpeta'
                font.pixelSize: app.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }

        Text{
            id: status
            text: !tiJsonsFolder.t.focus?'Escribe una ubicación en donde se guardarán los archivos.\n\nPresiona TAB para ingresar al campo de texto y editar la ubicación de la carpeta.':s
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            width: r.width-app.fs*0.5
            wrapMode: Text.WordWrap
            property string s: 'Presionar Enter o Crtl+Enter para grabar la nueva ubicación.\n\nPresiona ESCAPE para cancelar la edición y volver a la última ubicación utilizada.'
        }
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
