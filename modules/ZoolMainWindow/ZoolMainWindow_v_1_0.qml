import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../js/Funcs.js" as JS
import "../../js/Capture.js" as Cap

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


    Component.onCompleted: {

    }

    Shortcut{
        sequence: 'Ctrl+Down'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.ctrlDown()
                return
            }
            xBottomBar.state=xBottomBar.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Ctrl+Up'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.ctrlUp()
                return
            }
            xDataBar.state=xDataBar.state==='show'?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Space'
        onActivated: {
            if(apps.zFocus==='xLatIzq'){
                if(zsm.currentIndex===9){
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
            app.currentPlanetIndex=20
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+/'
        onActivated: {
            app.currentPlanetIndex=21
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
                if(apps.currentSwipeViewIndex===2&&zsm.getPanel('ZoolFileManager').currentIndex>=0){
                    zsm.getPanel('ZoolFileManager').enter()
                    return
                }
                //                if(apps.currentSwipeViewIndex===3){
                //                    zsm.getPanel('ZoolFileManager').enter()
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

    //Esto en algunos casos funciona con la tecla Return
    //de la derecha del teclado.
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
            if(apps.zFocus==='xLatIzq'){
                zsm.currentSectionFocused.enter()
                return
            }
            if(xEditor.visible){
                //xEditor.enter()
                //return
            }
            /*
            if(apps.currentSwipeViewIndex===3&&zsm.getPanel('ZoolFileManager').currentIndex>=0){
                zsm.getPanel('ZoolFileManager').enter()
                return
            }
            if(apps.currentSwipeViewIndex===3){
                zsm.getPanel('ZoolFileManager').enter()
                return
            }
            if(apps.currentSwipeViewIndex===5){
                panelRsList.enter()
                return
            }*/
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
    //    Shortcut{
    //        sequence: 'Ctrl+Shift+Esc'
    //        onActivated: {
    //            Qt.quit()
    //        }
    //    }
    Shortcut{
        sequence: 'Esc'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.visible=false
                return
            }
            if(log.visible){
                log.visible=false
                return
            }
            if(app.dev && !log.visible){
                Qt.quit()
                return
            }
            if(!xApp.focus){
                xApp.focus=true
                return
            }
            if(app.objInFullWin){
                //app.objInFullWin.escaped()
                return
            }
//            if(ncv.log.visible){
//                ncv.log.visible=false
//                return
//            }
            //            if(log.visible){
            //                log.visible=false
            //                return
            //            }
            if(videoListEditor.visible){
                videoListEditor.visible=false
                return
            }
            //Efecto sobre los paneles
            if(zsm.getPanel('ZoolFileManager').visible&&zsm.getPanel('ZoolFileManager').ti.focus){
                zsm.getPanel('ZoolFileManager').ti.focus=false
                return
            }
            if(zsm.getPanel('ZoolFileManager').visible&&(zsm.getPanel('ZoolFileManager').tiN.focus||zsm.getPanel('ZoolFileManager').tiC.focus)){
                if(zsm.getPanel('ZoolFileManager').tiN.focus){
                    zsm.getPanel('ZoolFileManager').tiN.focus=false
                }
                if(zsm.getPanel('ZoolFileManager').tiC.focus){
                    zsm.getPanel('ZoolFileManager').tiC.focus=false
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
                app.currentHouseIndex=-1
                return
            }
            if(app.currentPlanetIndexBack>=0){
                app.currentPlanetIndexBack=-1
                app.currentPlanetIndexBack=-1
                app.currentHouseIndexBack=-1
                //sweg.objHousesCircleBack.currentHouse=-1
                return
            }
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.visible=false
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
            if(zsm.getPanel('ZoolFileManager').state==='show'){
                zsm.getPanel('ZoolFileManager').state='hide'
                return
            }
//            if(zoolDataBodies.state==='show'){
//                zoolDataBodies.state='hide'
//                return
//            }
            if(zsm.getPanel('ZoolFileManager').state==='show'){
                zsm.getPanel('ZoolFileManager').state='hide'
                return
            }
            //            if(panelControlsSign.state==='show'){
            //                panelControlsSign.state='hide'
            //                return
            //            }
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
            if(apps.zFocus==='xLatIzq'){
                zsm.currentSectionFocused.up()
                return
            }
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.toup()
                return
            }

            if(apps.zFocus==='xLatIzq'){
                if(apps.currentSwipeViewIndex===2){
                    if(zsm.getPanel('ZoolFileManager').currentIndex>0){
                        zsm.getPanel('ZoolFileManager').currentIndex--
                    }else{
                        zsm.getPanel('ZoolFileManager').currentIndex=zsm.getPanel('ZoolFileManager').listModel.count-1
                    }
                    return
                }
                if(apps.currentSwipeViewIndex===3){
                    zsm.getPanel('ZoolFileManager').toUp()
                    return
                }
                //                if(panelControlsSign.state==='show'&&panelDataBodies.state==='hide'){
                //                    if(currentSignIndex>0){
                //                        currentSignIndex--
                //                    }else{
                //                        currentSignIndex=12
                //                    }
                //                    return
                //                }
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
            if(apps.zFocus==='xLatIzq'){
                zsm.currentSectionFocused.down()
                return
            }
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.todown()
                return
            }
            if(apps.zFocus==='xLatIzq'){
                if(apps.currentSwipeViewIndex===2){
                    if(zsm.getPanel('ZoolFileManager').currentIndex<zsm.getPanel('ZoolFileManager').listModel.count){
                        zsm.getPanel('ZoolFileManager').currentIndex++
                    }else{
                        zsm.getPanel('ZoolFileManager').currentIndex=0
                    }
                    return
                }
                if(apps.currentSwipeViewIndex===3){
                    zsm.getPanel('ZoolFileManager').toDown()
                    return
                }
                //                if(panelControlsSign.state==='show'&&panelDataBodies.state==='hide'){
                //                    if(currentSignIndex<12){
                //                        currentSignIndex++
                //                    }else{
                //                        currentSignIndex=0
                //                    }
                //                    return
                //                }
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
        sequence: 'Ctrl+Left'
        onActivated: {
            //if(zsm.getPanel('ZoolFileManager').state==='show'){
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.latFocus=panelDataBodies.latFocus===0?1:0
                return
            }
            if(apps.zFocus==='xLatIzq' || zsm.getPanel('ZoolSabianos').view.visible){
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.toleft()
                    return
                }
                if(zsm.currentIndex===2){
                    zsm.getPanel('ZoolFileManager').toLeft()
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
            if(menuBar.expanded&&!zsm.getPanel('ZoolSabianos').view.visible){
                menuBar.left()
                return
            }

        }
    }
    Shortcut{
        sequence: 'Ctrl+Right'
        onActivated: {
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.latFocus=panelDataBodies.latFocus===0?1:0
                return
            }
            if(apps.zFocus==='xLatDer'){
                panelDataBodies.latFocus=panelDataBodies.latFocus===0?1:0
                return
            }
            if(apps.zFocus==='xLatIzq' || zsm.getPanel('ZoolSabianos').view.visible){
                if(zsm.currentIndex===2){
                    zsm.getPanel('ZoolFileManager').toRight()
                    return
                }
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.toright()
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
            if(menuBar.expanded&&!zsm.getPanel('ZoolSabianos').view.visible){
                menuBar.right()
                return
            }
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.toleft()
                    return
                }

            }
            if(apps.zFocus==='xLatIzq'){
                if(zsm.currentIndex>0){
                    zsm.currentIndex--
                }else{
                    zsm.currentIndex=zsm.count-1
                }
            }
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.toright()
                    return
                }

            }
            if(apps.zFocus==='xLatIzq'){
                if(zsm.currentIndex<zsm.count-1){
                    zsm.currentIndex++
                }else{
                    zsm.currentIndex=0
                }
            }
        }
    }

    //Ver/Ocultar xLatIzq
    Shortcut{
        sequence: 'Ctrl+Shift+Right'
        onActivated: {
            apps.showLatIzq=!apps.showLatIzq
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
            app.j.saveZoomAndPos()
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
    //Mostrar/Ocultar ZoolMediaLive
    Shortcut{
        sequence: 'Ctrl+l'
        onActivated: {
            if(zoolMediaLive.settings.stateShowOrHide==='hide'){
                zoolMediaLive.settings.stateShowOrHide='show'
            }else{
                zoolMediaLive.settings.stateShowOrHide='hide'
            }

        }
    }
    //Mostrar/Ocultar ZoolVoicePlayer
    Shortcut{
        sequence: 'Ctrl+p'
        onActivated: {
            if(zoolVoicePlayer.settings.stateShowOrHide==='hide'){
                zoolVoicePlayer.settings.stateShowOrHide='show'
            }else{
                zoolVoicePlayer.settings.stateShowOrHide='hide'
            }

        }
    }
    //Insertar
    Shortcut{
        sequence: 'Ctrl+i'
        onActivated: {
            if(apps.zFocus==='xLatIzq'){
                zsm.currentSectionFocused.insert()
                return
            }
            //panelDataBodies.state=panelDataBodies.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel para Crear Nuevo VN
    Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            zsm.getPanel('ZoolFileManager').state=zsm.getPanel('ZoolFileManager').state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel de Revoluciones Solares
    Shortcut{
        sequence: 'Ctrl+r'
        onActivated: {
            //panelRsList.state=panelRsList.state==='show'?'hide':'show'
            apps.zFocus='xMed'
            zsm.currentIndex=4
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
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.zoomDown()
                return
            }
            //signCircle.subir()
            sweg.objSignsCircle.rotarSegundos(0)
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+Up'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.zoomUp()
                return
            }
            //signCircle.bajar()
            sweg.objSignsCircle.rotarSegundos(1)
        }
    }
    Shortcut{
        sequence: 'Ctrl++'
        onActivated: {
            if(ncv.log.visible&&apps.numPanelLogFs<app.fs*2){
                apps.numPanelLogFs+=app.fs*0.1
                return
            }
            sweg.width+=app.fs
        }
    }
    Shortcut{
        sequence: 'Ctrl+-'
        onActivated: {
            if(ncv.log.visible&&apps.numPanelLogFs>app.fs*0.5){
                apps.numPanelLogFs-=app.fs*0.1
                return
            }
            sweg.width-=app.fs
        }
    }
}
