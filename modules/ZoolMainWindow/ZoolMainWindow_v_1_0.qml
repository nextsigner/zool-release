import QtQuick 2.12
import QtQuick.Controls 2.12
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
            if(u.objectName!=='unikpy'){
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
            apps.showCmd=!apps.showCmd
            xBottomBar.state=!apps.showCmd?'hide':'show'
        }
    }
    Shortcut{
        sequence: 'Ctrl+Up'
        onActivated: {
            if(zsm.getPanel('ZoolSabianos').view.visible){
                zsm.getPanel('ZoolSabianos').view.ctrlUp()
                return
            }
            //xDataBar.state=xDataBar.state==='show'?'hide':'show'
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
            if(apps.zFocus==='xMed'){
                zm.toSpace(false)
                return
            }
        }
    }


    Shortcut{
        sequence: 'Ctrl+w'
        onActivated: {
            minymaClient.test()
        }
    }

    //--->Cap
    Shortcut{
        sequence: 'Ctrl+Shift+c'
        onActivated: {
            zm.zmc.startSinNombreYAbrir(xVisibleItems)
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+e'
        onActivated: {
            zev.visible=!zev.visible
        }
    }
    Shortcut{
        sequence: 'e'
        onActivated: {
            //zoolElementsView.zoom+=0.1//zoolElementsView.zoom*2
            if(zm.zev.settings.zoom===5.0){
                zm.zev.settings.zoom=1.0
            }else{
                if(app.t!=='dirprim'&&app.t!=='progsec'){
                    zm.zev.settings.zoom=5.0
                }else{
                    zm.zev.settings.zoom=2.5
                }
            }
        }
    }
    //<---Cap

    //--->GUI
    Shortcut{
        sequence: 't'
        onActivated: {
            zm.nextTheme()
        }
    }
    //<--GUI

    Shortcut{
        sequence: 'Ctrl+Shift+w'
        onActivated: {
            //minymaClient.sendData(minymaClient.loginUserName, 'zool_data_editor', 'openPlanet|1|3|a')
        }
    }


    Shortcut{
        sequence: 'Ctrl+Space'
        onActivated: {
            if(apps.zFocus==='xMed'){
                zm.toSpace(true)
                return
            }
            if(zm.currentPlanetIndex>=0&&app.currentXAs){
                app.showPointerXAs=!app.showPointerXAs
                return
            }
//            if(panelZonaMes.state==='show'){
//                panelZonaMes.pause()
//                return
//            }
            //sweg.nextState()
            //swegz.sweg.nextState()
        }
    }

    //Seleccionar Area
    Shortcut{
        sequence: '1'
        onActivated: {
            apps.zFocus='xLatIzq'
        }
    }
    Shortcut{
        sequence: '2'
        onActivated: {
            apps.zFocus='xMed'
        }
    }
    Shortcut{
        sequence: '3'
        onActivated: {
            apps.zFocus='xLatDer'
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+0'
        onActivated: {
            zm.currentPlanetIndex=0
        }
    }
    Shortcut{
        sequence: 'Ctrl+1'
        onActivated: {
            zm.currentPlanetIndex=1
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+2'
        onActivated: {
            zm.currentPlanetIndex=2
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+3'
        onActivated: {
            zm.currentPlanetIndex=3
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+4'
        onActivated: {
            zm.currentPlanetIndex=4
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+5'
        onActivated: {
            zm.currentPlanetIndex=5
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+6'
        onActivated: {
            zm.currentPlanetIndex=6
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+7'
        onActivated: {
            zm.currentPlanetIndex=7
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+8'
        onActivated: {
            zm.currentPlanetIndex=8
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+9'
        onActivated: {
            zm.currentPlanetIndex=9
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+*'
        onActivated: {
            zm.currentPlanetIndex=20
        }
    }
    //Seleccionar Planeta
    Shortcut{
        sequence: 'Ctrl+/'
        onActivated: {
            zm.currentPlanetIndex=21
        }
    }


    //Esto en algunos casos funciona con la tecla Return
    //de la derecha del teclado.
    Shortcut{
        sequence: 'Return'
        onActivated: {
            ctrlReturnEnter(false, 'Return')
        }
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: {
            ctrlReturnEnter(false, 'Enter')
        }
    }
    Shortcut{
        sequence: 'Ctrl+Return'
        onActivated: {
            ctrlReturnEnter(true, 'Return')
        }
    }
    Shortcut{
        sequence: 'Ctrl+Enter'
        onActivated: {
            ctrlReturnEnter(true, 'Enter')
        }
    }
    function ctrlReturnEnter(ctrl, tecla){
        if(apps.showCmd){
            xBottomBar.toEnter()
            return
        }
        if(menuBar.expanded){
            menuBar.e()
            return
        }
        if(apps.zFocus==='xLatDer'){
            zoolDataBodies.toEnter(ctrl)
            return
        }
        if(apps.zFocus==='xLatIzq'){

            zsm.getPanelVisible().toEnter(ctrl)
            return
        }
        if(apps.zFocus==='xLatDer'){
            zoolDataBodies.toEnter()
            return
        }
    }
    Shortcut{
        sequence: 'Tab'
        onActivated: {
            if(apps.zFocus==='xLatIzq'){
                zsm.toTab()
                return;
            }

        }
    }
    Shortcut{
        sequence: 'Ctrl+Tab'
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
            if(apps.zFocus==='xLatIzq'){
                if(zsm.getPanel('ZoolNumPit').isFocus()){
                    zsm.getPanel('ZoolNumPit').toEscape()
                    return
                }
                if(zsm.getPanel('ZoolNumPit').logView.visible){
                    zsm.getPanel('ZoolNumPit').logView.visible=false
                    return
                }
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.visible=false
                    return
                }
                if(zsm.getPanelVisible().isFocus()){
                    zsm.getPanelVisible().toEscape()
                    return
                }
                if(zsm.currentSectionFocusedName!=='ZoolSectionsManager'){
                    zsm.currentSectionFocused=zsm
                    return
                }
                //Qt.quit()
            }
            if(log.visible){
                log.visible=false
                return
            }
            if(apps.dev && !log.visible){
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
            if(zm.currentPlanetIndex>=0){
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=-1
                return
            }
            if(zm.currentPlanetIndexBack>=0){
                zm.currentPlanetIndexBack=-1
                zm.currentPlanetIndexBack=-1
                zm.currentHouseIndexBack=-1
                //sweg.objHousesCircleBack.currentHouse=-1
                return
            }


            /*if(xBottomBar.objPanelCmd.state==='show'){
                xBottomBar.objPanelCmd.state='hide'
                return
            }*/
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
            xApp.focus=true
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(xBottomBar.state==='show'){
                xBottomBar.toUp()
            }
            if(menuBar.expanded){
                menuBar.u()
                return
            }
            if(apps.zFocus==='xLatIzq'){
                zsm.currentSectionFocused.toUp()
                //zsm.toUp()
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
                //                if(panelControlsSign.state==='show'&&zoolDataBodies.state==='hide'){
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
            if(apps.zFocus==='xMed'){
                zm.toUp(false)
                return
            }
            if(apps.zFocus==='xLatDer'){
                //tAutoMaticPlanets.stop()
                zoolDataBodies.toUp()
                //                if(zoolDataBodies.latFocus===0){
                //                    if(currentPlanetIndex>-1){
                //                        currentPlanetIndex--
                //                    }else{
                //                        currentPlanetIndex=16
                //                    }
                //                }
                //                if(zoolDataBodies.latFocus===1){
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
            if(xBottomBar.state==='show'){
                xBottomBar.toDown()
            }
            if(menuBar.expanded){
                menuBar.d()
                return
            }
            if(apps.zFocus==='xLatIzq'){
                zsm.currentSectionFocused.toDown()
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
                //                if(panelControlsSign.state==='show'&&zoolDataBodies.state==='hide'){
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
            if(apps.zFocus==='xMed'){
                zm.toDown(false)
                return
            }
            if(apps.zFocus==='xLatDer'){
                //tAutoMaticPlanets.stop()
                zoolDataBodies.toDown()

                //                if(zoolDataBodies.latFocus===0){
                //                    if(currentPlanetIndex<16){
                //                        currentPlanetIndex++
                //                    }else{
                //                        currentPlanetIndex=-1
                //                    }
                //                }
                //                if(zoolDataBodies.latFocus===1){
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
            //log.l('zm.currentPlanetIndex: '+zm.currentPlanetIndex)
            //xAreaInteractiva.next()
        }
    }
//    Shortcut{
//        sequence: 'Ctrl+Left'
//        onActivated: {
//            //if(zsm.getPanel('ZoolFileManager').state==='show'){


//        }
//    }
    Shortcut{
        sequence: 'Left'
       onActivated: {
            ctrlLeft(false)
        }
    }
    Shortcut{
        sequence: 'Ctrl+Left'
        onActivated: {
            ctrlLeft(true)
        }
    }
    function ctrlLeft(ctrl){
        if(!ctrl){
            if(zsm.getPanel('ZoolSabianos').view.visible){
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.toleft()
                    return
                }

            }
//            if(apps.zFocus==='xLatIzq' && zsm.getPanel('ZoolFileManager').visible){
//                zsm.currentSectionFocused.toLeft()
//                return
//            }
            if(apps.zFocus==='xLatIzq'){
                zsm.toLeft()
            }
            if(apps.zFocus==='xMed'){
                zm.toLeft(false)
                return
            }
            if(apps.zFocus==='xLatDer'){
                zoolDataBodies.toLeft(ctrl)
                return
            }
        }else{
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

            if(apps.zFocus==='xMed'){
                if(zm.currentPlanetIndex>=0 && app.currentXAs){
                    app.currentXAs.rot(false)
                    return
                }
                if(zm.currentPlanetIndexBack>=0 && app.currentXAsBack){
                    app.currentXAsBack.rot(false)
                    return
                }
            }
            if(apps.zFocus==='xLatDer'){
                zoolDataBodies.toLeft(ctrl)
                return
            }
            //            if(apps.zFocus==='xLatDer'){
//                zoolDataBodies.latFocus=zoolDataBodies.latFocus===0?1:0
//                return
//            }
            if(menuBar.expanded&&!zsm.getPanel('ZoolSabianos').view.visible){
                menuBar.left()
                return
            }
            zsm.toLeft(ctrl)
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            ctrlRight(false)
        }
    }
    Shortcut{
        sequence: 'Ctrl+Right'
        onActivated: {
            ctrlRight(true)
        }
    }
    function ctrlRight(ctrl){
        //zpn.log('ZoolMainWindow.ctrlRight('+ctrl+')')
        if(!ctrl){
            if(zsm.getPanel('ZoolSabianos').view.visible){
                if(zsm.getPanel('ZoolSabianos').view.visible){
                    zsm.getPanel('ZoolSabianos').view.toright()
                    return
                }

            }
            if(apps.zFocus==='xLatIzq'){
                zsm.toRight(ctrl)
                return
            }
            if(apps.zFocus==='xMed'){
                zm.toRight(false)
                return
            }
            if(apps.zFocus==='xLatDer'){
                //zpn.log('111')
                zoolDataBodies.toRight(ctrl)
                return
            }
        }else{
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
            if(apps.zFocus==='xMed'){
                if(zm.currentPlanetIndex>=0 && app.currentXAs){
                    app.currentXAs.rot(true)
                    return
                }
                if(zm.currentPlanetIndexBack>=0 && app.currentXAsBack){
                    app.currentXAsBack.rot(true)
                    return
                }
            }
            if(apps.zFocus==='xLatDer'){
                zoolDataBodies.toRight(ctrl)
                return
            }
            if(menuBar.expanded&&!zsm.getPanel('ZoolSabianos').view.visible){
                menuBar.right()
                return
            }
            zsm.toRight(ctrl)
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
    //Mostrar/Ocultar Información
    Shortcut{
        sequence: 'Ctrl+Shift+i'
        onActivated: {
            if(!xEditor.visible){
                xEditor.showInfo()
            }else{
                xEditor.visible=false
            }
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
    /*Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            //ncv.visible=!ncv.visible
        }
    }*/
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
            //panelPronEdit.state=panelPronEdit.state==='show'?'hide':'show'
        }
    }
    //Cambiar Tema
    Shortcut{
        sequence: 'Ctrl+t'
        onActivated: {
            zm.nextTheme()
        }
    }
    //Mostrar Panel para Lineas de Comando
    Shortcut{
        sequence: 'Ctrl+b'
        onActivated: {
            xBottomBar.objPanelCmd.state=xBottomBar.objPanelCmd.state==='show'?'hide':'show'
        }
    }
    //Mostrar/Ocultar ZoolMediaLive
    /*Shortcut{
        sequence: 'Ctrl+l'
        onActivated: {
            if(zoolMediaLive.settings.stateShowOrHide==='hide'){
                zoolMediaLive.settings.stateShowOrHide='show'
            }else{
                zoolMediaLive.settings.stateShowOrHide='hide'
            }

        }
    }*/
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
            //zoolDataBodies.state=zoolDataBodies.state==='show'?'hide':'show'
        }
    }
    //Mostrar Panel para Crear Nuevo VN
    /*Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            zsm.getPanel('ZoolFileManager').state=zsm.getPanel('ZoolFileManager').state==='show'?'hide':'show'
        }
    }*/
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
    /*Shortcut{
        sequence: 'Ctrl+t'
        onActivated: {
            panelAspTransList.state=panelAspTransList.state==='show'?'hide':'show'
        }
    }*/
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
        sequence: 'Ctrl+D'
        onActivated: {
            apps.showDec=!apps.showDec
        }
    }
    Shortcut{
        sequence: 'Ctrl+n'
        onActivated: {
            apps.showNumberLines=!apps.showNumberLines
        }
    }
    Shortcut{
        sequence: 'Ctrl+Shift+N'
        onActivated: {
            apps.numberLinesMode=apps.numberLinesMode===0?1:0
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
                app.j.saveJson()
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
            zm.objSignsCircle.rotarSegundos(0)
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
            zm.objSignsCircle.rotarSegundos(1)
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
    Shortcut{
        sequence: 'F1'
        onActivated: {
            if(apps.zFocus==='xLatIzq'){
                zsm.getPanelVisible().toHelp()
                return
            }
        }
    }
    property int rv: 0
    Shortcut{
        sequence: '*'
        onActivated: {
            //zm.objSignsCircle.rotar(0, rv)
            //rv++
            //zm.isMultiCapturing=true
            //zm.capturing=true

            //log.lv('Descargando...')
            //u.downloadZipFile('https://sitsa.dl.sourceforge.net/project/zool/zool_v5.1.11.1.zip?viasf=1', 'C:/sss')
            //log.lv('Termino!')
            //zm.centrarZooMap()

            //log.lv('house pos: '+pos.x)
            //log.width=xLatIzq.width
            //log.lv('zm.currentHouseIndex: '+zm.currentHouseIndex)
            //zm.currentPlanetIndex=20
            //zm.zmc.start()

            //zm.unloadExt()
            //zoolDataBodies.objZbsv.selBodie(0)
            //zm.capturing=!zm.capturing
           // let d = u.downloadZipFile('https://github.com/nextsigner/zoolv4/releases/download/zool-release/zoolv4_5.6.11.0.zip', '/home/ns/', false)
            //log.lv('d: '+d)

            //zpn.log('zm.objPlanetsCircle.getMaxAsAbsPos(): '+zm.objPlanetsCircle.getMaxAsAbsPos())
            //zpn.log('zm.maxAbsPosInt: '+zm.maxAbsPosInt)
            zpn.log('zm.objAspsCircle.visible: '+zm.objAspsCircle.visible)
            zpn.log('zm.objAspsCircle.opacity: '+zm.objAspsCircle.opacity)
        }
    }
}
