import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import Qt.labs.settings 1.0
import "../../js/Funcs.js" as JS


import ZoolButton 1.0

Rectangle{
    id: r
    width: parent.width
    height: col.height+app.fs
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    anchors.bottom: parent.bottom
    property alias mp: apau
    property alias mplis: plau
    property int currentIndex: 0
    property var lugares: []//["Córdoba Argentina", "United Kingston England"]
    property var lats: []//[-31.416187, 53.4543314]
    property var longs: []//[-64.175087, -2.113293483429562]
    property var gmts: []//[0, 3]
    property string currentLugar: 'Mundo'
    state: 'hide'
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                x:r.parent.width-r.width
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                x:r.parent.width
            }
        }
    ]

    Behavior on x{NumberAnimation{duration: 250; easing.type: Easing.InOutQuad}}
    Settings{
        id: s
        fileName: 'zoolMediaLive.cfg'
        property bool repAutomatica: false
    }
    Item{
        anchors.fill: parent
        anchors.right: parent.right
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onDoubleClicked: r.state='hide'
        }
    }
    Item{
        width: app.fs
        height: r.height
        anchors.right: parent.left
        visible: r.x===r.parent.width
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: r.state='show'
        }
    }
    Column{
        id: col
        anchors.centerIn: parent
        Rectangle{
            width: r.width-app.fs*0.5
            height: txt.contentHeight+app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                id: txt
                text: '<b>Lugares del Mundo</b>'
                font.pixelSize: app.fs*0.65
                color: 'black'
                anchors.centerIn: parent
            }
        }
        Flow{
            id: rowBtns1
            spacing: app.fs*0.25
            width: r.width-app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                model: r.lugares
                ZoolButton{
                    text:modelData
                    onClicked: {
                        run(index, 0)
                    }
                }
            }
        }
        Item{
            width: r.width
            height: app.fs*3
            Row{
                spacing: app.fs*0.25
                anchors.centerIn: parent
                Row{
                    spacing: app.fs*0.1
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text:'Playing:'
                        font.pixelSize: app.fs*0.35
                        color: apps.fontColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Rectangle{
                        width: app.fs*0.35
                        height: width
                        radius: width*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        color: r.mp.playbackState === Audio.PlayingState?'red':'gray'
                    }
                }
                Row{
                    spacing: app.fs*0.1
                    anchors.verticalCenter: parent.verticalCenter
                    Text{
                        text:'Loading:'
                        font.pixelSize: app.fs*0.35
                        color: apps.fontColor
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Rectangle{
                        width: app.fs*0.35
                        height: width
                        radius: width*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        color: tRepAutomatic.running?'red':'gray'
                    }
                }
                Text{
                    text:'Automático:'
                    font.pixelSize: app.fs*0.35
                    color: apps.fontColor
                    anchors.verticalCenter: parent.verticalCenter
                }
                Switch{
                    text: qsTr("Bluetooth")
                    checked: s.repAutomatica
                    anchors.verticalCenter: parent.verticalCenter
                    onCheckedChanged: s.repAutomatica=checked
                }
            }
        }
        Flow{
            id: rowBtns2
            spacing: app.fs*0.25
            width: r.width-app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !s.repAutomatica
            Repeater{
                model: ['B', 'P', 'S', 'N']
                ZoolButton{
                    text:modelData
                    onClicked: {
                        run(index, 1)
                    }
                }
            }
        }
    }
    Timer{
        id: tRepAutomatic
        repeat: true
        running: r.mp.playbackState !== Audio.PlayingState && s.repAutomatica
        interval: 3000
        onTriggered: {
            loadBodiesNow()
            if(r.currentIndex<lugares.length-1){
                r.currentIndex++
            }else{
                r.currentIndex=0
            }

        }
    }
    //MediaPlayer{
    Audio{
        id: apau
        autoPlay: false
        onPlaybackStateChanged:{
            if(playbackState===Audio.StoppedState){
                if(plau.currentIndex===plau.itemCount-1){
                    //log.ls('plau index 16:'+currentIndex, 0, 500)
                    //loadBodiesNow()
                }
            }
        }
        playlist: Playlist{
            id: plau
            onCurrentIndexChanged: {
                if(plau.currentIndex<0)return
                if(currentIndex<=20){
                    app.currentPlanetIndex=plau.currentIndex-1
                }else{
                    app.currentPlanetIndex=-1
                }
            }
        }
    }
    Component.onCompleted: {
        s.repAutomatica=false
        loadLocations()
    }
    function run(index, row){
        if(row===0){
            //if(index===0)minymaClient.sendData(minymaClient.loginUserName, '', 'isWindowTool=true')
            //if(index===0){
            apau.stop()
            plau.clear()
            plau.currentIndex=-2
            r.currentIndex=index
            loadBodiesNow()
            //}
        }
        if(row===1){
            //['B', 'P', 'S', 'N']
            if(index===0){
                r.mplis.previous()
            }
            if(index===1){
                r.mp.play()
            }
            if(index===2){
                r.mp.stop()
            }
            if(index===3){
                r.mplis.next()
            }
        }
    }
    property int gmtServer: -3
    function loadBodiesNow(){
        sweg.centerZoomAndPos()
        let d0=new Date(Date.now())
        if(gmts[r.currentIndex]!==r.gmtServer){
            if(r.gmts[r.currentIndex]>0){
                if(r.gmtServer<0){
                    d0=d0.setHours(d0.getHours() + Math.abs(r.gmtServer) + r.gmts[r.currentIndex])
                }else{
                    d0=d0.setHours(d0.getHours() + r.gmtServer + r.gmts[r.currentIndex])
                }
            }else{
                if(r.gmtServer<0){
                    d0=d0.setHours(d0.getHours() + Math.abs(r.gmtServer) - r.gmts[r.currentIndex])
                }else{
                    d0=d0.setHours(d0.getHours() + r.gmtServer - r.gmts[r.currentIndex])
                }
            }
        }
        let d=new Date(d0)
        let dia=d.getDate()
        let mes=d.getMonth()+1
        let anio=d.getFullYear()
        let hora=d.getHours()
        let minutos=d.getMinutes()
        let nom="Los Astros Ahora "+dia+"-"+mes+'-'+anio+' '+hora+':'+minutos+'hs'
        let lugar=r.lugares[r.currentIndex]
        //log.ls('d: '+d.toString(), 0, 500)
        JS.loadFromArgs(d.getDate(), parseInt(d.getMonth() +1),d.getFullYear(), d.getHours(), d.getMinutes(), gmts[r.currentIndex], lats[r.currentIndex],longs[r.currentIndex],6, nom, lugar, "pron", false)
        r.currentLugar=lugares[r.currentIndex]
        //        if(r.currentIndex<lugares.length-1){
        //            r.currentIndex++
        //        }else{
        //            r.currentIndex=0
        //        }
    }
    function loadJson(json){
        let jo
        let o
        var ih
        let loadAudio=false
        if(!r.isBack&&JSON.parse(app.currentData).params.tipo==='pron')loadAudio=true
        if(loadAudio)plau.clear()
        let msg=''
        let urlEncoded=''
        let voice='es-ES_LauraVoice'
        msg='Estas son las posiciones de los astros, planetas y cuerpos astrológicos para '+r.currentLugar
        plau.addItem('https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3')
        for(var i=0;i<15;i++){
            //stringIndex='&index='+i
            jo=json.pc['c'+i]
            ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            var s = '<b>'+jo.nom+'</b> en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' <b>Casa:</b> ' +ih
            if(jo.retro===0&&i!==10&&i!==11)s+=' <b>R</b>'
            //console.log('--->'+s)
            if(loadAudio){
                //Set voice
                if(i===1 || i===3  || i===5  || i===7  || i===9){
                    voice='es-ES_LauraVoice'
                }else{
                    voice='es-ES_EnriqueVoice'
                }

                //Set msgs
                if(i===0){
                    msg='El '+app.planetas[i]+' está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+' '+jo.mdeg+' minutos y '+jo.sdeg+' segundos.'
                }else if(i===1){
                    msg='La '+app.planetas[i]+' está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+' '+jo.mdeg+' minutos y '+jo.sdeg+' segundos.'
                }else if(i===10){
                    msg='El nodo norte está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+'.'
                }else if(i===11){
                    msg='El nodo sur está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+'.'
                }else if(i===12){
                    msg='El asteroide quirón está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+'.'
                }else if(i===13){
                    msg='Selena está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+'.'
                }else if(i===14){
                    msg='Lilith está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+'.'
                }else{
                    msg='El planeta '+app.planetas[i]+' está en tránsito por el signo '+app.signos[jo.is]+' en la casa '+ih+' en el grado '+jo.rsgdeg+' '+jo.mdeg+' minutos y '+jo.sdeg+' segundos.'
                }
                urlEncoded='https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'
                //log.ls('urlEncoded:'+urlEncoded, 0, 350)
                plau.addItem(urlEncoded)
            }
        }
        let o1=json.ph['h1']
        //s = 'Ascendente °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        if(loadAudio){
            //stringIndex='&index=15'
            msg='El signo ascendente en el horizonte terrestre es '+app.signos[o1.is]+' en el grado '+o1.rsgdeg
            urlEncoded='https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'
            //log.ls('urlEncoded:'+urlEncoded, 0, 350)
            plau.addItem(urlEncoded)
            //plau.addItem('https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice=es-ES_EnriqueVoice&download=true&accept=audio%2Fmp3'+stringIndex)
        }

        if(loadAudio){
            voice='es-ES_EnriqueVoice'
            msg='Si usted desea agregar la ubicación de su país o región a este sistema comuníquese con el programador de este software. La información de contacto se muestra a la izquierda de esta pantalla.'
            urlEncoded='https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'
            //log.ls('urlEncoded:'+urlEncoded, 0, 350)
            plau.addItem(urlEncoded)
            //plau.addItem('https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'+stringIndex)
            voice='es-ES_LauraVoice'
            msg='Si desea apoyar este canal para que continúe creciendo, puede hacer una donación.'
            urlEncoded='https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'
            //log.ls('urlEncoded:'+urlEncoded, 0, 350)
            plau.addItem(urlEncoded)
            //plau.addItem('https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'+stringIndex)
            if(Qt.application.arguments.indexOf('-youtube')>=0){
                msg='En la descripción de este video está el enlace para realizar su colaboración.'
            }else{
                msg='Escriba en el chat el comando donación, exclamación donacion y allí obtendrá un enlace para realizar su colaboración.'
            }
            urlEncoded='https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3'
            //log.ls('urlEncoded:'+urlEncoded, 0, 350)
            plau.addItem(urlEncoded)
            plau.currentIndex=-2
            apau.play()
        }
    }
    function loadLocations(){
        let lugares=[]
        let lats=[]
        let longs=[]
        let gmts=[]
        let fl='./modules/ZoolMediaLive/locations.json'
        if(!unik.fileExist(fl)){
            log.ls('Error ZoolMediaLive: No se ha podido localizar el archivo '+fl+'', 0, 500)
            return
        }
        let fd=(''+unik.getFile(fl)).replace(/\n/g, '')
        let json=JSON.parse(fd)

        for(var i=0;i<Object.keys(json['locations']).length;i++){
            lugares.push(json['locations'][i].n)
            lats.push(json['locations'][i].lat)
            longs.push(json['locations'][i].lon)
            gmts.push(json['locations'][i].gmt)
        }
        r.lugares=lugares
        r.lats=lats
        r.longs=longs
        r.gmts=gmts
    }

    function play(){
        r.mp.play()
    }
    function pause(){
        r.mp.pause()
    }
    function stop(){
        r.mp.stop()
    }
    function previous(){
        r.mplis.previous()
    }
    function next(){
        r.mplis.next()
    }
}
