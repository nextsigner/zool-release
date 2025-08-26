import QtQuick 2.7
import QtQuick.Controls 2.0
import Qt.labs.folderlistmodel 2.12

import gui.ZoolDataBodies.ZoolBodiesSelView 1.0
import gui.ZoolDataBodies.ZoolDataBodiesItem 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    anchors.bottom: parent.bottom
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    state: 'show'
    property alias objZbsv: zbsv
    property var uJson
    property int latFocus: 0
    property int currentIndex: -1
    property int currentIndexBack: -1
    Behavior on x{NumberAnimation{duration: app.msDesDuration}}
    Column{
        Row{
            ZoolBodiesSelView{
                id: zbsv
                width: !zm.ev?r.width:r.width*0.5
            }
            ZoolBodiesSelView{
                id: zbsvExt
                width: r.width*0.5
                isExt: true
                visible: zm.ev
            }
        }
        Row{
            width: parent.width-r.border.width*2
            anchors.horizontalCenter: parent.horizontalCenter
            ZoolDataBodiesItem{id: xBodiesInt; isBack: false; hZBSL: zbsv.height;isLatFocus: r.latFocus===0}
            ZoolDataBodiesItem{id: xBodiesExt; isBack: true; hZBSL: zbsv.height; isLatFocus: r.latFocus===1}
        }
    }
    Rectangle{
        width: labelCargando.contentWidth+app.fs*0.25
        height: labelCargando.contentHeight+app.fs*0.25
        radius: app.fs*0.25
        border.width: 2
        border.color: apps.fontColor
        color: apps.backgroundColor
        opacity: !zm.ev?(xBodiesInt.opacity===1.0?0.0:1.0):(xBodiesInt.opacity===1.0&&xBodiesExt.opacity===1.0?0.0:1.0)
        anchors.centerIn: parent
        Text{
            id: labelCargando
            text: 'Cargando'
            font.pixelSize: app.fs
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }

    function loadJson(json){
        r.latFocus=0
        xBodiesInt.loadJson(json)
        //zoolMediaLive.loadJson(json)
    }
    function loadJsonBack(json){
        xBodiesExt.loadJson(json)
    }

    //--Teclado
    function toUp(ctrl){
        if(zoolDataBodies.latFocus===0){
            if(currentIndex>-1){
                currentIndex--
            }else{
                currentIndex=23
            }
        }
        if(zoolDataBodies.latFocus===1){
            if(currentIndexBack>-1){
                currentIndexBack--
            }else{
                currentIndexBack=23
            }
        }
        //        if(currentIndexBack===-1){
        //            zm.centerZoomAndPos()
        //        }
    }
    function toDown(ctrl){
        if(zoolDataBodies.latFocus===0){
            if(currentIndex<23){
                currentIndex++
            }else{
                currentIndex=-1
            }
        }
        if(zoolDataBodies.latFocus===1){
            if(currentIndexBack<23){
                currentIndexBack++
            }else{
                currentIndexBack=-1
            }
        }

    }
    function toLeft(ctrl){
        zoolDataBodies.latFocus=0
    }
    function toRight(ctrl){
        zoolDataBodies.latFocus=1
    }
    property int uIhEntered: -1
    function toEnter(){
        if(latFocus===0){
            if(xBodiesInt.currentIndex>19){
                zm.objHousesCircle.currentHouse=xBodiesInt.currentIndex-19
                let i=parseInt(xBodiesInt.currentIndex-19)
                let ih=0
                let jsonNot={}
                if(i===2){
                    ih=4
                }else if(i===3){
                    ih=7
                }else if(i===4){
                    ih=10
                }else{
                    ih=1
                }
                if(i!==r.uIhEntered){
                    zm.objHousesCircle.selectAscDescFcMc(ih, true)
                    r.uIhEntered=i
                }else{
                    zm.currentPlanetIndex=-1
                    zm.objHousesCircle.currentHouse=-1
                    zm.objHousesCircle.selectAscDescFcMc(ih, false)
                    r.uIhEntered=-1
                }
            }else{
                if(zm.currentPlanetIndex!==xBodiesInt.currentIndex){
                    zm.currentPlanetIndex=xBodiesInt.currentIndex
                }else{
                    zm.currentPlanetIndex=-1
                    zm.objHousesCircle.currentHouse=-1
                    zm.centerZoomAndPos()
                }
            }
        }else{
            if(xBodiesExt.currentIndex>19){
                zm.objHousesCircleBack.currentHouse=xBodiesInt.currentIndex-19
                let i=parseInt(xBodiesInt.currentIndex-19)
                let ih=0
                let jsonNot={}
                if(i===2){
                    ih=4
                }else if(i===3){
                    ih=7
                }else if(i===4){
                    ih=10
                }else{
                    ih=1
                }
                if(i!==r.uIhEntered){
                    zm.objHousesCircleBack.selectAscDescFcMc(ih, true)
                    r.uIhEntered=i
                }else{
                    zm.currentPlanetIndexBack=-1
                    zm.objHousesCircleBack.currentHouse=-1
                    zm.objHousesCircleBack.selectAscDescFcMc(ih, false)
                    r.uIhEntered=-1
                }
            }else{
                if(zm.currentPlanetIndexBack!==xBodiesExt.currentIndex){
                    zm.currentPlanetIndexBack=xBodiesExt.currentIndex
                }else{
                    app.currentPlanetIndexBack=-1
                    zm.objHousesCircleBack.currentHouse=-1
                }
            }
        }


    }
    //<--Teclado
}
