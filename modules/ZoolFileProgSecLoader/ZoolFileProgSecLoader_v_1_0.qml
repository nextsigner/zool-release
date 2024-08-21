import QtQuick 2.7
import QtQuick.Controls 2.0

import ZoolText 1.0
import ZoolTextInput 1.0
import ZoolButton 1.0
import ZoolControlsTime 1.0
import ZoolLogView 1.0

Rectangle {
    id: r
    width: xLatIzq.width
    height: xLatIzq.height-xPanelesTits.height-app.fs*0.5
    color: apps.backgroundColor
    border.width: 2
    border.color: apps.fontColor
    property int currentAnioNac: 0



    MouseArea{
        anchors.fill: parent
        //onDoubleClicked: colXConfig.visible=!xCtrlJsonsFolderTemp.visible
    }

    /*ZoolButton{
        text:'\uf013'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        z: col.z+1
        onClicked:{
            zoolFileManager.s.showConfig=!zoolFileManager.s.showConfig
        }
    }*/

    Flickable{
        id: flk
        width: r.width-app.fs
        height: r.height
        contentWidth: col.width
        contentHeight: col.height
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Item{width: 1; height: app.fs*0.25}
            ZoolText{
                id: tit
                //t.width:r.width-app.fs
                text: '<b>Crear Progresiones Secundarias</b>'
                w: r.width-app.fs
                font.pixelSize: app.fs*0.65
                color: 'white'
            }
            ListView{
                id: lv
                width: r.width-app.fs
                height: r.height-tit.t.contentHeight-app.fs*5//1.75
                delegate: delegate
                model: lm
                clip: true
                anchors.horizontalCenter: parent.horizontalCenter
                ListModel{
                    id: lm
                    function addItem(anio){
                        return {
                            a: anio
                        }
                    }
                }
                Rectangle{
                    anchors.fill: parent
                    color: 'transparent'
                    border.width: 1
                    border.color: apps.fontColor
                }
            }
        }
    }
    Component{
        id: delegate
        Rectangle{
            id: xItemList
            width: lv.width
            height: app.fs
            color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            border.width: 1
            border.color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
            //property int a: -1
            Text{
                text: a>1?'<b>Año: </b> '+parseInt(r.currentAnioNac + a)+' <b>Edad: </b>'+a+' años.':'<b>Año: </b> '+parseInt(r.currentAnioNac + a)+' <b>Edad: </b>'+a+' año.'
                font.pixelSize: app.fs*0.5
                color: index===lv.currentIndex?apps.backgroundColor:apps.fontColor
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    zsm.currentSectionFocused=r
                    lv.currentIndex=index
                    r.loadProgSec(a)
                }
            }
        }
    }
    Component.onCompleted: {
        updateDateList()
    }
    Timer{
        running: r.visible
        repeat: true
        interval: 1000
        onTriggered: {
            let p=zfdm.getJsonAbs().params
            r.currentAnioNac=p.a
            if(lm.count===0){
                updateDateList()
            }
        }
    }
    function updateDateList(){
        lm.clear()
        for(var i=0;i<150;i++){
            lm.append(lm.addItem(i))
        }
    }
    function loadProgSec(a){
        let d=zm.currentDate
        //log.lv('cd: '+cd.toString())
        d.setDate(d.getDate() + a)
        //log.lv('nd: '+d.toString())
        let p=zfdm.getJsonAbs().params
        let dia=d.getDate()
        let mes=d.getMonth()+1
        let anio=d.getFullYear()
        //r.currentAnioNac=anio
        let hora=d.getHours()
        let minutos=d.getMinutes()
        let gmt=p.gmt

        let nom='Año '+parseInt(d.getFullYear() + a)+' '
        nom+=a>1?"(Edad "+a+" años)":"(Edad "+a+" año)"
        let ciudad=p.c
        let lat=p.lat
        let lon=p.lon
        let alt=0
        if(p.alt)alt=p.alt


            zm.currentNomBack=nom
            zm.currentGeneroBack='n'
            zm.currentFechaBack=dia+'/'+mes+'/'+anio
            zm.currentLugarBack=ciudad
            zm.currentGmtBack=gmt
            zm.currentLonBack=lon
            zm.currentLatBack=lat
            zm.currentAltBack=alt
            zm.currentDateBack= new Date(parseInt(anio), parseInt(mes) - 1, parseInt(dia), parseInt(hora), parseInt(minutos))
        zm.loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), gmt,lat,lon, alt, nom, ciudad, "progsec", true)

    }
    function toUp(){
        if(lv.currentIndex>0){
            lv.currentIndex--
        }else{
            lv.currentIndex=lm.count-1
        }
    }
    function toDown(){
        if(lv.currentIndex<lm.count-1){
            lv.currentIndex++
        }else{
            lv.currentIndex=0
        }
    }
    function toRight(){
        loadProgSec(lv.currentIndex)
    }
}
