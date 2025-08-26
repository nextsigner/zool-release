import QtQuick 2.7
import QtQuick.Controls 2.0
import u.Unik 1.0
import unik.UnikQProcess 1.0
ApplicationWindow{
    id: app
    visible: true
    visibility: "Maximized"
    color: 'black'
    property int fs: width*0.03
    property url uUrl
    Unik{id: unik}
    UnikQProcess{
        id: uqp

        onLogDataChanged:{
            //log.text+=logData
            let std=logData
            if(std.indexOf('Proceso Pic2Wave finalizado.')>=0){
                Qt.openUrlExternally(uUrl)
            }
        }
    }
    Item{
        id: xApp
        anchors.fill: parent
        Row{
            Rectangle{
                width: xApp.width*0.5
                height: xApp.height
                color: 'transparent'
                border.width: 1
                border.color: 'white'

                Column{
                    spacing: app.fs*0.25
                    anchors.centerIn: parent
                    Text{
                        text:'Nombre de Nativo'
                        font.pixelSize: app.fs
                        color: 'white'
                    }
                    Rectangle{
                        width: children[0].width+app.fs*0.5
                        height: children[0].height+app.fs*0.5
                        color: 'transparent'
                        border.width: 1
                        border.color: 'white'
                        clip: true
                        TextInput{
                            id: ti1
                            font.pixelSize: app.fs
                            width: parent.parent.width-app.fs
                            height: app.fs*1.2
                            color: 'white'
                            anchors.centerIn: parent
                        }
                    }
                    Text{
                        text:'Signo¨'
                        font.pixelSize: app.fs
                        color: 'white'
                    }
                    ComboBox{
                        id: cb1
                        model: ['aries', 'tauro', 'geminis', 'cancer', 'leo', 'virgo', 'libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']
                        font.pixelSize: app.fs*0.5
                    }
                    Text{
                        text:'Género¨'
                        font.pixelSize: app.fs
                        color: 'white'
                    }
                    ComboBox{
                        id: cb2
                        model: ['Seleccionar', 'Femenino', 'Masculino']
                        font.pixelSize: app.fs*0.5
                    }
                    Item{width: 1;height: app.fs}
                    Button{
                        text: 'Crear Audio'
                        font.pixelSize: app.fs*0.5
                        onClicked: {
                            crearAudio()
                        }
                    }
                }

            }
            Rectangle{
                width: xApp.width*0.5
                height: xApp.height
                color: 'transparent'
                border.width: 1
                border.color: 'white'
                clip: true
                Flickable{
                    anchors.fill: parent
                    contentWidth: log.width
                    contentHeight: log.height+app.fs
                    Text{
                        id: log
                        width: parent.parent.width-app.fs
                        color: 'white'
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    function crearAudio(){
        let n1
        let n2
        let n3
        let mnom=ti1.text.split(',')
        n1=mnom[0]
        if(mnom.length>1){
            n2=mnom[1]
        }else{
            n2=mnom[0]
            n3=mnom[0]
        }
        if(mnom.length>2){
            n3=mnom[2]
        }else{
            if(mnom.length===2){
                n3=mnom[2]
            }else{
                //n2=mnom[0]
                n3=mnom[0]
            }
        }
        let sGen='fem'
        if(cb2.currentIndex===0){
            log.text='Error. Género no seleccionado.'
            return
        }

        if(cb2.currentIndex===1){
            sGen='fem'
        }
        if(cb2.currentIndex===2){
            sGen='masc'
        }
        let fd=u.getFile('./luna_'+cb1.currentText+'_nativo_'+sGen+'.txt').replace(/\[Nativo1\]/g, n1)
        fd=fd.replace(/\[Nativo2\]/g, n2)
        fd=fd.replace(/\[Nativo3\]/g, n3)
        //console.log('fd: '+fd)
        fd+='\n\nEsto es todo. Fin del audio.'
        fd+='\nEste audio fué creado por el Astrólogo Ricardo Martín Pizarro'
        fd+='\nexclusivamente para '+n1

        log.text=fd
        let d=new Date(Date.now())
        let ms=d.getTime()
        let fp='/tmp/file_luna_'+ms+'.txt'
        u.setFile(fp, fd)
        let wavFileName='/home/ns/luna_'+cb1.currentText+'_'+n1+'.wav'
        let cmd='sh archivoToVoicePic2Wave.sh '+fp+' '+wavFileName
        app.uUrl='file://'+wavFileName
        console.log('cmd: '+cmd)
        uqp.run(cmd)
    }
}
