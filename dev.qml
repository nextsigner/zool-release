import QtQuick 2.0

Item{
    id: r
    objectName: 'devcode'
    /*Timer{
        id: t
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            log.lv('zoolMap.objHousesCircleBack.visible:\n'+zoolMap.objHousesCircleBack.visible+'\n')
            zoolMap.objHousesCircleBack.width=zoolMap.width
            log.lv('zoolMap.objHousesCircleBack.width:\n'+zoolMap.objHousesCircleBack.width+'\n')
            log.x=xApp.width-xLatIzq.width
        }
    }*/
    Component.onCompleted: {
        log.clear()
        log.lv('DevCode ir running!')
    }
}
