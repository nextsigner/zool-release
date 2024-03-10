import QtQuick 2.0
import ZoolText 1.0

Item {
    id: r
    width: !isBack?signCircle.width+app.fs:(sweg.parent.height*apps.sweMargin)+extraWidth//((sweg.parent.height*(apps.sweMargin))+app.fs)
    height: width
    anchors.centerIn: signCircle
    visible: isBack?app.ev:true
    property bool isBack: false
    property int extraWidth: 0
    property int currentHouse: !isBack?sweg.objHousesCircle.currentHouse:sweg.objHousesCircleBack.currentHouse
    property int houseShowSelectadIndex: -1
    property int w: sweg.fs//*3
    property int wb: 1//sweg.fs*0.15
    property int f: 0
    property bool v: false
    property var arrayWg: []
    property string extraObjectName: ''
    property var swegParent//: value
    property int widthAspCircle: 10
    property var aWs: []
    property int c: 0
    property var aTipoEjes: ['Eje de<br><b>ENCUENTRO</b>', 'Eje de<br><b>POSESIONES</b>', 'Eje de<br><b>PENSAMIENTO</b>', 'Eje de la<br><b>INDIVIDUACIÓN</b>', 'Eje de<br><b>RELACIONES</b>', 'Eje de<br><b>EXISTENCIA</b>','Eje de<br><b>ENCUENTRO</b>', 'Eje de<br><b>POSESIONES</b>', 'Eje de<br><b>PENSAMIENTO</b>', 'Eje de la<br><b>INDIVIDUACIÓN</b>', 'Eje de<br><b>RELACIONES</b>', 'Eje de<br><b>EXISTENCIA</b>']
    property var aTipoEjesCasas:['Entre Casas<br>1 y 7', 'Entre Casas<br>2 y 8', 'Entre Casas<br>3 y 9', 'Entre Casas<br>4 y 10', 'Entre Casas<br>5 y 11', 'Entre Casas<br>6 y 12', 'Entre Casas<br>1 y 7', 'Entre Casas<br>2 y 8', 'Entre Casas<br>3 y 9', 'Entre Casas<br>4 y 10', 'Entre Casas<br>5 y 11', 'Entre Casas<br>6 y 12']
    Rectangle{
        anchors.fill: parent
        color: 'yellow'
        radius: width*0.5
        visible: false//r.isBack
    }
    Rectangle{
        width: r.width-app.fs
        height: width
        color: 'transparent'
        border.width: 1//apps.houseLineWidth
        border.color: apps.houseLineColorBack
        radius: width*0.5
        visible: r.isBack
        anchors.centerIn: parent
    }
    Item{
        id: dha//xDinamicHouserArcs
        anchors.fill: r
        property real fr: 0.00 //FakeRotation
    }
    Component{
        id: compArc
        Rectangle{
            id: item
            width: r.width
            height: 10
            color: 'transparent'
            border.width: 0
            border.color: 'white'
            anchors.centerIn: parent
            property int ih: -1
            property real wg: 0.000
            property string ejeTipoText: 'Eje Tipo Text Indefinido.'
            Rectangle{
                width: parent.width*0.5
                height: apps.houseLineWidth
                color: !isBack?apps.houseLineColor:apps.houseLineColorBack//apps.fontColor
                anchors.verticalCenter: parent.verticalCenter
                Rectangle{
                    width: !app.ev?app.fs*1.5:app.fs
                    height: width
                    radius: width*0.5
                    color: 'transparent'
                    border.width: 1//apps.houseLineWidth
                    border.color: !isBack?apps.houseLineColor:apps.houseLineColorBack//apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.left
                    anchors.rightMargin: 0//app.fs*14
                    rotation: 360-parent.parent.rotation+(!r.isBack?0:sweg.dirPrimRot)
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(!r.isBack){
                                //sweg.objHousesCircle.currentIndex=item.ih-1
                                app.currentHouseIndex=item.ih
                                r.currentHouse=app.currentHouseIndex
                            }else{
                                //sweg.objHousesCircleBack.currentIndex=item.ih-1
                                app.currentHouseIndexBack=item.ih
                                r.currentHouse=app.currentHouseIndexBack
                            }
                            //log.lv('r.currentHouse: '+r.currentHouse)
                        }
                    }
                    Text{
                        text: '<b>'+item.ih+'</b>'
                        font.pixelSize: !app.ev?app.fs*0.8:app.fs*0.75
                        color: !isBack?apps.houseLineColor:apps.houseLineColorBack//apps.fontColor
                        anchors.centerIn: parent
                    }
                }

                Text{
                    text:'<b>'+item.wg+'</b>'
                    font.pixelSize: 20
                    color: 'red'
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    visible: false
                }
            }
            Repeater{
                model: item.ih===r.currentHouse?wg:0
                //model: 10
                Rectangle{
                    width: !r.isBack?parent.width-(r.w*2):parent.width
                    height: 5
                    color: 'transparent'
                    rotation: 0-(0+index)
                    anchors.centerIn: parent
                    //visible: item.ih===r.currentHouse
                    LinePoints{
                        width: parent.width
                        height: parent.height
                        c: !r.isBack?apps.houseColor:apps.houseColorBack
                    }
                }
            }
            Rectangle{
                id: ec
                width: r.width+app.fs//*2
                height: xEjeTipo1.visible?3:0
                color: apps.fontColor//'yellow'//'transparent'
                //anchors.centerIn: r
                rotation: 0-item.wg/2
                //visible:c>5
                visible:sweg.ejeTipoCurrentIndex!==-2 && (sweg.ejeTipoCurrentIndex===item.ih-1 || sweg.ejeTipoCurrentIndex===item.ih-1-6 || sweg.ejeTipoCurrentIndex===-1)
                //visible:item.ih===1
                anchors.centerIn: parent

                property int fs: app.fs*0.75
                property color c1: toogleColor?apps.fontColor:apps.backgroundColor
                property color c2: !toogleColor?apps.fontColor:apps.backgroundColor
                property bool selected: false
                property bool toogleColor: false
                Timer{
                    running: parent.visible && sweg.ejeTipoCurrentIndex>=-1 && ec.selected
                    repeat: true
                    interval: 500
                    onTriggered: {
                        ec.toogleColor=!ec.toogleColor
                    }
                }
                Rectangle{
                    id: xEjeTipo1
                    //width: txtTipoEje1.contentWidth+app.fs//*0.5
                    width: txtTipoEje1.rotation===0?txtTipoEje1.contentWidth+app.fs:txtTipoEje11.contentWidth+app.fs//*0.5
                    height: colTxt1.height+app.fs*0.25
                    color: parent.c1
                    border.color: apps.fontColor
                    border.width: 3
                    radius: app.fs*0.25
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0-width//-app.fs
                    clip: true
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            ec.selected=!ec.selected
                            ec.toogleColor=false
                        }
                    }
                    Column{
                        id: colTxt1
                        spacing: app.fs*0.1
                        anchors.centerIn: parent
                        rotation: item.ih>3 && item.ih<10?180:0
                        Text{
                            id: txtTipoEje1
                            text: rotation===0?r.aTipoEjes[item.ih - 1]:r.aTipoEjesCasas[item.ih - 1]
                            //text: item.ih<=6?r.aTipoEjes[item.ih - 1]:'Casas '+parseInt(item.ih - 1)+' y '+parseInt(item.ih + 6)
                            color: ec.c2
                            font.pixelSize: ec.fs
                            horizontalAlignment: Text.AlignHCenter
                            //rotation: item.ih===4 || item.ih===3 || item.ih===2?180:0
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            id: txtTipoEje11
                            //text: 'Casas '+parseInt(r.c + 1)+' y '+parseInt(r.c + 7)
                            text: rotation===180?r.aTipoEjes[item.ih - 1]:r.aTipoEjesCasas[item.ih - 1]
                            color: ec.c2
                            font.pixelSize: ec.fs;
                            horizontalAlignment: Text.AlignHCenter
                            textFormat: Text.RichText
                            //rotation: item.ih===4 || item.ih===3 || item.ih===2?180:0
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }



                Rectangle{
                    visible: false
                    width: sweg.fs
                    height: width
                    //x:(r.w-width)/2
                    border.width: 2
                    border.color: 'white'
                    radius: width*0.5
                    color: 'red'//r.colors[r.c]
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: 90-r.rotation-parent.rotation
                    antialiasing: true
                    ZoolText {
                        text: '<b>'+parseFloat(r.wg).toFixed(2)+'</b>'
                        font.pixelSize: parent.width*0.3
                        anchors.centerIn: parent
                        color: 'white'
                        rotation: 270+ec.rotation
                    }
                }
            }
        }
    }
    //Probando/Visualizando rotación
    //    Rectangle{
    //        width: r.width
    //        height: 2
    //        anchors.centerIn: parent
    //        color: '#ff8833'
    //    }



    Text{
        text: 'RHC:'+r.rotation
        font.pixelSize: 40
        color: 'blue'
        //x: 300
        visible: false
    }
    function loadHouses(jsonData) {
        var i=0
        //xArcsBack.rotation=360-jsonData.ph.h1.gdec+signCircle.rot//+1
        dha.rotation=0
        for(i=0;i<dha.children.length;i++){
            dha.children[i].destroy(0)
        }
        for(i=0;i<12;i++){
            if(i===0){
                zm.uAscDegreeTotal=jsonData.ph.h1.gdec
            }
            let wg=0.05
            let g1=0
            let g2=0
            if(i!==11){
                g1=360-jsonData.ph['h'+parseInt(i + 1)].gdec
                g2=360-jsonData.ph['h'+parseInt(i + 2)].gdec
                wg=g1-g2
            }else{
                g1=360-jsonData.ph['h'+parseInt(i + 1)].gdec
                g2=360-jsonData.ph['h'+parseInt(0 + 1)].gdec
                wg=g1-g2
            }
            if(wg<0){
                wg=wg+360
            }
            let comp=compArc.createObject(dha, {rotation: 360-jsonData.ph['h'+parseInt(i + 1)].gdec+sweg.objSignsCircle.rot, ih: i+1, wg: wg})
        }
        if(app.t==='dirprim'){
            //xArcsBack.rotation-=sweg.dirPrimRot
            dha.rotation-=sweg.dirPrimRot
        }
    }

    function getHousePos(g, rot, ip, defaultRet){
        let rotDiff=360-rot
        let initdeg=0-rotDiff
        var findeg
        if(initdeg+180<g){
            initdeg+=360
        }
        for(var i=0;i<12;i++){
            findeg=initdeg+housesCircle.aWs[i]//-rotDiff
            if(g>initdeg&&g<findeg){
                return i + 1
            }
            initdeg+=housesCircle.aWs[i]
        }
        initdeg=0-rotDiff
        for(i=0;i<12;i++){
            findeg=initdeg+housesCircle.aWs[i]
            if(g>initdeg&&g<findeg){
                return i + 1
            }
            initdeg+=housesCircle.aWs[i]
        }
        return defaultRet
    }
    function reloadHousesColors() {
        for(i=0;i<12;i++){
            let h=dha.children[i]
            h.colors=['red','red','red','red','red','red','red','red','red','red','red','red']
        }
    }
}
