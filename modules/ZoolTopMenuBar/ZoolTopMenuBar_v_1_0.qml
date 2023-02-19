import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import "../../js/Funcs.js" as JS

MenuBar{
    id: r
    visible: apps.showMenuBar
    height: app.fs
    focus: expanded

    property var aMenuItems: []
    property var uCMI // Ultimo Current Menu Item
    property bool expanded: false
    function right(){
        if(r.currentIndex<r.menus.length-1){
            r.currentIndex++
            r.menus[r.currentIndex - 1].close()
        }else{
            r.currentIndex=0
            r.menus[r.menus.length - 1].close()
        }
        r.menus[r.currentIndex].open()
    }
    function left(){
        if(r.currentIndex>0){
            r.currentIndex--
            r.menus[r.currentIndex + 1].close()
        }else{
            r.currentIndex=r.menus.length - 1
            r.menus[0].close()
        }
        r.menus[r.currentIndex].open()
    }
    function u(){
        var ci
        for(var i=0;i<aMenuItems.length; i++){
            if(aMenuItems[i].opened){
                if(aMenuItems[i].opened){
                    ci=aMenuItems[i]
                    break
                }
            }
        }
        if(ci){
            if(ci.currentIndex>0){
                ci.currentIndex--
            }else{
                ci.currentIndex=ci.count-1
            }
        }
    }
    function d(){
        var ci
        for(var i=0;i<aMenuItems.length; i++){
            if(aMenuItems[i].opened){
                if(aMenuItems[i].opened){
                    ci=aMenuItems[i]
                    break
                }
            }
        }
        if(ci){
            if(ci.currentIndex<ci.count-1){
                ci.currentIndex++
            }else{
                ci.currentIndex=0
            }
        }
    }
    function e(){
        var ci
        for(var i=0;i<aMenuItems.length; i++){
            if(aMenuItems[i].opened){
                if(aMenuItems[i].opened){
                    ci=aMenuItems[i]
                    break
                }
            }
        }
        if(ci){
            var cmi
            for(i=0;i<ci.count; i++){
                if(ci.itemAt(i).highlighted){
                    if(ci.itemAt(i).highlighted){
                        cmi=ci.itemAt(i)
                        break
                    }
                }
            }
            if(cmi)cmi.action.trigger()
        }
    }
    XMenu {
        title: qsTr("&Archivo")
        Action {text: qsTr("&Nuevo"); onTriggered: zsm.getPanel('ZoolFileManager').showSection('ZoolFileMaker')}
        Action { text: qsTr("&Abrir"); onTriggered: zsm.getPanel('ZoolFileManager').showSection('ZoolFileLoader') }
        Action {enabled: app.fileData!==app.currentData; text: qsTr("&Guardar"); onTriggered: JS.saveJson() }
        //Action { text: qsTr("Save &As...") }
        MenuSeparator { }
        Action { text: qsTr("&Salir"); onTriggered: Qt.quit() }
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
    }
    XMenu {
        title: qsTr("&Ver")
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
        MenuSeparator { }
        Action { text: qsTr("&Panel Zoom"); onTriggered: apps.showSWEZ=!apps.showSWEZ; checkable: true; checked: apps.showSWEZ}
        Action { text: qsTr("&Fondo Color de Rueda Zodiacal"); onTriggered: apps.enableBackgroundColor=!apps.enableBackgroundColor; checkable: true; checked: apps.enableBackgroundColor}
        Action { text: qsTr("&Definir Color de Fondo"); onTriggered: defColor('backgroundColor')}
        Action { text: qsTr("&Definir Color de Texto"); onTriggered: defColor('fontColor')}
        Action { text: qsTr("&Decanatos"); onTriggered: apps.showDec=!apps.showDec; checkable: true; checked: apps.showDec}
        MenuSeparator { }
        Action { text: qsTr("Ver &Lupa"); onTriggered: apps.showLupa=!apps.showLupa; checkable: true; checked: apps.showLupa}
        MenuSeparator { }
        Action { text: qsTr("Ver Rueda Sin Aspectos"); onTriggered: sweg.state=sweg.aStates[0]; checkable: true; checked: sweg.state===sweg.aStates[0]}
        Action { text: qsTr("Ver Rueda Resaltando Casas "); onTriggered: sweg.state=sweg.aStates[1]; checkable: true; checked: sweg.state===sweg.aStates[1]}
        Action { text: qsTr("Ver Rueda con Aspectos"); onTriggered: sweg.state=sweg.aStates[2]; checkable: true; checked: sweg.state===sweg.aStates[2]}
        //MenuSeparator { }
        //Action { text: qsTr("Ver PanelRemoto"); onTriggered: panelRemoto.state=panelRemoto.state==='show'?'hide':'show'; checkable: true; checked: panelRemoto.state==='show'}
    }
    XMenu {
        title: qsTr("&Colores")
        Action { text: qsTr("Color de Cuerpos Interior"); onTriggered: defColor('xAsColor')}
        Action { text: qsTr("Color de Cuerpos Exterior"); onTriggered: defColor('xAsColorBack')}
    }

//    XMenu {
//        title: qsTr("&Paneles")
//        Action { text: qsTr("&Panel Información"); onTriggered: panelDataBodies.state=panelDataBodies.state==='show'?'hide':'show'; checkable: true; checked: panelDataBodies.state==='show'}
//        Action { text: qsTr("&Panel Crear Archivo"); onTriggered: zsm.getPanel('ZoolFileManager').state=zsm.getPanel('ZoolFileManager').state==='show'?'hide':'show'; checkable: true; checked: zsm.getPanel('ZoolFileManager').state==='show'}
//        Action { text: qsTr("&Panel Buscar Archivo"); onTriggered: zsm.getPanel('ZoolFileManager').state=zsm.getPanel('ZoolFileManager').state==='show'?'hide':'show'; checkable: true; checked: zsm.getPanel('ZoolFileManager').state==='show'}
//        Action { text: qsTr("&Panel Inferior"); onTriggered: xBottomBar.state=xBottomBar.state==='show'?'hide':'show'; checkable: true; checked: xBottomBar.state==='show'}
//        Action { text: qsTr("&Panel Zoom"); onTriggered: apps.showSWEZ=!apps.showSWEZ; checkable: true; checked: apps.showSWEZ}
//    }

    XMenu {
        title: qsTr("&Opciones")
        Action { text: qsTr("Activar todas las animaciones"); onTriggered: apps.enableFullAnimation=!apps.enableFullAnimation; checkable: true; checked: apps.enableFullAnimation}
        Action { text: qsTr("Actualizar Panel Remoto");onTriggered: JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/panelremoto/main.qml', panelRemoto)}
        Action { text: qsTr("Centellar Planetas"); onTriggered: apps.anColorXAs=!apps.anColorXAs; checkable: true; checked: apps.anColorXAs}

    }
    XMenu {
        title: qsTr("&Ayuda")
        Action { text: qsTr("Manual de Ayuda de Zool");onTriggered: JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/ayuda/main.qml', setZoolStart)}
        Action { text: qsTr("Desarrolladores y Patrocinadores");onTriggered: JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/somos/main.qml', setZoolStart)}
        Action { text: qsTr("&Novedades Sobre Zool");onTriggered: JS.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/windowstart/main.qml', setZoolStart)}
        Action { text: qsTr("&Sobre Zool");onTriggered: mdSA.visible=true}
        Action { text: qsTr("&Sobre Qt");onTriggered: mdSQ.visible=true}
    }
    MessageDialog {
        id: mdSA
        title: "Sobre Zool"
        width: app.fs*10
        standardButtons:  StandardButton.Close
        icon: StandardIcon.Information
        text: "<b>Zool v"+version+"</b>"
        informativeText: "Esta aplicación fue desarrollada por Ricardo Martín Pizarro.\nJunio 2021 Buenos Aires Argentina\nPara más información: nextsigner@gmail.com\nFue creada con el Framework Qt Open Source 5.15.2"
        onAccepted: {
            close()
        }
    }
    MessageDialog {
        id: mdSQ
        title: "Sobre Qt"
        width: app.fs*10
        standardButtons:  StandardButton.Close
        icon: StandardIcon.Information
        text: "Qt Open Source"
        informativeText:"Qt es la forma más rápida e inteligente de producir software líder en la industria que encanta a los usuarios.\nEl framework Qt tiene licencia doble, disponible tanto con licencias comerciales como de código abierto . La licencia comercial es la opción recomendada para proyectos que no son de código abierto.\nPara más información: https://qt.io/"
        onAccepted: {
            close()
        }
    }

    function defColor(object){
        xSelectColor.visible=true
        xSelectColor.c=object
    }
}
