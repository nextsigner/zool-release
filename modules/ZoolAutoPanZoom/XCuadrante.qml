import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle{
    id: r
    color: 'transparent'
    border.width: selected?4:0
    border.color: 'red'
    visible: isPron
    property bool isPron: JSON.parse(app.fileData).params.tipo==='pron'
    property int c: -1
    property bool selected: aHouses.indexOf(sweg.objHousesCircle.currentHouse)>=0
    property var aHouses: []
    onSelectedChanged: {
        if(!isPron)return
        if(selected){
            let zp=getJsonZP()
            if(zp[0]===0&&zp[1]===0&&zp[2]===0&&zp[3]===0&&zp[4]===0&&zp[5]===0&&zp[6]===0&&zp[7]===0){
                sweg.centerZoomAndPos()
            }else{
                sweg.setZoomAndPos(zp)
            }
        }
    }
    Column{
        spacing: app.fs*0.5
        anchors.centerIn: parent
        Text{
            text: r.c
            font.pixelSize: app.fs*3
            color: apps.fontColor

        }
        Button{
            text: 'Grabar ZP'
            onClicked: {
                setJsonZP()
                let zp=r.getJsonZP()
                log.ls('ZP'+r.c+':', 0, 500)
                log.l('zp[0]:'+zp[0], 0, 500)
                log.l('zp[1]:'+zp[1], 0, 500)
                log.l('zp[2]:'+zp[2], 0, 500)
                log.l('zp[3]:'+zp[3], 0, 500)
                log.l('zp[4]:'+zp[4], 0, 500)
                log.l('zp[5]:'+zp[5], 0, 500)
                log.l('zp[6]:'+zp[6], 0, 500)
                log.l('zp[7]:'+zp[7], 0, 500)
            }
        }
    }
    Rectangle{
        id: centroide
        width: 10
        height: width
        color: 'transparent'
        border.width: 4
        border.color: 'red'
        anchors.centerIn: parent
    }

    function getJsonZP(){
        let zp=[]
        let jsonPath='./modules/ZoolAutoPanZoom/'+app.stringRes+'_zp.json'
        if(unik.fileExist(jsonPath)){
            let jsonData=unik.getFile(jsonPath)
            let json=JSON.parse(jsonData)
            zp=json['c'+r.c]
        }else{
            let jsonCode='{\n'
            jsonCode+=' "c1":[0,0,0,0,0,0,0,0],\n'
            jsonCode+=' "c2":[0,0,0,0,0,0,0,0],\n'
            jsonCode+=' "c3":[0,0,0,0,0,0,0,0],\n'
            jsonCode+=' "c4":[0,0,0,0,0,0,0,0]\n'
            jsonCode+='}\n'
            unik.setFile(jsonPath, jsonCode)
            zp=[0,0,0,0,0,0,0,0]
        }
        return zp
    }
    function setJsonZP(){
        let zp=sweg.getZoomAndPos()
        let jsonPath='./modules/ZoolAutoPanZoom/'+app.stringRes+'_zp.json'
        let jsonData=unik.getFile(jsonPath)
        let json=JSON.parse(jsonData)
        json['c'+r.c]=zp
        unik.setFile(jsonPath, JSON.stringify(json))
    }
}
