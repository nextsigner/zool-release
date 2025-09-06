import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.1
import QtGraphicalEffects 1.0

import comps.FocusSen 1.0
import ZoolButton 1.2
import ZoolText 1.2
import ZoolTextInput 1.0

Item{
    id: rMod
    width: 1
    height: 1
    objectName: 'InterLink'
    property string moduleName: 'InterLink'
    property string folderImg: '../../../../modules/ZoolMap/imgs/imgs_v1'
    property string folderImgSigns: '../../../../imgs/signos'
    property var aParents: [capa101]
    property bool enableChangeArea: false

    property int cBSH: 1
    property string cKWS1: ''
    property string cKWS2: ''
    property string cKWS3: ''
    property int cKW1: 0
    property int cKW2: 0
    property int cKW3: 0
    onCKW1Changed: updateKwSelecteds()
    onCKW2Changed: updateKwSelecteds()
    onCKW3Changed: updateKwSelecteds()
    Settings{
        id: s
        fileName: u.getPath(4)+'/module_'+r.moduleName+'.cfg'
        property int typeShow: 0
        onTypeShowChanged: {
            r.parent=rMod.aParents[s.typeShow]
        }
    }
    Rectangle{
        id: r
        width: parent.width
        height: parent.parent.height
        border.width: 1
        border.color: apps.fontColor
        radius: app.fs*0.25
        color: apps.backgroundColor
        parent: zsm.getPanel('ModulesManager')
        property var aColors: [apps.backgroundColor, 'green', apps.backgroundColor]
        property int currentPlanetIndex: 0
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                toNextArea()
            }
        }
        Column{
            id: col
            anchors.centerIn: parent
            spacing: app.fs*0.25
            Item{width: 1; height: app.fs*0.25}
            Text{
                id: txtTit
                text:'<b>InterLink</b>'
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                anchors.horizontalCenter: parent.horizontalCenter
                //visible: false
            }
            Column{
                id: colBSH
            }
            //Item{width: 1; height: app.fs*0.5}

        }
        ZoolButton{
            id: botChangeArea
            text:'Cerrar'
            fs: app.fs*0.35
            colorInverted: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.1
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.1
            //visible: rMod.enableChangeArea
            onClicked: {
                zsm.getPanel('ModulesManager').loadModule('ModulesLoader', '1.0')
                //r.destroy(0)
                //toNextArea()
            }
        }
    }
    Component{
        id: compBSH
        Rectangle{
            id: xItem
            width: r.width
            height: ((r.height-txtTit.contentHeight-app.fs*0.75)/3)//-app.fs*0.5
            border.width: 3
            color: r.aColors[t]
            property int numAstro: -1
            property int is: -1
            property int h: -1
            property int t: -1
            property color textColor: apps.fontColor
            Row{
                Rectangle{
                    width: xItem.width*0.2
                    height: xItem.height
                    color: 'transparent'
                    border.width: 1
                    border.color: apps.fontColor
                    Rectangle{
                        width: colBodie.width+app.fs
                        height: colBodie.height+app.fs
                        color: 'transparent'
                        border.width: 2
                        border.color: xItem.textColor
                        radius: app.fs*0.2
                        anchors.centerIn: parent

                        Column{
                            id: colBodie
                            anchors.centerIn: parent
                            Text{
                                id: tit
                                //text:xItem.numAstro>=0?zm.aBodies[xItem.numAstro]:''
                                font.pixelSize: app.fs*1.5
                                color: xItem.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Image{
                                id: img
                                width: app.fs*2
                                height: width
                                //source: xItem.numAstro>=0?rMod.folderImg+'/'+app.planetasRes[xItem.numAstro]+'.svg':''
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: false
                            }
                            ColorOverlay{
                                source: img
                                color: xItem.textColor
                                width: img.width
                                height: img.height
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: xItem.t!==2
                            }
                        }
                    }
                }
                ListView{
                    id: lv
                    width: xItem.width*0.2
                    height: xItem.height
                    //anchors.fill: parent
                    model: lm
                    delegate: compItemList
                    boundsBehavior: ListView.StopAtBounds
                    //verticalScrollBar.interactive: false
                    ListModel{
                        id: lm
                        function addItem(kw, tipo){
                            return {
                                keyWord: kw,
                                t: tipo
                            }
                        }
                    }
                }
                Rectangle{
                    width: xItem.width*0.6
                    height: xItem.height
                    color: apps.backgroundColor
                    border.width: 2
                    border.color: apps.fontColor
                    radius: app.fs*0.5
                    Text{
                        text: xItem.t===0?'¿Qué expresa?':(xItem.t===1?'¿Cómo expresa?':'¿En dónde expresa?')
                        color: apps.fontColor
                        font.pixelSize: app.fs*3
                        //anchors.centerIn: parent
                        //anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text{
                        text: xItem.t===0?rMod.cKWS1:(xItem.t===1?rMod.cKWS2:rMod.cKWS3)
                        color: apps.fontColor
                        font.pixelSize: app.fs*3
                        anchors.centerIn: parent
                        //anchors.horizontalCenter: parent.horizontalCenter
                    }
                    /*Column{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        Text{
                            text: rMod.cKWS1
                            color: apps.fontColor
                            font.pixelSize: app.fs
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: rMod.cKWS2
                            color: apps.fontColor
                            font.pixelSize: app.fs
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text{
                            text: rMod.cKWS3
                            color: apps.fontColor
                            font.pixelSize: app.fs
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }*/
                }
            }
            FocusSen{
                width: parent.width*0.4
                height: parent.height
                //radius: parent.r.radius
                border.width: 6
                //anchors.centerIn: parent
                visible: xItem.t+1===rMod.cBSH
            }
            function setKwSelected(index){
                var item
                if(xItem.t===0){
                    for(var i=0;i<lm.count;i++){
                        item=lv.itemAtIndex(i)
                        if(rMod.cKW1 === i){
                            item.selected=true
                        }else{
                            item.selected=false
                        }
                    }
                }
                if(xItem.t===1){
                    for(i=0;i<lm.count;i++){
                        item=lv.itemAtIndex(i)
                        if(rMod.cKW2 === i){
                            item.selected=true
                        }else{
                            item.selected=false
                        }
                    }
                }
                if(xItem.t===2){
                    for(i=0;i<lm.count;i++){
                        item=lv.itemAtIndex(i)
                        if(rMod.cKW3 === i){
                            item.selected=true
                        }else{
                            item.selected=false
                        }
                    }
                }
            }
            Component.onCompleted: {
                r.parent=capa101
                let m0
                if(t===0){
                    m0=zds.getKeyWordsBodiesListData(numAstro)
                }
                if(t===1){
                    m0=zds.getKeyWordsSignsListData(is)
                }
                if(t===2){
                    m0=zds.getKeyWordsHousesListData(h)
                }
                for(var i=0;i<m0.length;i++){
                    lm.append(lm.addItem(m0[i], t))
                }
                if(t===0){
                    tit.text=zm.aBodies[xItem.numAstro]
                    img.source=rMod.folderImg+'/'+app.planetasRes[xItem.numAstro]+'.svg'
                }
                if(t===1){
                    tit.text=zm.aSigns[xItem.is]
                    img.source=rMod.folderImgSigns+'/'+is+'.svg'
                }
                if(t===2){
                    tit.text='Casa '+xItem.h
                }
                //let m1=m0.toString().split(',').join('\n')
                //txt.text=m1
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: xItem
            width: parent.width
            height: (xItem.parent.parent.height/10)
            border.width: 3
            color: 'transparent'//apps.backgroundColor
            //property int t: -1
            property bool selected: false
            onSelectedChanged: {
                if(selected){
                    if(t===0){
                        rMod.cKWS1=txtKW.text
                    }
                    if(t===1){
                        rMod.cKWS2=txtKW.text
                    }
                    if(t===2){
                        rMod.cKWS3=txtKW.text
                    }
                }
            }
            Text{
                id: txtKW
                text:  keyWord
                width: contentWidth//parent.width-app.fs
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
                Rectangle{
                    width: xItem.width*0.5-parent.width*0.5//-xItem.width
                    height: 3//app.fs*0.5
                    color: 'red'
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.left
                    visible: xItem.selected
                }
                Rectangle{
                    width: parent.width+4
                    height: parent.height+4
                    border.width: 1
                    border.color: parent.color
                    color: apps.backgroundColor
                    radius: height*0.15
                    anchors.centerIn: parent
                    z: parent.z-1
                }
            }
        }
    }
    Timer{
        running: false//true
        repeat: true
        interval: 1000
        onTriggered: {
            if(rMod.cKW1<9){
                rMod.cKW1++
            }else{
                rMod.cKW1=0
            }
        }
    }
    Component.onCompleted: {
        //app.ci=rMod
        //zsm.getPanel('ModulesManager').cm=rMod
        app.ci=rMod
        updateBSH()
    }
    function updateKwSelecteds(){
        for(var i=0;i<colBSH.children.length;i++){
            colBSH.children[i].setKwSelected(0)
        }
    }

    //-->Teclado
    function toEnter(ctrl){

    }
    function clear(){

    }
    function toLeft(ctrl){
        r.opacity=0.5
        if(!ctrl){
            if(rMod.cBSH>1){
                rMod.cBSH--
            }else{
                rMod.cBSH=3
            }
        }else{

        }
    }
    function toRight(ctrl){
        if(!ctrl){
            if(rMod.cBSH<3){
                rMod.cBSH++
            }else{
                rMod.cBSH=1
            }
        }else{

        }
    }
    function toUp(){
        if(rMod.cBSH===1){
            if(rMod.cKW1>0){
                rMod.cKW1--
            }else{
                rMod.cKW1=9
            }
        }
        if(rMod.cBSH===2){
            if(rMod.cKW2>0){
                rMod.cKW2--
            }else{
                rMod.cKW2=9
            }
            if(rMod.cBSH===3){
                if(rMod.cKW3>0){
                    rMod.cKW3--
                }else{
                    rMod.cKW3=9
                }
            }
        }
    }
    function toDown(){
        if(rMod.cBSH===1){
            if(rMod.cKW1<9){
                rMod.cKW1++
            }else{
                rMod.cKW1=0
            }
        }
        if(rMod.cBSH===2){
            if(rMod.cKW2<9){
                rMod.cKW2++
            }else{
                rMod.cKW2=0
            }
        }
        if(rMod.cBSH===3){
            if(rMod.cKW3<9){
                rMod.cKW3++
            }else{
                rMod.cKW3=0
            }
        }
    }
    function toTab(){

    }
    function toEscape(){
        zsm.getPanel('ModulesManager').loadModule('ModulesLoader', '1.0')
    }
    function isFocus(){
        return false
    }
    function toHelp(){
        let itemHelpExist=zsm.cleanOneDinamicItems("ItemHelp_"+app.j.qmltypeof(r))
        if(!itemHelpExist){
            let text='<h2>Ayuda en Construcción</h2><br><br><b><b>Presionar F1: </b>Para ver u ocultar esta ayuda.'

            let c='import comps.ItemHelp 1.0\n'
            c+='ItemHelp{\n'
            c+='    text:"'+text+'"\n'
            c+='    ctx: "'+zsm.cPanelName+'"\n'
            c+='    objectName: "ItemHelp_'+app.j.qmltypeof(r)+'"\n'
            c+='}\n'
            let comp=Qt.createQmlObject(c, zsm, 'itemhelpcode')
        }
    }
    //<--Teclado

    //-->Funciones ModulesTemplate
    function toNextArea(){
        if(s.typeShow<rMod.aParents.length-1){
            s.typeShow++
        }else{
            s.typeShow=0
        }
        //zpn.log('s.fileName: '+s.fileName)
    }
    //<--Funciones ModulesTemplate

    //-->Funciones de InterLink
    function updateBSH(){
        for(var i=0;i<colBSH.children.length;i++){
            colBSH.children[i].destroy(0)
        }
        let j=zm.currentJson
        let bodie=j.pc['c'+r.currentPlanetIndex]
        let b=r.currentPlanetIndex
        let s=bodie.is
        let h=bodie.ih

        let textColor=apps.backgroundColor
        if(s===0 || s===4 || s===8){
            textColor=apps.fontColor
        }

        r.aColors=[apps.backgroundColor, zm.aSignsColors[s], apps.backgroundColor]

        let obj1=compBSH.createObject(colBSH, {t: 0, numAstro: b})
        let obj2=compBSH.createObject(colBSH, {t: 1, is: s, textColor: textColor})
        let obj3=compBSH.createObject(colBSH, {t: 2, h: h})
    }
    //<--Funciones de InterLink

}
