import QtQuick 2.0
import QtQuick.Controls 2.0
import "./comps"
import "Funcs.js" as JS

Rectangle {
    id: r
    width: col.width//app.fs*6
    height: col.height//app.fs*3
    //border.width: 2
    //border.color: 'red'
    //color: 'red'
    color: 'transparent'
    Column{
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        Repeater{
            model:col.state==='hide'?1:5
            Rectangle{
                width: index!==0&&col.state==='show'?(col.state==='hide'?app.fs*2:r.width-app.fs*1.3-((app.fs)*(2-index))):app.fs*2
                height: col.state==='hide'?width:app.fs*1.1//*2
                color: 'transparent'
                border.width: 0
                border.color: 'yellow'
                //anchors.bottom: parent.bottom
                anchors.right: parent.right
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: col.state='show'
                    onPositionChanged: {
                        if(apps.xToolEnableHide){
                            tHideCol.restart()
                        }
                    }
                }
            }
        }
    }
    Column{
        id: col
        spacing: app.fs*0.25
        //anchors.centerIn: r
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.1
        anchors.bottom: parent.bottom
        state: 'hide'
        states: [
            State {
                name: "show"
                PropertyChanges {
                    target: col
                    anchors.bottomMargin: 0
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: col
                    anchors.bottomMargin: 0-col.height
                }
            }
        ]
        Behavior on y{NumberAnimation{duration: 250}}
        //        Button{
        //            text: app.uSon
        //            width: app.fs*3
        //            height: app.fs*0.6
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            visible: app.uSon!==''
        //            onClicked: {
        //                JS.showIW()
        //            }
        //        }

        //Alfiler xTool
        ButtonIcon{
            text: ''
            width: apps.botSize
            height: width
            anchors.right: parent.right
            onClicked: {
                apps.xToolEnableHide=!apps.xToolEnableHide
                if(apps.xToolEnableHide){
                    col.state='hide'
                }
            }
            Text{
                text:'\uf08d'
                font.pixelSize: parent.width*0.9
                rotation: apps.xToolEnableHide?45:0
                anchors.centerIn: parent
            }
            Timer{
                id: tHideCol
                running: apps.xToolEnableHide
                repeat: true
                interval: 5000
                onTriggered: col.state='hide'

            }
        }

        //Botones de prueba.  Chequear la propiedad visible de este Row{}
        Row{
            spacing: app.fs*0.25
            anchors.right: parent.right
            ButtonIcon{
                text:  '<b>A</b>'
                width: apps.botSize
                height: width
                onClicked: {
                    if(!tAutoMaticPlanets.running){
                        tAutoMaticPlanets.currentJsonData=app.currentData
                        tAutoMaticPlanets.running=true
                    }else{
                        tAutoMaticPlanets.running=false
                        sweg.centerZoomAndPos()
                    }

                }
                Text{
                    text:'\uf06e'
                    font.pixelSize: parent.width*0.35
                    anchors.right:parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    visible: tAutoMaticPlanets.running
                }
            }
            ButtonIcon{
                text:  '<b>C</b>'
                width: apps.botSize
                height: width
                enabled: !apps.showDec
                onClicked: {
                    apps.showXAsLineCenter=!apps.showXAsLineCenter
                }
                Text{
                    text:'\uf06e'
                    font.pixelSize: parent.width*0.35
                    anchors.right:parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    visible: apps.showXAsLineCenter
                }
            }
            ButtonIcon{
                text:  '<b>E</b>'
                width: apps.botSize
                height: width
                visible: app.mod==='sin'
                onClicked: {
                    app.ev=!app.ev
                }
                Text{
                    text:'\uf06e'
                    font.pixelSize: parent.width*0.35
                    anchors.right:parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    visible: app.ev
                }
            }
        }
        Row{
            spacing: app.fs*0.25
            anchors.right: parent.right
            Button{
                text: 'MODO '+parseInt(sweg.aStates.indexOf(sweg.state) + 1)
                width: app.fs*2
                height: app.fs*0.6
                onClicked: {
                    sweg.nextState()
                }
            }
            ButtonIcon{
                text:  'N'
                width: apps.botSize
                height: width
                onClicked: {
                    ncv.visible=true
                }
            }
            ButtonIcon{
                text:  'I'
                width: apps.botSize
                height: width
                onClicked: {
                    apps.xAsShowIcon=!apps.xAsShowIcon
                }
            }
            ButtonIcon{
                text:  'NL'
                width: apps.botSize
                height: width
                onClicked: {
                    apps.showNumberLines=!apps.showNumberLines
                }
            }
        }

        //Botones SAM
        Row{
            spacing: app.fs*0.25
            anchors.right: parent.right
            Rectangle{
                width: rowBotsSabInt.width+app.fs*0.35
                height: apps.botSize+app.fs*0.35
                color: apps.houseColor
                anchors.verticalCenter: parent.verticalCenterenter
                Row{
                    id: rowBotsSabInt
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    ButtonIcon{
                        text:  '<b>S</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(sv.currentIndex!==1||panelSabianos.uSAM!=='S'){
                                let h1=app.currentJson.pc.c0
                                let gf=h1.rsgdeg//app.currentGradoSolar-gr
                                app.uSon='sun_'+app.objSignsNames[h1.is]+'_'+h1.ih
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), gf-1)
                                sv.currentIndex=1
                            }else{
                                xSabianos.numSign=panelSabianos.numSign
                                xSabianos.numDegree=panelSabianos.numDegree
                                xSabianos.loadData()
                                xSabianos.visible=!xSabianos.visible
                            }
                            panelSabianos.uSAM='S'
                        }
                    }
                    ButtonIcon{
                        text:  '<b>A</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(sv.currentIndex!==1||panelSabianos.uSAM!=='A'){
                                let h1=app.currentJson.ph.h1
                                app.uSon='asc_'+app.objSignsNames[h1.is]+'_1'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                                sv.currentIndex=1
                            }else{
                                xSabianos.numSign=panelSabianos.numSign
                                xSabianos.numDegree=panelSabianos.numDegree
                                xSabianos.loadData()
                                xSabianos.visible=!xSabianos.visible
                            }
                            panelSabianos.uSAM='A'
                        }
                    }
                    ButtonIcon{
                        text:  '<b>M</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(sv.currentIndex!==1||panelSabianos.uSAM!=='M'){
                                let h1=app.currentJson.ph.h10
                                app.uSon='mc_'+app.objSignsNames[h1.is]+'_10'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
                                sv.currentIndex=1
                            }else{
                                xSabianos.numSign=panelSabianos.numSign
                                xSabianos.numDegree=panelSabianos.numDegree
                                xSabianos.loadData()
                                xSabianos.visible=!xSabianos.visible
                            }
                            panelSabianos.uSAM='M'
                        }
                    }
                }
            }
            Rectangle{
                width: rowBotsSabIntBack.width+app.fs*0.35
                height: apps.botSize+app.fs*0.35
                color: apps.houseColorBack
                anchors.verticalCenter: parent.verticalCenter
                visible: app.ev
                Row{
                    id: rowBotsSabIntBack
                    spacing: app.fs*0.1
                    anchors.centerIn: parent
                    ButtonIcon{
                        text:  '<b>S</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJsonBack.pc.c0
                                let gf=h1.rsgdeg//app.currentGradoSolar-gr
                                app.uSon='sun_'+app.objSignsNames[h1.is]+'_'+h1.ih
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), gf-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                    ButtonIcon{
                        text:  '<b>A</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJsonBack.ph.h1
                                app.uSon='asc_'+app.objSignsNames[h1.is]+'_1'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uAscDegree-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                    ButtonIcon{
                        text:  '<b>M</b>'
                        width: apps.botSize
                        height: width
                        onClicked: {
                            if(panelSabianos.state==='hide'){
                                let h1=app.currentJsonBack.ph.h10
                                app.uSon='mc_'+app.objSignsNames[h1.is]+'_10'
                                JS.showSABIANOS(app.objSignsNames.indexOf(app.uSon.split('_')[1]), app.uMcDegree-1)
                                panelSabianos.state='show'
                            }else{
                                panelSabianos.state='hide'
                            }
                        }
                    }
                }
            }
        }
        Row{
            spacing: app.fs*0.1
            Button{
                id: botEditSin
                text: 'Crear Sinastria'
                //width: app.fs*3
                height: app.fs*0.6
                anchors.verticalCenter: parent.verticalCenter
                visible: false//app.ev&&app.mod!=='sin'&&app.mod!=='rs'
                onClicked: {
                    JS.mkSinFile(apps.urlBack)
                }
            }
            Button{
                id: botEdit
                text: xEditor.visible?'Ocultar Informe':'Ver Informe'
                //width: app.fs*3
                height: app.fs*0.6
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    if(!xEditor.visible){
                        xEditor.showInfo()
                    }else{
                        xEditor.visible=false
                    }
                }
            }
            ComboBox{
                id: cbHsys
                width: app.fs*4
                height: app.fs*0.75
                model: app.ahysNames
                currentIndex: app.ahys.indexOf(apps.currentHsys)
                //anchors.bottom: parent.bottom
                onCurrentIndexChanged: {
                    if(currentIndex===app.ahys.indexOf(apps.currentHsys))return
                    apps.currentHsys=app.ahys[currentIndex]
                    //JS.showMsgDialog('Zool Informa', 'El sistema de casas ha cambiado.', 'Se ha seleccionado el sistema de casas '+app.ahysNames[currentIndex]+' ['+app.ahys[currentIndex]+'].')
                    //sweg.load(JSON.parse(app.currentData))
                    JS.loadJson(apps.url)
                }
            }
        }

        //}
    }
}
