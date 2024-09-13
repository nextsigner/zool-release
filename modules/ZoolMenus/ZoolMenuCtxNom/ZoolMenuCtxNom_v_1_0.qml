import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Menu Nombre'//+app.planetas[r.currentIndexPlanet]
    Action {text: qsTr("Editar Archivo"); onTriggered: {
            let panel=zsm.getPanel('ZoolFileManager').getSection('ZoolFileMaker')
            panel.setForEdit()
        }
    }
    Action {text: qsTr("Crear Html en Zool.ar"); onTriggered: {
            let genero='femenino'
            let p=zfdm.getJsonAbs().params
            if(p.g && p.g==='m')genero='masculino'
            mkHtml(genero, true)
        }
    }
    Action {text: qsTr("Crear Html Local"); onTriggered: {
            let genero='femenino'
            let p=zfdm.getJsonAbs().params
            if(p.g && p.g==='m')genero='masculino'
            mkHtml(genero, false)
        }
    }
    Action {text: qsTr("Eliminar Archivo"); onTriggered: {
            zfdm.deleteCurrentJson()
        }
    }
    function mkHtml(sexo, remoto){
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
        let host='www.zool.ar'
        if(!remoto){
            host='localhost:8100'
        }
        let folderCaps=unik.getPath(3)+'/Zool/caps/'+zm.currentNom.replace(/ /g, '_')
        let url='http://'+host+'/getZoolDataMapFull?n='+n+'&d='+d+'&m='+m+'&a='+a+'&h='+h+'&min='+min+'&gmt='+gmt+'&lugarNacimiento='+ciudad+'&lat='+lat+'&lon='+lon+'&alt='+alt+'&ciudad='+ciudad+'&ms=0&msReq=0&adminId=zoolrelease&sexo='+sexo+'&onlyBodyData=FALSE&host='+host+'&printStd=FALSE&folderCaps='+folderCaps
        Qt.openUrlExternally(url)
    }
}
