import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../../"
import "../../js/Funcs.js" as JS
import ZoolText 1.0


Rectangle{
    id: r
    width: showPlanets?r.sizeValue+r.maxPlanetsListWith:r.sizeValue//r.sizeValue
    height: iCap.height
    color: app.capturing?apps.backgroundColor:'transparent'
    anchors.top: parent.top
    anchors.topMargin: app.fs*0.1
    anchors.right: parent.right
    anchors.rightMargin: app.fs*0.1//spacing
    property alias itemCap: iCap
    property var aPorcs: [0.0, 0.0,0.0,0.0]
    //property int spacing: apps.elementsFs.fs*0.1
    property int spacing: apps.elementsFs*0.1
    property string arbolGen: '?'

    property url uItemGrabber
    property bool isBack: false
    property bool showPlanets: false
    property int maxPlanetsListWith: 0

    property int sizeValue: apps.elementsFs*40

    Rectangle{
        id: iCap
        width: col.width
        height: col.height
        color: parent.color
        border.width: 0//app.dev?10:0
        border.color: 'red'
        anchors.right: parent.right
        Column{
            id: col
            width: lv.width+r.maxPlanetsListWith
            anchors.centerIn: parent
            Rectangle{
                width: r.width
                height: xItemNums.height//apps.elementsFs*0.35
                color: apps.fontColor
                visible: app.ev && !r.isBack
                anchors.right: parent.right
                ZoolText{
                    text: '<b>Interior</b>'
                    font.pixelSize: xItemNums.fs
                    color: apps.backgroundColor
                    anchors.centerIn: parent
                }
            }
            ListView{
                id: lv
                width: xItemNums.width//r.sizeValue-r.maxPlanetsListWith
                height: xItemNums.height*4//*0.65*4+apps.elementsFs
                delegate: comp
                model: lm
                boundsBehavior: ListView.StopAtBounds
                anchors.right: parent.right
            }
            Rectangle{
                id: xItemNums
                width: (r.sizeValue*0.65)-r.maxPlanetsListWith
                height: r.sizeValue*0.06//apps.elementsFs*0.65
                border.width: 1
                border.color: apps.backgroundColor
                color: apps.fontColor
                radius: apps.elementsFs*0.15
                anchors.right: parent.right
                property int nd: 0
                property string ns: '0'
                property int ag: -1
                property int fs: r.sizeValue*0.04
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        ncv.currentDate=app.currentDate
                        ncv.setCurrentDate(app.currentDate)
                        ncv.setCurrentNombre(app.currentNom)
                        ncv.currentAG=app.arbolGenealogico[xItemNums.ag]
                        ncv.currentCargaAG=ncv.aCargasAG[xItemNums.ag]
                        sv.currentIndex=5
                        //ncv.printData(app.currentNom, app.currentDate)
                        //ncv.visible=true
                    }
                }
                Row{
                    anchors.centerIn: parent
                    spacing: apps.elementsFs*0.5
                    ZoolText{text: '<b>'+xItemNums.nd+'</b>'; color: apps.backgroundColor; font.pixelSize: xItemNums.fs}
                    ZoolText{text: '<b>'+xItemNums.ns+'</b>'; color: apps.backgroundColor; font.pixelSize: xItemNums.fs}
                    ZoolText{text: '<b>'+r.arbolGen+'</b>'; color: apps.backgroundColor; font.pixelSize: xItemNums.fs}
                }
            }
        }
    }
    ListModel{
        id: lm
        function addItem(e, p, c, v){
            return{
                element: e,
                porc: p,
                signColor: c,
                arrayPlan: v
            }
        }
    }
    Component{
        id: comp
        Rectangle{
            id: xItemElement
            width: xItemNums.width//r.sizeValue-r.maxPlanetsListWith
            height: xItemNums.height//apps.elementsFs*0.65
            border.width: 1
            border.color: apps.backgroundColor
            color: signColor
            radius: apps.elementsFs*0.15
            property var a: arrayPlan
            Row{
                anchors.centerIn: parent
                spacing: row.spacing//apps.elementsFs*0.5
                ZoolText{text: '<b>'+element+'</b>'; color: index===0||index===3?'white':'black'; font.pixelSize: xItemNums.fs}
                ZoolText{text: '<b>%'+porc+'</b>'; color: index===0||index===3?'white':'black'; font.pixelSize: xItemNums.fs}
            }
            Row{
                id: row
                spacing: r.sizeValue*0.01
                anchors.right: parent.left
                opacity: r.showPlanets?1.0:0.0
                onWidthChanged: {
                    if(width>r.maxPlanetsListWith)r.maxPlanetsListWith=width
                }
                Repeater{
                    id: rep
                    Item{
                        width: xItemElement.height
                        height: width
                        visible: modelData
                        Image{
                            id: img
                            source: modelData?'../../resources/imgs/planetas/'+app.planetasRes[modelData]+'.svg':''
                            anchors.fill: parent
                        }
                        ColorOverlay {
                            id: co
                            anchors.fill: img
                            source: img
                            color: signColor
                            antialiasing: true
                        }
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(row.width<=0){
                        rep.model=arrayPlan.split('|')
                        r.showPlanets=true
                    }else{
                        rep.model=[]
                    }

                }
            }
            Component.onCompleted: rep.model=arrayPlan.split('|')
        }
    }
    function load(j){
        r.maxPlanetsListWith=0
        let cFuego=0
        let cTierra=0
        let cAire=0
        let cAgua=0
        let cTotal=0
        let v1=''
        let v2=''
        let v3=''
        let v4=''
        for(var i=0;i<12;i++){
            //console.log('-------->'+j.pc['c'+i].is)
            if(j.pc['c'+i].is===0||j.pc['c'+i].is===4||j.pc['c'+i].is===8){
                cFuego++
                if(v1===''){
                    v1+=''+i
                }else{
                    v1+='|'+i
                }
            }
            if(j.pc['c'+i].is===1||j.pc['c'+i].is===5||j.pc['c'+i].is===9){
                cTierra++
                if(v2===''){
                    v2+=''+i
                }else{
                    v2+='|'+i
                }
            }
            if(j.pc['c'+i].is===2||j.pc['c'+i].is===6||j.pc['c'+i].is===10){
                cAire++
                if(v3===''){
                    v3+=''+i
                }else{
                    v3+='|'+i
                }
            }
            if(j.pc['c'+i].is===3||j.pc['c'+i].is===7||j.pc['c'+i].is===11){
                cAgua++
                if(v4===''){
                    v4+=''+i
                }else{
                    v4+='|'+i
                }
            }
            //let rFuego=
            cTotal++
        }
        if(j.ph['h1'].is===0||j.ph['h1'].is===4||j.ph['h1'].is===8){
            cFuego++
        }
        if(j.ph['h1'].is===1||j.ph['h1'].is===5||j.ph['h1'].is===9){
            cTierra++
        }
        if(j.ph['h1'].is===2||j.ph['h1'].is===6||j.ph['h1'].is===10){
            cAire++
        }
        if(j.ph['h1'].is===3||j.ph['h1'].is===7||j.ph['h1'].is===11){
            cAgua++
        }
        cTotal++
        let rFuego=cFuego/cTotal*100
        let rTierra=cTierra/cTotal*100
        let rAire=cAire/cTotal*100
        let rAgua=cAgua/cTotal*100
        let af=[parseFloat(rFuego).toFixed(1), parseFloat(rTierra).toFixed(1), parseFloat(rAire).toFixed(1), parseFloat(rAgua).toFixed(1)]
        //console.log('vi:'+v1.toString())
        updateListModel(af, v1, v2, v3, v4)
        let d = JS.getNums(app.currentFecha)
        xItemNums.nd=d[0]
        xItemNums.ns=d[1]
        xItemNums.ag=parseInt(d[2])
        r.arbolGen=app.arbolGenealogico[parseInt(d[2])][0]
        setUImgGrabber()
    }
    function setUImgGrabber(){
        r.grabToImage(function(result) {
            //result.saveToFile(folder+"/"+imgFileName);
            r.uItemGrabber=result.url
        });
    }
    function updateListModel(af, v1, v2, v3, v4){
        lm.clear()
        lm.append(lm.addItem('Fuego',af[0], app.signColors[0], v1))
        lm.append(lm.addItem('Tierra',af[1], app.signColors[1], v2))
        lm.append(lm.addItem('Aire',af[2], app.signColors[2], v3))
        lm.append(lm.addItem('Agua',af[3], app.signColors[3], v4))
    }
}
