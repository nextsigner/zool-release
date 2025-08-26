import QtQuick 2.12

Item{
    id: r

    /*

    property var itemCap



    Timer{
        id: tMultiCap
        repeat: true
        interval: 250
        property int piCaptured: 0
        onTriggered: {
            zm.isMultiCapturing=true
            zm.capturing=true
            if(zm.currentPlanetIndex<19){
                zm.currentPlanetIndex++
            }else{
                zm.currentPlanetIndex=-1
                stop()
                //zm.centerZoomAndPos()
                zm.isMultiCapturingPlanets=false
                zm.currentPlanetIndex=-1
                zm.currentHouseIndex=0
                tMultiHouseWait.start()
            }
            let pos=zm.objPlanetsCircle.getAs(zm.currentPlanetIndex).getPos()
            zm.panTo(pos.x, pos.y)
            //log.lv('pi: '+zm.currentPlanetIndex)
            //log.lv('pos: x:'+pos.x+' y:'+pos.y)
            tMultiCap2.restart()

        }
    }



    Timer{
        id: tMultiHouseWait
        interval: 500
        onTriggered: {
            tMultiCapHouses.start()
        }
    }



    Timer{
        id: tMultiCapHouses
        repeat: true
        interval: 250
        property int piCaptured: 0
        onTriggered: {
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

            let pos=zm.objHousesCircle.getPosOfHouse(zm.currentHouseIndex-1)
            zm.panTo(pos.x, pos.y)
            tMultiCap2Houses.restart()

        }
    }



    Timer{
        id: tMultiCap2
        interval: 100
        onTriggered: {
            let fn=zm.objPlanetsCircle.getAs(zm.currentPlanetIndex).getAsFileNameForCap()
            captureToPng(fn, zm.parent, false)
        }
    }


    Timer{
        id: tMultiCap2Houses
        interval: 100
        onTriggered: {
            let fn=u.getPath(3)+'/Zool/caps/'+zm.currentNom.replace(/ /g, '_')+'/casa_'+zm.currentHouseIndex+'.png'//zm.objPlanetsCircle.getAs(zm.currentPlanetIndex).getAsFileNameForCap()
            //zpn.addNot('fn: '+fn, false, 0)
            //log.lv('fn: '+fn)
            //fn=fn.toLowerCase()
            //fn=app.j.quitarAcentos(fn)
            captureToPng(fn, zm.parent, false)
            if(zm.currentHouseIndex===12){
                tSetFinishedMultiCap.start()

            }
        }
    }


    Timer{
        id: tInitMultiCap
        interval: 1000
        onTriggered: {
            tMultiCap.start()
        }
    }

    Timer{
        id: tSetFinishedMultiCap
        interval: 1000
        onTriggered: {
            zpn.addNot('Se finalizó la multicaptura.', true, 10000)
            zm.currentHouseIndex=0
            zm.objHousesCircle.currentHouse=-1
            zm.centerZoomAndPos()
        }
    }
    */

    /*Timer{
        id: tCap//Captura sin nombre, se definirá nombre de png zool_cap...
        running: false
        repeat: false
        interval: 500
        onTriggered: captureToPng('', true)
    }*/
/*    Timer{
        id: tCap2
        running: false
        repeat: false
        interval: 500
        onTriggered: {
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
                captureToPng(fn, zsm.getPanel('ZoolSabianos').view, true)
            }else{
                captureToPng(fn, zm.parent, true)
            }
        }
    }

    function startMultiCap(){
        zm.capturing=true
        zm.isMultiCapturingPlanets=true
        zm.currentHouseIndex=0
        zm.centerZoomAndPos()
        tInitMultiCap.start()
        //tMultiCap.start()
    }
    function startSinNombreYAbrir(){
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
            c+='            app.c.savePng(fileUrl+".png")\n'
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
            if(openInExternal)Qt.openUrlExternally(fileUrl)
            zm.capturing=false
        });
    }
*/
}
