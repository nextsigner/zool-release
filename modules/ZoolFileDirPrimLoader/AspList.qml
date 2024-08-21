import QtQuick 2.0
import ZoolButton 1.1

Rectangle{
    id: r
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    clip: true
    property var moduleDirPrim
    Column{
        anchors.centerIn: parent
        ListView{
            id: lv
            width: r.width
            height: r.height-app.fs*1.5
            model: lm
            delegate: compItem
        }
        Rectangle{
            width: r.width
            height: app.fs*1.5
            color: apps.backgroundColor
            ZoolButton{
                text: 'Crear Html'
                onClicked:{
                    mkHtml()
                }
            }
        }
    }
    ListModel{
        id: lm
        function addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms, s){
            return {
                vAspType: aspType,
                vObjAspectedIndex1: objAspectedIndex1,
                vObjAspectedIndex2: objAspectedIndex2,
                vMs: ms,
                vStringData: s
            }
        }
    }
    Component{
        id: compItem
        Rectangle{
            id: xItem
            width: r.width
            height: txt1.contentHeight+app.fs
            color: selected?apps.fontColor:apps.backgroundColor
            border.width: 2
            border.color: txt1.color
            property bool selected: index===lv.currentIndex
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    let d = new Date(vMs)
                    moduleDirPrim.setFechaEvento(d)
                }
            }
            Text{
                id: txt1
                width: parent.width-app.fs*2
                wrapMode: Text.WordWrap
                font.pixelSize: app.fs*0.5
                color: !selected?apps.fontColor:apps.backgroundColor
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: app.fs*0.5
                //anchors.centerIn: parent
            }
            Rectangle{
                id: cc
                width: app.fs
                height: width
                radius: width*0.5
                anchors.verticalCenter: parent.verticalCenter
                x:app.fs*0.25
            }
            Component.onCompleted: {
                let at='Indefinido'
                let ac='pink'
                if(vAspType===0){
                    at='Conjunción'
                    ac='blue'
                }else if(vAspType===1){
                    at='Oposición'
                    ac='red'
                }else if(vAspType===2){
                    at='Cuadratura'
                    ac='orange'
                }else{
                    at='No Indefinido'
                }
                cc.color=ac
                let d=new Date(vMs)

                let dia=d.getDate()
                let mes=d.getMonth() + 1
                let anio=d.getFullYear()
                let hora=d.getHours()
                let minutos=d.getMinutes()

                let s='<b>Edad:</b> '+zm.getAgeFromTwoDates(zm.currentDate, vMs)+' años.<br>'
                s+='<b>Fecha:</b> '+dia+'/'+mes+'/'+anio+'<br>'
                s+=''+at+'<br>'
                s+=' '+zm.aBodies[vObjAspectedIndex1]
                s+='/'+zm.aBodies[vObjAspectedIndex2]+'<br>'
                txt1.text=s
            }
            function getText(){
                return txt1.text
            }
        }
    }
    function clear(){
        lm.clear()
    }
    function addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms){
        let sd=''+aspType+'_'+objAspectedIndex1+'_'+objAspectedIndex2+'_'+ms.getTime()
        let existe=false
        //        for(var i=0; i<lm.count-1;i++){
        //            let sdItem=lm.get(i).vStringData
        //            //log.lv('P: '+zm.aBodies[objAspectedIndex1]+'/'+zm.aBodies[objAspectedIndex2])
        //            //log.lv('sd: ['+sd+']\nsdItem: ['+sdItem+']\n\n')
        //            if(sd===sdItem){
        //                lm.remove(i)
        //                //existe=true
        //                //break
        //            }
        //        }
        //if(!existe)
        lm.append(lm.addItem(aspType, objAspectedIndex1, objAspectedIndex2, ms, sd))

    }
    function mkHtml(){
        let dateAhora=new Date(Date.now())
        let p=zfdm.getJsonAbs().params
        let fileNamePath=unik.getPath(3)+'/Direcciones_Primarias_Fechas_Importantes_de_'+(p.n.replace(/ /g, '_'))+'.html'
        let title='Fechas claves en la vida de '+p.n
        let html='<!DOCTYPE html>
<html lang="es-ES">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>'+title+'</title>
<style>
        body {
            background-color: black;
            color: white;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
    </style>
</head>
<body>
<h1>'+title+'</h1><br>
<h2>Método de Prognosis: Direcciones Primarias</h2>
<p><b>Nota: </b>Este método, se calcula girando la carta natal astral en sentido anti horaria, aproximadamente °1 (un grado) por año. Las siguientes son las conjunciones, cuadraturas, trígonos y oposiciones detectadas en los planetas de la carta natal utilizando este método.</p>
*****
<br><br><p>Archivo creado el día '+dateAhora.toString()+' por Ricardo Martín Pizarro con su aplicación Zool</p>
<p>Para más información comunicarse al Whatsapp +54 1138024370 o qtpizarro@gmail.com</p>
</body>
</html>'
        let s=''

        for(var i=0;i<lm.count-1;i++){
            if(lv.itemAtIndex(i))s+=lv.itemAtIndex(i).getText()+'<br><br>'
        }
        html=html.replace('*****', s)
        unik.setFile(fileNamePath, html)
       //log.lv('html: '+html)
        Qt.openUrlExternally(fileNamePath)
    }
}
