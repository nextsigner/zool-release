import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Menu General'
    w:app.fs*40
   Action {enabled: app.t==='rs'; text: qsTr("Guardar Revolución"); onTriggered: {
                           //if(app.dev)log.lv('MenuBack: '+JSON.stringify(JSON.parse(app.fileDataBack, null, 2)))                       }
            zfdm.addExtData(JSON.parse(app.fileDataBack))
            zsm.currentIndex=1
        }
    }
    Action {enabled: app.dev; text: qsTr("Cargar Ricardo"); onTriggered: {
                           zm.loadJsonFromFilePath('/home/ns/gd/Zool/Ricardo.json')
                       }
    }
    Action {text: qsTr("Cargar Tránsitos de Ahora"); onTriggered: {
                           zm.loadNow()
                       }
    }
    Action {text: qsTr("Crear imagen acutal y abrir"); onTriggered: {
                           zm.zmc.startSinNombreYAbrir()
                       }
    }
    Action {text: qsTr("Crear capturas"); onTriggered: {
                           zm.zmc.startMultiCap()
                       }
    }
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
    Action {text: qsTr("Capturar"); onTriggered: {
                           Cap.captureSweg()
                       }
    }
    Action {
        id: aDeleteExt
        text: qsTr("Eliminar Exterior oculto")
        onTriggered: {app.j.deleteJsonBackHidden()}

    }
    Action {
        text: qsTr(apps.showNumberLines?"Ocultar grados":"Mostrar grados")
        onTriggered: {apps.showNumberLines=!apps.showNumberLines}
    }
    Action {text: qsTr("Salir"); onTriggered: {
                           Qt.quit()
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
