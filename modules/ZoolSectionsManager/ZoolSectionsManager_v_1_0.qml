import QtQuick 2.12
import QtQuick.Controls 2.12
import '../../comps' as Comps

import ZoolDataText 1.0
import ZoolFileExtDataManager 1.1
import ZoolFileManager 1.3
import ZoolSabianos 1.1
import ZoolRevolutionList 1.4
import ZoolNumPit 1.0
import ZoolModulesManager 1.0

Item{
    id: r
    width: xLatIzq.width
    height: xLatIzq.height//-indicatorSV.height-xPanelesTits.height
    clip: true
    property int currentIndex: apps.currentSwipeViewIndex
    property int count: indicatorSV.count
    property var aPanelsIds: []
    onAPanelsIdsChanged: {
        indicatorSV.count=aPanelsIds.length
    }
    onCurrentIndexChanged:{
        apps.currentSwipeViewIndex=currentIndex
        zsm.getPanel('ZoolRevolutionList').desactivar()
    }
    Column{
        width: r.width
        anchors.centerIn: parent
        Rectangle{
            id: xPanelesTits
            width: xLatIzq.width
            height: app.fs*0.6
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            property var aPanelesTits: ['Información','Esquemas', 'Sabianos', 'Archivos', 'Revolución Solar', 'Módulos', 'Numerología', 'Funciones', 'Opciones', 'Texto a voz']
            Text{
                text: parseInt(zsm.currentIndex + 1)+': '+xPanelesTits.aPanelesTits[zsm.currentIndex]
                color: apps.backgroundColor
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
            }
        }

        Item{
            id: xPanels
            width: r.width
            height: r.height-xPanelesTits.height-xIndicadorSV.height
            Comps.XPaneles{ZoolDataText{id: panelZoolText;itemIndex: 0}}
            Comps.XPaneles{ZoolFileExtDataManager{id: zoolFileExtDataManager;itemIndex: 1}}
            Comps.XPaneles{ZoolSabianos{id: panelSabianos;itemIndex: 2}}
            Comps.XPaneles{ZoolFileManager{id: zoolFileManager;itemIndex: 3}}
            Comps.XPaneles{ZoolRevolutionList{id: panelRsList;itemIndex: 4}}
            //Comps.XPaneles{Comps.PanelZoolModules{id: panelZoolModules;itemIndex: 5}}
            Comps.XPaneles{ZoolModulesManager{}}
            Comps.XPaneles{ZoolNumPit{id: ncv;itemIndex: 6}}
            //XPaneles{PanelBotsFuncs{id: panelBotsFuncs;itemIndex: 6}}
            Comps.XPaneles{Comps.PanelZoolData{id: panelZoolData;itemIndex: 7}}
            //XPaneles{PanelVideoLectura{id: panelVideLectura;itemIndex: 9}}
        }
        Rectangle{
            id: xIndicadorSV
            width: xLatIzq.width
            height: indicatorSV.height
            color: 'transparent'
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    apps.zFocus='xLatIzq'
                }
            }
            PageIndicator {
                id: indicatorSV
                interactive: true
                count: 0//zsm.aPanelsIds.length
                currentIndex: zsm.currentIndex
                anchors.centerIn: parent
                onCurrentIndexChanged: zsm.currentIndex=currentIndex
                delegate: Rectangle{
                    width: app.fs*0.5
                    height: width
                    radius: width / 2
                    color: apps.fontColor
                    opacity: index === indicatorSV.currentIndex?0.95: pressed ? 0.7: 0.45
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
        }
    }
    function getPanel(typeOfSection){
        let obj
        for(var i=0;i<xPanels.children.length;i++){
            let o=xPanels.children[i].children[0]
            //if(app.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
}
