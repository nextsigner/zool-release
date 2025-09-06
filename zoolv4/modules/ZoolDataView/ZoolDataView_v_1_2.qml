import QtQuick 2.7
import QtQuick.Controls 2.12

import ZoolDataView.menus.MenuIsDataDiff 1.0
import ZoolDataView.menus.MenuFecha 1.0
import ZoolDataView.menus.MenuNom 1.0
import ZoolDataView.menus.MenuSep 1.0

import comps.FocusSen 1.0

Rectangle {
    id: r
    width: parent.width
    height: app.fs*1.5
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor

    property string stringMiddleSeparator: 'VN'
    property url uItemGrabber
    property int fs: app.fs*0.5
    property var atLeft: []
    property var atRight: []
    property string uExtIdLoaded: ''

    onAtLeftChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    onAtRightChanged: {
        //setDataView(r.stringMiddleSeparator, r.atLeft, r.atRight)
    }
    Rectangle{
        width: txtLoading.contentWidth+app.fs*0.3
        height: txtLoading.contentHeight+app.fs*0.3
        color: apps.backgroundColor
        border.width: 2
        border.color: apps.fontColor
        radius: app.fs*0.1
        anchors.centerIn: parent
        visible: !row.visible
        Text{
            id: txtLoading
            text: '<b>Cargando...<b>'
            font.pixelSize: r.height*0.5
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Row{
        anchors.centerIn: parent
        //anchors.horizontalCenterOffset: r.width*0.5-row.width*0.5-()
        parent: xSep
        z:9
        visible: r.atRight.length>0
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColor
        }
        Rectangle{
            width: r.width
            height: r.height
            color: apps.houseColorBack
        }
    }
    Row{
        id: row
        width: rowDataLeft.width+xSep.width+rowDataRight.width+spacing*2
        spacing: app.fs*0.15
        anchors.centerIn: parent
        visible: !tResizeFs.running
        Row{
            id: rowDataLeft
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
            Rectangle{
                id: cell0
                width: txtRow0.contentWidth+app.fs*0.3
                height: txtRow0.contentHeight+app.fs*0.3
                color: apps.backgroundColor
                border.width: 2//modelData==='@'?0:1
                border.color: apps.fontColor
                radius: app.fs*0.1
                anchors.verticalCenter: parent.verticalCenter
                visible: zm.isDataDiff
                property int cellIndex: -1
                property string txtData: '<b>Sin guardar</b>'

                Rectangle{
                    id: bgCell0
                    anchors.fill: parent
                    color: 'red'//apps.backgroundColor
                    radius: parent.radius
                    border.width: 1//modelData==='@'?0:1
                    border.color: apps.fontColor
                }
                Text{
                    id: txtRow0
                    //text: modelData!=='@'?modelData:r.stringMiddleSeparator//.replace(/_/g, ' ')
                    text: cell0.txtData
                    font.pixelSize: r.fs
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
                Timer{
                    running: parent.visible
                    repeat: true
                    interval: 500
                    onTriggered: bgCell0.visible=!bgCell0.visible
                }
                MouseArea{
                    anchors.fill: parent
                    //enabled: parent.cellIndex===0
                    acceptedButtons: Qt.AllButtons;
                    onClicked: {
                        //apps.sweFs=app.fs
                        if (mouse.button === Qt.RightButton) { // 'mouse' is a MouseEvent argument passed into the onClicked signal handler
                            //if(parent.cellIndex===0){
                                mIsDataDiff.popup()
                            //}
                        } else if (mouse.button === Qt.LeftButton) {
                            //Qt.quit()
                        }
                    }
                }

            }

        }
        Item{
            id: xSep
            width: txtSep.contentWidth+app.fs*0.3+border.width
            height: txtSep.contentHeight+app.fs*0.3+border.width
            anchors.verticalCenter: parent.verticalCenter
            visible: r.atRight.length>0
            z:-100
            Rectangle{
                id: bgSep
                anchors.fill: parent
                color: apps.fontColor
                border.width: app.backIsSaved?2:6
                border.color: apps.backgroundColor
                radius: app.fs*0.1
                z:10

//                SequentialAnimation on border.color {
//                    running: !app.backIsSaved
//                    loops: Animation.Infinite
//                    ColorAnimation {
//                        from: apps.fontColor
//                        to: apps.backgroundColor
//                        duration: 400
//                    }
//                    ColorAnimation {
//                        from: apps.backgroundColor
//                        to: apps.fontColor
//                        duration: 400
//                    }

//                }

            }
            Text{
                id: txtSep
                text: '<b>'+r.stringMiddleSeparator+'</b>'
                //font.pixelSize: !app.backIsSaved?r.height*0.35:r.height*0.5
                font.pixelSize: r.height*0.5
                color: apps.backgroundColor
                anchors.centerIn: parent
                z:11
            }
            MouseArea{
                anchors.fill: parent
                //enabled: parent.cellIndex===0
                acceptedButtons: Qt.AllButtons;
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        mSep.stringMiddleSep=r.stringMiddleSeparator
                        mSep.popup()

                    } else if (mouse.button === Qt.LeftButton) {
                        //Qt.quit()
                    }
                }
            }

//            Rectangle{
//                id: xTxtSG
//                width: txtSG.contentWidth+app.fs*0.3+border.width
//                height: txtSG.contentHeight+border.width
//                color: apps.fontColor
//                border.width: 1
//                border.color: bgSep.border.color
//                radius: app.fs*0.1
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.bottom
//                z: txtSep.z+1
//                visible: !app.backIsSaved

////                MouseArea{
////                    anchors.fill: parent
////                    onClicked: {
////                        let isSaved=zfdm.saveExtToJsonFile(r.uExtIdLoaded)
////                        app.backIsSaved=isSaved
////                        if(apps.dev)log.lv('Guardado desde zoolDataView: '+app.backIsSaved)
////                    }
////                }

//                Text{
//                    id: txtSG
//                    text: '<b>Sin guardar</b>'
//                    font.pixelSize: r.height*0.2
//                    color: apps.backgroundColor//bgSep.border.color
//                    anchors.centerIn: xTxtSG
//                    //visible: xTxtSG.visible
//                }
//            }


        }
        Row{
            id: rowDataRight
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        anchors.fill: row
        border.width: 4
        border.color: 'red'
        color: 'transparent'
        visible: apps.dev
    }
    Component{
        id: compCellData
        Rectangle{
            id: xCellData
            width: txtRow.contentWidth+app.fs*0.3
            height: txtRow.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 2//modelData==='@'?0:1
            border.color: apps.fontColor
            radius: app.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
            visible: app.t!=='dirprim'&&app.t!=='progsec'?true:!xCellData.isExt?
                                                               (
                                                                   cellIndex<6
                                                                   )
                                                             :(
                                                                   cellIndex<3+r.atLeft.length-1
                                                                   )
            property bool isExt: false
            property int cellIndex: -1
            property string txtData: 'txtData'

            Rectangle{
                id: bgCell
                anchors.fill: parent
                color: apps.backgroundColor
                radius: parent.radius
                border.width: 1//modelData==='@'?0:1
                border.color: apps.fontColor
            }
            Text{
                id: txtRow
                //text: modelData!=='@'?modelData:r.stringMiddleSeparator//.replace(/_/g, ' ')
                text: txtData
                font.pixelSize: r.fs
                color: apps.fontColor
                anchors.centerIn: parent
            }
            FocusSen{
                id: fs1
                visible: zm.isDataDiff && parent.cellIndex===1
                radius: parent.radius
                color: apps.backgroundColor
                Text{
                    id: txtFechaTemp
                    text: '??/??/????'//txtData
                    font.pixelSize: r.fs
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
            FocusSen{
                id: fs2
                visible: zm.isDataDiff && parent.cellIndex===3
                radius: parent.radius
                color: apps.backgroundColor
                Text{
                    id: txtHoraMinutoTemp
                    text: txtData
                    font.pixelSize: r.fs
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
            Timer{
                running: fs1.visible || fs2.visible
                repeat: true
                interval: 250
                onTriggered: {
                    let d = zm.currentDate
                    txtFechaTemp.text=zdm.dateToDMA(d)
                    txtHoraMinutoTemp.text=zdm.dateToHMS(d)+'hs'
                    //log.lv('d: '+zdm.dateToHMS(d))
                }
            }

            MouseArea{
                anchors.fill: parent
                //enabled: parent.cellIndex===0
                hoverEnabled: true
                acceptedButtons: Qt.AllButtons;
                onClicked: {
                    //apps.sweFs=app.fs
                    if (mouse.button === Qt.RightButton) {
                        if(parent.cellIndex===0){
                            mNom.popup()
                        }
                        if(parent.cellIndex===1){
                            var item1=zoolDataView.parent
                            var item2=xCellData
                            var absolutePosition = item2.mapToItem(item1, 0, 0);
                            //return {x: absolutePosition.x, y:absolutePosition.y}
                            mFecha.parentX=absolutePosition.x//xCellData.x+((app.width-xCellData.parent.width)*0.5)
                            mFecha.popup()
                        }
                    } else if (mouse.button === Qt.LeftButton) {
                        if(zm.isDataDiff && (xCellData.cellIndex===1 || xCellData.cellIndex===3)){
                            let d = zm.currentDate
                            let p=zfdm.getJsonAbsParams(false)
                            //log.lv('d: '+d.toString())
                            let cd
                            if(xCellData.cellIndex===1){
                                cd=new Date(p.a, p.m-1, p.d, d.getHours(), d.getMinutes())
                                //log.lv('cd1: '+cd.toString())
                            }
                            if(xCellData.cellIndex===3){
                                cd=new Date(d.getFullYear(), d.getMonth(), d.getDate(), p.h, p.min)
                                //log.lv('cd2: '+cd.toString())
                            }
                            zm.currentDate=cd
                        }
                    }
                }
                onPositionChanged: {
                    setXTip()
                }
                onEntered: {
                    setXTip()
                }
                onExited: {
                    if(zm.isDataDiff && (xCellData.cellIndex===1 || xCellData.cellIndex===3)){
                        tHideXTip.restart()
                        txtTip.text=''
                        xTip.visible=false
                        xTip.x=0
                        xTip.width=app.fs*5
                        xTip.parent=capa101
                    }
                }
                function setXTip(){
                    var item1=zoolDataView.parent
                    var item2=xCellData
                    var absolutePosition = item2.mapToItem(item1, 0, 0);
                    if(zm.isDataDiff && (xCellData.cellIndex===1 || xCellData.cellIndex===3)){
                        tHideXTip.restart()
                        if(xCellData.cellIndex===1){
                            txtTip.text='\n\nHacer click para restaurar la fecha.'
                        }
                        if(xCellData.cellIndex===3){
                            txtTip.text='\n\nHacer click para restaurar la hora.'
                        }
                        xTip.visible=true
                        xTip.parent=capa101
                        xTip.x=absolutePosition.x//-xCellData.x
                        xTip.y=zoolDataView.height
                    }
                }
            }

            Rectangle{
                id: xTip
                width: parent.width
                height: txtTip.contentHeight+app.fs*0.5
                color: apps.backgroundColor
                radius: parent.radius
                border.width: 1
                border.color: apps.fontColor
                y:zoolDataView.height
                visible: false
                Timer{
                    id: tHideXTip
                    running: parent.visible
                    interval: 10000
                    onTriggered: {
                        xTip.visible=false
                        xTip.parent=xCellData
                    }
                }
                Text{
                    id: txtTip
                    text: 'Dato de tip'
                    width: parent.width-app.fs*0.25
                    font.pixelSize: r.fs*0.75
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
    }
    //    Timer{
    //        id: tWaitUpdateData
    //        running: false
    //        repeat: false
    //        interval: 1500
    //        onTriggered: {
    //            if(row.width>app.fs*53){
    //                //tResizeFs.start()
    //            }else{
    //                //tResizeFs.stop()
    //                //row.visible=true
    //            }
    //        }
    //    }
    Timer{
        id: tResizeFs
        running: row.width>xApp.width
        repeat: true
        interval: 50
        onTriggered: {
            r.fs-=1
            //            //if(row.width<r.width-app.fs){
            //            if(row.width<app.fs*53){
            //                //stop()
            //                row.visible=true
            //            }
        }
    }
    MenuIsDataDiff{id:mIsDataDiff}
    MenuNom{id:mNom}
    MenuFecha{id:mFecha}
    MenuSep{id:mSep}
    function setDataView(sep, aL, aR){
        //row.visible=false
        r.fs=r.height*0.5
        r.stringMiddleSeparator=sep
        r.atLeft=aL
        r.atRight=aR
        //if(apps.dev)log.lv('zoolDataView.setDataView(sep, aL, aR): '+aL.toString()+' \n'+aR.toString())
        updateDataView()
    }
    function updateDataView(){
        for(var i=0; i < rowDataLeft.children.length;i++){
            if(i!==0)rowDataLeft.children[i].destroy(1)
        }
        for(i=0; i < rowDataRight.children.length;i++){
            rowDataRight.children[i].destroy(1)
        }
        let aL=r.atLeft
        let aR=r.atRight
        for(i=0; i < aL.length;i++){
            var obj=compCellData.createObject(rowDataLeft, {txtData:aL[i], cellIndex: i})
        }
        for(i=0; i < aR.length;i++){
            obj=compCellData.createObject(rowDataRight, {txtData:aR[i], cellIndex: i+r.atLeft.length-1, isExt: true})
        }
        //tWaitUpdateData.start()
    }

    function updateFromCurrentJson(isExt){
        let json=isExt?zfdm.ja:zfdm.jaBack
        //log.lv('zfdm.ja: '+JSON.stringify(zfdm.ja, null, 2))
        log.lv('json: '+JSON.stringify(json, null, 2))
        //return
        let n=json.params.n
        let d=json.params.n
        let m=json.params.d
        let a=json.params.m
        let h=json.params.a
        let min=json.params.min
        let gmt=json.params.gmt
        let lat=json.params.lat
        let lon=json.params.lon
        let alt=json.params.alt
        let c=json.params.c
        let t=json.params.t

        let edad=zm.getEdad(d, m, a, h, min)
        let numEdad=zm.getEdad(parseInt(a), parseInt(m), parseInt(d), parseInt(h), parseInt(min))
        let stringEdad='<b>Edad:</b> '
        if(edad===1){
            stringEdad+=edad+' año'
        }else{
            stringEdad+=edad+' años'
        }

        let sep='Sinastría'
        if(t==='progsec')sep='Prog. Sec.'
        if(t==='trans')sep='Tránsitos'
        let aL=[]
        let aR=[]
        if(!isExt){
            //aL.push('Trásitos')
            aL.push(n)
            aL.push(''+d+'/'+m+'/'+a)
            aL.push(''+h+':'+min+'hs')
            aL.push('<b>GMT:</b> '+gmt)
            if(t==='vn')aL.push(stringEdad)
            aL.push('<b>Ubicación:</b> '+c)
            aL.push('<b>Lat.:</b> '+lat)
            aL.push('<b>Lon.:</b> '+lon)
            aL.push('<b>Alt.:</b> '+alt)
        }else{
            aL=zoolDataView.atLeft
            aR.push(n)
            aR.push(''+d+'/'+m+'/'+a)
            aR.push(''+h+':'+min+'hs')
            if(t==='vn')aL.push(stringEdad)
            aR.push('<b>GMT:</b> '+gmt)
            aR.push('<b>Ubicación:</b> '+c)
            aR.push('<b>Lat.:</b> '+lat)
            aR.push('<b>Lon.:</b> '+lon)
            aR.push('<b>Alt.:</b> '+alt)
        }
        zoolDataView.setDataView(sep, aL, aR)

    }
    function clearExtData(){
        r.fs=r.height*0.5
        r.stringMiddleSeparator=''
        r.atRight=[]
        updateDataView()
    }
}
