import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import ZoolMenus 1.0

import ZoolMenus.ZoolMenuFiles 1.0
import ZoolMenus.ZoolMenuView 1.0
import ZoolMenus.ZoolMenuHelp 1.0


MenuBar{
    id: r
    visible: apps.showMenuBar
    height: app.fs
    focus: expanded

    property var aMenuItems: []
    property var uCMI // Ultimo Current Menu Item
    property bool expanded: false
    function right(){
        if(r.currentIndex<r.menus.length-1){
            r.currentIndex++
            r.menus[r.currentIndex - 1].close()
        }else{
            r.currentIndex=0
            r.menus[r.menus.length - 1].close()
        }
        r.menus[r.currentIndex].open()
    }
    function left(){
        if(r.currentIndex>0){
            r.currentIndex--
            r.menus[r.currentIndex + 1].close()
        }else{
            r.currentIndex=r.menus.length - 1
            r.menus[0].close()
        }
        r.menus[r.currentIndex].open()
    }
    function u(){
        var ci
        for(var i=0;i<aMenuItems.length; i++){
            if(aMenuItems[i].opened){
                if(aMenuItems[i].opened){
                    ci=aMenuItems[i]
                    break
                }
            }
        }
        if(ci){
            if(ci.currentIndex>0){
                ci.currentIndex--
            }else{
                ci.currentIndex=ci.count-1
            }
        }
    }
    function d(){
        var ci
        for(var i=0;i<aMenuItems.length; i++){
            if(aMenuItems[i].opened){
                if(aMenuItems[i].opened){
                    ci=aMenuItems[i]
                    break
                }
            }
        }
        if(ci){
            if(ci.currentIndex<ci.count-1){
                ci.currentIndex++
            }else{
                ci.currentIndex=0
            }
        }
    }
    function e(){
        var ci
        for(var i=0;i<aMenuItems.length; i++){
            if(aMenuItems[i].opened){
                if(aMenuItems[i].opened){
                    ci=aMenuItems[i]
                    break
                }
            }
        }
        if(ci){
            var cmi
            for(i=0;i<ci.count; i++){
                if(ci.itemAt(i).highlighted){
                    if(ci.itemAt(i).highlighted){
                        cmi=ci.itemAt(i)
                        break
                    }
                }
            }
            if(cmi)cmi.action.trigger()
        }
    }
    ZoolMenuFiles{parent: r}
    ZoolMenuView{parent: r}

    XMenu {
        title: qsTr("&Opciones")
        Action {
            text: qsTr("Activar todas las animaciones")
            onTriggered: apps.enableFullAnimation=!apps.enableFullAnimation; checkable: true; checked: apps.enableFullAnimation
        }

    }
    ZoolMenuHelp{parent: r}
    function defColor(object){
        xSelectColor.visible=true
        xSelectColor.c=object
    }
}
