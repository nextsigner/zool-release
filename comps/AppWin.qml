import QtQuick 2.12
import QtQuick.Controls 2.12
import "../js/Funcs.js" as JS

ApplicationWindow {
    id: r
    property alias ip: itemXPlanets
    Item{
        id: itemXPlanets
        anchors.fill: parent
        //XPlanets{id: xPlanets}
        function showSS(){
            let comp=Qt.createComponent("XPlanets.qml")
            let obj=comp.createObject(itemXPlanets)
            if(obj){
                app.sspEnabled=true
            }
        }
        function hideSS(){
            for(var i=0;itemXPlanets.children.length;i++){
                itemXPlanets.children[i].destroy(1)
            }
        }
        Component.onCompleted: {
            if(unik.objectName!=='unikpy'){
                showSS()

            }
        }
    }

    //    Keys.onDownPressed: {
    //        log.l('event: '+event.text)
    //        log.visible=true
    //    }


    Shortcut{
        sequence: 'Ctrl+Down'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.ctrlDown()
                return
            }
            xBottomBar.state=xBottomBar.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Ctrl+Up'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.ctrlUp()
                return
            }
            xDataBar.state=xDataBar.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Space'
        onActivated: {
            if(apps.zFocus==='xLatIzq'){
                if(sv.currentIndex===9){
                    panelZoolData.tooglePlayPause()
                }
            }
            apps.xAsShowIcon=!apps.xAsShowIcon
        }
    }

    Shortcut{
        sequence: 'Ctrl+w'
        onActivated: {
            minymaClient.test()
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+w'
        onActivated: {
            //minymaClient.sendData(minymaClient.loginUserName, 'zool_data_editor', 'openPlanet|1|3|a')
        }
    }


    Shortcut{
        sequence: 'Ctrl+Space'
        onActivated: {
            if(app.currentPlanetIndex>=0&&app.currentXAs){
                app.showPointerXAs=!app.showPointerXAs
                return
            }
            if(panelZonaMes.state==='show'){
                panelZonaMes.pause()
                return
            }
            sweg.nextState()
            //swegz.sweg.nextState()
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+0'
        onActivated: {
            app.currentPlanetIndex=0
        }
    }
    Shortcut{
        sequence: 'Ctrl+1'
        onActivated: {
            app.currentPlanetIndex=1
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+2'
        onActivated: {
            app.currentPlanetIndex=2
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+3'
        onActivated: {
            app.currentPlanetIndex=3
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+4'
        onActivated: {
            app.currentPlanetIndex=4
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+5'
        onActivated: {
            app.currentPlanetIndex=5
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+6'
        onActivated: {
            app.currentPlanetIndex=6
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+7'
        onActivated: {
            app.currentPlanetIndex=7
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+8'
        onActivated: {
            app.currentPlanetIndex=8
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+9'
        onActivated: {
            app.currentPlanetIndex=9
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+*'
        onActivated: {
            app.currentPlanetIndex=15
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+/'
        onActivated: {
            app.currentPlanetIndex=16
        }
    }
    Shortcut{
        sequence: 'Return'
        onActivated: {
            if(xBottomBar.state==='show'){
                xBottomBar.enter()
                return
            }
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.toEnter()
                return
            }
            if(apps.zFocus==='xLatIzq'){
                if(apps.currentSwipeViewIndex===2&&zoolFileManager.currentIndex>=0){
                    zoolFileManager.enter()
                    return
                }
//                if(apps.currentSwipeViewIndex===3){
//                    zoolFileManager.enter()
//                    return
//                }
                if(apps.currentSwipeViewIndex===3){
                    panelRsList.enter()
                    return
                }
                if(apps.currentSwipeViewIndex===4){
                    ncv.enter()
                    return
                }
            }
        }
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            if(menuBar.expanded){
                menuBar.e()
                return
            }
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.toEnter()
                return
            }
            if(xEditor.visible){
                //xEditor.enter()
                //return
            }
            if(apps.currentSwipeViewIndex===2&&zoolFileManager.currentIndex>=0){
                zoolFileManager.enter()
                return
            }
            if(apps.currentSwipeViewIndex===3){
                zoolFileManager.enter()
                return
            }
            if(apps.currentSwipeViewIndex===4){
                panelRsList.enter()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Tab'
        onActivated: {
            if(apps.zFocus==='xLatIzq'){apps.zFocus='xMed';return;}
            if(apps.zFocus==='xMed'){apps.zFocus='xLatDer';return;}
            if(apps.zFocus==='xLatDer'){apps.zFocus='xLatIzq';return;}
            apps.zFocus='xLatIzq'
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: {
            if(app.objInFullWin){
                app.objInFullWin.escaped()
                return
            }
            if(panelLog.visible){
                panelLog.visible=false
                return
            }
            if(log.visible){
                log.visible=false
                return
            }
            if(videoListEditor.visible){
                videoListEditor.visible=false
                return
            }
            //Efecto sobre los paneles
            if(zoolFileManager.visible&&zoolFileManager.ti.focus){
                zoolFileManager.ti.focus=false
                return
            }
            if(zoolFileManager.visible&&(zoolFileManager.tiN.focus||zoolFileManager.tiC.focus)){
                if(zoolFileManager.tiN.focus){
                    zoolFileManager.tiN.focus=false
                }
                if(zoolFileManager.tiC.focus){
                    zoolFileManager.tiC.focus=false
                }
                return
            }
            if(xEditor.visible&&xEditor.e.textEdit.focus){
                xEditor.e.textEdit.focus=false
                xEditor.focus=true
                return
            }
            if(xEditor.visible&&xEditor.editing){
                xEditor.editing=false
                xEditor.e.textEdit.focus=false
                xEditor.focus=true
                return
            }
            if(xEditor.visible){
                xEditor.visible=false
                return
            }
            if(app.currentPlanetIndex>=0){
                app.currentPlanetIndex=-1
                return
            }
            if(app.currentPlanetIndexBack>=0){
                app.currentPlanetIndexBack=-1
                app.currentPlanetIndexBack=-1
                sweg.objHousesCircleBack.currentHouse=-1
                return
            }
            if(xSabianos.visible){
                xSabianos.visible=false
                return
            }
            if(xBottomBar.objPanelCmd.state==='show'){
                xBottomBar.objPanelCmd.state='hide'
                return
            }
            //            if(panelRsList.state==='show'){
            //                panelRsList.state='hide'
            //                return
            //            }
            if(zoolFileManager.state==='show'){
                zoolFileManager.state='hide'
                return
            }
            if(panelDataBodies.state==='show'){
                panelDataBodies.state='hide'
                return
            }
            if(zoolFileManager.state==='show'){
                zoolFileManager.state='hide'
                return
            }
            if(panelControlsSign.state==='show'){
                panelControlsSign.state='hide'
                return
            }
            if(xInfoData.visible){
                xInfoData.visible=false
                return
            }
            Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Ctrl+Esc'
        onActivated: {
            app.focus=true
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(menuBar.expanded){
                menuBar.u()
                return
            }
            if(xSabianos.visible){
                xSabianos.toup()
                return
            }

            if(apps.zFocus==='xLatIzq'){
                if(apps.currentSwipeViewIndex===2){
                    if(zoolFileManager.currentIndex>0){
                        zoolFileManager.currentIndex--
                    }else{
                        zoolFileManager.currentIndex=zoolFileManager.listModel.count-1
                    }
                    return
                }
                if(apps.currentSwipeViewIndex===3){
                    zoolFileManager.toUp()
                    return
                }
                if(panelControlsSign.state==='show'&&panelDataBodies.state==='hide'){
                    if(currentSignIndex>0){
                        currentSignIndex--
                    }else{
                        currentSignIndex=12
                    }
                    return
                }
                if(apps.currentSwipeViewIndex===4){
                    if(panelRsList.currentIndex>0){
                        panelRsList.currentIndex--
                    }else{
                        panelRsList.currentIndex=panelRsList.listModel.count-1
                    }
                    return
                }
            }
            if(apps.zFocus==='xLatDer'){
                tAutoMaticPlanets.stop()
                panelDataBodies.toUp()
                //                if(panelDataBodies.latFocus===0){
                //                    if(currentPlanetIndex>-1){
                //                        currentPlanetIndex--
                //                    }else{
                //                        currentPlanetIndex=16
                //                    }
                //                }
                //                if(panelDataBodies.latFocus===1){
                //                    if(currentPlanetIndexBack>-1){
                //                        currentPlanetIndexBack--
                //                    }else{
                //                        currentPlanetIndexBack=16
                //                    }
                //                }

            }
            //xAreaInteractiva.back()
        }
    }
    Shortcut{
        sequence: 'Down'
        //enabled: !menuBar.expanded
        onActivated: {
            if(menuBar.expanded){
                menuBar.d()
                return
            }
            if(xSabianos.visible){
                xSabianos.todown()
                return
            }
            if(apps.zFocus==='xLatIzq'){
                if(apps.currentSwipeViewIndex===2){
                    if(zoolFileManager.currentIndex<zoolFileManager.listModel.count){
                        zoolFileManager.currentIndex++
                    }else{
                        zoolFileManager.currentIndex=0
                    }
                    return
                }
                if(apps.currentSwipeViewIndex===3){
                    zoolFileManager.toDown()
                    return
                }
                if(panelControlsSign.state==='show'&&panelDataBodies.state==='hide'){
                    if(currentSignIndex<12){
                        currentSignIndex++
                    }else{
                        currentSignIndex=0
                    }
                    return
                }
                if(apps.currentSwipeViewIndex===4){
                    if(panelRsList.currentIndex<panelRsList.listModel.count-1){
                        panelRsList.currentIndex++
                    }else{
                        panelRsList.currentIndex=0
                    }
                    return
                }

            }
            if(apps.zFocus==='xLatDer'){
                tAutoMaticPlanets.stop()
                panelDataBodies.toDown()

                //                if(panelDataBodies.latFocus===0){
                //                    if(currentPlanetIndex<16){
                //                        currentPlanetIndex++
                //                    }else{
                //                        currentPlanetIndex=-1
                //                    }
                //                }
                //                if(panelDataBodies.latFocus===1){
                //                    if(currentPlanetIndexBack<16){
                //                        currentPlanetIndexBack++
                //                    }else{
                //                        currentPlanetIndexBack=-1
                //                    }
                //                }

            }

            //log.visible=true
            //log.width=xApp.width*0.2
            //log.l('currentPlanetIndex: '+currentPlanetIndex)
            //log.l('app.currentPlanetIndex: '+app.currentPlanetIndex)
            //xAreaInteractiva.next()
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            //if(zoolFileManager.state==='show'){
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.latFocus=panelDataBodies.latFocus===0?1:0
                return
            }
            if(apps.zFocus==='xLatIzq'){
                if(xSabianos.visible){
                    xSabianos.toleft()
                    return
                }
                if(sv.currentIndex===2){
                    zoolFileManager.toLeft()
                    return
                }
            }

            if(app.currentPlanetIndex>=0 && app.currentXAs){
                app.currentXAs.rot(false)
                return
            }
            if(app.currentPlanetIndexBack>=0 && app.currentXAsBack){
                app.currentXAsBack.rot(false)
                return
            }
            if(menuBar.expanded&&!xSabianos.visible){
                menuBar.left()
                return
            }

        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.latFocus=panelDataBodies.latFocus===0?1:0
                return
            }
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.latFocus=panelDataBodies.latFocus===0?1:0
                return
            }
            if(apps.zFocus==='xLatIzq'){
                if(sv.currentIndex===2){
                    zoolFileManager.toRight()
                    return
                }
                if(xSabianos.visible){
                    xSabianos.toright()
                    return
                }
            }
            if(app.currentPlanetIndex>=0 && app.currentXAs){
                app.currentXAs.rot(true)
                return
            }
            if(app.currentPlanetIndexBack>=0 && app.currentXAsBack){
                app.currentXAsBack.rot(true)
                return
            }
            if(menuBar.expanded&&!xSabianos.visible){
                menuBar.right()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Ctrl+Left'
        onActivated: {
            if(sv.currentIndex>0){
                sv.currentIndex--
            }else{
                sv.currentIndex=sv.count-1
            }
        }
    }
    Shortcut{
        sequence: 'Ctrl+Right'
        onActivated: {
            if(sv.currentIndex<sv.count-1){
                sv.currentIndex++
            }else{
                sv.currentIndex=0
            }
        }
    }

    //Mostrar/Activar Show Log
    Shortcut{
        sequence: 'Ctrl+Shift+l'
        onActivated: {
            apps.showLog=!apps.showLog
        }
    }

    //Guardar Zoom y Pos
    Shortcut{
        sequence: 'Ctrl+Shift+r'
        onActivated: {
            if(app.currentPlanetIndex>=0&&app.currentXAs){
                if(app.currentPlanetIndex===16||app.currentPlanetIndex===15){
                    if(app.currentPlanetIndex===16){
                        app.currentXAs.saveZoomAndPos('mc')
                    }
                    if(app.currentPlanetIndex===15){
                        app.currentXAs.saveZoomAndPos('asc')
                    }
                }else{
                    app.currentXAs.saveZoomAndPos()
                }
                return
            }
            if(app.currentPlanetIndexBack>=0&&app.currentXAsBack){
                if(app.currentPlanetIndexBack===16||app.currentPlanetIndexBack===15){
                    if(app.currentPlanetIndexBack===16){
                        app.currentXAs.saveZoomAndPos('mcBack')
                    }
                    if(app.currentPlanetIndexBack===15){
                        app.currentXAsBack.saveZoomAndPos('ascBack')
                    }
                }else{
                    app.currentXAsBack.saveZoomAndPos()
                }
                return
            }
        }
    }
    //Restaurar xAs Pointer rotation
    Shortcut{
        sequence: 'r'
        onActivated: {
            app.currentXAs.restoreRot()
        }
    }
    //Centrar Sweg
    Shortcut{
        sequence: 'Ctrl+Shift+Space'
        onActivated: {
            if(!sweg.zoomAndPosCentered){
                sweg.centerZoomAndPos()
            }else{
                sweg.setZoomAndPos(sweg.uZp)
            }
        }
    }

    Shortcut{
        sequence: 'Ctrl+Shift+a'
        onActivated: {
            apps.lt=!apps.lt
        }
    }
    //Mostrar/Ocultar MenuBar
    Shortcut{
        sequence: 'Ctrl+m'
        onActivated: {
            apps.showMenuBar=!apps.showMenuBar
        }
    }
    //Mostrar/Ocultar Panel Numerología
    Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            //ncv.visible=!ncv.visible
        }
    }
    //Mostrar/Ocultar lineas de número de grados
    Shortcut{
        sequence: 'Ctrl+Shift+l'
        onActivated: {
            apps.showNumberLines=!apps.showNumberLines
        }
    }
    //Mostrar / Ocultar Decanatos
    Shortcut{
        sequence: 'Ctrl+Shift+d'
        onActivated: {
            apps.showDec=!apps.showDec
            //swegz.sweg.objSignsCircle.showDec=!swegz.sweg.objSignsCircle.showDec
        }
    }
    //Mostrar Panel para Cargar Archivos
    Shortcut{
        sequence: 'Ctrl+f'
        onActivated: {
            apps.currentSwipeViewIndex=2
            //apps.currentSwipeViewIndex
        }
    }
    //Mostrar Panel PL Signos
    //    Shortcut{
    //        sequence: 'Ctrl+w'
    //        onActivated: {
    //            panelControlsSign.state=panelControlsSign.state==='show'?'hide':'show'
    //        }
    //    }
    //Mostrar Panel Editor de Pronósticos
    Shortcut{
        sequence: 'Ctrl+e'
        onActivated: {
            panelPronEdit.state=panelPronEdit.state==='show'?'hide':'show'
        }
    }
    //Mostrar Mostrar Reloj
    //    Shortcut{
    //        sequence: 'Ctrl+t'
    //        onActivated: {
    //            apps.showTimes=!apps.showTimes
    //        }
    //    }
    //Mostrar Panel para Lineas de Comando
    Shortcut{
        sequence: 'Ctrl+Shift+c'
        onActivated: {
            xBottomBar.objPanelCmd.state=xBottomBar.objPanelCmd.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel de Cuerpos
    Shortcut{
        sequence: 'Ctrl+i'
        onActivated: {
            panelDataBodies.state=panelDataBodies.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel para Crear Nuevo VN
    Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            zoolFileManager.state=zoolFileManager.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel de Revoluciones Solares
    Shortcut{
        sequence: 'Ctrl+r'
        onActivated: {
            //panelRsList.state=panelRsList.state==='show'?'hide':'show'
            apps.zFocus='xMed'
            sv.currentIndex=4
        }
    }
    //Mostrar Panel de Aspectos en Transito
    Shortcut{
        sequence: 'Ctrl+t'
        onActivated: {
            panelAspTransList.state=panelAspTransList.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+p'
        onActivated: {
            panelZonaMes.state=panelZonaMes.state==='hide'?'show':'hide'
        }
    }

    //AutoMatic Planets
    Shortcut{
        sequence: 'Ctrl+a'
        onActivated: {
            tAutoMaticPlanets.running=!tAutoMaticPlanets.running
        }
    }

    Shortcut{
        sequence: 'Ctrl+s'
        onActivated: {
            if(xEditor.visible){
                xEditor.save()
                return
            }
            if(app.fileData!==app.currentData){
                JS.saveJson()
                let s ='Se ha grabado el archivo '+apps.url+' correctamente.'
                log.ls(s, xApp.width*0.2, xApp.width*0.2)
                return
            }

            //panelSabianos.z=panelRemoto.z+1
            //if(panelSabianos.z<panelSa)
            //log.ls('z1:'+panelSabianos.z, xApp.width*0.2, xApp.width*0.2)
            //log.ls('z2:'+panelRemoto.z, xApp.width*0.2, xApp.width*0.2)
            panelSabianos.state=panelSabianos.state==='hide'?'show':'hide'
        }
    }
    Shortcut{
        sequence: 'Ctrl+x'
        onActivated: {
            if(xEditor.visible){
                xEditor.close()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+Down'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.zoomDown()
                return
            }
            //signCircle.subir()
            sweg.objSignsCircle.rotarSegundos(0)
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+Up'
        onActivated: {
            if(xSabianos.visible){
                xSabianos.zoomUp()
                return
            }
            //signCircle.bajar()
            sweg.objSignsCircle.rotarSegundos(1)
        }
    }
    Shortcut{
        sequence: 'Ctrl++'
        onActivated: {
            if(panelLog.visible&&apps.numPanelLogFs<app.fs*2){
                apps.numPanelLogFs+=app.fs*0.1
                return
            }
            sweg.width+=app.fs
        }
    }
    Shortcut{
        sequence: 'Ctrl+-'
        onActivated: {
            if(panelLog.visible&&apps.numPanelLogFs>app.fs*0.5){
                apps.numPanelLogFs-=app.fs*0.1
                return
            }
            sweg.width-=app.fs
        }
    }
}
