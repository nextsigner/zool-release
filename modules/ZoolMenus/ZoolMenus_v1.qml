import QtQuick 2.12
import QtQuick.Controls 2.12

Menu {
    id: r
    width: app.fs*8
    onOpenedChanged:  menuBar.expanded=opened
    //onCurrentIndexChanged: menuBar.uCMI=aMI[currentIndex]
    Component.onCompleted: menuBar.aMenuItems.push(this)
    property int w: 400
    property int fs: app.fs*0.75
    onVisibleChanged: {
        if(visible){
            let cantMaxCaracteres=1
            for(var i=0;i<r.count; i++){
                if(r.actionAt(i).text.length>cantMaxCaracteres){
                    cantMaxCaracteres=r.actionAt(i).text.length
                }
                //log.lv('cantMaxCaracteres='+cantMaxCaracteres)
            }
            r.w=cantMaxCaracteres*r.fs*0.65
        }
    }
    delegate: MenuItem {
        id: menuItem
        font.pixelSize: r.fs
        implicitWidth: r.w
        implicitHeight: r.fs*1.25
        width: r.w
        height: r.fs*1.25

        //        arrow: Canvas {
        //            x: parent.width - width
        //            implicitWidth: 40
        //            implicitHeight: 40
        //            visible: menuItem.subMenu
        //            onPaint: {
        //                var ctx = getContext("2d")
        //                ctx.fillStyle = menuItem.highlighted ? "#ffffff" : "#21be2b"
        //                ctx.moveTo(15, 15)
        //                ctx.lineTo(width - 15, height / 2)
        //                ctx.lineTo(15, height - 15)
        //                ctx.closePath()
        //                ctx.fill()
        //            }
        //        }

        indicator: Item {
            implicitWidth: 2
            implicitHeight: 2//40
            Rectangle {
                width: 1//26
                height: 1//26
                anchors.centerIn: parent
                visible: menuItem.checkable
                border.color: "#21be2b"
                radius: 3
                Rectangle {
                    width: 14
                    height: 14
                    anchors.centerIn: parent
                    visible: menuItem.checked
                    color: "#21be2b"
                    radius: 2
                }
            }
        }
        contentItem: Text {
            leftPadding: menuItem.indicator.width
            rightPadding: menuItem.arrow.width
            text: menuItem.text.replace('&', '')
            font: menuItem.font
            opacity: enabled ? 1.0 : 0.3
            color:menuItem.highlighted ? apps.fontColor : apps.backgroundColor
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: menuItem.highlighted ?  apps.backgroundColor : apps.fontColor
        }
    }
}
