import QtQuick 2.0

Item{
    id: r
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
            Text{
                id: txt1
                width: parent.width-app.fs
                font.pixelSize: app.fs*0.5
                color: !selected?apps.fontColor:apps.backgroundColor
                anchors.centerIn: parent
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
                let d=new Date(vMs)
                let s=''+at
                s+=' '+app.planeta[vObjAspectedIndex1]
                s+='/'+app.planeta[vObjAspectedIndex2]
                s+='\nFecha: '+d.toString()
                txt1.text=s
            }
        }
    }
    function addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms){
        lm.append(lm.addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms))
    }
}
