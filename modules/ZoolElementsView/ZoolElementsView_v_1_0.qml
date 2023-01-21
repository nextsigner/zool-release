import QtQuick 2.0
import ZoolElementsView.ZoolGroupElementItems 1.0
import Qt.labs.settings 1.0

Rectangle{
    id: r
    width: colZoolGroupElementItems.width+app.fs
    height: colZoolGroupElementItems.height+app.fs
    anchors.right: parent.right
    anchors.rightMargin: 0-width*0.75
    border.width: 4
    border.color:'yellow'
    color: 'transparent'
    property int fs: app.fs*2*s.zoom
    property alias settings: s
    transform: Scale {
        id: tform2
        xScale: 0.25
        yScale: 0.25
    }
    Settings{
        id: s
        fileName: './modules/ZoolElementsView/ZoolElementsView.cfg'
        property real zoom: 1.0
    }

    Column{
        id: colZoolGroupElementItems
        anchors.centerIn: parent
        spacing: app.fs*0.5
        ZoolGroupElementItems{fs: r.fs}
        ZoolGroupElementItems{fs: r.fs}
    }

}
