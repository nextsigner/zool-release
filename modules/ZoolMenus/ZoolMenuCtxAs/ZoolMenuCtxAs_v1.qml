import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0
import "../../../js/Capture.js" as Cap
ZoolMenus {
    id: r
    property int currentIndexPlanet: -1
    property int currentIndexSign: -1
    property int currentIndexHouse: -1
    property var aMI: []
    property bool isBack: false
    title: 'Menu '+zm.aBodies[r.currentIndexPlanet]
    Action {text: qsTr("Info"); onTriggered: {
            let b=r.currentIndexPlanet
            let s=r.currentIndexSign
            let h=r.currentIndexHouse
            //log.lv('b: '+b+' s: '+s+' h: '+h)
            zm.getZiData(b, s, h)
        }
    }
//    Action {text: qsTr(apps.anColorXAs?"No Centellar":"Centellar"); onTriggered: {
//            apps.anColorXAs=!apps.anColorXAs
//        }
//    }
    Action {text: qsTr("Grabar Posición"); onTriggered: {
            app.j.saveZoomAndPos()
            Cap.capturePlanet()
        }
    }
    Action {text: qsTr("Capturar"); onTriggered: {
            if(!r.isBack){
                Cap.captureSweg()
            }else{
                Cap.captureSwegBack()
            }
        }
    }
}
