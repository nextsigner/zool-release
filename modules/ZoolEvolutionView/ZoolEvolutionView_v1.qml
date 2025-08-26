import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: r
    anchors.fill: parent
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    visible: false
    onVisibleChanged: if(visible)updateData()
    property int wdeg: (r.width-app.fs*3)/360
    property int currentAscDeg: 0

    property string txtNac: '<b>Nacimiento</b>'

    property var iconC1 //Casa 1
    property var iconC2 //Casa 2
    property var iconC3 //Casa 3
    property var iconC4 //Casa 4
    property var iconC5 //Casa 5
    property var iconC6 //Casa 6
    property var iconC7 //Casa 7
    property var iconC8 //Casa 8
    property var iconC9 //Casa 9
    property var iconC10 //Casa 10
    property var iconC11 //Casa 11
    property var iconC12 //Casa 12
    property var iconC12p1 //Casa 12 parte 1
    property var iconC12p2 //Casa 12 parte 2
    property var iconC12p3 //Casa 12 parte 3
    property var iconC12p4 //Casa 12 parte 4

    property var bodie0
    property var bodie1
    property var bodie2
    property var bodie3
    property var bodie4
    property var bodie5
    property var bodie6
    property var bodie7
    property var bodie8
    property var bodie9
    property var bodie10
    property var bodie11
    property var bodie12

    property var icon16 //Para las patas

    property var signColors: ['red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6','red', '#FBE103', '#09F4E2', '#0D9FD6']
    Column{
        anchors.centerIn: parent
        Text{
            text: '<b>Módulo de Astrología Evolutiva</b>'
            color: apps.fontColor
            font.pixelSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
        }
        //Espacio vertical para separar título del contenido
        Item{width: 1; height: app.height*0.2}
        Rectangle{
            id: xSigns
            width: r.wdeg*360
            height: app.fs
            color: apps.backgroundColor
            border.width: 1
            border.color: apps.fontColor
            //clip: true
            Row{
                id: rowSigns
                //anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 0-(r.wdeg*360)-(r.wdeg*r.currentAscDeg)
            }
            Item{
                id: rowIcons
            }
            Rectangle{
                id: contenidoSuperior
                anchors.fill: parent
                color: 'transparent'
                border.width: 1
                border.color: apps.fontColor
                Rectangle{
                    width: 2
                    height: app.fs
                    anchors.bottom: parent.top
                    Rectangle{
                        width: txtNac.contentWidth+app.fs*0.5
                        height: txtNac.contentHeight+app.fs*0.5
                        anchors.bottom: parent.top
                        radius: app.fs*0.25
                        color: 'transparent'
                        border.width: 2
                        border.color: apps.fontColor
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text{
                            id: txtNac
                            text: r.txtNac
                            color: apps.fontColor
                            font.pixelSize: app.fs*0.5
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        width: app.fs//*0.5
        height: width
        color: 'white'
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        MouseArea{
            anchors.fill: parent
            onClicked: r.visible=false
        }
        Text {
            text: 'X'
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width*0.6
            color: 'black'
            anchors.centerIn: parent
        }
    }
    Component{
        id: comp12Sign
        Rectangle{
            id: x12Signs
            width: r.wdeg*360
            height: xSigns.height
            color: 'red'
            Row{
                id: row12Signs
                anchors.verticalCenter: parent.verticalCenter
            }
            Component.onCompleted: {
                //r.visible=false
                let s1 = compSign.createObject(row12Signs, {c: r.signColors[0], is: 0})
                let s2 = compSign.createObject(row12Signs, {c: r.signColors[1], is: 1})
                let s3 = compSign.createObject(row12Signs, {c: r.signColors[2], is: 2})
                let s4 = compSign.createObject(row12Signs, {c: r.signColors[3], is: 3})
                let s5 = compSign.createObject(row12Signs, {c: r.signColors[0], is: 4})
                let s6 = compSign.createObject(row12Signs, {c: r.signColors[1], is: 5})
                let s7 = compSign.createObject(row12Signs, {c: r.signColors[2], is: 6})
                let s8 = compSign.createObject(row12Signs, {c: r.signColors[3], is: 7})
                let s9 = compSign.createObject(row12Signs, {c: r.signColors[0], is: 8})
                let s10 = compSign.createObject(row12Signs, {c: r.signColors[1], is: 9})
                let s11 = compSign.createObject(row12Signs, {c: r.signColors[2], is: 10})
                let s12 = compSign.createObject(row12Signs, {c: r.signColors[3], is: 11})
            }

        }
    }
    Component{
        id: compSign
        Item{
            id: xSign
            width: r.wdeg*30
            height: xSigns.height
            property color c: 'red'
            property int is: 0
            Row{
                anchors.centerIn: parent
                Repeater{
                    model: 30
                    Rectangle{
                        color: xSign.c
                        width: r.wdeg
                        height: xSigns.height
                        //border.width: 1
                    }
                }
            }
            Image{
                width: parent.height
                height: width
                source: '../../imgs/signos/'+xSign.is+'.svg'
                anchors.centerIn: parent
            }
        }
    }
    Component{
        id: compBodie
        Rectangle{
            id: xIcon
            width: 1
            height: hs*0.5+(sen.width*0.25*i)
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            property int i: 0
            property int is: -1
            property int ih: -1
            property real gdeg: 0.0
            property real s: 1.0
            property real hs: app.fs*3
            property string strImg: 'ego.png'
            Rectangle{
                id: sen
                width: app.fs*0.75
                height: width
                radius: width*0.5
                color: 'transparent'
                border.width: 0
                border.color: apps.fontColor
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: xIcon.strImg!==''
                Rectangle{
                    anchors.fill: parent
                    color: apps.backgroundColor
                    opacity: 0.5
                    radius: width*0.5
                }
                Image{
                    id: imgIcon
                    width: parent.width*xIcon.s
                    height: width
                    //source: '../../modules/ZoolEvolutionView/imgs/ev'+xIcon.i+'.png'
                    source: xIcon.strImg!==''?'../../imgs/planetas/'+xIcon.strImg:''
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    anchors.fill: imgIcon
                    source: imgIcon
                    color: apps.fontColor
                    visible: xIcon.strImg!==''
                }
            }
        }
    }
    Component{
        id: compIconEv
        Rectangle{
            id: xIcon
            width: 2
            height: hs*2
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            property int i: 0
            property real s: 1.0
            property real hs: app.fs*3
            property int ih: -1
            property string strImg: 'ego.png'
            Item{
                id: xHouse
                width: app.fs*2
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: width//*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                visible: parent.ih>=1
                Image{
                    id: imgIconHouse
                    width: parent.width*0.5
                    height: width
                    source: '../../imgs/casa.svg'
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    anchors.fill: imgIconHouse
                    source: imgIconHouse
                    color: apps.fontColor
                }
                Text{
                    text: '<b>'+xIcon.ih+'</b>'
                    color: apps.backgroundColor
                    font.pixelSize: app.fs*0.35
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                id: sen
                width: app.fs*2
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 2
                border.color: apps.fontColor
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: xIcon.strImg!==''
                Image{
                    id: imgIcon
                    width: parent.width*xIcon.s
                    height: width
                    //source: '../../modules/ZoolEvolutionView/imgs/ev'+xIcon.i+'.png'
                    source: xIcon.strImg!==''?'../../modules/ZoolEvolutionView/imgs/'+xIcon.strImg:''
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    anchors.fill: imgIcon
                    source: imgIcon
                    color: apps.fontColor
                    visible: xIcon.strImg!==''
                }
            }
            Component.onCompleted: {
                /*if(xIcon.i===3){
                    r.icon3=xIcon
                }
                if(xIcon.i===4){
                    r.icon4=xIcon
                }
                if(xIcon.i===5){
                    r.icon5=xIcon
                }
                if(xIcon.i===6){
                    r.icon6=xIcon
                }
                if(xIcon.i===7){
                    r.icon7=xIcon
                }
                if(xIcon.i===8){
                    r.icon8=xIcon
                }
                if(xIcon.i===10){
                    r.icon10=xIcon
                }
                if(xIcon.i===12){
                    r.icon12=xIcon
                }
                if(xIcon.i===16){
                    r.icon16=xIcon
                }*/
            }
        }
    }
    Component{
        id: compIconEvSup
        Rectangle{
            id: xIcon
            width: 2
            height: hs
            radius: width*0.5
            color: 'transparent'//apps.backgroundColor
            //border.width: 2
            //border.color: apps.fontColor
            property int i: 0
            property int e: 1
            property real s: 1.0
            property real hs: app.fs*3
            property int ih: -1
            property string strImg: 'ego.png'
            Rectangle{
                id: sen
                width: app.fs*1.25
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: 2
                border.color: apps.fontColor
                anchors.bottom: parent.top
                anchors.bottomMargin: width*parent.e-xSigns.height//+app.fs*0.1
                anchors.horizontalCenter: parent.horizontalCenter
                visible: xIcon.strImg!==''
                Rectangle{
                    width: 2
                    height: parent.width*parent.parent.e-xSigns.height
                    color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top:  parent.bottom
                }
                Image{
                    id: imgIcon
                    width: parent.width*xIcon.s
                    height: width
                    //source: '../../modules/ZoolEvolutionView/imgs/ev'+xIcon.i+'.png'
                    source: xIcon.strImg!==''?'../../modules/ZoolEvolutionView/imgs/'+xIcon.strImg:''
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    anchors.fill: imgIcon
                    source: imgIcon
                    color: apps.fontColor
                    visible: xIcon.strImg!==''
                }
            }
        }
    }
    Component.onCompleted: {
        r.visible=false
        let s12Signs1 = comp12Sign.createObject(rowSigns, {})
        let s12Signs2 = comp12Sign.createObject(rowSigns, {})
        let s12Signs3 = comp12Sign.createObject(rowSigns, {})
        let s12Signs4 = comp12Sign.createObject(rowSigns, {})

        //Iconos de Contextos de Vida
        //let iconCasa1 = compIconEv.createObject(rowIcons, {i: 1, ih: 1, s: 2.0, strImg: 'ev1.png'})
        r.iconC1=compIconEv.createObject(rowIcons, {i: 1, ih: 1, s: 2.0, strImg: 'ev1.png'})
        r.iconC2 = compIconEv.createObject(rowIcons, {i: 2, ih: 2, s: 1.0, strImg: 'ev2.png'})
        r.iconC3 = compIconEv.createObject(rowIcons, {i: 3, ih: 3, s: 1.0, strImg: 'ev3.png'})
        r.iconC4 = compIconEv.createObject(rowIcons, {i: 4, ih: 4, s: 1.0, strImg: 'ev4.png'})
        r.iconC5 = compIconEv.createObject(rowIcons, {i: 5, ih: 5, s: 0.75, strImg: 'ego.png'})
        r.iconC6 = compIconEv.createObject(rowIcons, {i: 6, ih: 6, s: 1.0, strImg: 'ev5.png'})
        r.iconC7 = compIconEv.createObject(rowIcons, {i: 7, ih: 7, s: 1.0, strImg: 'ev6.png'})
        r.iconC8 = compIconEv.createObject(rowIcons, {i: 8, ih: 8, s: 1.0, strImg: 'ev7.png'})
        r.iconC9 = compIconEv.createObject(rowIcons, {i: 9, ih: 9, s: 1.0, strImg: 'ev8.png'})
        r.iconC10 = compIconEv.createObject(rowIcons, {i: 10, ih: 10, s: 1.0, strImg: 'ev9.png'})
        r.iconC11 = compIconEv.createObject(rowIcons, {i: 11, ih: 11, s: 1.0, strImg: 'ev10.png'})
        r.iconC12 = compIconEv.createObject(rowIcons, {i: 12, ih: 12, s: 1.0, strImg: 'ev11.png'})
        r.iconC12p1 = compIconEvSup.createObject(rowIcons, {e:1, i: 12, ih: 12, s: 0.8, strImg: 'ev12.png'})
        r.iconC12p2 = compIconEvSup.createObject(rowIcons, {e:2, i: 12, ih: 12, s: 0.8, strImg: 'ev13.png'})
        r.iconC12p3 = compIconEvSup.createObject(rowIcons, {e:3, i: 12, ih: 12, s: 0.8, strImg: 'ev14.png'})
        r.iconC12p4 = compIconEvSup.createObject(rowIcons, {e:4, i: 12, ih: 12, s: 0.8, strImg: 'ev15.png'})

        r.icon16 = compIconEv.createObject(xSigns, {i: 16, s: 0.8, strImg: 'ev16.png'})

        //Bodies
        r.bodie0 = compBodie.createObject(xSigns, {i: 0, s: 0.8, strImg: 'sun.svg'})
        r.bodie1 = compBodie.createObject(xSigns, {i: 1, s: 0.8, strImg: 'moon.svg'})
        r.bodie2 = compBodie.createObject(xSigns, {i: 2, s: 0.8, strImg: 'mercury.svg'})
        r.bodie3 = compBodie.createObject(xSigns, {i: 3, s: 0.8, strImg: 'venus.svg'})
        r.bodie4 = compBodie.createObject(xSigns, {i: 4, s: 0.8, strImg: 'mars.svg'})
        r.bodie5 = compBodie.createObject(xSigns, {i: 5, s: 0.8, strImg: 'jupiter.svg'})
        r.bodie6 = compBodie.createObject(xSigns, {i: 6, s: 0.8, strImg: 'saturn.svg'})
        r.bodie7 = compBodie.createObject(xSigns, {i: 7, s: 0.8, strImg: 'uranus.svg'})
        r.bodie8 = compBodie.createObject(xSigns, {i: 8, s: 0.8, strImg: 'neptune.svg'})
        r.bodie9 = compBodie.createObject(xSigns, {i: 9, s: 0.8, strImg: 'pluto.svg'})
        r.bodie10 = compBodie.createObject(xSigns, {i: 10, s: 0.8, strImg: 'nn.svg'})
        r.bodie11 = compBodie.createObject(xSigns, {i: 11, s: 0.8, strImg: 'ns.svg'})
        r.bodie12 = compBodie.createObject(xSigns, {i: 12, s: 0.8, strImg: 'hiron.svg'})

        return
        let icon4 = compIconEv.createObject(xSigns, {i: 4, ih: 3, s: 1.0, strImg: 'ev3.png'})
        let icon5 = compIconEv.createObject(xSigns, {i: 5, ih: 4, s: 1.0, strImg: 'ev4.png'})
        let iconCasa5 = compIconEv.createObject(xSigns, {i: 5, ih: 5, s: 1.0, strImg: 'ego.png'})
        let icon6 = compIconEv.createObject(xSigns, {i: 6, ih: 6, s: 1.0, strImg: 'eg6.png'})
        let icon7 = compIconEv.createObject(xSigns, {i: 7, ih: 9, s: 1.0, strImg: 'ev7.png'})
        let icon8 = compIconEv.createObject(xSigns, {i: 8, ih: 10, s: 1.0, strImg: 'ev8.png'})
        //let icon9 = compIconEv.createObject(xSigns, {i: 9, s: 1.0}) //Sale con maletin
        let icon10 = compIconEv.createObject(xSigns, {i: 10, ih: 11, s: 1.0, strImg: 'ev10.png'})
        let icon12 = compIconEv.createObject(xSigns, {i: 12, ih: 12, s: 1.0, strImg: 'ev12.png'})
        //let icon16 = compIconEv.createObject(xSigns, {i: 16, s: 0.8, strImg: 'ev16.png'})

    }
    function updateData(){
        //        for(var i=0;i<rowSigns.children.length;i++){
        //            rowSigns.children[i].destroy(0)
        //        }
        let j=zm.currentJson
        //log.lv('json: '+JSON.stringify(j, null, 2))
        //log.lv('json: '+JSON.stringify(j, null, 2))
        let gdegAsc=j.ph.h1.gdeg
        let gdecAsc=j.ph.h1.gdec
        //log.lv('gdegAsc: '+gdegAsc)
        r.currentAscDeg=gdegAsc
        let ascIs=zm.getIndexSign(gdecAsc)
        let gms=zm.getDDToDMS(gdecAsc)
        r.txtNac='<b>Nacimiento:</b><br>Signo '+zm.aSigns[ascIs]+'<br>°'+parseInt(gms.deg-(ascIs*30))+' \''+gms.min+' \'\''+parseInt(gms.sec)

        //return

        let nx=(r.wdeg*(j.ph.h2.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width

        nx=(r.wdeg*(j.ph.h2.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC2.x=nx

        nx=(r.wdeg*(j.ph.h3.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC3.x=nx

        nx=(r.wdeg*(j.ph.h4.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC4.x=nx

        nx=(r.wdeg*(j.ph.h5.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC5.x=nx

        nx=(r.wdeg*(j.ph.h6.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC6.x=nx

        nx=(r.wdeg*(j.ph.h7.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC7.x=nx

        nx=(r.wdeg*(j.ph.h8.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC8.x=nx

        nx=(r.wdeg*(j.ph.h9.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC9.x=nx

        nx=(r.wdeg*(j.ph.h10.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC10.x=nx

        nx=(r.wdeg*(j.ph.h11.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC11.x=nx

        nx=(r.wdeg*(j.ph.h12.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.iconC12.x=nx


        r.icon16.x=r.icon16.parent.width

        //Bodies
        nx=(r.wdeg*(j.pc.c0.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie0.x=nx

        nx=(r.wdeg*(j.pc.c1.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie1.x=nx

        nx=(r.wdeg*(j.pc.c2.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie2.x=nx

        nx=(r.wdeg*(j.pc.c3.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie3.x=nx

        nx=(r.wdeg*(j.pc.c4.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie4.x=nx

        nx=(r.wdeg*(j.pc.c5.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie5.x=nx

        nx=(r.wdeg*(j.pc.c6.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie6.x=nx

        nx=(r.wdeg*(j.pc.c7.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie7.x=nx

        nx=(r.wdeg*(j.pc.c8.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie8.x=nx

        nx=(r.wdeg*(j.pc.c9.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie9.x=nx

        nx=(r.wdeg*(j.pc.c10.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie10.x=nx

        nx=(r.wdeg*(j.pc.c11.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie11.x=nx

        nx=(r.wdeg*(j.pc.c12.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.bodie12.x=nx



        let posInicial=r.iconC12.x
        let posFinal=r.icon16.x
        let diff=posFinal-posInicial
        let fraccion=diff/5
        r.iconC12p1.x=r.iconC12.x+fraccion
        r.iconC12p2.x=r.iconC12.x+fraccion*2
        r.iconC12p3.x=r.iconC12.x+fraccion*3
        r.iconC12p4.x=r.iconC12.x+fraccion*4



        /*return
        r.icon4.x=(r.wdeg*(j.ph.h3.gdeg+(360-gdegAsc)))
        r.icon5.x=(r.wdeg*(j.ph.h4.gdeg+(360-gdegAsc)))
        r.icon6.x=(r.wdeg*(j.ph.h6.gdeg+(360-gdegAsc)))
        r.icon7.x=(r.wdeg*(j.ph.h9.gdeg+(360-gdegAsc)))
        r.icon8.x=(r.wdeg*(j.ph.h10.gdeg+(360-gdegAsc)))
        r.icon10.x=(r.wdeg*(j.ph.h11.gdeg+(360-gdegAsc)))
        r.icon12.x=(r.wdeg*(j.ph.h12.gdeg+(360-gdegAsc)))*/

    }

}
