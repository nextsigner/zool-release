import QtQuick 2.0
import '../../comps' as Comps

import ZoolDataText 1.0
import ZoolFileExtDataManager 1.0
import ZoolFileManager 1.3
import ZoolSabianos 1.1
import ZoolRevolutionList 1.4
import ZoolNumPit 1.0
import ZoolModulesManager 1.0

Item{
    id: sv
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
    width: xApp.width*0.5
    height: xLatIzq.height-indicatorSV.height-xPanelesTits.height
    clip: true
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
    function getPanel(typeOfSection){
        let obj
        for(var i=0;i<sv.children.length;i++){
            let o=sv.children[i].children[0]
            //if(app.dev)log.lv('getPanel( '+typeOfSection+' ): ' +app.j.qmltypeof(o))
            if(''+app.j.qmltypeof(o)===''+typeOfSection){
                obj=o
                break
            }
        }
        return obj
    }
}
