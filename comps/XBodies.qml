import QtQuick 2.12
import QtQuick.Controls 2.0
import "../Funcs.js" as JS

Column{
    id: r
    width: !app.ev?parent.width:parent.width*0.5
    opacity: 0.0
    property bool isBack: false
    property bool isLatFocus: false
    property int currentIndex: !isBack?panelDataBodies.currentIndex:panelDataBodies.currentIndexBack
    Behavior on opacity{NumberAnimation{id:numAn1;duration:10}}
    Rectangle{
        id: headerLv
        width: r.width
        height: app.fs*0.85
        color: r.isBack?apps.houseColorBack:apps.houseColor//apps.fontColor
        border.width: 1
        border.color: apps.fontColor
        Item{
            width: r.width
            height: txtTit.contentHeight
            anchors.centerIn: parent
            Text {
                id: txtTit
                text: 'Lista de Cuerpos'
                font.pixelSize: app.fs*0.4
                width: parent.width-app.fs*0.2
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: r.isBack?apps.xAsColorBack:apps.xAsColor
                anchors.centerIn: parent
            }
        }
    }
    ListView{
        id: lv
        spacing: app.fs*0.1
        width: r.width-app.fs*0.25//r.parent.width-r.border.width*2
        height: xLatDer.height-headerLv.height
        delegate: compItemList
        model: lm
        cacheBuffer: 60
        displayMarginBeginning: lv.height*2
        displayMarginEnd: lv.height*2
        clip: true
        ScrollBar.vertical: ScrollBar {}
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListModel{
        id: lm
        function addItem(indexSign, indexHouse, grado, minuto, segundo, stringData){
            return {
                is: indexSign,
                ih: indexHouse,
                gdeg:grado,
                mdeg: minuto,
                sdeg: segundo,
                sd: stringData
            }
        }
    }
    Component{
        id: compItemList
        Rectangle{
            id: xItem
            width: lv.width
            height: !app.ev?
                        //Mostrando 1 columna de datos.
                        (index===panelDataBodies.currentIndex?(colTxtSelected.height+app.fs*0.1):
                                                               (txtData.contentHeight+app.fs*0.1)):

                        //Mostrando 2 columas de Datos
                        (colTxtEV.height+app.fs*0.1)

            color: !r.isBack?(index===panelDataBodies.currentIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.fontColor:apps.backgroundColor):(index===panelDataBodies.currentIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.fontColor:apps.backgroundColor)
            border.width: 1
            border.color: !r.isBack?apps.houseColor:apps.houseColorBack
            visible: !app.ev?txtData.width<xItem.width:true
            //anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity{NumberAnimation{duration: 250}}
            property bool textSized: false
            onTextSizedChanged: {}
            Rectangle{
                anchors.fill: parent
                color: !r.isBack?apps.houseColor:apps.houseColorBack
                opacity: 0.5
            }
            Text {
                id: txtData
                //text: sd
                font.pixelSize: app.fs
                textFormat: Text.RichText
                color: !r.isBack?(index===panelDataBodies.currentIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===panelDataBodies.currentIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                visible: !app.ev && index!==panelDataBodies.currentIndex
                onVisibleChanged: {
                    if(!visible){
                        //font.pixelSize=app.fs
                    }
                }
                Timer{
                    running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                    repeat: true
                    interval: 50
                    onTriggered: {
                        tShow.restart()
                        parent.font.pixelSize-=1
                    }
                }
            }
            Column{
                id: colTxtSelected
                anchors.centerIn: parent
                visible: !app.ev && index===panelDataBodies.currentIndex
                Text {
                    id: txtDataSelected1
                    font.pixelSize: app.fs
                    textFormat: Text.RichText
                    color: !r.isBack?(index===panelDataBodies.currentIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===panelDataBodies.currentIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: !app.ev
                    Timer{
                        running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
                Text {
                    id: txtDataSelected2
                    font.pixelSize: app.fs
                    textFormat: Text.RichText
                    color: !r.isBack?(index===panelDataBodies.currentIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===panelDataBodies.currentIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: !app.ev
                    Timer{
                        running: parent.width>xItem.width-app.fs*0.1 && !app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
            }
            Column{
                id: colTxtEV
                anchors.centerIn: parent
                Text {
                    id: txtDataEV
                    font.pixelSize: app.fs//*0.4
                    textFormat: Text.RichText
                    color: !r.isBack?(index===panelDataBodies.currentIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===panelDataBodies.currentIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: app.ev
                    opacity: r.isLatFocus?1.0:0.65
                    Timer{
                        running: parent.contentWidth>xItem.width-app.fs*0.1 && app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
                Text {
                    id: txtDataEV2
                    font.pixelSize: app.fs//*0.4
                    textFormat: Text.RichText
                    color: !r.isBack?(index===panelDataBodies.currentIndex||(index>16&&sweg.objHousesCircle.currentHouse===index-16)?apps.backgroundColor:apps.fontColor):(index===panelDataBodies.currentIndexBack||(index>16&&sweg.objHousesCircleBack.currentHouse===index-16)?apps.backgroundColor:apps.fontColor)
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.centerIn: parent
                    visible: app.ev
                    opacity: r.isLatFocus?1.0:0.65
                    anchors.horizontalCenter: parent.horizontalCenter
                    Timer{
                        running: parent.contentWidth>xItem.width-app.fs*0.1 && app.ev
                        repeat: true
                        interval: 50
                        onTriggered: {
                            tShow.restart()
                            parent.font.pixelSize-=1
                        }
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (mouse.modifiers & Qt.ControlModifier) {
                        if(index<=16){
                            JS.showIW()
                        }
                    }else{
                        if(index>16){
                            if(!r.isBack){
                                sweg.objHousesCircle.currentHouse=index-16
                            }else{
                                sweg.objHousesCircleBack.currentHouse=index-16
                            }
                        }else{
                            if(!r.isBack){
                                if(app.currentPlanetIndex!==index){
                                    app.currentPlanetIndex=index
                                    panelDataBodies.currentIndex=index
                                }else{
                                    app.currentPlanetIndex=-1
                                    panelDataBodies.currentIndex=-1
                                    sweg.objHousesCircle.currentHouse=-1
                                }
                            }else{
                                if(app.currentPlanetIndexBack!==index){
                                    app.currentPlanetIndexBack=index
                                    panelDataBodies.currentIndexBack=index
                                }else{
                                    app.currentPlanetIndexBack=-1
                                    panelDataBodies.currentIndexBack=-1
                                    sweg.objHousesCircleBack.currentHouse=-1
                                }
                            }
                        }
                        apps.zFocus='xLatDer'
                    }
                }
            }
            Component.onCompleted: {
                txtData.text=sd.replace(/ @ /g, ' ')
                let m0=sd.split(' @ ')
                txtDataEV.text=m0[0]//sd.replace(/ @ /g, '<br />')
                if(m0[1]){
                    txtDataEV2.text=m0[1]
                    txtDataSelected1.text=m0[0]
                    txtDataSelected2.text=m0[1]
                }else{
                    //log.ls('sd: '+sd, 0, 500)
                }

                //cantTextSized++
                //log.ls('cantTextSized: '+index, 0, 500)
                //                log.l('sd: '+sd)
                //                log.l('xItem.width: '+xItem.width)
                //                log.l('xItem.height: '+xItem.height)
                //                log.visible=true
            }
        }
    }
    Timer{
        id: tShow
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            numAn1.duration=250
            r.opacity=1.0
        }
    }
    function loadJson(json){
        numAn1.duration=1
        r.opacity=0.0
        lm.clear()
        let jo
        let o
        var ih
        let loadAudio=false
        if(!r.isBack&&JSON.parse(app.currentData).params.tipo==='pron')loadAudio=true
        if(loadAudio)plau.clear()
        let msg=''
        let urlEncoded=''
        let voice='es-ES_LauraVoice'
        msg='Estas son las posiciones de los planetas para '+tAutoMatic.currentLugar
        plau.addItem('https://text-to-speech-demo.ng.bluemix.net/api/v3/synthesize?text='+encodeURI(msg)+'&voice='+voice+'&download=true&accept=audio%2Fmp3')
        for(var i=0;i<15;i++){
            //stringIndex='&index='+i
            jo=json.pc['c'+i]
            ih=sweg.objHousesCircle.getHousePos(jo.gdec, json.ph.h1.gdec, i, jo.ih)
            var s = '<b>'+jo.nom+'</b> en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' <b>Casa:</b> ' +ih
            if(jo.retro===0&&i!==10&&i!==11)s+=' <b>R</b>'
            //console.log('--->'+s)
            lm.append(lm.addItem(jo.is, ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
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


            //            if(i===0){
            //                houseSun=ih
            //            }
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
        s = '<b>Ascendente</b> en <b>'+app.signos[o1.is]+'</b> @ <b>Grado:</b>°' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' <b>Casa:</b> 1'
        lm.append(lm.addItem(o1.is, 1, o1.rsgdeg, o1.mdeg, o1.sdeg,  s))
        o1=json.ph['h10']
        //s = 'Medio Cielo °' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' ' +app.signos[o1.is]
        s = '<b>Medio Cielo</b> en <b>'+app.signos[o1.is]+'</b> @ <b>Grado:</b>°' +o1.rsgdeg+ '\'' +o1.mdeg+ '\'\'' +o1.sdeg+ ' <b>Casa:</b> 10'
        lm.append(lm.addItem(o1.is, 10, o1.rsgdeg, o1.mdeg, o1.sdeg, s))
        //log.ls('o1.is: '+o1.is, 0, 500)

        //Load Houses
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            //s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            s = '<b>Casa</b> '+i+' en <b>'+app.signos[jo.is]+'</b> @ <b>Grado:</b>°' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ''
            lm.append(lm.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
            //lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }


        //Load Houses
        /*lm2.clear()
        for(i=1;i<13;i++){
            jo=json.ph['h'+i]
            s = 'Casa '+i+' °' +jo.rsgdeg+ '\'' +jo.mdeg+ '\'\'' +jo.sdeg+ ' ' +app.signos[jo.is]
            lm2.append(lm2.addItem(jo.is, jo.ih, jo.rsgdeg, jo.mdeg, jo.sdeg, s))
        }*/

        //if(app.mod!=='rs'&&app.mod!=='pl')r.state='show'
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
}
