import QtQuick 2.0
import QtQuick.Controls 2.0

import ZoolTextInput 1.0

Rectangle{
    id: r
    width: parent.width
    height: col.height+app.fs*0.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.2
    Column{
        id: col
        spacing: app.fs*0.25
        anchors.centerIn: parent
        Text{
            text: 'Enviar Mensaje, Correo o Número'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
        Item{width: 1; height: app.fs*0.5}
        ZoolTextInput{
            id: tiData
            width: r.width-app.fs*0.5
            t.font.pixelSize: app.fs*0.65
            anchors.horizontalCenter: parent.horizontalCenter
            //KeyNavigation.tab: controlTimeFecha
            t.maximumLength: 150
            borderColor:apps.fontColor
            borderRadius: app.fs*0.1
            padding: app.fs*0.25
            horizontalAlignment: TextInput.AlignLeft
            opacity: enabled?1.0:0.5
            onTextChanged: if(cbPreview.checked)loadTemp()
            onEnterPressed: {
                //controlTimeFecha.focus=true
                //controlTimeFecha.cFocus=0
            }
            Text {
                text: 'Datos a enviar'
                font.pixelSize: app.fs*0.5
                color: 'white'
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }
        }
        Text{
            id: salida1
            text: 'Tamaño '+tiData.t.length+'/'+tiData.t.maximumLength
            font.pixelSize: app.fs*0.35
            color: apps.fontColor
            width: r.width-app.fs
            wrapMode: Text.WordWrap
        }
        Button{
            id: botEnviar
            text: 'Enviar'
            font.pixelSize: app.fs*0.5
            opacity: enabled?1.0:0.5
            onClicked: {
                let s='Desde Formulario Contacto Zool: '
                s+=tiData.t.text
                tCheckSendMsg.uMsg=s
                pushOver.sendMessage(s)
            }
        }
        Timer{
            id: tCheckSendMsg
            running: uMsg!==''
            repeat: true
            interval: 1000
            property string uMsg: ''
            onTriggered: {
                if(pushOver.aMsgs.indexOf(uMsg)>=0){
                    uMsg=''
                    salida1.text='El mensaje ha sido enviado correctamente.'
                    botEnviar.enabled=false
                    tiData.enabled=false
                }else{
                    salida1.text='El mensaje aún NO ha sido enviado correctamente.'
                }
            }
        }
    }
}
