import QtQuick 2.0

Rectangle{
    id: r
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    clip: true
    property var moduleDirPrim
    ListView{
        id: lv
        width: r.width
        height: r.height
        model: lm
        delegate: compItem
    }
    ListModel{
        id: lm
        function addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms){
            return {
                vAspType: aspType,
                vObjAspectedIndex1: objAspectedIndex1,
                vObjAspectedIndex2: objAspectedIndex2,
                vMs: ms
            }
        }
    }
    Component{
        id: compItem
        Rectangle{
            id: xItem
            width: r.width
            height: txt1.contentHeight+app.fs
            color: selected?apps.fontColor:apps.backgroundColor
            border.width: 2
            border.color: txt1.color
            property bool selected: index===lv.currentIndex
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    let d = new Date(vMs)
                    moduleDirPrim.setFechaEvento(d)
                }
            }
            Text{
                id: txt1
                width: parent.width-app.fs*2
                wrapMode: Text.WordWrap
                font.pixelSize: app.fs*0.5
                color: !selected?apps.fontColor:apps.backgroundColor
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.5
                //anchors.centerIn: parent
            }
            Rectangle{
                id: cc
                width: app.fs
                height: width
                radius: width*0.5
                anchors.verticalCenter: parent.verticalCenter
                x:app.fs*0.25
            }
            Component.onCompleted: {
                /*
                vAspType: aspType,
                vObjAspectedIndex1: objAspectedIndex1,
                vObjAspectedIndex2: objAspectedIndex2,
                vMs: ms
                */

                let at='Indefinido'
                let ac='pink'
                if(vAspType===0){
                    at='Conjunción'
                    ac='blue'
                }else if(vAspType===1){
                    at='Oposición'
                    ac='red'
                }else if(vAspType===2){
                    at='Cuadratura'
                    ac='orange'
                }else{
                    at='No Indefinido'
                }
                cc.color=ac
                let d=new Date(vMs)
                let s=''+at
                s+=' '+app.planetas[vObjAspectedIndex1]
                s+='/'+app.planetas[vObjAspectedIndex2]
                s+='\nFecha: '+d.toString()
                txt1.text=s
            }
        }
    }
    function addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms){
        lm.append(lm.addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms))
    }
}
