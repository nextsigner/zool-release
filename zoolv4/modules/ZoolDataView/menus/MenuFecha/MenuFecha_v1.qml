import QtQuick 2.12
import QtQuick.Controls 2.12
import ZoolMenus 1.0

ZoolMenus{
    id: r
    title: 'Menu General'
    w: app.fs*40
    scaleExpandWidh: 0.65
    property int parentX: 0
    Action {
        text: qsTr("Modificar Fecha")
        onTriggered: {
            let comp=Qt.createComponent('../../XModFechav1.qml')
            let obj=comp.createObject(app, {x: r.parentX, y: zoolDataView.height})
        }
    }

}
