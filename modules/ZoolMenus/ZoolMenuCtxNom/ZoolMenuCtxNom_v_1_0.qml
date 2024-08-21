import QtQuick 2.12
import QtQuick.Controls 2.12
Menu {
    id: r
    width: app.fs*8
    property int currentIndexHouse: -1
    property var aMI: []
    property bool isBack: false
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
    title: 'Menu Nombre'//+app.planetas[r.currentIndexPlanet]
    Action {text: qsTr("Editar Archivo"); onTriggered: {
            let panel=zsm.getPanel('ZoolFileManager').getSection('ZoolFileMaker')
            panel.setForEdit()
        }
    }
    Action {text: qsTr("Crear Html"); onTriggered: {
            let genero='femenino'
            let p=zfdm.getJsonAbs().params
            if(p.g && p.g==='m')genero='masculino'
            mkHtml(genero)
        }
    }
    Action {text: qsTr("Eliminar Archivo"); onTriggered: {
            zfdm.deleteCurrentJson()
        }
    }
    function mkHtml(sexo){
        let j=zfdm.getJsonAbs().params
        let n=(j.n).replace(/_/g, '+')
        let d=j.d
        let m=j.m
        let a=j.a
        let h=j.h
        let min=j.min
        let gmt=j.gmt
        let ciudad=(j.c).replace(/_/g, '+')
        let lat=j.lat
        let lon=j.lon
        let alt=0
        if(j.alt)alt=j.alt
        let url='http://www.zool.ar/getZoolDataMapFull?n='+n+'&d='+d+'&m='+m+'&a='+a+'&h='+h+'&min='+min+'&gmt='+gmt+'&lugarNacimiento='+ciudad+'&lat='+lat+'&lon='+lon+'&alt='+alt+'&ciudad='+ciudad+'&ms=0&msReq=0&adminId=zoolrelease&sexo='+sexo
        Qt.openUrlExternally(url)
    }
}
