import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Guardar archivo'//+app.planetas[r.currentIndexPlanet]
    Action {
        text: qsTr("Guardar Archivo")
        onTriggered: {
            let date=new Date(Date.now())
            let msmod=date.getTime()
            let json=zm.currentJson.params

            let cjson=zfdm.getJsonAbs()
            let j=zm.getParamsFromArgs(cjson.params.n, json.d, json.m, json.a, json.h, json.min, json.gmt, json.lat, json.lon, json.alt, cjson.params.c, cjson.params.t, json.hsys, cjson.params.ms, msmod, cjson.params.f, cjson.params.g)
            if(zfdm.updateParams(j.params, true)){
                zm.loadJsonFromFilePath(apps.url)
            }else{
                //Error 594
                log.lv('Error N° 594 al guardar archivo.')
            }
        }
    }
    Action {text: qsTr("Ver Cambios"); onTriggered: {
            log.lv(zm.getRevIsDataDiff())
        }
    }
    Action {text: qsTr("Enviar a Zool.ar"); onTriggered: {
            let j=zfdm.getJsonAbs()
            //log.lv('json for send to zool.ar:'+JSON.stringify(j.params, null, 2))
            zrdm.sendNewParams(j)
        }
    }
}
