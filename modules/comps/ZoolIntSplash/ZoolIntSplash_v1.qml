import QtQuick 2.0

Rectangle{
    id: r
    color: 'transparent'
    anchors.fill: parent
    onVisibleChanged: r.destroy(0)
    MouseArea{
        anchors.fill: parent
        onClicked: r.visible=false
    }
    Row{
        Rectangle{
            id: r1
            width: xLatIzq.width
            height: r.height
            color: apps.backgroundColor
            onOpacityChanged:{
                if(opacity===0.0){
                    r3.opacity=0.0
                }
            }
            Behavior on opacity{NumberAnimation{duration: 1500}}
        }
        Rectangle{
            id: r2
            width: xMed.width
            height: r.height
            color: apps.backgroundColor
            onOpacityChanged:{
                if(opacity===0.0){
                    r.visible=false
                }
            }
            Behavior on opacity{NumberAnimation{duration: 1500}}
            Column{
                id: col
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Text{
                    text: '<b>Zool</b>'
                    font.pixelSize: app.fs*2
                    color: apps.fontColor
                }
                Text{
                    text: 'Aplicación de Astrología\nCreada por Ricardo Martín Pizarro'
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                }
                Text{
                    id: txtVersion
                    font.pixelSize: app.fs*0.5
                    color: apps.fontColor
                }
            }
        }
        Rectangle{
            id: r3
            width: xLatIzq.width
            height: r.height
            color: apps.backgroundColor
            onOpacityChanged:{
                if(opacity===0.0){
                    r2.opacity=0.0
                }
            }
            Behavior on opacity{NumberAnimation{duration: 1500}}
        }
    }
    Timer{
        running: true
        interval: 5000
        onTriggered: r1.opacity=0.0
    }

    Component.onCompleted: {
        txtVersion.text='<b>Versión: </b>'+u.getFile('version')
        r.visible=!u.folderExist('/home/ns')
    }
}
