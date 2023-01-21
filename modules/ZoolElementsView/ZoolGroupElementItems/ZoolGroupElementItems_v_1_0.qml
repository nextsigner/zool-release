import QtQuick 2.0
import ZoolElementsView.ZoolGroupElementItems.ZoolElementItem 1.0


Rectangle{
    id: r
    width: r.fs*6
    height: col.height//app.fs*4
    border.width: 1
    border.color: 'red'
    color: 'blue'// 'transparent'
    property int fs: app.fs*3
    Column{
        id: col
        anchors.centerIn: parent
        ZoolElementItem{fs: r.fs; numElement: 0}
        ZoolElementItem{fs: r.fs; numElement: 1}
        ZoolElementItem{fs: r.fs; numElement: 2}
        ZoolElementItem{fs: r.fs; numElement: 3}
    }
}


