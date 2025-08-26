import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0
import ZoolMenus.ZoolMenuFiles 1.0
import ZoolMenus.ZoolMenuView 1.0
import ZoolMenus.ZoolMenuHelp 1.0

ZoolMenus{
    id: r
    title: 'Menu General'
    w: app.fs*40
    Action {
        enabled: app.t==='rs'
        text: qsTr("Guardar Revolución")
        onTriggered: {
            //if(apps.dev)log.lv('MenuBack: '+JSON.stringify(JSON.parse(app.fileDataBack, null, 2)))                       }
            zfdm.addExtData(JSON.parse(app.fileDataBack))
            zsm.currentIndex=1
        }
    }
    //<--Clasificados
    /*ZoolMenus {
        title: qsTr("MMMM sdfas fas as a afsaa sd 1111 11111 22222");
        w: r.w
        property string text: title
        Action {
            text: qsTr("mmm 222");
            onTriggered: {
                zm.loadNow()
            }
        }
        Action {
            text: qsTr("mmm 333");
            onTriggered: {
                zm.loadNow()
            }
        }
    }*/
    ZoolMenuFiles{}
    ZoolMenuView{}
    ZoolMenus{
        title: 'Sabianos'
        w: r.w
        Action {text: qsTr("Simbología del grado del Ascendente"); onTriggered: {
                log.visible=false
                //zsm.currentIndex=4
                zsm.showPanel('ZoolSabianos')
                let sabianosPanelIndex=zsm.getPanelIndex('ZoolSabianos')
                //log.lv('sabianosPanelIndex: '+sabianosPanelIndex)
                if(zsm.currentIndex!==sabianosPanelIndex||zsm.getPanel('ZoolSabianos').uSAM!=='A'){
                    let h1=zm.currentJson.ph.h1
                    zm.uSon='asc_'+zm.objSignsNames[h1.is]+'_1'
                    //log.lv('zm.uSon: '+zm.uSon)
                    //log.lv('zm.uAscDegree: '+zm.uAscDegree)
                    app.j.showSABIANOS(zm.objSignsNames.indexOf(zm.uSon.split('_')[1]), zm.uAscDegree-1)
                    zsm.currentIndex=sabianosPanelIndex
                }else{
                    zsm.getPanel('ZoolSabianos').view.numSign=zsm.getPanel('ZoolSabianos').numSign
                    zsm.getPanel('ZoolSabianos').view.numDegree=zsm.getPanel('ZoolSabianos').numDegree
                    zsm.getPanel('ZoolSabianos').view.loadData()
                    zsm.getPanel('ZoolSabianos').view.visible=!zsm.getPanel('ZoolSabianos').view.visible
                }
                zsm.getPanel('ZoolSabianos').uSAM='A'
            }
        }
        Action {text: qsTr("Simbología del grado del Sol"); onTriggered: {
                log.visible=false
                zsm.showPanel('ZoolSabianos')
                let sabianosPanelIndex=zsm.getPanelIndex('ZoolSabianos')
                if(zsm.currentIndex!==sabianosPanelIndex||zsm.getPanel('ZoolSabianos').uSAM!=='S'){
                    let h1=zm.currentJson.pc.c0
                    let gf=h1.rsgdeg//app.currentGradoSolar-gr
                    zm.uSon='sun_'+zm.objSignsNames[h1.is]+'_'+h1.ih
                    //log.lv('zm.uSon: '+zm.uSon)
                    app.j.showSABIANOS(zm.objSignsNames.indexOf(zm.uSon.split('_')[1]), gf-1)
                    zsm.currentIndex=sabianosPanelIndex
                }else{
                    zsm.getPanel('ZoolSabianos').view.numSign=zsm.getPanel('ZoolSabianos').numSign
                    zsm.getPanel('ZoolSabianos').view.numDegree=zsm.getPanel('ZoolSabianos').numDegree
                    zsm.getPanel('ZoolSabianos').view.loadData()
                    zsm.getPanel('ZoolSabianos').view.visible=!zsm.getPanel('ZoolSabianos').view.visible
                }
                zsm.getPanel('ZoolSabianos').uSAM='S'
            }
        }
        Action {text: qsTr("Simbología del grado del Medio Cielo"); onTriggered: {
                log.visible=false
                //zsm.currentIndex=4
                zsm.showPanel('ZoolSabianos')
                let sabianosPanelIndex=zsm.getPanelIndex('ZoolSabianos')
                if(zsm.currentIndex!==sabianosPanelIndex||zsm.getPanel('ZoolSabianos').uSAM!=='M'){
                    let h1=zm.currentJson.ph.h10
                    zm.uSon='mc_'+zm.objSignsNames[h1.is]+'_10'
                    //log.lv('zm.uSon: '+zm.uSon)
                    app.j.showSABIANOS(zm.objSignsNames.indexOf(zm.uSon.split('_')[1]), zm.uMcDegree-1)
                    zsm.currentIndex=sabianosPanelIndex
                }else{
                    zsm.getPanel('ZoolSabianos').view.numSign=zsm.getPanel('ZoolSabianos').numSign
                    zsm.getPanel('ZoolSabianos').view.numDegree=zsm.getPanel('ZoolSabianos').numDegree
                    zsm.getPanel('ZoolSabianos').view.loadData()
                    zsm.getPanel('ZoolSabianos').view.visible=!zsm.getPanel('ZoolSabianos').view.visible
                }
                zsm.getPanel('ZoolSabianos').uSAM='M'
            }
        }
    }
    ZoolMenus{
        title: 'Capturar'
        w: r.w
        Action {text: qsTr("Capturar todo rápido"); onTriggered: {
                zm.zmc.msChangeBodieOrHouse=500
                zm.zmc.startMultiCap()
            }
        }
        Action {text: qsTr("Capturar todo lento"); onTriggered: {
                zm.zmc.msChangeBodieOrHouse=5000
                zm.zmc.startMultiCap()
            }
        }
        /*Action {text: qsTr("Capturar"); onTriggered: {
                app.c.captureSweg()
            }
        }*/
        Action {text: qsTr("Crear imagen actual y abrir"); onTriggered: {
                zm.zmc.startSinNombreYAbrir()
            }
        }
    }
    ZoolMenus{
        title: 'Configurar'
        w: r.w
        Action {text: !apps.enableWheelAspCircle?"Habilitar Rotar con Mouse":"Deshabilitar Rotar con Mouse"; onTriggered: {
                apps.enableWheelAspCircle=!apps.enableWheelAspCircle
            }
        }
        Action {
            text: !apps.dev?"Habilitar Modo Desarrollador":"Deshabilitar Modo Desarrollador"
            onTriggered: {
                if(u.folderExist('/home/ns')){
                    apps.dev=!apps.dev
                }
            }
        }
        Action {
            text: !apps.speakEnabled?"Habilitar Voz (Linux)":"Deshabilitar Voz (Linux)"
            onTriggered: {
                apps.speakEnabled=!apps.speakEnabled
                if(apps.speakEnabled){
                    let msg='Audio activado.'
                    zoolVoicePlayer.speak(msg, true)
                }
            }
        }

    }
    ZoolMenuHelp{}
    Action {text: qsTr("Salir"); onTriggered: {
            Qt.quit()
        }
    }
    Component{
        id: compDev
        Action {
            text: "Dev: "//+apps.dev;
            onTriggered: {
                apps.dev=!apps.dev
            }
        }
    }

    Timer{
        running: r.visible
        repeat: true
        interval: 250
        onTriggered: {
            /*let p=zfdm.getJsonAbs().params
            let json=JSON.parse(app.fileData)
            if(!app.ev&&json.paramsBack){
                aDeleteExt.enabled=true
            }else{
                aDeleteExt.enabled=false
            }*/
            //let d = new Date(Date.now())
            //log.lv('Menu ...'+d.getTime())
        }
    }

}
