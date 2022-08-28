import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: cellWidth*15
    height: cellWidth*15
    color: 'transparent'
    antialiasing: true
    property int cellWidth: app.fs*0.45
    Row{
        id: row
        visible: apps.showAspPanel
        Repeater{
            model: r.visible?15:0
            CellColumnAsp{planet: index;cellWidth: r.cellWidth; objectName: 'cellRowAsp_'+index}
        }
    }
    Rectangle{
        width: r.cellWidth
        height: width
        color: apps.fontColor
        anchors.bottom: apps.showAspPanel?parent.top:parent.bottom
        border.width: 1
        border.color: apps.backgroundColor
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (mouse.modifiers & Qt.ControlModifier) {
                    apps.showAspCircle=!apps.showAspCircle
                    return
                }
                apps.showAspPanel=!apps.showAspPanel
            }
        }
        Text{
            text:  apps.showAspCircle?'\uf06e':'\uf070'
            font.family: "FontAwesome"
            font.pixelSize: r.cellWidth*0.8
            color: apps.backgroundColor
            opacity: apps.showAspCircle?1.0:0.65
            anchors.centerIn: parent
        }
        Text{
            text:  'Aspextos'
            font.pixelSize: app.fs*0.25
            color: apps.fontColor
            opacity: apps.showAspPanel?0.0:1.0
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.right
            anchors.leftMargin: app.fs*0.1
        }
    }
    function clear(){
        if(!r.visible)return
        for(var i=0;i<15;i++){
            let column=row.children[i]
            column.clear()
        }
    }
    function setAsp2(c1, c2, ia, iPosAsp){
        if(!r.visible)return
        let column=row.children[c2]
        let cellRow=column.col.children[c1]
        cellRow.indexAsp=ia
        cellRow.indexPosAsp=iPosAsp
    }
    function setAsp(c1, c2, ia, iPosAsp){
        if(!r.visible)return
        setAsp2(c1,c2,ia,iPosAsp)
        setAsp2(c2,c1,ia,iPosAsp)
    }
    function load(jsonData){
        if(!r.visible)return
        clear()
        if(!jsonData.asps)return
        let asp=jsonData.asps
        /*
        log.l(JSON.stringify(asp))
        for(var i=0;i<Object.keys(asp).length;i++){
            log.l('i: '+i)
            if(asp['asp'+parseInt(i )]){
                let a=asp['asp'+parseInt(i )]
                let strAsp=''+app.planetas[a.ic1]+' '+app.planetas[a.ic2]+' '+a.ia
                log.l(strAsp)
                log.visible=true
                if(asp['asp'+parseInt(i )]){
                    if((asp['asp'+parseInt(i )].ic1===10 && asp['asp'+parseInt(i)].ic2===11)||(asp['asp'+parseInt(i )].ic1===11 && asp['asp'+parseInt(i )].ic2===10)){
                        continue
                    }else{
                        //let a=asp['asp'+parseInt(i +1)]
                        setAsp(a.ic1, a.ic2, a.ia,i+1)
                    }
                }
            }
        }
        */
        for(var i=0;i<Object.keys(asp).length;i++){
            if(asp['asp'+parseInt(i +1)]){
                if(asp['asp'+parseInt(i +1)]){
                    if((asp['asp'+parseInt(i +1)].ic1===10 && asp['asp'+parseInt(i +1)].ic2===11)||(asp['asp'+parseInt(i +1)].ic1===11 && asp['asp'+parseInt(i +1)].ic2===10)){
                        continue
                    }else{
                        let a=asp['asp'+parseInt(i +1)]
                        setAsp(a.ic1, a.ic2, a.ia,i)
                    }
                }
            }
        }
    }
}
