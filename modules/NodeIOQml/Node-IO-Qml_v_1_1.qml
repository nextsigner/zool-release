import QtQuick 2.0
import unik.UnikQProcess 1.0

/*
Ejemplo de uso: unik.sendToTcpServer(r.host, r.port, r.user, r.to, text)
*/

Item{
    id: r
    property string user: 'node-io-qml'
    property string to: 'all'
    property string indexPath: '/home/ns/nsp/node-io-sc/index.js'
    property string host: 'localhost'
    property int port: 3111
    signal dataReceibed(string data)
    signal dataError(string e)
    onHostChanged: uqp.init()
    onPortChanged: uqp.init()
    UnikQProcess{
        id: uqp
        property var aLogData: []
        onLogDataChanged:{
            //console.log('onLogDataChanged:'+logData)
            //log.lv('NodeIOQml v1.1 onLogDataChanged:['+logData+']')
            //let m00=(''+logData).split('\n')
//            for(var i=0;i<m00.length;i++){
//                log.lv('onLogDataChanged ['+i+']:['+m00[i]+']\n\n')
//            }
            //let m0=(''+logData).split('{"from":"')
            //let sjson=m0['{"from":"'+m0.length-1]
            //log.lv('onLogDataChanged:['+logData+']')
            //log.lv('onLogDataChanged sjson:['+sjson+']')
            //aLogData.push(sjson)
            try{
              let json=JSON.parse(logData)
              r.dataReceibed(JSON.stringify(json))
            }catch(e){
                let error='LogData del error: ['+sjson+']\n'
                error+='Descripción del error: ['+e+']\n\n'
                r.dataError(error);
                //console.error(e);
            }
            //setLogData('')
        }
        function init(){
            let cmd='node '
            cmd+=' '+r.indexPath
            cmd+=' '+r.user
            cmd+=' node-io-ss'//+r.to
            //cmd+=' '+r.user
            cmd+=' conectado'
            cmd+=' host='+r.host
            cmd+=' port='+r.port
            console.log('Node-IO-Qml uqp cmd: '+cmd)
            //log.lv('Node-IO-Qml logData: '+logData)
            run(cmd)
        }
        Component.onCompleted: {
            let localhost=false
            if(args.indexOf('-localhost')>=0)localhost=true
            if(unik.fileExist('./tcpclient.conf')){
                let data=unik.getFile('./tcpclient.conf')
                //console.log(data)
                //if()console.log(data)
                let lines=data.split('\n')
                r.user=lines[0].replace('user=', '')
                if(localhost){
                    r.host='127.0.0.1'
                }else{
                    r.host=lines[1].replace('ip=', '')
                }
                r.port=lines[2].replace('port=', '')
                r.init()
                return
            }
            for(i=0;i<args.length;i++){
                let a=args[i]
                if(a.indexOf('-host=')>=0){
                    let mt=a.split('-host=')
                    r.host=mt[1]
                }
                if(a.indexOf('-port=')>=0){
                    let mt=a.split('-port=')
                    r.port=mt[1]
                }
                if(a.indexOf('-ip=')>=0){
                    let mt=a.split('-ip=')
                    r.host=''+mt[1]
                }
            }
            r.init()
        }
    }
    function send(to, data){
        unik.sendToTcpServer(r.host, r.port, r.user, to, data)
    }
}
