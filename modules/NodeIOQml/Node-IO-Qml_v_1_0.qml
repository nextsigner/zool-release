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
        onLogDataChanged:{
            try{
              let json=JSON.parse(logData)
              r.dataReceibed(JSON.stringify(json))
            }catch(e){
                let error='LogData del error: ['+logData+']\n'
                error+='Descripción del error: ['+e+']\n\n'
                r.dataError(error);
                //console.error(e);
            }
        }
        function init(){
            let cmd='node '
            cmd+=' '+r.indexPath
            cmd+=' '+r.user
            cmd+=' node-io-ss'//+r.to
            cmd+=' conectado'
            cmd+=' host='+r.host
            cmd+=' port='+r.port
            console.log('Node-IO-Qml uqp cmd: '+cmd)
            run(cmd)
        }
        Component.onCompleted: {
            //init()
        }
    }
    function send(to, data){
        unik.sendToTcpServer(r.host, r.port, r.user, to, data)
    }
}
