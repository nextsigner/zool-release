import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Ver'
    w: r.w
    isContainer: true
    Action {
        text: "Cambiar Colores"//apps.fontColor==='white'?qsTr("Tema Claro"):qsTr("Tema Oscuro")
        onTriggered: {
            zm.nextTheme()
        }
    }
    Action {
        enabled: app.t==='vn'
        text: qsTr("Ver Mapa Evolutivo")
        onTriggered: {
            zev.visible=true
        }
    }
    Action {
        text: !apps.xAsShowIcon?qsTr("Ocultar glifos"):qsTr("Ver glifos");
        onTriggered: {
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }
    Action {
        text: zm.objAspsCircle.visible?qsTr("Ocultar Aspectos Internos"):qsTr("Ver Aspectos Internos");
        onTriggered: {
            zm.objAspsCircle.visible=!zm.objAspsCircle.visible
            if(zm.objAspsCircle.visible){
                zm.objAspsCircle.opacity=1.0
            }else{
                zm.objAspsCircle.opacity=0.0
            }
        }
    }
    Action {
        text: zm.objAspsCircleBack.visible?qsTr("Ocultar Aspectos Externos"):qsTr("Ver Aspectos Externos");
        onTriggered: {
            zm.objAspsCircleBack.visible=!zm.objAspsCircleBack.visible
            if(zm.objAspsCircleBack.visible){
                zm.objAspsCircleBack.opacity=1.0
            }else{
                zm.objAspsCircleBack.opacity=0.0
            }
        }
    }

    Action {text: zm.ev?'Ocultar Exterior':'Ver Exterior'; onTriggered: {
            zm.ev=!zm.ev
        }
    }
    Action {text: qsTr("Zoom 1.0"); onTriggered: {
            zm.zoomTo(1.0, true)
        }
    }
    Action {text: qsTr("Zoom 1.5"); onTriggered: {
            zm.zoomTo(1.5, true)
        }
    }
    Action {
        text: qsTr(apps.showNumberLines?"Ocultar grados":"Mostrar grados")
        onTriggered: {apps.showNumberLines=!apps.showNumberLines}
    }
    Action {
        enabled: apps.showNumberLines
        text: qsTr("Cambiar Pos. de grados")
        onTriggered: {apps.numberLinesMode=apps.numberLinesMode===0?1:0}
    }
    Action {
        text: qsTr("Cargar Ejemplo")
        onTriggered: {
            zm.loadJsonFromFilePath('/home/ns/gd/Zool/Ricardo.json')
        }
    }

    Action {
        text: qsTr("&Informe");
        onTriggered: {
            if(!xEditor.visible){
                xEditor.showInfo()
            }else{
                xEditor.visible=false
            }
        }
        checkable: true; checked: xEditor.visible}

    //MenuSeparator { }


    /*Action { text: qsTr("&Panel Zoom"); onTriggered: apps.showSWEZ=!apps.showSWEZ; checkable: true; checked: apps.showSWEZ}
    Action { text: qsTr("&Fondo Color de Rueda Zodiacal"); onTriggered: apps.enableBackgroundColor=!apps.enableBackgroundColor; checkable: true; checked: apps.enableBackgroundColor}
    Action { text: qsTr("&Definir Color de Fondo"); onTriggered: defColor('backgroundColor')}
    Action { text: qsTr("&Definir Color de Texto"); onTriggered: defColor('fontColor')}
    Action { text: qsTr("&Decanatos"); onTriggered: apps.showDec=!apps.showDec; checkable: true; checked: apps.showDec}
    MenuSeparator { }
    Action { text: qsTr("Ver &Lupa"); onTriggered: apps.showLupa=!apps.showLupa; checkable: true; checked: apps.showLupa}*/

}
