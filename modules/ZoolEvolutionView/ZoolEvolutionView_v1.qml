import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: r
    anchors.fill: parent
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    onVisibleChanged: if(visible)updateData()
    property int wdeg: (r.width-app.fs*3)/360
    property int currentAscDeg: 0

    property string txtNac: '<b>Nacimiento</b>'

    property var icon3 //Comineza a gatear
    property var icon4 //Comineza a caminar
    property var icon5 //Comineza a interactuar con el hogar
    property var icon6 //Comineza Estudios
    property var icon7 //Comineza Estudios Secundarios
    property var icon8 //Termina los estudios o capacitación
    property var icon10 //Logros
    property var icon12 //Entra a la vejez de Casa 12
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
        Item{width: 1; height: app.fs*4}
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
                source: '../../resources/imgs/signos/'+xSign.is+'.svg'
                anchors.centerIn: parent
            }
        }
    }
    Component{
        id: compIconEv
        Rectangle{
            id: xIcon
            width: 2
            height: hs
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            property int i: 0
            property real s: 1.0
            property real hs: app.fs*3
            property int ih: -1
            Item{
                id: xHouse
                width: app.fs*2
                height: width
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: width*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                visible: parent.ih>=1
                Image{
                    id: imgIconHouse
                    width: parent.width*0.5
                    height: width
                    source: '/home/ns/nsp/zool-release/resources/imgs/casa.svg'
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
                Image{
                    id: imgIcon
                    width: parent.width*xIcon.s
                    height: width
                    source: '../../modules/ZoolEvolutionView/imgs/ev'+xIcon.i+'.png'
                    anchors.centerIn: parent
                    visible: false
                }
                ColorOverlay{
                    anchors.fill: imgIcon
                    source: imgIcon
                    color: apps.fontColor
                }
            }
            Component.onCompleted: {
                if(xIcon.i===3){
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
        let icon1 = compIconEv.createObject(rowIcons, {i: 1, ih: 1, s: 2.0})
        let icon3 = compIconEv.createObject(rowIcons, {i: 3, ih: 2, s: 1.0})
        let icon4 = compIconEv.createObject(xSigns, {i: 4, ih: 3, s: 1.0})
        let icon5 = compIconEv.createObject(xSigns, {i: 5, ih: 4, s: 1.0})
        let icon6 = compIconEv.createObject(xSigns, {i: 6, ih: 6, s: 1.0})
        let icon7 = compIconEv.createObject(xSigns, {i: 7, ih: 9, s: 1.0})
        let icon8 = compIconEv.createObject(xSigns, {i: 8, ih: 10, s: 1.0})
        //let icon9 = compIconEv.createObject(xSigns, {i: 9, s: 1.0}) //Sale con maletin
        let icon10 = compIconEv.createObject(xSigns, {i: 10, ih: 11, s: 1.0})
        let icon12 = compIconEv.createObject(xSigns, {i: 12, ih: 12, s: 1.0})
        let icon16 = compIconEv.createObject(xSigns, {i: 16, s: 0.8})

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

        let nx=(r.wdeg*(j.ph.h2.gdeg+(360-gdegAsc)))
        if(nx>=r.icon16.parent.width)nx=nx-r.icon16.parent.width
        r.icon3.x=nx
        r.icon4.x=(r.wdeg*(j.ph.h3.gdeg+(360-gdegAsc)))
        r.icon5.x=(r.wdeg*(j.ph.h4.gdeg+(360-gdegAsc)))
        r.icon6.x=(r.wdeg*(j.ph.h6.gdeg+(360-gdegAsc)))
        r.icon7.x=(r.wdeg*(j.ph.h9.gdeg+(360-gdegAsc)))
        r.icon8.x=(r.wdeg*(j.ph.h10.gdeg+(360-gdegAsc)))
        r.icon10.x=(r.wdeg*(j.ph.h11.gdeg+(360-gdegAsc)))
        r.icon12.x=(r.wdeg*(j.ph.h12.gdeg+(360-gdegAsc)))
        r.icon16.x=r.icon16.parent.width
    }

}
