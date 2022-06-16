import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: r
    //width: !selected?(planetsCircle.expand?parent.width-(r.fs*2*objData.p)-r.fs:parent.width-(r.fs*1.5*objData.p))-r.fs:parent.width//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    width: !selected?parent.width-(r.fs*1.5*objData.p)-r.fs-(!apps.showNumberLines?0:r.fs):parent.width-(!apps.showNumberLines?0:r.fs)//-sweg.fs*2-(r.fs*1.5*(planetsCircle.totalPosX-1))
    height: 1
    anchors.centerIn: parent
    z: !selected?numAstro:15
    property bool selected: numAstro === app.currentPlanetIndex//panelDataBodies.currentIndex
    property string astro
    property int is
    property int fs
    property var objData: ({g:0, m:0,ih:0,rsgdeg:0,rsg:0, retro:0})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int numAstro: 0

    property color colorCuerpo: '#ff3300'

    state: sweg.state
    states: [
        State {
            name: sweg.aStates[0]
            PropertyChanges {
                target: r
                colorCuerpo: '#ffffff'
            }
            PropertyChanges {
                target: xIcon
                width: !app.ev?r.fs*0.85:r.fs*0.5
            }
        },
        State {
            name: sweg.aStates[1]
            PropertyChanges {
                target: r
                colorCuerpo: '#000000'
            }
            PropertyChanges {
                target: xIcon
                width: !app.ev?r.fs*0.5:r.fs*0.25
            }
        },
        State {
            name: sweg.aStates[2]
            PropertyChanges {
                target: r
                colorCuerpo: '#ffffff'
            }
            PropertyChanges {
                target: xIcon
                width: !app.ev?r.fcs*0.5:r.fcs*0.25
            }
        }
    ]

    onWidthChanged: {
        //        if(r.width===r.parent.width-sweg.fs*2){
        //            r.opacity=1.0
        //        }else{
        //            r.opacity=0.5
        //        }
    }
    onSelectedChanged: {
        if(selected)app.uSon=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
        if(selected)housesCircle.currentHouse=objData.ih
    }
    Rectangle{
        anchors.fill: parent
        color: 'transparent'
        antialiasing: true
        Rectangle{
            width: parent.width*0.5
            height: 4
            color: 'transparent'
            visible: r.selected
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            Rectangle{
                id: lineaATripleCircle
                width: r.selected?parent.width-xIconPlanetSmall.width:0
                anchors.left: parent.left
                anchors.leftMargin: xIconPlanetSmall.width-xIconPlanetSmall.border.width*2
                height: sweg.objectName==='sweg'?2:4
                antialiasing: true
                SequentialAnimation on color {
                    running: true
                    loops: Animation.Infinite
                    PropertyAnimation {
                        target: lineaATripleCircle; property: "color"
                        from: 'red'
                        to: 'yellow'
                    }
                    PauseAnimation {
                        duration: 100
                    }
                    PropertyAnimation {
                        target: lineaATripleCircle; property: "color"
                        from: 'yellow'
                        to: 'red'
                    }
                }
                Behavior on width {
                    enabled: apps.enableFullAnimation;
                    NumberAnimation{
                        duration: 500
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
    //Probando/Visualizando rotación
    //    Rectangle{
    //        width: r.width
    //        height: apps.widthHousesAxis
    //        anchors.centerIn: parent
    //        //color: apps.fontColor
    //        //visible: apps.showHousesAxis
    //        //y: lineaEje2.y
    //        color: 'red'
    //        antialiasing: true
    //    }
    Behavior on width {
        enabled: apps.enableFullAnimation;
        NumberAnimation{
            duration: 350
            easing.type: Easing.InOutQuad
        }
    }
    Behavior on rotation {
        enabled: apps.enableFullAnimation;
        NumberAnimation{
            duration: sweg.speedRotation
            easing.type: Easing.InOutQuad
        }
    }
    Item{
        id: xIcon
        //width: r.fs*0.85
        height: width
        anchors.left: parent.left
        //anchors.leftMargin: !r.selected?0:width*0.5
        anchors.verticalCenter: parent.verticalCenter
        Rectangle{
            //Circulo que queda mostrando el cuerpo chico.
            id: xIconPlanetSmall
            width: parent.width+sweg.fs*0.1
            height: width
            anchors.centerIn: parent
            radius: width*0.5
            border.width: 2
            border.color: lineaATripleCircle.color
            opacity: r.selected?1.0:0.0
            color: 'transparent'//app.signColors[r.is]
            antialiasing: true
        }
        MouseArea{
            id: maSig
            property int vClick: 0
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons;
            hoverEnabled: true
//            onWheel: {
//                //apps.enableFullAnimation=false
//                if(wheel.angleDelta.y>=0){
//                    if(reSizeAppsFs.fs<app.fs*2){
//                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
//                    }else{
//                        reSizeAppsFs.fs=app.fs
//                    }
//                }else{
//                    if(reSizeAppsFs.fs>app.fs){
//                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
//                    }else{
//                        reSizeAppsFs.fs=app.fs*2
//                    }
//                }
//                reSizeAppsFs.restart()
//            }
            onEntered: {
                vClick=0
                r.parent.cAs=r
            }
//            Timer{
//                id: reSizeAppsFs
//                running: false
//                repeat: false
//                interval: 500
//                property int fs: app.fs
//                onTriggered: {
//                    apps.sweFs=fs
//                    //Qt.quit()
//                }
//            }
            onExited: {
                vClick=0
                //r.parent.cAs=r.parent
            }
            onClicked: {
                //apps.sweFs=app.fs
                if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                    app.uSonFCMB=''+app.planetasRes[r.numAstro]+'_'+app.objSignsNames[r.is]+'_'+objData.ih
                    menuPlanets.currentIndexPlanet=r.numAstro
                    menuPlanets.popup()
                } else if (mouse.button === Qt.LeftButton) {
                    vClick++
                    tClick.restart()
                }
            }
            onDoubleClicked: {
                tClick.stop()
                r.parent.doublePressed(r)
            }
            Timer{
                id: tClick
                running: false
                repeat: false
                interval: 500
                onTriggered: {
                    if(maSig.vClick<=1){
                        r.parent.pressed(r)
                    }else{
                        r.parent.doublePressed(r)
                    }
                }
            }
        }
        Rectangle{
            id: fondoImgCentral
            opacity: r.selected?1.0:0.0
            width: img.width*1.5
            height: width
            color: 'black'//app.signColors[r.is]//'white'
            radius: width*0.5
            border.width: 2
            border.color: lineaATripleCircle.color
            anchors.centerIn: img
            antialiasing: true
            TripleCircle{
                id: tripeCircle
                //rotation: 0-parent.parent.rotation
                is:r.is
                gdeg: objData.g
                mdeg: objData.m
                rsgdeg:objData.rsg
                ih:objData.ih
                expand: r.selected
                iconoSignRot: img.rotation
            }
        }
        Image {
            id: img0
            source: img.source
            width: parent.width
            height: width
            rotation: 0-parent.parent.rotation
            antialiasing: true
        }
        Image {
            id: img
            source: app.planetasRes[r.numAstro]?"./resources/imgs/planetas/"+app.planetasRes[r.numAstro]+".svg":""
            width: r.parent.parent.objectName==='sweg'?!r.selected?parent.width:parent.width*2:!r.selected?parent.width:parent.width*1.25
            height: width
            x:!r.selected?0:r.parent.width*0.5-img.width*0.5-(apps.showNumberLines?sweg.fs*0.5:0)//+sweg.fs*2
            y: (parent.width-width)/2
            rotation: 0-parent.parent.rotation
            antialiasing: true
            Behavior on width {
                enabled: apps.enableFullAnimation;
                NumberAnimation{
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on x {
                enabled: apps.enableFullAnimation;
                NumberAnimation{
                    duration: 350
                    easing.type: Easing.InOutQuad
                }
            }

        }
        ColorOverlay {
            id: co
            anchors.fill: img
            source: img
            color: lineaATripleCircle.color
            rotation: img.rotation
            visible: r.selected
            antialiasing: true
            Rectangle{
                width: parent.width*0.35
                height: width
                radius: width*0.5
                //anchors.verticalCenter: parent.verticalCenter
                anchors.bottom: parent.bottom
                anchors.left: parent.right
                anchors.leftMargin: 0-width
                visible: r.objData.retro===0&&r.selected
                color: apps.fontColor
                Text{
                    text: '<b>R</b>'
                    font.pixelSize: parent.width*0.8
                    color: apps.backgroundColor
                    anchors.centerIn: parent
                }
            }
        }
        ColorOverlay {//Planeta que se muestra en espera no seleccionado
            id: co0
            anchors.fill: img0
            source: img0
            color: apps.xAsColor//lineaATripleCircle.color//r.colorCuerpo
            rotation: img.rotation
            visible: !r.selected
            antialiasing: true
            SequentialAnimation{
                running: !apps.anColorXAs
                loops: 3//Animation.Infinite
                PropertyAnimation {
                    target: co0
                    properties: "color"
                    from: co0.color
                    to: apps.xAsColor
                    duration: 500
                }
            }
            SequentialAnimation{
                running: apps.anColorXAs
                loops: Animation.Infinite
                PropertyAnimation {
                    target: co0
                    properties: "color"
                    from: 'red'
                    to: 'white'
                    duration: 500
                }
                PropertyAnimation {
                    target: co0
                    properties: "color"
                    from: 'red'
                    to: 'red'
                    duration: 500
                }
            }
            Rectangle{
                width: parent.width*0.35
                height: width
                radius: width*0.5
                //anchors.verticalCenter: parent.verticalCenter
                anchors.bottom: parent.bottom
                anchors.left: parent.right
                anchors.leftMargin: 0-width
                visible: r.objData.retro===0
                color: apps.fontColor
                Text{
                    text: '<b>R</b>'
                    font.pixelSize: parent.width*0.8
                    color: apps.backgroundColor
                    anchors.centerIn: parent
                }
            }
        }
        ColorOverlay {
            id: co1
            anchors.fill: img0
            source: img0
            color: lineaATripleCircle.color//r.colorCuerpo
            rotation: img.rotation
            visible: r.selected
            antialiasing: true
        }

    }
}
