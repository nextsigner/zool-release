import QtQuick 2.0
import QtMultimedia 5.12
import Qt.labs.settings 1.0
import unik.UnikQProcess 1.0

import ZoolButton 1.0

Rectangle{
    id: r
    width: parent.width
    height: parent.height+app.fs
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    radius: app.fs*0.25
    anchors.bottom: parent.bottom
    property var audioPlayer
    property int currentIndex: 0
    property var lugares: []//["Córdoba Argentina", "United Kingston England"]

    property alias settings: s

    property int cantAudiosMaked: 0
    property bool playing: false

    state: s.stateShowOrHide
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
        fileName: 'zoolVoicePlayer.cfg'
        property bool repAutomatica: true
        property string stateShowOrHide: 'hide'
    }
    Item{id: xUqpsPicoWave}
    Item{id: xAudioPlayers}
    Timer{
        id: tCheck
        running: lv.count>0 && !r.playing
        repeat: false
        interval: 1000
        onTriggered: {
            //mkAudio(lm.get(0).texto)
            mkUqpPico2Wave(lm.get(0).texto, lm.get(0).url)
        }
    }
    Column{
        spacing: app.fs*0.5
        Item{width: 10; height: app.fs*0.5}
        Text{
            id: tit
            text: '<b>Lista de textos</b>'
            font.pixelSize: app.fs*0.5
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
    ListView{
        id: lv
        width: r.width
        height: r.height-tit.contentHeight-app.fs
        model:lm
        delegate: compAudioItem
        spacing: app.fs*0.1
    }
    }
    ListModel{
        id: lm
        function addItem(fn, u, t){
            return {
                fileName: fn,
                url: u,
                texto: t
            }
        }

    }
    Component{
        id: compAudioItem
        Rectangle{
            width: app.fs*6
            height: txt.contentHeight+app.fs*0.5
            border.width: 3
            border.color: 'blue'
            Text{
                id: txt
                text: '<b>Texto: </b>'+texto+' <br /><b>Url: </b>'+url+' <br /><b>Nombre: </b>'+fileName
                width: parent.width-app.fs
                wrapMode: Text.WrapAnywhere
                //textFormat: Text.RichText
                //color: 'red'
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
            }
            Component.onCompleted: {
                //txt.text='adssaf'+texto
            }
        }
    }
    function speak(t){
        if(Qt.platform.os==='windows' || !apps.speakEnabled)return
        let d=new Date(Date.now())
        let ms=d.getTime()
        let fileName='audio_'+ms+'.wav'
        lm.append(lm.addItem(fileName, '/tmp/'+fileName, t))
    }
    function mkUqpPico2Wave(msg, filePath){
        let d=new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import unik.UnikQProcess 1.0\n'
        c+='Item{\n'
        c+='    id: iUqpPico2Wave'+ms+'\n'
        c+='    UnikQProcess{\n'
        c+='        id: uqpPico2Wave'+ms+'\n'
        c+='        onLogDataChanged:{\n'
        //c+='            r.cantAudiosMaked++\n'
        c+='            //if(app.dev)log.lv(\'Audio: '+filePath+'\')\n'
        //c+='            if(r.cantAudiosMaked===19){\n'
        //c+='                updateAudioPlayList("'+folderAudios+'")\n'
        c+='                mkAudio("'+filePath+'")\n'
        //c+='            }\n'
        //c+='            tUqpPico2Wave'+ms+'.start()\n'
        c+='              iUqpPico2Wave'+ms+'.destroy(1)\n'
        c+='        }\n'
        c+='        Component.onCompleted:{\n'
        //c+='            let fp=\''+folderAudios+'/'+index+'.wav\'\n'
        c+='            let fp=\''+filePath+'\'\n'
        c+='            //log.lv("Fp: "+fp)\n'
        c+='            run(\'/home/ns/nsp/zool-release/modules/ZoolMediaLive/textoAWav.sh \"'+msg+'\" \'+fp+\' es-ES\')\n'
        c+='        }'
        c+='    }'
        c+='}'
        //console.log(c)
        let comp=Qt.createQmlObject(c, xUqpsPicoWave, 'uqpcode')
    }

    function mkAudio(filePath){
        let d = new Date(Date.now())
        let ms=d.getTime()
        let c='import QtQuick 2.0\n'
        c+='import QtMultimedia 5.12\n'
        c+='Item{\n'
        c+='    id: a'+ms+'\n'
        c+='    Audio{\n'
        c+='        id: ap'+ms+'\n'
        //c+='        source:"file:///tmp/at_1679148053124/0.wav"\n'
        c+='        source:"file://'+filePath+'"\n'
        c+='        autoPlay: true\n'
        c+='        onPlaybackStateChanged: {\n'
        c+='            if(playbackState===Audio.StoppedState){\n'
        c+='                a'+ms+'.destroy(0)\n'
        c+='                lm.remove(0)\n'
        c+='                r.playing=false\n'
        c+='            }\n'
        c+='            if(playbackState===Audio.PlayingState){\n'
        c+='                r.playing=true\n'
        c+='            }\n'
        c+='        }\n'
        c+='    }\n'
        c+='    Component.onCompleted: {\n'
        c+='        r.audioPlayer=ap'+ms+'\n'
        c+='    }\n'
        c+='}\n'
        c+='\n'
        let obj=Qt.createQmlObject(c, xAudioPlayers, 'audiocode')
    }
    function play(){
        if(audioPlayer)audioPlayer.play()
        //r.mp.play()
    }
    function pause(){
        if(audioPlayer)audioPlayer.pause()
    }
    function stop(){
        if(audioPlayer)audioPlayer.stop()
    }
    function previous(){
        //r.mplis.previous()
    }
    function next(){
        //r.mplis.next()
    }
}
