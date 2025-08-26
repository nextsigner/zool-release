import QtQuick 2.0

Item{
    id: r
    objectName: 'devcode'
    Timer{
        id: t
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            //log.lv('zm.objHousesCircleBack.visible:\n'+zm.objHousesCircleBack.visible+'\n')
            //zm.objHousesCircleBack.width=zm.width
            //log.lv('zm.objHousesCircleBack.width:\n'+zm.objHousesCircleBack.width+'\n')
            //zm.objPlanetsCircle.vw=zm.objAspsCircle.width
            //log.lv('zm.objPlanetsCircle.vw:\n'+zm.objPlanetsCircle.vw+'\n')
            //log.x=xApp.width-xLatIzq.width
            //zm.objSignsCircle.visible=!zm.objSignsCircle.visible
            zm.objAspsCircle.visible=!zm.objAspsCircle.visible
            //zm.objHousesCircle.visible=!zm.objHousesCircle.visible
        }
    }
    Component.onCompleted: {
        log.clear()
        log.lv('DevCode ir running!')
    }
}
