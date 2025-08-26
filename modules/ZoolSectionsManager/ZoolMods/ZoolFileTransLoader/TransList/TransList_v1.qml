import QtQuick 2.0

Rectangle{
    id: r
    width: 300
    height: lv.height
    color: 'transparent'
    border.width: 1
    border.color: apps.fontColor
    clip: true
    property alias olv: lv
    property alias olm: lm
    signal selected(string j)
    ListView{
        id: lv
        spacing: app.fs*0.1
        model: lm
        delegate: compItem
        width: r.width
        height: contentHeight
        //anchors.fill: parent

    }
    ListModel{
            id: lm
            function ai(vj){
                return {
                    j: vj
                }
            }
    }
    Component{
        id: compItem
        Rectangle{
                id: xItem
                width: r.width-app.fs*0.2
                height: t1.contentHeight+app.fs*0.2
                color: index===lv.currentIndex?apps.fontColor:apps.backgroundColor
                border.width: 1
                border.color:index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                radius: app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(lv.currentIndex!==index){
                            lv.currentIndex=index
                            r.selected(JSON.stringify(j))
                        }else{
                            lv.currentIndex=-1
                            zm.ev=false
                        }

                    }
                }
                Text{
                    id: t1
                    width: parent.width-app.fs*0.2
                    wrapMode: Text.WordWrap
                    font.pixelSize: app.fs*0.55
                    color: index!==lv.currentIndex?apps.fontColor:apps.backgroundColor
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
                Component.onCompleted: {                   
                    let sAsp=zm.objAspsCircle.getAspName(j.aspIndex)
                    t1.text='<b>'+sAsp+'</b> '+j.b+' '+j.d+'/'+j.m+'/'+j.a//+' '+j.h+':'+j.min
                }
        }
    }
    function addItem(j){
        lm.append(lm.ai(j))
    }
    function clear(){
        lv.currentIndex=-1
        lm.clear()
    }
    function isDateInList(j){
        let ret=false
        for(var i=0;i<lm.count;i++){
            let j0=lm.get(i).j
            if(j.a===j0.a && j.m===j0.m && j.d===j0.d){
                ret=true
                break
            }
        }
        return ret
    }
    function getData(bsel1){
        let ret=''
        for(var i=0;i<lm.count;i++){
            let j0=lm.get(i).j
            let aspName=zm.objAspsCircle.getAspName(j0.aspIndex)
            ret+=''+j0.d+'/'+j0.m+'/'+j0.a+' '+aspName+' '+j0.b+' sobre el '+zm.aBodies[bsel1]+'\n'

        }
        return ret
    }
}
