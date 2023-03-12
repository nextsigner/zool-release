import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS
import "../../js/Capture.js" as Cap
Menu {
    id: r
    width: app.fs*8
    property int currentIndexPlanet: -1
    property var aMI: []
    property bool isBack: false
    property int uX: 0
    property int uY: 0
    onOpenedChanged:  menuBar.expanded=opened
    //onCurrentIndexChanged: menuBar.uCMI=aMI[currentIndex]
    Component.onCompleted: menuBar.aMenuItems.push(this)
    delegate: MenuItem {
        id: menuItem
        implicitWidth: 200
        implicitHeight: 40

        arrow: Canvas {
            x: parent.width - width
            implicitWidth: 40
            implicitHeight: 40
            visible: menuItem.subMenu
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = menuItem.highlighted ? "#ffffff" : "#21be2b"
                ctx.moveTo(15, 15)
                ctx.lineTo(width - 15, height / 2)
                ctx.lineTo(15, height - 15)
                ctx.closePath()
                ctx.fill()
            }
        }

        indicator: Item {
            implicitWidth: 40
            implicitHeight: 40
            Rectangle {
                width: 26
                height: 26
                anchors.centerIn: parent
                visible: menuItem.checkable
                border.color: "#21be2b"
                radius: 3
                Rectangle {
                    width: 14
                    height: 14
                    anchors.centerIn: parent
                    visible: menuItem.checked
                    color: "#21be2b"
                    radius: 2
                }
            }
        }
        contentItem: Text {
            leftPadding: menuItem.indicator.width
            rightPadding: menuItem.arrow.width
            text: menuItem.text.replace('&', '')
            font: menuItem.font
            opacity: enabled ? 1.0 : 0.3
            color:menuItem.highlighted ? apps.fontColor : apps.backgroundColor
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: menuItem.highlighted ?  apps.backgroundColor : apps.fontColor
        }
    }
    title: 'Menu '+app.planetas[r.currentIndexPlanet]
    Action {enabled: app.mod==='rs'; text: qsTr("Guardar Revolución"); onTriggered: {
                           //if(app.dev)log.lv('MenuBack: '+JSON.stringify(JSON.parse(app.fileDataBack, null, 2)))                       }
            zfdm.addExtData(JSON.parse(app.fileDataBack))
            zsm.currentIndex=1
        }
    }
    Action {enabled: app.dev; text: qsTr("Cargar Ricardo"); onTriggered: {
                           app.j.loadJson('/home/ns/gd/Zool/Ricardo.json')
                       }
    }
    Action {text: qsTr("Cargar Tránsitos de Ahora"); onTriggered: {
                           app.j.loadNow()
                       }
    }
    Action {enabled: app.ev; text: qsTr("Descartar exterior"); onTriggered: {
                           app.j.loadJson(apps.url)
                       }
    }

    Action {text: qsTr("Zoom 1.0"); onTriggered: {
                           sweg.zoomTo(0.5)
                       }
    }
    Action {text: qsTr("Zoom 1.5"); onTriggered: {
                           sweg.zoomTo(1.0)
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
            let json=JSON.parse(app.fileData)
            if(!app.ev&&json.paramsBack){
                aDeleteExt.enabled=true
            }else{
                aDeleteExt.enabled=false
            }
            //let d = new Date(Date.now())
            //log.lv('Menu ...'+d.getTime())
        }
    }
}
