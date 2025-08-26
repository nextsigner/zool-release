import QtQuick 2.0
import ZoolControlsTime 1.0
import ZoolButton 1.2

Rectangle{
    id: r
    width: col.width+app.fs
    height: col.height+app.fs
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    Column{
        id: col
        spacing: app.fs*0.5
        anchors.centerIn: parent
        Text{
            text: 'Modificar Fecha'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
        }
        ZoolControlsTime{id: ct}
        Row{
            ZoolButton{
                text: 'Restaurar'
                onClicked:{
                    let p=zfdm.getJsonAbs().params
                    let d = new Date(p.a, p.m-1, p.d, p.h, p.min)
                    ct.currentDate=d
                }
            }
            ZoolButton{
                text: 'Modificar'
                onClicked:{
                    let json=zfdm.getJsonAbs()
                    json.params.d=ct.dia
                    json.params.m=ct.mes
                    json.params.a=ct.anio
                    json.params.h=ct.hora
                    json.params.min=ct.minuto
                    json.params.gmt=ct.gmt
                    json.params.d=ct.dia
                    //log.lv('Json: '+JSON.stringify(json, null, 2))
                    zfdm.mkFileAndLoad(json, false)
                    r.destroy(0)
                }
            }
        }
    }
    Component.onCompleted: {
        let p=zfdm.getJsonAbs().params
        let d = new Date(p.a, p.m-1, p.d, p.h, p.min)
        ct.currentDate=d
        //log.lv('Fecha: '+d.toString())
        //ct.dia=p.d
    }
}
