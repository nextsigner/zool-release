import QtQuick 2.0

Item{
    id: r
    QtObject{
        id: setZoolLastVersion
        function setData(data, isData){
            if(isData){
                let s=''
                let m0=data.split('Zool v')
                if(m0.length>1){
                    let m1=m0[1].split(' for Windows 64bit')
                    s+=''+m1[0]
                    s=s.replace(/ /g, '')
                }else{
                    console.log('Error en ZoolWinUpdate::setData(data, isData): data --> '+data)
                    return
                }
                let jsonNot={}
                jsonNot.id='winuptate'
                let v1=s
                v1=v1.replace(/ /g, '').replace(/\n/g, '')
                let v2=app.version
                v2=v2.replace(/ /g, '').replace(/\n/g, '')
                if(v1===v2){
                    jsonNot.text='Está utilizando la versión más actualizada de Zool.\n\nVersión actual: '+v2+'\nÚltima versión disponible: '+v1+''
                    zpn.addNot(jsonNot, true, 20000)
                }else{
                    jsonNot.text='Hay una nueva versión de Zool disponible\n\nVersión actual: '+v2+'\nVersión disponible: '+v1+''
                    jsonNot.url='https://github.com/nextsigner/zoolv4/releases/latest'
                    jsonNot.bot1Text='Ver página de Descarga'
                    zpn.addNot(jsonNot, true, 20000)
                }

                /*let c='import QtQuick 2.0\n'
                c+='Item{\n'
                c+='    Component.onCompleted:{\n'
                c+='        log.lv("Descargando actualización...")\n'
                //c+='        var gitDownloaded=u.downloadGit(\'https://github.com/nextsigner/zoolv4.git\', \'C:\\pd1\')\n'
                //https://github.com/nextsigner/zoolv4/archive/refs/heads/main.zip
                c+='       var gitDownloaded=u.downloadZipFile(\'https://downloads.sourceforge.net/project/zool/Zool_v4.11.18.2.zip.zip?use_mirror=sitsa\', \'C:/pd1\')\n'
                c+='        log.lv("Descargado: "+gitDownloaded)\n'
                c+='    }\n'
                c+='}\n'
                jsonNot.qml=c*/

                //log.lv(s)
                //let comp=Qt.createQmlObject(data, app, 'xzoolstart')
            }else{
                //console.log('setXZoolStart Data '+isData+': '+data)
                //JS.showMsgDialog('Error! - Zool Informa', 'Problemas de conexión a internet', 'Por alguna razón, la aplicación no está pudiendo acceder a internet para obtener los datos requeridos. Error: '+data)
            }
        }
    }

    Component.onCompleted: {
        let ms=new Date(Date.now()).getTime()
        app.j.getRD('https://github.com/nextsigner/zoolv4/releases/latest?r='+ms, setZoolLastVersion)
        //u.downloadZipFile('https://github.com/nextsigner/zoolv4/releases/download/zool-release/zoolv4_5.6.11.0.zip', 'C:\aqui')


    }
}
