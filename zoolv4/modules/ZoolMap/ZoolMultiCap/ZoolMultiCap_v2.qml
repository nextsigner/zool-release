import QtQuick 2.12

Item{
    id: r
    property var itemCap
    property int msChangeBodieOrHouse: 500
    Timer{
        id: tTimerSelectBodies
        objectName: 'TimerSelectBodies'
        repeat: true
        interval: r.msChangeBodieOrHouse
        property int piCaptured: 0
        onTriggered: {
            //log.lv('tTimerSelectBodies....')
            zm.isMultiCapturing=true
            zm.capturing=true
            if(zm.currentPlanetIndex<19){
                zm.currentPlanetIndex++
                zm.capturing=true
                //zoolDataBodies.objZbsv.searchAsp(zm.currentPlanetIndex)
                //zoolDataBodies.objZbsv.selBodie(zm.currentPlanetIndex)
                //zpn.addNot('cpi: '+zm.currentPlanetIndex, true, 20000)
                let pos=zm.objPlanetsCircle.getAs(zm.currentPlanetIndex).getPos()
                zm.panTo(pos.x, pos.y)
                //log.lv('pi: '+zm.currentPlanetIndex)
                //log.lv('pos: x:'+pos.x+' y:'+pos.y)
                //tMultiCap2.restart()
                tTimerCapBodies.restart()
            }else{
                zm.currentPlanetIndex=-1
                //zoolDataBodies.objZbsv.selBodie(-1)
                //zoolDataBodies.objZbsv.selBodie(-1)
                //zm.capturing=false
                stop()
                //zm.centerZoomAndPos()
                zm.isMultiCapturingPlanets=false
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=0
                tTimerWaitInitPosHouses.start()
            }


        }
    }
    Timer{
        id: tTimerWaitInitPosHouses
        objectName: 'TimerWaitInitPosHouses'
        interval: 500
        onTriggered: {
            //log.lv('tTimerWaitInitPosHouses....')
            tTimerPosHouses.start()
        }
    }
    Timer{
        id: tTimerPosHouses
        objectName: 'TimerPosHouses'
        repeat: true
        interval: r.msChangeBodieOrHouse
        property int piCaptured: 0
        onTriggered: {
            //log.lv('tTimerPosHouses....')
            zm.isMultiCapturing=true
            zm.capturing=true
            if(zm.currentHouseIndex<12){
                zm.currentHouseIndex++
            }else if(zm.currentHouseIndex===0){
                zm.currentHouseIndex=1
            }else{
                zm.currentHouseIndex=1
            }
            if(zm.currentHouseIndex===0){
                zm.currentHouseIndex=1
            }
            //zpn.addNot('chi: '+zm.currentHouseIndex, true, 20000)
            if(zm.currentHouseIndex===12){
                stop()
            }
            zm.objHousesCircle.clearHousesActivated()
            //log.lv('Activando '+zm.currentHouseIndex)
            zm.objHousesCircle.setCurrentHouseIndex(zm.objHousesCircle.getItemOfHouse(zm.currentHouseIndex))
            let pos=zm.objHousesCircle.getPosOfHouse(zm.currentHouseIndex-1)
            zm.panTo(pos.x, pos.y)
            tTimerCapHouses.restart()

        }
    }
    Timer{
        id: tTimerCapBodies
        objectName: 'TimerCapBodies'
        interval: 100
        onTriggered: {
            //log.lv('tMultiCap2....')
            let fn=zm.objPlanetsCircle.getAs(zm.currentPlanetIndex).getAsFileNameForCap()
            let jsonNot={}
            jsonNot.id='captura'
            jsonNot.text='Capturando Cuerpos '+fn
            jsonNot.qmlTextBot='Cancelar capturas'
            jsonNot.qml='import QtQuick 2.0\nItem{\nComponent.onCompleted:{\nzm.zmc.cancelarTodo()\n}\n}'
            zpn.addNot(jsonNot, true, 20000)
            captureToPng(fn, zm.parent, false)
        }
    }
    Timer{
        id: tTimerCapHouses
        objectName: 'TimerCapHouses'
        interval: 100
        onTriggered: {
            //log.lv('tTimerCapHouses....')
            let fnFolder=u.getPath(3)+'/Zool/caps/'+zm.currentNom.replace(/ /g, '_')
            let fn=fnFolder+'/casa_'+zm.currentHouseIndex+'.png'//zm.objPlanetsCircle.getAs(zm.currentPlanetIndex).getAsFileNameForCap()
            let jsonNot={}
            jsonNot.id='captura'
            jsonNot.text='Capturando casa '+fn
            zpn.addNot(jsonNot, true, 5000)
            //log.lv('fn: '+fn)
            //fn=fn.toLowerCase()
            //fn=app.j.quitarAcentos(fn)
            captureToPng(fn, zm.parent, false)
            if(zm.currentHouseIndex===12){
                tTimerFinish.folder=fnFolder
                tTimerFinish.start()

            }
        }
    }
    Timer{
        id: tTimerInit
        objectName: 'TimerInit'
        interval: 1000
        onTriggered: {
            //log.lv('tInitTimerSelectBodies....')
            tTimerSelectBodies.start()

        }
    }

    Timer{
        id: tTimerFinish
        objectName: 'TimerFinish'
        interval: 1000
        property string folder: ''
        onTriggered: {
            //log.lv('tFinishedMultiCap....')
            let jsonNot={}
            jsonNot.text='Se finalizó la multicaptura.'
            jsonNot.url='file://'+folder
            zpn.addNot(jsonNot, true, 15000)
            zm.currentHouseIndex=0
            zm.objHousesCircle.currentHouse=-1
            zm.centerZoomAndPos()
            zm.capturing=false
        }
    }
    /*Timer{
        id: tCap//Captura sin nombre, se definirá nombre de png zool_cap...
        running: false
        repeat: false
        interval: 500
        onTriggered: captureToPng('', true)
    }*/
    Timer{
        id: tCap2
        objectName: 'TimerCapSab'
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            //log.lv('tCap2....')
            var fnp
            let d=new Date(Date.now())
            let vd=d.getDate()
            let vm=d.getMonth() + 1
            let va=d.getFullYear()
            let vh=d.getHours()
            let vmin=d.getMinutes()
            let vsec=d.getSeconds()
            let sn='zool_captura_D'+vd+'M'+vm+'A'+va+'_H'+vh+'M'+vmin+'S'+vsec//+'.png'
            let fn=u.getPath(3)+'/'+sn+'.png'
            //fn=fn.toLowerCase()
            //fn=app.j.quitarAcentos(fn)
            if(zsm.getPanel('ZoolSabianos').view.visible){
                fnp=u.getPath(3)+'/Zool/caps/sabianos'
                if(!u.folderExist(fnp)){
                    u.mkdir(fnp)
                }
                fn=fnp
                fn+='/'+zsm.getPanel('ZoolSabianos').getCurrentFileName()
                captureToPng(fn, zsm.getPanel('ZoolSabianos').view.container, true)
                if (Qt.platform.os === "windows") {
                    Qt.openUrlExternally("file:///" + fnp)
                }else{
                    Qt.openUrlExternally("file://" + fnp)
                }
            }else if(r.itemForCap){
                fnp=u.getPath(3)+'/Zool/caps'
                if(!u.folderExist(fnp)){
                    u.mkdir(fnp)
                }
                let date = new Date(Date.now())
                let dia=date.getDate()
                let mes=date.getMonth() + 1
                let anio=date.getFullYear()
                let hora=date.getHours()
                let minuto=date.getMinutes()
                let segundo=date.getSeconds()
                let strFn='cap_'+dia+'_'+mes+'_'+anio+'_'+hora+'_'+minuto+'_'+segundo
                fn=fnp
                fn+='/'+strFn+'.png'
                captureToPng(fn, r.itemForCap, true)
                if (Qt.platform.os === "windows") {
                    Qt.openUrlExternally("file:///" + fnp)
                }else{
                    Qt.openUrlExternally("file://" + fnp)
                }
            }else{
                //Captura lo que se está viendo en el mapa.
                let jsonNot={}
                jsonNot.text='Capturando '+fn
                zpn.addNot(jsonNot, true, 8000)
                captureToPng(fn, zm.parent, true)
            }
        }
    }

    function startMultiCap(){
        zm.capturing=true
        zm.isMultiCapturingPlanets=true
        zm.isMultiCapturing=true
        zm.centrarZooMap()
        zm.zoomTo(1.0, false)
        zm.currentHouseIndex=0
        tTimerInit.start()
        let jsonNot={}
        jsonNot.id='captura_init'
        let segVel=parseFloat(r.msChangeBodieOrHouse/1000).toFixed(2)
        jsonNot.text='Iniciando el proceso\nde capturas a '+segVel+'\n segundos de velocidad.'
        zpn.addNot(jsonNot, true, r.msChangeBodieOrHouse+2000)
    }
    property var itemForCap
    function startSinNombreYAbrir(item){
        if(!item){
            r.itemForCap=xVisibleItems
        }else{
            r.itemForCap=item
        }
        zm.capturing=true
        tCap2.restart()
    }
    function captureToPng(fileUrl, item, openInExternal){
        itemCap=item
        if(fileUrl!==''){
            savePng(fileUrl, openInExternal)
        }else{
            let c=''
            c+='import QtQuick 2.0\n'
            c+='import QtQuick.Dialogs 1.3\n'
            c+='    FileDialog {\n'
            c+='        id: fileDialog\n'
            //c+='        width: 800\n'
            //c+='        height: 500\n'
            c+='        modality: Qt.Window\n'
            c+='        folder: "'+u.getPath(3)+'"\n'
            c+='        title: "Escribir el nombre del archivo de imagen."\n'
            c+='        selectExisting: false\n'
            c+='        nameFilters: ["Imagen PNG (*.png)"]\n'
            c+='        onAccepted: {\n'
            //c+='            log.lv(fileUrl)\n'
            c+='            savePng(fileUrl+".png")\n'
            c+='            fileDialog.destroy(10000)\n'
            c+='        }\n'
            c+='        onRejected: {\n'
            c+='            fileDialog.destroy(10000)\n'
            c+='        }\n'
            //c+='    }\n'
            c+='    Component.onCompleted:{\n'
            //c+='        log.lv("Capture!")\n'
            c+='        fileDialog.visible=true\n'
            c+='    }\n'
            c+='}\n'
            let obj=Qt.createQmlObject(c, app, 'itemCapturecode')
        }
    }
    function savePng(fileUrl, openInExternal){
        itemCap.grabToImage(function(result) {
            let fn=fileUrl
            fn=fn.replace('file://', '')
            result.saveToFile(fn);
            let jsonNot={}
            jsonNot.id='captura_'+fn
            jsonNot.text='imgUrl='+fn
            zpn.addNot(jsonNot, true, 20000)
            if(openInExternal)Qt.openUrlExternally(fileUrl)
            //zm.capturing=false
            r.itemForCap=undefined
        });
    }
    function cancelarTodo(){
        tTimerInit.stop()

        tTimerSelectBodies.stop()
        tTimerCapBodies.stop()

        tTimerWaitInitPosHouses.stop()
        tTimerPosHouses.stop()
        tTimerCapHouses.stop()

        tTimerFinish.stop()
        tCap2.stop()

        zm.centerZoomAndPos()
        zm.currentPlanetIndex=-1
        zm.currentHouseIndex=-1
        zm.objHousesCircle.clearHousesActivated()

        let jsonNot={}
        jsonNot.id='captura_cancelada'
        jsonNot.text='Se ha cancelado el proceso de capturas.'
        zpn.addNot(jsonNot, true, 20000)

        jsonNot={}
        jsonNot.id='captura'
        jsonNot.text='destroy'
        zpn.addNot(jsonNot, true, 20000)
    }
}
