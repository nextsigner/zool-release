import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2
import "../../js/Funcs.js" as JS
import "../../comps"
import unik.UnikQProcess 1.0


Rectangle {
    id: r
    color: '#333'
    x: apps.repLectX
    y: apps.repLectY
    width: apps.repLectW
    height: apps.repLectH
    border.width: 1
    border.color: apps.fontColor
    clip: r.playMaximized
    onXChanged: apps.repLectX=x
    onYChanged: apps.repLectY=y
    visible: zsm.currentIndex===0&&apps.repLectVisible
    property alias pl: playList
    property alias vo: videoPlayerOutPut
    property alias vp: videoPlayer
    property var uJson: {}
    property string currentUrl: ''
    property bool playMaximized: !(''+playList.currentItemSource===''+apps.repLectCurrentVidIntro || ''+playList.currentItemSource===''+apps.repLectCurrentVidClose)

    UnikQProcess{
        id: uqp
        onLogDataChanged: {
            //log.ls('LogData: '+logData, 300, 500)
        }
        onFinished: botRec.isRec=false
        onStarted: botRec.isRec=true
    }
    Rectangle {
        id: bg
        color: 'black'
        //color: 'red'
        x:r.playMaximized?0:0-r.x
        y:r.playMaximized?0:0-r.y
        width: r.playMaximized?parent.width:xApp.width
        height:r.playMaximized?parent.width:xApp.height
        visible: videoPlayer.playbackState===MediaPlayer.PlayingState
    }

    MediaPlayer{
        id: videoPlayer
        autoPlay: true
        onPositionChanged:{
            if(position>duration-3000&&duration>=1000){
                trans.opacity=1.0
                //                videoPlayer.stop()
                //                tPlayTrans.start()
            }
        }
        playlist: Playlist{
            id: playList
            onCurrentIndexChanged: {
                let ip=r.uJson.items['item'+currentIndex].indexPlanet
                app.currentPlanetIndex=ip
                let im=r.uJson.items['item'+currentIndex].isMirror
                videoPlayerOutPut.isMirror=im
                let isMax=r.uJson.items['item'+currentIndex].isMaximized
                r.playMaximized=isMax

                //log.ls('IP: '+ip, 300, 500)
                //app.currentPlanetIndex=currentIndex-1
                //videoPlayer.stop()
                //tPlayTrans.start()
            }
        }
        onPlaybackStateChanged: {
            if(videoPlayer.playbackState===MediaPlayer.PlayingState){
                trans.opacity=0.0
                tAutoMaticPlanets.stop()
                if(playList.currentIndex===-1||playList.currentIndex===0){
                    if(r.uJson['itemData']){
                        let file=r.uJson['itemData'].file
                        zm.loadJsonFromFilePath(file)
                    }
                }
            }
            if(videoPlayer.playbackState===MediaPlayer.StoppedState){
                //app.currentPlanetIndex++
            }
        }
    }

    Grid{
        spacing: app.fs*0.25
        columns: 30
        anchors.centerIn: parent
        visible: false
        Repeater{
            model:480
            Rectangle{
                width: 2
                height: 2
            }
        }
    }
    Column{
        spacing: app.fs*0.1
        anchors.centerIn: parent
        Text{
            text: '<b>Zool</b>'
            font.pixelSize: app.fs
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            text: 'Video Player'
            font.pixelSize: app.fs*0.35
            color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


    VideoOutput{
        id: videoPlayerOutPut
        source: videoPlayer
        width: r.playMaximized?parent.width:xApp.width
        height: r.playMaximized?parent.height:xApp.height
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.leftMargin: videoPlayerOutPut.isMirror?width:0
        transform: Scale{ xScale: videoPlayerOutPut.isMirror?-1:1}
        anchors.bottom: parent.bottom
        property bool isMirror: false
    }
    Rectangle{
        id: trans
        x:r.playMaximized?0:0-r.x
        y:r.playMaximized?0:0-r.y
        width: r.playMaximized?parent.width:xApp.width
        height:r.playMaximized?parent.width:xApp.height
        color: apps.backgroundColor
        opacity: 0.0
        onOpacityChanged:{
            if(opacity===1.0 && (playList.currentIndex!==playList.itemCount-1)){
                tPlayTrans.start()
            }
        }
        Behavior on opacity{NumberAnimation{duration:1000}}
        Text{
            text: 'Video '+parseInt(playList.currentIndex + 1)+'/'+playList.itemCount
            font.pixelSize: app.fs
            color: apps.fontColor
            anchors.centerIn: parent
        }
    }
    Timer{
        id: tPlayTrans
        running: false
        repeat: false
        interval: 2000
        onTriggered: videoPlayer.play()
    }
    MouseArea{
        drag.target: r
        drag.axis: Drag.XAndYAxis
        anchors.fill: r
        hoverEnabled: true
        onEntered: col.opacity=1.0
        onPositionChanged: {
            if(apps.xToolEnableHide){
                tHideCol.restart()
            }
        }
        onClicked: {
            col.opacity=col.opacity===0.0?1.0:0.0
        }
        onWheel: {
            //apps.enableFullAnimation=false
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    if(apps.repLectW<xApp.width*0.2){
                        apps.repLectW+=1
                    }
                }else{
                    if(apps.repLectW>app.fs*6){
                        apps.repLectW-=1
                    }
                }
            }else{
                if(wheel.angleDelta.y>=0){
                    if(apps.repLectH<xApp.width*0.3){
                        apps.repLectH+=1
                    }
                }else{
                    if(apps.repLectH>app.fs*2){
                        apps.repLectH-=1
                    }
                }
            }
            //reSizeAppsFs.restart()
        }
    }

    Column{
        spacing: app.fs*0.25
        anchors.top: parent.top
        anchors.topMargin: apps.botSize*0.3
        anchors.horizontalCenter: parent.horizontalCenter
        Column{
            id: col
            anchors.horizontalCenter: parent.horizontalCenter
            Text{
                //Muestra CARPETA DE JSON LIST
                //Ocultado
                visible: false

                id: labelCF
                text: apps.repLectCurrentFolder
                font.pixelSize: app.fs*0.5
                color: apps.fontColor
                width: r.width-app.fs
                wrapMode: Text.WrapAnywhere
                anchors.horizontalCenter: parent.horizontalCenter                
            }
            Row{
                spacing: app.fs*0.25
                anchors.horizontalCenter: parent.horizontalCenter
                ButtonIcon{
                    text: '\uf049'
                    width: apps.botSize*0.6
                    height: width
                    onClicked: {
                        videoPlayer.stop()
                        playList.currentIndex=0
                    }
                }
                ButtonIcon{
                    text: '\uf04a'
                    width: apps.botSize*0.6
                    height: width
                    enabled: playList.currentIndex!==0
                    onClicked: {
                        videoPlayer.stop()
                        if(playList.currentIndex>0){
                            playList.currentIndex--
                        }
                        videoPlayer.play()
                    }
                }
                ButtonIcon{
                    id: botRec
                    text: ''
                    width: apps.botSize*0.8
                    height: width
                    property bool isRec: false
                    onClicked: {
                        if(!uqp.upIsOpen()){
                            uqp.run('ffmpeg -y -f x11grab -framerate 25 -video_size '+1280+'x'+920+' -i +0,0 /home/ns/prueba.mkv')
                        }else{
                            uqp.kill()
                        }
                    }
                    Rectangle{
                        width: parent.width*0.65
                        height: width
                        //color: parent.isRec?'red':'black'
                        color: 'red'
                        radius: width*0.5
                        anchors.centerIn: parent
                    }
                }
                ButtonIcon{
                    text: videoPlayer.playbackState!==MediaPlayer.PlayingState?'\uf04b':'\uf04c'
                    width: apps.botSize*0.6
                    height: width
                    onClicked: {
                        if(videoPlayer.playbackState!==MediaPlayer.PlayingState){
                            videoPlayer.play()
                        }else{
                            videoPlayer.pause()
                        }
                    }
                }
                ButtonIcon{
                    text: '\uf04d'
                    width: apps.botSize*0.6
                    height: width
                    onClicked: {
                        videoPlayer.stop()
                    }
                }
                ButtonIcon{
                    text: '\uf04e'
                    width: apps.botSize*0.6
                    height: width
                    enabled: playList.currentIndex<playList.itemCount-1
                    onClicked: {

                        if(playList.currentIndex<playList.itemCount-1){
                            videoPlayer.stop()
                            playList.currentIndex++
                            videoPlayer.play()
                        }


                    }
                }
                ButtonIcon{
                    text: '\uf114'
                    width: apps.botSize*0.6
                    height: width
                    onClicked: {
                        fileDialog.visible=true
                    }
                }
                ButtonIcon{
                    text: '\uf0ca'
                    width: apps.botSize*0.6
                    height: width
                    onClicked: {
                        videoListEditor.visible=!videoListEditor.visible
                        if(videoListEditor.visible){
                            videoListEditor.updateList()
                        }
                    }
                }
            }
        }
    }
    Timer{
        id: tHideCol
        running: apps.xToolEnableHide
        repeat: true
        interval: 5000
        onTriggered: col.opacity=0.0

    }
    Component.onCompleted: {
        updateVideoList()
    }
    function updateVideoList(){
        playList.clear()
        playList.currentIndex=-1
        let json={}
        let obj={}
        let jsonFile=(''+apps.repLectCurrentFolder).replace('file://', '')+'/list.json'
        if(!unik.fileExist(jsonFile)){
            let fl=unik.getFileList((''+apps.repLectCurrentFolder).replace('file://', ''))
            //Formato esperado. Ejemplo: file:///home/ns/Documentos/gd/zool_videos/intro_vn.mkv
            if(apps.repLectCurrentVidIntro!==''){
                playList.addItem(apps.repLectCurrentVidIntro)
                obj={}
                obj.fileName=apps.repLectCurrentVidIntro
                obj.indexPlanet=-1
                obj.isMirror=false
                obj.isMaximized=true
                json['item0']=obj
            }

            for(var i=0;i<fl.length;i++){
                let s=apps.repLectCurrentFolder+'/'+fl[i]
                //log.ls('Pl add: '+s, 0, 500)
                playList.addItem(s)
                obj={}
                obj.fileName=s
                obj.indexPlanet=i+1
                obj.isMirror=false
                obj.isMaximized=false
                json['item'+parseInt(i + 1)]=obj
            }
            if(apps.repLectCurrentVidClose!==''){
                playList.addItem(apps.repLectCurrentVidClose)
                obj={}
                obj.fileName=apps.repLectCurrentVidClose
                obj.indexPlanet=-1
                obj.isMirror=false
                obj.isMaximized=true
                json.items={}
                json.items['item'+parseInt(fl.length)]=obj
            }
            obj={}
            obj.file=''
            json['itemData']=obj
            r.uJson=json

        }else{

            let jsonData=unik.getFile(jsonFile)
            json=JSON.parse(jsonData)
            r.uJson=json
            for(var i=0;i<Object.keys(json.items).length;i++){
                if(json.items['item'+i]){
                    let s=json.items['item'+i].fileName
                    if(s.indexOf('file://')!==0){
                        s='file://'+s
                    }
                    playList.addItem(s)
                }
            }
            //Qt.quit()
            //log.ls('0 Set file: '+r.currentUrl, 0, 500)
            if(json['itemData']){
                r.currentUrl=json['itemData'].file
                //log.ls('Set file: '+r.currentUrl, 0, 500)
            }
        }
    }
}
