import QtQuick 2.12



Item{
    id: r
    width: parent.width
    height: parent.height
    property int nz: -1
    property int e: 1
    MouseArea{
        anchors.fill: parent
        onClicked: {
            r.destroy(0)
        }
    }
    Timer{
        running: r.visible
        repeat: true
        interval: 500
        onTriggered: {
            if(r.e===0){
                r.e=1
            }else{
                r.e=0
            }

            if(r.nz===1){
                r.parent=xLatIzq
                sen1.width=xLatIzq.width
                sen1.height=xLatIzq.height
            }
            if(r.nz===2){
                r.parent=xMed
                sen1.width=xMed.width
                sen1.height=xMed.height
            }
            if(r.nz===3){
                r.parent=xLatDer
                sen1.width=xLatDer.width
                sen1.height=xLatDer.height
            }
            if(r.nz===4){
                r.parent=zoolDataView
                sen1.width=zoolDataView.width
                sen1.height=zoolDataView.height
            }

        }
    }
    Rectangle{
        id: sen1
        color: r.e===0?'red':apps.backgroundColor
        Text{
            text: '<b>Área N° '+r.nz+' Hacer click para detener'
            font.pixelSize: app.fs
            color: r.e===0?'white':apps.fontColor
            anchors.centerIn: parent
            visible: r.nz===4
        }
        Column{
            spacing: app.fs
            anchors.centerIn: parent
            visible: r.nz!==4
            Text{
                id: t1
                text: '<b>Área N° '+r.nz
                font.pixelSize: app.fs
                color: r.e===0?'white':apps.fontColor
            }
            Text{
                text: 'Hacer click\npara detener'
                font.pixelSize: app.fs
                color: t1.color
            }
        }



    }
}
