import QtQuick 2.0
import '../../comps' as Comps

import ZoolDataText 1.0
import ZoolFileExtDataManager 1.0
import ZoolFileManager 1.3
import ZoolSabianos 1.1
import ZoolRevolutionList 1.4
import ZoolNumPit 1.0


Item{
    id: sv
    property int currentIndex: apps.currentSwipeViewIndex
    property int count: indicatorSV.count
    property var aPanelsIds: []
    onCurrentIndexChanged:{
        apps.currentSwipeViewIndex=currentIndex
        panelRsList.desactivar()
    }
    width: xApp.width*0.5
    height: xLatIzq.height-indicatorSV.height-xPanelesTits.height
    clip: true
    Comps.XPaneles{ZoolDataText{id: panelZoolText;itemIndex: 0}}
    Comps.XPaneles{ZoolFileExtDataManager{id: zoolFileExtDataManager;itemIndex: 1}}
    Comps.XPaneles{ZoolSabianos{id: panelSabianos;itemIndex: 2}}
    Comps.XPaneles{ZoolFileManager{id: zoolFileManager;itemIndex: 3}}
    Comps.XPaneles{ZoolRevolutionList{id: panelRsList;itemIndex: 4}}
    //Comps.XPaneles{Comps.PanelZoolModules{id: panelZoolModules;itemIndex: 5}}
    Comps.XPaneles{ZoolNumPit{id: ncv;itemIndex: 6}}
    //XPaneles{PanelBotsFuncs{id: panelBotsFuncs;itemIndex: 6}}
    Comps.XPaneles{Comps.PanelZoolData{id: panelZoolData;itemIndex: 7}}
    //XPaneles{PanelVideoLectura{id: panelVideLectura;itemIndex: 9}}
    function getPanel(typeOfPanel){
//        if(app.dev)log.lv('getPanel( '+typeOfPanel+' ): ')
//        for(var i=0;i<sv.aPanelsIds.length;i++){
//            if(app.dev)log.lv('aPanelsIds['+i+']='+sv.aPanelsIds[i])
//        }
        return sv.children[getPanelIndex(typeOfPanel)].children[0]
    }
    function getPanelIndex(typeOfPanel){
        let a=sv.aPanelsIds.reverse()
        return a.indexOf(typeOfPanel)
    }
}
