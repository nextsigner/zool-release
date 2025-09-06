import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: r
    width: app.fs*6
    height: asContainer.height+app.fs*0.2
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.1
    property int xAsWidth: !zm.ev?r.width/(parseInt(zm.aBodies.length/2))-1:(r.width/(parseInt(zm.aBodies.length/2))-1)*2
    property bool isExt: false
    property string folderImg: '../../../../modules/ZoolMap/imgs/imgs_v1'
    Flow{
        id: asContainer
        spacing: 0//app.fs*0.1
        width: r.width-app.fs*0.2
        anchors.centerIn: parent
    }
    Component{
        id: compAs
        Item{
            id: xa
            width: r.xAsWidth
            height: width
            property int numAstro: -1
            property bool selected: false
            onSelectedChanged: {
                if(selected){
                    searchAsp(numAstro)
                }else{
                    searchAsp(-1)
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    xa.selected=!xa.selected
                }
            }
            Rectangle{
                width: parent.width-app.fs*0.1
                height: width
                radius: app.fs*0.1
                color: apps.backgroundColor
                border.width: xa.selected?2:1
                border.color: apps.fontColor
                anchors.centerIn: parent
                Rectangle{
                    color: apps.fontColor
                    radius: parent.radius
                    opacity: xa.selected?0.35:0.0
                    anchors.fill: parent
                }

                Image{
                    id: img
                    width: xa.selected?parent.width*0.65:xa.width*0.4
                    height: width
                    source: r.folderImg+'/'+app.planetasRes[numAstro]+'.svg'
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    source: img
                    color: apps.fontColor
                    anchors.fill: img
                }
            }
        }
    }
    Component.onCompleted: {
        updateAsSelList()
    }

    function updateAsSelList(){
        for(var i=0;i<asContainer.children.length;i++){
            asContainer.children[i].destroy(0)
        }
        var aSel=zm.aBodies//[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        for(i=0;i<aSel.length;i++){
            let obj=compAs.createObject(asContainer, {numAstro: i})
        }
    }
    function searchAsp(numAstro){
        zm.objAspsCircle.clearAxis()
        let j1
        let j2
        if(!zm.ev){
            j1=!r.isExt?zm.currentJson:zm.currentJsonBack
            j2=!r.isExt?zm.currentJson:zm.currentJsonBack
        }else{
            j1=!r.isExt?zm.currentJson:zm.currentJsonBack
            j2=r.isExt?zm.currentJson:zm.currentJsonBack
        }
        if(numAstro<0){
            if(!r.isExt){
                zm.objAspsCircle.load(zm.currentJson)
            }else{
                zm.objAspsCircle.load(zm.currentJsonBack)
            }
            return
        }

        let indexAsp=0
        let j={}
        j.asps={}
        let aAspsReg=[]

        let g1=j1.pc['c'+numAstro].gdec
        for(var i=0;i<zm.aBodies.length;i++){
            let g2=j2.pc['c'+i].gdec
            let aspType=zm.objAspsCircle.getAsp(g1, g2)
            if(aspType>=0){
                let indexAspName=zm.objAspsCircle.getAspName(indexAsp)
                let search=''+numAstro+':'+i
                if(aAspsReg.indexOf(search)<0&&numAstro!==i){
                    j.asps['asp'+indexAsp]={}
                    j.asps['asp'+indexAsp].ic1=numAstro
                    j.asps['asp'+indexAsp].ic2=i
                    j.asps['asp'+indexAsp].c1=zm.aBodies[numAstro]
                    j.asps['asp'+indexAsp].c2=zm.aBodies[i]
                    j.asps['asp'+indexAsp].ia=aspType
                    j.asps['asp'+indexAsp].gdeg1=g1
                    j.asps['asp'+indexAsp].gdeg2=g2
                    j.asps['asp'+indexAsp].dga=zm.objAspsCircle.diffDegn(g1, g2)
                    aAspsReg.push(''+numAstro+':'+i)
                    indexAsp++
                    zm.objAspsCircle.drawAspAxisRect(numAstro, aspType, g1, r.isExt)
                    zm.objAspsCircle.drawAspAxisRect(numAstro, aspType, g2, r.isExt)
                }
                //log.lv('indexAspName: '+indexAspName)
            }
        }
        //log.lv('j: '+JSON.stringify(j, null, 2))
        zm.objAspsCircle.loadFromJsonAsps(j)
    }
    function selBodie(numAstro){
        for(var i=0;i<asContainer.children.length;i++){
            asContainer.children[i].selected=false
        }
        if(numAstro>=0){
            asContainer.children[numAstro].selected=true
        }
    }
}
