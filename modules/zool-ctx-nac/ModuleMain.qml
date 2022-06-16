import QtQuick 2.12
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    id: r
    width: sweg.objSignsCircle.width*0.5
    height: width
    anchors.centerIn: parent
    parent: sweg
    visible: false
    property real o: 0.25
    property string moduleName: 'Contexto de Nacimiento'
    property bool showAsCircle: true
    onVisibleChanged: {
        if(visible){
            sweg.centerZoomAndPos()
        }
    }
    MouseArea{
        anchors.fill: parent
        onWheel: {
            //apps.enableFullAnimation=false
            fakeSignCircle.rotation=sweg.objSignsCircle.rot
            let no=r.o
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    no+=0.1
                }else{
                    no-=0.1
                }
                r.o=no
            }else{
                //                if(wheel.angleDelta.y>=0){
                ////                    if(reSizeAppsFs.fs<app.fs*2){
                ////                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                ////                    }else{
                ////                        reSizeAppsFs.fs=app.fs
                ////                    }
                //                    pointerPlanet.pointerRot+=45
                //                }else{
                ////                    if(reSizeAppsFs.fs>app.fs){
                ////                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                ////                    }else{
                ////                        reSizeAppsFs.fs=app.fs*2
                ////                    }
                //                    pointerPlanet.pointerRot-=45
                //                }
            }
            //reSizeAppsFs.restart()
        }

        onClicked: {
            //horizonteBg.posSol=3
            r.showAsCircle=!r.showAsCircle
        }
        onDoubleClicked: {
            r.visible=false
        }
    }
    Rectangle{
        id: xCircle
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: width*0.5
        visible: !r.showAsCircle
        opacity: r.o
        Item{
            id: xHorBg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: img1.bottom
            //            HorizonteBg{
            //                id: horizonteBg

            //            }
        }
        SubsueloBg{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: img1.bottom
        }
        Image {
            id: img1
            source: "hospital.png"
            width: app.fs*3
            height: width
            fillMode: Image.PreserveAspectCrop
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            anchors.bottom: parent.verticalCenter
        }
        Image {
            id: img2
            source: "sotano.png"
            width: img1.width
            height: width
            fillMode: Image.PreserveAspectCrop
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            cache: false
            anchors.top:  img1.bottom
            //anchors.bottomMargin: height
        }
        //Arboles
        Image {
            source: "arbol_1.png"
            width: app.fs*6
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: img1.verticalCenter
            anchors.verticalCenterOffset: 0-app.fs*0.35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: img1.width*1.5
        }
        Brujula{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-app.fs*3
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0-app.fs*3
        }
        Rectangle{
            id: xInfoNac
            anchors.horizontalCenter: imgFlecha.horizontalCenter
            anchors.bottom: imgFlecha.top
            anchors.bottomMargin: app.fs*0.5
            width:  app.fs*6
            height: txt3.contentHeight+app.fs
            border.width: 3
            border.color: 'black'
            radius: app.fs*0.5
            Text {
                id: txt3
                text: 'Lugar de Nacimiento'
                width: parent.width-app.fs
                font.pixelSize: app.fs*0.5
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
            }
        }
        Image {
            id: imgFlecha
            source: "flecha.png"
            width: app.fs*2
            height: width*0.7
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: app.fs*3
            visible: false
        }
        ColorOverlay{
            anchors.fill: imgFlecha
            source: imgFlecha
            color: 'yellow'
            rotation: 90
            SequentialAnimation on color{
                running: true
                loops: Animation.Infinite

                ColorAnimation {
                    from: "red"
                    to: "yellow"
                    duration: 300
                }
                ColorAnimation {
                    from: "yellow"
                    to: "red"
                    duration: 300
                }
            }
        }
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: app.fs*3
            width:  txt2.contentWidth+app.fs
            height: txt2.contentHeight+app.fs
            border.width: 3
            border.color: 'black'
            radius: app.fs*0.5
            Text {
                id: txt2
                text: '<b>Bajo tierra</b>'
                font.pixelSize: app.fs
                anchors.centerIn: parent
            }
        }
    }
    Rectangle{
        id: xCircleMask
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        radius: width*0.5
        visible: r.showAsCircle
        opacity: r.o
    }
    OpacityMask {
        anchors.fill: xCircle
        source: xCircle
        maskSource: xCircleMask
        visible: r.showAsCircle
        opacity: r.o
    }
    Rectangle{
        id: fakeSignCircle
        anchors.fill: parent
        color: 'transparent'
        radius: width*0.5
        border.width: 0
        border.color: 'blue'
        Rectangle{
            id: fakeSignCircleAxis1
            width: parent.width*2
            height: 3
            anchors.centerIn: parent
            color: 'transparent'
        }
        Rectangle{
            id: fakeSolAxis
            width: parent.width-app.fs*2
            height: 3
            anchors.centerIn: parent
            color: 'transparent'
            opacity: r.o
            Rectangle{
                id: xFakeSol
                width: app.fs
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#f38a27"
                radius: width*0.5
                SequentialAnimation on color{
                    running: true
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: "#f38a27"
                        to: "yellow"
                        duration: 200
                    }
                    ColorAnimation {
                        from: "yellow"
                        to: "#f38a27"
                        duration: 200
                    }
                }
                Repeater{
                    model: 12
                    Rectangle{
                        width: parent.width+app.fs*0.5
                        height: 2
                        color: parent.color
                        anchors.centerIn: parent
                        rotation: index*30
                    }
                }
                Text{
                    text: '<b>SOL</b>'
                    font.pixelSize: parent.width*0.4
                    anchors.centerIn: parent
                    rotation: 360-fakeSignCircle.rotation-fakeSolAxis.rotation
                }
            }
        }

    }
    //    Text{
    //        text: '-...'+horizonteBg.posSol
    //        font.pixelSize: 80
    //        color: 'red'
    //        anchors.centerIn: parent
    //    }
    Component{
        id: comp
        Rectangle{
            id: xPanel
            width: panelZoolModules.width-app.fs*0.25
            height: col.height+app.fs
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            radius: app.fs*0.25
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter
            property bool showPanel: false
            Behavior on height{
                NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}
            }
            Column{
                id: col
                anchors.centerIn: parent
                Rectangle{
                    width: xPanel.width-app.fs*0.5
                    height: app.fs*1.5
                    color: apps.fontColor
                    radius: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            xPanel.showPanel=!xPanel.showPanel

                        }
                    }
                    Text{
                        text: r.moduleName
                        font.pixelSize: app.fs
                        color: 'black'//apps.backgroundColor
                        anchors.centerIn: parent
                        opacity: t1.running?0.0:1.0
                        Behavior on opacity{
                            NumberAnimation{duration: 250}
                        }
                        Timer{
                            id: t1
                            running: parent.contentWidth>parent.parent.width-app.fs
                            repeat: true
                            interval: 100
                            onTriggered: parent.font.pixelSize-=1
                        }
                    }
                }
                Rectangle{
                    visible: xPanel.showPanel
                    width: parent.width
                    height: btn1.height+app.fs*0.5
                    color: apps.backgroundColor
                    Button{
                        id: btn1
                        text: r.visible?'Ocultar':'Mostrar'
                        anchors.centerIn: parent
                        onClicked: r.visible=!r.visible
                    }
                }
            }


            //            Rectangle{
            //                width: parent.width
            //                height: app.fs*1.5
            //                color: apps.fontColor
            //                Text{
            //                    text: r.moduleName
            //                    font.pixelSize: app.fs
            //                    color: apps.backgroundColor
            //                    anchors.centerIn: parent
            //                    Timer{
            //                        id: t1
            //                        running: parent.contentWidth>parent.parent.width-app.fs
            //                        repeat: true
            //                        interval: 100
            //                        onTriggered: parent.font.pixelSize-=1
            //                    }
            //                }

            //            }


        }
    }
    Timer{
        id: tCheck
        running: r.visible || r.uIH<0
        repeat: true
        interval: 1000
        onTriggered: setBgPosSol()
    }
    property int uIH: -1
    property int uGS: -1
    Component.onCompleted: {
        setBgPosSol()
        let obj=comp.createObject(panelZoolModules.c, {})
    }
    function setBgPosSol(){
        let json=app.currentJson
        //log.ls('json: '+JSON.stringify(json.pc.c0), 0, xLatIzq.width)
        if(!json)return
        let ih=parseInt(json.pc.c0.ih)
        r.uIH=ih
        let gs=parseInt(json.pc.c0.gdec)
        r.uGS=gs
        if(ih===12||ih===7){
            setBg(0)
        }else if(ih===1||ih===2||ih===3||ih===4||ih===5||ih===6){
            setBg(3)
            //horizonteBg.opacity-=0.05
        }else if(ih===8||ih===9||ih===11){
            setBg(1)
        }else{
            setBg(1)
        }
    }
    function setBg(posSol){
        for(var i=0;i<xHorBg.children.length;i++){
            xHorBg.children[i].destroy(1)
        }
        let c='import QtQuick 2.0\nHorizonteBg{\nid: horizonteBg\n}\n'
        let comp=Qt.createComponent('HorizonteBg.qml')
        let obj=comp.createObject(xHorBg, {posSol: posSol})
        fakeSignCircle.rotation=sweg.objSignsCircle.rot
        let gs=app.currentRotationxAsSol-(fakeSignCircle.rotation-360)//r.uGS90
        fakeSolAxis.rotation=gs
        let cd=new Date(app.currentDate)
        let hora=cd.getHours()
        let min=cd.getMinutes()
        txt3.text='Lugar de nacimiento de <b>'+app.currentNom+'</b> el día <b>'+app.currentFecha+'</b> a las <b>'+hora+':'+min+'hs</b> en '+app.currentLugar
    }
}
