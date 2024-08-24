import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    property int currentIndexHouse: -1
    property var aMI: []
    property bool isBack: false
    title: 'Menu Nombre'//+app.planetas[r.currentIndexPlanet]
    Action {text: qsTr("Editar Archivo"); onTriggered: {
            let panel=zsm.getPanel('ZoolFileManager').getSection('ZoolFileMaker')
            panel.setForEdit()
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
