import QtQuick 2.0
import ZoolText 1.0

Rectangle{
    id: r
    width: r.fs*6
    height: r.fs*1.5
    border.width: 1
    border.color: apps.backgroundColor
    color: apps.fontColor
    radius: r.fs*0.25
    property int fs: app.fs*6
    property bool isBack: false

    property int nd: 0
    property string ns: '0'
    property int ag: -1
    property string arbolGen: '?'

    onWidthChanged: {
        zt1.font.pixelSize = r.width*0.15
        zt2.font.pixelSize = r.width*0.15
        zt3.font.pixelSize = r.width*0.15
    }
    MouseArea{
        enabled: !r.locked
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons;
        onClicked: {
            if (mouse.button === Qt.RightButton && (mouse.modifiers & Qt.ControlModifier)) {
                zoolElementsView.settings.zoom+=0.1
            }else if(mouse.button === Qt.LeftButton  && (mouse.modifiers & Qt.ControlModifier)){
                zoolElementsView.settings.zoom-=0.1
            }else{
                log.lv('Elemento no sabe que hacer: ???')
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            ncv.currentDate=!r.isBack?zm.currentDate:zm.currentDateBack
            ncv.setCurrentDate(!r.isBack?zm.currentDate:zm.currentDateBack)
            ncv.setCurrentNombre(!r.isBack?zm.currentNom:zm.currentNomBack)
            ncv.currentAG=app.arbolGenealogico[r.ag]
            ncv.currentCargaAG=ncv.aCargasAG[r.ag]
            sv.currentIndex=5
        }
    }
    Row{
        anchors.centerIn: parent
        spacing: r.fs*0.5
        ZoolText{id: zt1; text: '<b>'+r.nd+'</b>'; color: apps.backgroundColor; font.pixelSize: r.fs}
        ZoolText{id: zt2; text: '<b>'+r.ns+'</b>'; color: apps.backgroundColor; font.pixelSize: r.fs}
        ZoolText{id: zt3; text: '<b>'+r.arbolGen+'</b>'; color: apps.backgroundColor; font.pixelSize: r.fs}
    }
    function updateNumPit(){
        let d = !r.isBack?app.j.getNums(zm.currentFecha):app.j.getNums(zm.currentFechaBack)
        r.nd=d[0]
        r.ns=d[1]
        r.ag=parseInt(d[2])
        r.arbolGen=app.arbolGenealogico[parseInt(d[2])][0]
    }
}
