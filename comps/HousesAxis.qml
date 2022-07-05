import QtQuick 2.0

Item{
    id: r
    width: signCircle.width+sweg.fs*4
    height: width
    anchors.centerIn: parent
    rotation: signCircle.rot
    property var aDegs: [0,10,20,30,40,50,60,70,80,90,100,110]
    property var aNums: [1,2]
    Repeater{
        id: rep
        model: aDegs
        Item{
            id: xItem
            objectName: 'c'+index
            width: parent.width//-signCircle.w
            height: 1
            rotation: aDegs[index]
            anchors.centerIn: parent
            Rectangle{
                width: sweg.fs*3
                height: 6
                //y:0-1
                //visible:r.aDegs.indexOf(index)>=0
                color: 'white'//r.aDegs.indexOf(index)>=0?'white':'#ff8833'
                antialiasing: true
                y:0-height*0.5
                //opacity: r.aDegs.indexOf(index)>=0?1.0:0.5
                Rectangle{
                    width: sweg.fs*0.65
                    height: width
                    radius: width*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: 0-xItem.rotation
                    Text{text:parseInt(index + 1);font.pixelSize: parent.width*0.6;anchors.centerIn: parent}
                }
            }
        }
    }
    function reload(i,g){
            r.children[i].rotation=g
        //        var na=a
//        console.log('na: '+a.toString())
//        console.log('l: '+r.children.length)
//        for(var i=0;i<12;i++){
//            console.log('l2: '+r.children[i].objectName)
//            //if(r.children[i].objectName.indexOf('c')>=0)r.children[i].rotation=a[i]
//        }
        //rep.model=na
    }
}
