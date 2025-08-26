import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Ayuda'
    w: r.w
    isContainer: true
    /*Action {
        text: qsTr("Manual de Ayuda de Zool")
        onTriggered: {
            app.j.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/ayuda/main.qml', setZoolStart)
        }
    }
    Action {
        text: qsTr("Desarrolladores y Patrocinadores")
        onTriggered: {
            app.j.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/somos/main.qml', setZoolStart)
        }
    }
    Action {
        text: qsTr("&Novedades Sobre Zool")
        onTriggered: {
            app.j.getRD('https://github.com/nextsigner/nextsigner.github.io/raw/master/zool/windowstart/main.qml', setZoolStart)
        }
    }*/
    Action {
        text: qsTr("&Sobre Zool")
        onTriggered: {
            let s='Esta aplicación fue desarrollada por Ricardo Martín Pizarro.\nAbril 2021 Buenos Aires Argentina\nPara más información: nextsigner@gmail.com\nFue creada con el Framework Qt Open Source 5.14.2'
            zdm.showMsgBox('Sobre Zool', s, app.fs*20, app.fs*10)
        }
    }
    Action {
        text: qsTr("&Sobre Qt")
        onTriggered: {
            let s='Qt es la forma más rápida e inteligente de producir software líder en la industria que encanta a los usuarios.\nEl framework Qt tiene licencia doble, disponible tanto con licencias comerciales como de código abierto . La licencia comercial es la opción recomendada para proyectos que no son de código abierto.\nPara más información: https://qt.io/'
            zdm.showMsgBox('Sobre Qt', s, app.fs*20, app.fs*10)
        }
    }
}
