import QtQuick 2.0

Item {
    id: r
    width: !isBack?signCircle.width+app.fs:(sweg.parent.height*apps.sweMargin)+extraWidth//((sweg.parent.height*(apps.sweMargin))+app.fs)
    property bool isBack: false
    property int extraWidth: 0
    property int currentHouse: app.currentHouseIndex
    property int houseShowSelectadIndex: -1
    property int w: sweg.fs*3
    property int wb: 1//sweg.fs*0.15
    property int f: 0
    property bool v: false
    property var arrayWg: []
    property string extraObjectName: ''
    property var swegParent//: value
    property int widthAspCircle: 10
    property var aWs: []
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
            Rectangle{
                width: parent.width*0.5
                height: 1//apps.houseLineWidth
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
                    rotation: 360-parent.parent.rotation
                    Text{
                        text: '<b>'+item.ih+'</b>'
                        font.pixelSize: !app.ev?app.fs*0.8:app.fs*0.75
                        color: !isBack?apps.houseLineColor:apps.houseLineColorBack//apps.fontColor
                        anchors.centerIn: parent
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
        for(i=0;i<dha.children.length;i++){
            dha.children[i].destroy(0)
        }
        for(i=0;i<12;i++){

            let comp
            comp=compArc.createObject(dha, {rotation: 360-jsonData.ph['h'+parseInt(i + 1)].gdec+sweg.objSignsCircle.rot, ih: i+1})
        }
        ////housesAxis.reload(aDegs)

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
            let h=xArcs.children[i]
            h.colors=['red','red','red','red','red','red','red','red','red','red','red','red']
        }
    }
}
