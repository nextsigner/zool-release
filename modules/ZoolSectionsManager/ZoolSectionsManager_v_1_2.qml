import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../comps' as Comps


import ZoolModulesManager 1.0
import ZoolSectionsManager.ZoolFiles.ZoolFileManager 1.4
import ZoolSectionsManager.ZoolFileExtDataManager 1.2
import ZoolSectionsManager.ZoolMods 1.0
import ZoolSectionsManager.ZoolListLunar 1.0
import ZoolSectionsManager.ZoolSabianos 1.1
import ZoolSectionsManager.ZoolRevolutionList 1.6
import ZoolSectionsManager.ZoolNumPit 1.4
import ZoolSectionsManager.ZoolHelp 1.0
import ZoolSectionsManager.ZoolConfig 1.0
import mods.ModulesManager 1.0





import ZoolButton 1.2

import web.ZoolUserManager 1.0

Item{
    id: r
    width: xLatIzq.width
    height: xLatIzq.height//-indicatorSV.height-xPanelesTits.height
    clip: true
    property int currentIndex: count-1//apps.currentSwipeViewIndex
    property var currentSectionPrev: r
    property int count: indicatorSV.count
    property var aPanelsIds: []
    property var currentSectionFocused: r
    property var aPanelesTits: []
    property string uPanelIdHovered: ''
    property string cPanelName: ''

    property string currentSectionFocusedName: ''



    onCurrentSectionFocusedChanged: {
        r.currentSectionFocusedName=app.j.qmltypeof(currentSectionFocused)
    }
    onAPanelsIdsChanged: {
        indicatorSV.count=aPanelsIds.length
    }
    onCurrentIndexChanged:{
        apps.currentSwipeViewIndex=currentIndex
        r.showPanel(r.aPanelsIds[zsm.currentIndex])
        if(r.currentSectionPrev!==r){
            let panelPrevio=getPanel(app.j.qmltypeof(currentSectionPrev))
            let panelType=app.j.qmltypeof(panelPrevio)
            if(r.currentSectionPrev.hasUnUsedFunction){
                r.currentSectionPrev.unUsed();
                //log.lv('Panel Anterior con unUsed(): '+panelType)
            }else{
                //log.lv('Panel Anterior sin unUsed(): '+panelType)
            }
        }

        r.currentSectionPrev=getPanel(app.j.qmltypeof(getPanelObject(currentIndex)))
        zsm.getPanel('ZoolRevolutionList').desactivar()
    }
    MouseArea{
        anchors.fill: parent
    }
    Column{
        width: r.width
        anchors.centerIn: parent
        Rectangle{
            id: xPanelesTits
            width: xLatIzq.width
            height: r.aPanelesTits[zsm.currentIndex]?app.fs*0.6:0
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text: parseInt(zsm.currentIndex + 1)+': '+r.aPanelesTits[zsm.currentIndex]
                color: apps.backgroundColor
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
            }
        }

        Item{
            id: xPanels
            width: r.width
            height: r.height-xPanelesTits.height-xIndicadorSV.height

            //10
            Comps.XPaneles{ZoolConfig{id: zoolConfig;}}

            //9
            Comps.XPaneles{ModulesManager{}}

            //8
            Comps.XPaneles{ZoolHelp{id: zoolHelp;}}

            //7
            Comps.XPaneles{ZoolSabianos{id: panelSabianos}}

            //6
            Comps.XPaneles{ZoolNumPit{id: ncv}}

            //5
            Comps.XPaneles{ZoolRevolutionList{id: panelRsList}}

            //4
            Comps.XPaneles{ZoolListLunar{id: zoolListLunar;}}

            //3
            Comps.XPaneles{ZoolMods{id: zoolMods}}

            //2
            Comps.XPaneles{ZoolFileExtDataManager{id: zoolFileExtDataManager;}}


            //1
            Comps.XPaneles{ZoolFileManager{id: zoolFileManager}}
        }
        Rectangle{
            id: xIndicadorSV
            width: xLatIzq.width
            height: indicatorSV.height
            color: 'transparent'
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: container
                width: r.width-app.fs
                height: txtUPanelIdHovered.contentHeight+app.fs*0.25
                color: apps.fontColor
                border.width: 2
                border.color: 'blue'
                radius: app.fs*0.25
                anchors.bottom: parent.top
                anchors.bottomMargin: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                visible: r.uPanelIdHovered!==''
                property int minFontSize: 10 // Tamaño mínimo de fuente permitido
                property int maxFontSize: app.fs

                Text{}
                Text{
                    id: txtUPanelIdHovered
                    text: r.uPanelIdHovered
                    //width: contentWidth
                    font.pixelSize: app.fs
                    color: apps.backgroundColor
                    anchors.centerIn: parent
                    onTextChanged: ajustarTamanioFuente()
                    function ajustarTamanioFuente() {
                                    var newFontSize = container.maxFontSize;
                                    txtUPanelIdHovered.font.pixelSize = newFontSize;
                                    while (txtUPanelIdHovered.contentWidth > container.width-app.fs && newFontSize > container.minFontSize) {
                                        newFontSize -= 1;
                                        txtUPanelIdHovered.font.pixelSize = newFontSize;
                                    }
                                    tHideTxtUPanelId.restart()
                                }
                }
                Timer{
                    id: tHideTxtUPanelId
                    running: false
                    repeat: false
                    interval: 5000
                    onTriggered: r.uPanelIdHovered=''
                }

            }
            Text{
                text: r.currentSectionFocusedName
                font.pixelSize: app.fs*0.25
                color: apps.fontColor
                visible: false
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    apps.zFocus='xLatIzq'
                }
            }
            PageIndicator {
                id: indicatorSV
                interactive: true
                count: 0//zsm.aPanelsIds.length
                currentIndex: apps.currentSwipeViewIndex//zsm.currentIndex
                anchors.centerIn: parent
                onCurrentIndexChanged: zsm.currentIndex=currentIndex
                delegate: Rectangle{
                    width: app.fs*0.5
                    height: width
                    radius: width / 2
                    color: apps.fontColor
                    opacity: index === indicatorSV.currentIndex?0.95: pressed ? 0.7: 0.45
                    /*Rectangle{
                        width: parent.width*0.65
                        height: width
                        color: apps.backgroundColor
                        anchors.centerIn: parent
                        rotation: r.currentSectionFocusedName===app.j.qmltypeof(getPanelVisible())?45:0
                        visible:rotation===45
                        //rotation: 'ZoolNumPit'===app.j.qmltypeof(getPanelVisible())?45:0
                    }*/
                    Text{
                        text:'\uf04b'
                        font.family: "FontAwesome"
                        font.pixelSize: parent.width*0.75
                        color: apps.backgroundColor
                        anchors.centerIn: parent
                        rotation: 270
                        visible:r.currentSectionFocusedName===app.j.qmltypeof(getPanelVisible()) && parent.opacity===0.95
                    }
                    Text{
                        text:'\uf26c'
                        font.family: "FontAwesome"
                        font.pixelSize: parent.width*0.6
                        color: apps.backgroundColor
                        anchors.centerIn: parent
                        visible: index===0&&apps.repLectVisible
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onPositionChanged: r.uPanelIdHovered=r.aPanelesTits[index]
                        onEntered: {
                            //log.lv('PageIndicator: '+r.aPanelsIds[index])
                            r.uPanelIdHovered=r.aPanelesTits[index]
                        }
                        onExited: {
                            //log.lv('PageIndicator exited... ')
                            r.uPanelIdHovered=''
                        }
                        onClicked: {
                            zsm.currentIndex=index
                            if (mouse.modifiers) {
                                apps.repLectVisible=!apps.repLectVisible
                            }
                        }
                    }
                }
                Timer{
                    running: parent.count===0
                    repeat: true
                    interval: 1000
                    onTriggered: parent.count=zsm.aPanelsIds.length
                }
            }
            ZoolButton{
                text:'\uf0ab'
                width: parent.height-4
                height: width
                rotation: 90
                borderWidth: 0
                borderColor: 'transparent'
                colorInverted: true
                anchors.verticalCenter: xIndicadorSV.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 2
                onClicked: {
                    if(r.currentIndex>0)r.currentIndex--
                }
            }
            ZoolButton{
                text:'\uf0ab'
                width: parent.height-4
                height: width
                rotation: -90
                colorInverted: true
                anchors.verticalCenter: xIndicadorSV.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 2
                onClicked: {
                    if(r.currentIndex<r.count)r.currentIndex++
                }
            }
        }

    }
    Timer{
        running: true
        repeat: false
        interval: 2000
        onTriggered: {
            showPanel(r.aPanelsIds[apps.currentSwipeViewIndex])
            //r.currentIndex=apps.currentSwipeViewIndex
        }
    }
    Component.onCompleted: {
        allToEscape()
    }
    function getPanel(typeOfSection){
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
    function getPanelObject(index){
        return xPanels.children[Math.abs(xPanels.children.length-1-index)].children[0]
    }
    function showPanel(typeOfSection){
        //let newCi=-1
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                o.visible=true
                r.cPanelName=typeOfSection
                //newCi=i
                //r.currentSectionFocused=o
            }else{
                o.visible=false
            }
        }
        //r.currentIndex=newCi
    }
    function getPanelIndex(typeOfSection){
        let ci=-1
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            if(apps.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                ci=zsm.aPanelsIds.indexOf(app.j.qmltypeof(o))
                break
            }
        }

        return ci
    }
    function getPanelVisible(){
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            if(o.visible){
                obj=o
                break
            }
        }
        return obj
    }
    function setCurrentSectionFocusedName(){
        let s='-->:'+app.j.qmltypeof(currentSectionFocused)
        s+=' -->: '+currentSectionFocused.objectName
        log.lv(s)

    }
    function cleanDinamicItems(){
        for(var i=0;i<r.children.length;i++){
            let o=r.children[i]
            //zpn.log(o.objectName)
            if(o.objectName.indexOf('ItemHelp')>=0){
                o.destroy(0)
            }
        }
    }
    function cleanOneDinamicItems(objectName){
        let ret=false
        for(var i=0;i<r.children.length;i++){
            let o=r.children[i]
            //zpn.log(o.objectName)
            if(o.objectName.indexOf(objectName)>=0){
                o.destroy(0)
                ret=true
            }
        }
        return ret
    }
    //-->Teclado
    function toEnter(ctrl){
        cleanDinamicItems()
        r.currentSectionFocused=getPanelVisible()
    }
    function toLeft(ctrl){
        cleanDinamicItems()
        if(!ctrl){
            //setCurrentSectionFocusedName()
            if(!currentSectionFocused || currentSectionFocused===r){
                if(r.currentIndex>0){
                    r.currentIndex--
                }else{
                    r.currentIndex=r.aPanelesTits.length-1
                }
            }else{
                getPanelVisible().toLeft()
            }
        }else{
            getPanelVisible().toLeft(ctrl)
        }
    }
    function toRight(ctrl){
        cleanDinamicItems()
        //zpn.log('ZoolSectionsManager.toRight('+ctrl+')')
        if(!ctrl){
            if(!currentSectionFocused || currentSectionFocused===r){
                if(r.currentIndex<r.aPanelesTits.length-1){
                    r.currentIndex++
                }else{
                    r.currentIndex=0
                }
            }
        }else{
            getPanelVisible().toRight(ctrl)
        }
    }
    function toUp(){
        cleanDinamicItems()
        getPanelVisible().toUp()
    }
    function toDown(){
        cleanDinamicItems()
        getPanelVisible().toDown()
    }
    function toTab(){
        cleanDinamicItems()
        getPanelVisible().toTab()
    }
    function toEscape(){
        cleanDinamicItems()
        getPanelVisible().toEscape()
    }
    function toHelp(){
        cleanDinamicItems()
        getPanelVisible().toHelp()
    }
    //<--Teclado

    function allToEscape(){
        cleanDinamicItems()
        let aTypes=[]
        for(var i=0;i<xPanels.children.length;i++){
            aTypes.push(app.j.qmltypeof(xPanels.children[i].children[0]))
        }
        //zpn.log('aTypes: '+aTypes)
        for(i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            let sn=app.j.qmltypeof(o)
            //zpn.log('r.aPanelsIds:'+r.aPanelsIds)
            //zpn.log('sn:'+sn)
            if(aTypes.indexOf(sn)>=0){
                //console.log('toEscaped() in '+aTypes[i])
                if(o)o.toEscape()
            }
        }
    }
}
