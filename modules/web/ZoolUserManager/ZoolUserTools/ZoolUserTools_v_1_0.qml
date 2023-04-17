import QtQuick 2.7
import QtQuick.Controls 2.0
import ZoolTextInput 1.0

import ZoolText 1.0
import ZoolButton 1.2

Rectangle {
    id: r
    width: xLatIzq.width
    height: parent.height
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor





    Column{
        id: col
        anchors.centerIn: parent
        spacing: app.fs
        Item{width: 1; height: app.fs; visible: colXConfig.visible}
        Text{
            text: '<b>Usuario</b>'
            font.pixelSize: app.fs*0.65
            color: 'white'
        }
        Text{
            text: '<b>Nombre: </b>'+apps.zoolUser
            font.pixelSize: app.fs*0.5
            color: 'white'
        }
        Row{
            spacing: app.fs*0.25
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                text: 'Almacenar copias de seguridad\nen el servidor de Zool: '
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox{
                id: cbSaveInServer
                checked: apps.enableSaveBackupInServer
                anchors.verticalCenter: parent.verticalCenter
                onCheckedChanged: apps.enableSaveBackupInServer=checked
            }
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: app.fs*0.25
            Button{
                id: botCrear
                text: 'Eliminar Usuario'
                font.pixelSize: app.fs*0.5
                KeyNavigation.tab: tiNombre.t
                onClicked: {
                    apps.zoolUser=''
                    apps.zoolUserId=''
                    apps.zoolKey=''
                    apps.enableSaveBackupInServer=fale
                }
            }
        }
    }
    QtObject{
        id: getUser
        function setData(data, isData){
            if(isData){
                let j=JSON.parse(data)
                if(app.dev){
                    log.lv('New user, id: '+j.user._id)
                    log.lv('New user, n: '+j.user.n)
                    log.lv('New user, c: '+unik.decData(j.user.c, tiNombre.text, tiClave.text))
                }
                apps.zoolUser=j.user.n
                apps.zoolUserId=j.user._id
                apps.zoolKey=j.user.c
            }else{
                log.lv('Falla getUser: '+data)
            }
        }
    }
    function enter(){

    }
    function clear(){
        tiNombre.t.text=''
        tiClave.text=''
    }
    function toRight(){

    }
    function toLeft(){

    }
    function toUp(){

    }
    function toDown(){

    }
    function setInitFocus(){
        tiNombre.t.selectAll()
        tiNombre.t.focus=true
    }
}
