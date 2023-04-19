import QtQuick 2.0

Item{
    id:r
    property bool isServerOnLine: false
    onIsServerOnLineChanged: {
        if(isServerOnLine){
            timerFistRun.stop()
            zpn.addNot('El servidor Zool ha sido encendido.', true, 10000)
        }else{
            zpn.addNot('El servidor Zool ha sido apagado.', true, 10000)
        }
    }
    QtObject{
        id: setIsServerOnLine
        function setData(data, isData){
            if(isData){
                isServerOnLine=true
            }else{
                isServerOnLine=false
            }
        }
    }
    property var timerFistRun
    property var timerCheckStatus
    Component.onCompleted: {
        if(apps.enableShareInServer){
            init()
        }
    }
    function init(){
        //Chequear el estado del servidor Zool
        var tfr = new timer();
        tfr.running=true
        tfr.interval = 5000;
        tfr.repeat = false;
        tfr.triggered.connect(function () {
            zpn.addNot('El servidor de Zool no se encuentra encendido.', true, 6000)
        })
        tfr.start();
        timerFistRun=tfr

        var t = new timer();
        t.running=!r.isServerOnLine
        t.interval = 5000;
        t.repeat = true;
        t.triggered.connect(function () {
            app.j.getRD(apps.host, setIsServerOnLine)
        })
        t.start();
        timerCheckStatus=t
    }
    function stop(){
        timerFistRun.stop()
        timerCheckStatus.stop()
    }
    function timer() {
        return Qt.createQmlObject("import QtQuick 2.0; Timer {}", r);
    }

}
