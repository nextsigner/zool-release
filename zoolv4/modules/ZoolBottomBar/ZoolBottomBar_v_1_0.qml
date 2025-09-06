import QtQuick 2.0
import ZoolCmd 1.0

Rectangle {
    id: r
    width: parent.width
    height: app.fs
    color: apps.backgroundColor
    border.width: 1
    border.color: apps.fontColor
    clip: true
    //anchors.bottom: parent.bottom
    property alias objPanelCmd: panelCmd
    property alias objXState: xStatus
    state: apps.zFocus==='cmd'?"show":"hide"
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: r
                y:r.parent.height-r.height
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: r
                y:r.parent.height
            }
        }
    ]
    onStateChanged:{
        if(state==="show"){
            panelCmd.ti.focus=true
        }else{
            panelCmd.ti.focus=false
        }
    }
    Behavior on y {enabled: apps.enableFullAnimation;NumberAnimation{duration: app.msDesDuration;easing.type: Easing.InOutQuad}}
    XStatus{
        id: xStatus;

    }
    ZoolCmd{
        id: panelCmd
        width: parent.width-xStatus.width
        height: parent.height
        //state: r.state
        //onStateChanged: if(state==='show')r.state='show'
    }
    function toEnter(){
        panelCmd.toEnter()
    }
    function toUp(){
        panelCmd.toUp()
    }
    function toDown(){
        panelCmd.toDown()
    }
}
