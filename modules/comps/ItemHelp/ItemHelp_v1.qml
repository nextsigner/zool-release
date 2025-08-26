import QtQuick 2.0

Rectangle{
    id: r
    anchors.fill: parent
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    property string text: '?'
    property string ctx: ''
    property string cCtx: zsm.cPanelName
    onCCtxChanged: {
        //zpn.log('ctx: '+r.ctx+'\ncCtx: '+r.cCtx)
        if(ctx!==cCtx)r.destroy(0)
    }
    MouseArea{
        anchors.fill: parent
        onClicked: r.destroy(0)
    }
    Rectangle{
        width: lx.contentWidth+app.fs*0.1
        height: lx.contentHeight+app.fs*0.1
        color: apps.fontColor
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.25
        MouseArea{
            anchors.fill: parent
            onClicked: r.destroy(0)
        }
        Text{
            id: lx
            text: 'X'
            font.pixelSize: app.fs*0.5
            color: apps.backgroundColor
            anchors.centerIn: parent
        }
    }
    Text{
        text: r.text
        width: parent.width-app.fs
        height: contentHeight
        font.pixelSize: app.fs*0.5
        color: apps.fontColor
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
    }
}
