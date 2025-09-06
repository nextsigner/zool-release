import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Archivos'
    w: r.w
    isContainer: true
    Action {
        text: qsTr("&Nuevo");
        onTriggered: {
            let panelIndex=zsm.getPanelIndex('ZoolFileManager')
            zsm.currentIndex=panelIndex
            zsm.getPanel('ZoolFileManager').showSection('ZoolFileMaker')
        }
    }
    Action {
        text: qsTr("&Abrir")
        onTriggered: {
            let panelIndex=zsm.getPanelIndex('ZoolFileManager')
            zsm.currentIndex=panelIndex
            zsm.getPanel('ZoolFileManager').showSection('ZoolFileLoader')
        }
    }
    Action {
        id: actGuardar
        text: qsTr("&Guardar")
        onTriggered: {
            zfdm.saveChanges()
            //app.j.saveJson()
        }

    }
    Timer{
        running: r.visible
        repeat: true
        interval: 1000
        onTriggered: {
            let isDataDiff=zm.isDataDiff
            if(isDataDiff){
                actGuardar.text="Guardar Cambios"
            }else{
                actGuardar.text="No hay Cambios"
            }
            actGuardar.enabled = isDataDiff
        }
    }
    Action {
        text: qsTr("Recargar archivo interior")
        onTriggered: {
            zm.unloadExt()
        }
    }
    Action {
        text: qsTr("Cargar Tránsitos de Ahora")
        onTriggered: {
            zm.loadNow()
        }
    }
    Action {
        id: aDeleteExt
        text: qsTr("Eliminar Exterior oculto")
        onTriggered: {
            app.j.deleteJsonBackHidden()
        }
    }
    Action {
        text: "Cerrar/Apagar Zool"
        onTriggered: {
            Qt.quit()
        }
    }
}
