import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1

import comps.FocusSen 1.0
import ZoolButton 1.2
import ZoolText 1.2
import ZoolTextInput 1.0

Item{
    id: rMod
    width: 1
    height: 1
    property string moduleName: 'InterLink'
    property var aParents: [xMed, xLatIzq, xLatDer, capa101]
    Settings{
        id: s
        fileName: u.getPath(4)+'/module_'+r.moduleName+'.cfg'
        property int typeShow: 0
        onTypeShowChanged: {
            r.parent=rMod.aParents[s.typeShow]
        }
    }
    Rectangle{
        id: r
        width: parent.width
        height: parent.height
        border.width: 1
        border.color: apps.fontColor
        radius: app.fs*0.25
        color: apps.backgroundColor
        parent: zsm.getPanel('ModulesManager')
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                toNextArea()
            }
        }
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Item{width: 1; height: app.fs*0.5}
            Text{
                id: txtTit
                text:'<b>InterLink</b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
            //Item{width: 1; height: app.fs*0.5}

        }
        ZoolButton{
            id: botChangeArea
            text:'Cambiar de Area'
            fs: app.fs*0.35
            colorInverted: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.1
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.1
            onClicked: {
                toNextArea()
            }
        }
    }
    Component.onCompleted: {

    }

    //-->Teclado
    function toEnter(ctrl){

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

    }
    function toEscape(){

    }
    function isFocus(){
        return false
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda en Construcción</h2><br><br><b><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

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

    //-->Funciones ModulesTemplate
    function toNextArea(){
        if(s.typeShow<r.aParents.length-1){
            s.typeShow++
        }else{
            s.typeShow=0
        }
        zpn.log('s.fileName: '+s.fileName)
    }
    //<--Funciones ModulesTemplate
}
