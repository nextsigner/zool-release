import QtQuick 2.0
import QtQuick.Controls 2.0
import "../Funcs.js" as JS

Rectangle {
    id: r
    width: row.width+app.fs*0.25
    height: txt.contentHeight<app.fs*1.2?app.fs*1.2:txt.contentHeight+app.fs*0.5
    color: apps.backgroundColor
    border.width: 0
    border.color: apps.fontColor
    radius: app.fs*0.25
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: xDataBar.bottom
    z: xDataBar.z-1
    property int currentIndex: -1
    property var textStatus: ['Mostrando sinastría.Aún no se ha creado el archivo']
    onCurrentIndexChanged: setGui()
    state: currentIndex<0?'hide':'show'
    states: [
        State {
            name: "hide"
            PropertyChanges {
                target: r
                anchors.topMargin: 0-r.height
            }
        },
        State {
            name: "show"
            PropertyChanges {
                target: r
                anchors.topMargin: 0
            }
        }
    ]
    Behavior on y{NumberAnimation{duration: 500}}
    MouseArea{
        anchors.fill: parent
        //onClicked: r.currentIndex=0
    }
    Row{
        id: row
        spacing: app.fs*0.25
        anchors.centerIn: parent
        Text{
            id: txt
            //text: r.textStatus[r.currentIndex]
            font.pixelSize: app.fs*0.35
            color: apps.fontColor
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button{
            id: bot1
            font.pixelSize: app.fs*0.5
            height: app.fs*0.7
            anchors.verticalCenter: parent.verticalCenter
            onClicked: run(0)
        }
        Button{
            id: bot2
            font.pixelSize: app.fs*0.5
            height: app.fs*0.7
            anchors.verticalCenter: parent.verticalCenter
            onClicked: run(1)
        }
    }
    function setGui(){
        txt.text=(r.textStatus[r.currentIndex]).replace(/\./g, '.\n')
        if(r.currentIndex===0){
            bot1.text='Crear Sinastría'
            bot1.visible=true
            bot2.visible=false
        }
    }
    function run(numBot){
        if(r.currentIndex===0){
            if(numBot===0){
                JS.mkSinFile(apps.urlBack)
            }
        }
    }
}
