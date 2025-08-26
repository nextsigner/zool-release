import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Menu General'
    w: app.fs*40
    Action {
        enabled: app.t==='rs'
        text: qsTr("Guardar Revolución")
        onTriggered: {
            //if(apps.dev)log.lv('MenuBack: '+JSON.stringify(JSON.parse(app.fileDataBack, null, 2)))                       }
            zfdm.addExtData(JSON.parse(app.fileDataBack))
            zsm.currentIndex=1
        }
    }
    //<--Clasificados
    /*ZoolMenus {
        title: qsTr("MMMM sdfas fas as a afsaa sd 1111 11111 22222");
        w: r.w
        property string text: title
        Action {
            text: qsTr("mmm 222");
            onTriggered: {
                zm.loadNow()
            }
        }
        Action {
            text: qsTr("mmm 333");
            onTriggered: {
                zm.loadNow()
            }
        }
    }*/
    ZoolMenus{
        title: 'Opciones de Archivo'
        w: r.w
        isContainer: true
        Action {text: qsTr("Cargar Tránsitos de Ahora"); onTriggered: {
                zm.loadNow()
            }
        }
        Action {
            id: aDeleteExt
            text: qsTr("Eliminar Exterior oculto")
            onTriggered: {app.j.deleteJsonBackHidden()}

        }
    }
    ZoolMenus{
        title: 'Capturar'
        w: r.w
        Action {text: qsTr("Crear capturas"); onTriggered: {
                zm.zmc.startMultiCap()
            }
        }
        Action {text: qsTr("Capturar"); onTriggered: {
                Cap.captureSweg()
            }
        }
        Action {text: qsTr("Crear imagen acutal y abrir"); onTriggered: {
                zm.zmc.startSinNombreYAbrir()
            }
        }
    }
    ZoolMenus{
        title: 'Opciones de Visualización'
        w: r.w
        Action {enabled: zm.ev; text: qsTr("Descartar exterior"); onTriggered: {
                zm.loadFromFile(apps.url, zm.getParams().t, false)
                zoolDataView.clearExtData()
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
            text: qsTr("Cargar Ejemplo")
            onTriggered: {
                zm.loadJsonFromFilePath('/home/ns/gd/Zool/Ricardo.json')
            }
        }
    }
    ZoolMenus{
        title: 'Configurar'
        w: r.w
        Action {text: apps.enableWheelAspCircle?"Habilitar Rotar con Mouse":"Deshabilitar Rotar con Mouse"; onTriggered: {
                apps.enableWheelAspCircle=!apps.enableWheelAspCircle
            }
        }
        Action {
            text: !apps.dev?"Habilitar Modo Desarrollador":"Deshabilitar Modo Desarrollador"
            onTriggered: {
                if(unik.folderExist('/home/ns')){
                    apps.dev=!apps.dev
                }
            }
        }
        Action {
            text: !apps.speakEnabled?"Habilitar Voz (Linux)":"Deshabilitar Voz (Linux)"
            onTriggered: {
                apps.speakEnabled=!apps.speakEnabled
                if(apps.speakEnabled){
                    let msg='Audio activado.'
                    zoolVoicePlayer.speak(msg, true)
                }
            }
        }

    }
    Action {text: qsTr("Salir"); onTriggered: {
            Qt.quit()
        }
    }
    Component{
        id: compDev
        Action {
            text: "Dev: "//+apps.dev;
            onTriggered: {
                apps.dev=!apps.dev
            }
        }
    }

    Timer{
        running: r.visible
        repeat: true
        interval: 250
        onTriggered: {
            /*let p=zfdm.getJsonAbs().params
            let json=JSON.parse(app.fileData)
            if(!app.ev&&json.paramsBack){
                aDeleteExt.enabled=true
            }else{
                aDeleteExt.enabled=false
            }*/
            //let d = new Date(Date.now())
            //log.lv('Menu ...'+d.getTime())
        }
    }

}
