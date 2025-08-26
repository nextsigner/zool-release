import QtQuick 2.0
import ZoolSectionsManager.XSection 1.0

XSection{
    id: r
    itemType: r
    Rectangle{
        id: container
        width: r.width
        height: col.height
        color: 'green'
        border.width: 20
        border.color: 'blue'
        //parent: r.c
        Column{
            id: col
            anchors.centerIn: parent
            Repeater{
                model: 30
                Rectangle{
                    width: 300
                    height: 50
                    border.width: 10
                    border.color: 'red'
                }
            }
        }
    }


}
