import QtQuick 2.7
import QtQuick.Controls 2.12

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
        id: row
        spacing: app.fs*0.15
        anchors.centerIn: parent
        Rectangle{
            id: circuloSave
            width: app.fs*0.5
            height: width
            radius: width*0.5
            color: app.fileData===app.currentData?'gray':'red'
            border.width: 2
            border.color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            //y:(parent.height-height)/2
            visible:  !app.ev
            MouseArea{
                anchors.fill: parent
                enabled: app.titleData!==app.currentData
                onClicked: {
                    app.j.saveJson()
                }
            }
        }
        Row{
            id: rowDataLeft
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle{
            id: xSep
            width: txtSep.contentWidth+app.fs*0.3
            height: txtSep.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 2
            border.color: apps.fontColor
            radius: app.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
            visible: r.atRight.length>0
            Text{
                id: txtSep
                text: '<b>'+r.stringMiddleSeparator+'<b>'
                font.pixelSize: r.height*0.5
                color: apps.fontColor
                anchors.centerIn: parent
            }
        }
        Row{
            id: rowDataRight
            spacing: app.fs*0.15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Component{
        id: compCellData
        Rectangle{
            width: txtRow.contentWidth+app.fs*0.3
            height: txtRow.contentHeight+app.fs*0.3
            color: apps.backgroundColor
            border.width: 2//modelData==='@'?0:1
            border.color: apps.fontColor
            radius: app.fs*0.1
            anchors.verticalCenter: parent.verticalCenter
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
        }
    }
    Timer{
        id: tWaitUpdateData
        running: false
        repeat: false
        interval: 1500
        onTriggered: {
            if(row.width>r.width-app.fs){
                tResizeFs.start()
            }else{
                row.visible=true
            }
        }
    }
    Timer{
        id: tResizeFs
        running: false
        repeat: true
        interval: 100
        onTriggered: {
            r.fs-=2
            if(row.width<r.width-app.fs){
                stop()
                row.visible=true
            }
        }
    }
    Component.onCompleted: {
        let aL=['Ricardo P1', '20/06/1975', '23:04', 'GMT -3', 'Malargue Mendoza', '-69.6564', '-34.6452']
        let aR= []//['Ricardo sdf sd fa fads a s a ', '20/06/1975', '23:04', 'GMT -3', 'sdfsa asd sda sda Malargue Mendoza', '-69.6564', '-34.6452']
        //setDataView('Sinastría', aL, aR)
    }
    function setDataView(sep, aL, aR){
        row.visible=false
        r.fs=r.height*0.5
        r.stringMiddleSeparator=sep
        r.atLeft=aL
        r.atRight=aR
        updateDataView()
    }
    function updateDataView(){
        for(var i=0; i < rowDataLeft.children.length;i++){
            rowDataLeft.children[i].destroy(1)
        }
        for(i=0; i < rowDataRight.children.length;i++){
            rowDataRight.children[i].destroy(1)
        }
        let aL=r.atLeft
        let aR=r.atRight
        for(i=0; i < aL.length;i++){
            var obj=compCellData.createObject(rowDataLeft, {txtData:aL[i]})
        }
        for(i=0; i < aR.length;i++){
            obj=compCellData.createObject(rowDataRight, {txtData:aR[i]})
        }
        tWaitUpdateData.start()
    }

}
