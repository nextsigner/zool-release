import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../editor" as Editor
Rectangle{
    id: r
    visible: false
    width: xApp.width*0.2
    height: parent.height
    color: apps.backgroundColor
    clip: true
    property alias l: labelEditorTitle
    property alias e: editor
    property bool editing: false
    onVisibleChanged: {
        if(editing)editor.textEdit.focus=visible
    }
    onEditingChanged: {
        if(editing){
            editor.textEdit.focus=r.visible
            editor.fl.contentY=0
        }
    }
    MouseArea{
        anchors.fill: r
    }
    Column{
        anchors.centerIn: parent
        //spacing: app.fs*0.25
        Rectangle{
            id: xEditorTit
            width: r.width
            height: labelEditorTitle.contentHeight+app.fs*0.5
            color: apps.fontColor
            Text{
                id: labelEditorTitle
                text: 'Editando Información'
                width: parent.width-app.fs*0.5
                color: apps.backgroundColor
                font.pixelSize: app.fs*0.5
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
            }
        }
        Editor.UnikTextEditor{
            id:editor
            z: xEditorTit.z-1
            width: xEditor.width
            height: xEditor.height-xEditorTit.height-xEditorTools.height//-app.fs*0.5
            fs:apps.editorFs
            wordWrap: true
            visible: r.editing
            //onEscaped: r.focus=true
            clip: true
            //text: r.data
        }
        Rectangle{
            id: xEd
            z: xEditorTit.z-1
            width: xEditor.width
            height: xEditor.height-xEditorTit.height-xEditorTools.height//-app.fs*0.5
            visible: !r.editing
            color: 'transparent'
            border.width: 2
            border.color: apps.fontColor
            clip: true
            Flickable{
                //anchors.fill: parent
                width: parent.width-app.fs*0.5
                height: parent.height-app.fs*0.5
                anchors.centerIn: parent
                contentWidth: dataResult.contentWidth
                contentHeight: dataResult.contentHeight+apps.editorFs*2
                boundsBehavior: Flickable.StopAtBounds
                Text{
                    id: dataResult
                    font.pixelSize: apps.editorFs
                    width: r.width-app.fs
                    wrapMode: Text.WordWrap//Text.WrapAnywhere
                    color: apps.fontColor
                    //textFormat: TextEdit.MarkdownText
                    text: visible?xEditor.e.text:''
                    textFormat: Text.MarkdownText
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        Rectangle{
            id: xEditorTools
            width: r.width
            height: app.fs*1.2
            color: apps.fontColor
//            Text{
//                anchors.verticalCenter: parent.verticalCenter
//                text: 'l: '+xEditor.e.lin
//                font.pixelSize: app.fs*0.5
//                color: 'red'
//            }
            Row{
                anchors.centerIn: parent
                spacing: app.fs*0.1
                Button{
                    id: botSave
                    width: app.fs*1.1
                    text:  ''
                    enabled: !diff
                    opacity: diff?0.5:1.0
                    property bool diff: false
                    onClicked: {
                        save()
                    }
                    Text{
                        text:  '\uf0c7'
                        color: botSave.diff?apps.backgroundColor:'blue'
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                    Timer{
                        running: r.visible
                        repeat: true
                        interval: 250
                        onTriggered: {
                            let json=JSON.parse(app.fileData)
                            let d0=''
                            if(json.params.data)d0=json.params.data
                            let d1=editor.text
                            botSave.diff=d1===d0
                        }
                    }
                }
                Button{
                    id: botEdit
                    width: app.fs*1.1
                    text:  ''
                    onClicked: {
                        r.editing=!editing
                        if(r.editing)xEditor.e.textEdit.focus=true
                    }
                    Text{
                        text:  !r.editing?'\uf044':'\uf06e'
                        //color: apps.fontColor
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                }
                Item{
                    width: app.fs*0.25
                    height: 1
                }
                Button{
                    width: app.fs*1.1
                    text:  ''
                    visible: r.editing
                    opacity: diff?0.5:1.0
                    property bool diff: false
                    onClicked: {
                        apps.editorShowNumberLines=!apps.editorShowNumberLines
                    }
                    Text{
                        text:  '\uf0cb'
                        //color: apps.fontColor
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                }
                Item{
                    width: app.fs*0.25
                    height: 1
                }
                Button{
                    id: botClose
                    width: app.fs*1.1
                    text:  ''
                    onClicked: {
                        r.visible=false
                    }
                    Text{
                        text:  '\uf00d'
                        //color: botSave.diff?apps.backgroundColor:'blue'
                        font.family: "FontAwesome"
                        font.pixelSize: app.fs
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
    function showInfo(){
        let json=JSON.parse(app.fileData)
        let data=''
        if(json.params.data){
            data=json.params.data
        }
        r.e.text=data
        r.l.text='Información de '+json.params.n.replace(/_/g, ' ')
        r.editing=false
        r.visible=true
    }
    function enter(){
        //Qt.quit()
    }
    function save(){
        let json=JSON.parse(app.fileData)
        json.params.data=editor.text
        if(unik.fileExist(apps.url.replace('file://', ''))){
            let dataModNow=new Date(Date.now())
            json.params.msmod=dataModNow.getTime()
        }
        let njson=JSON.stringify(json)        
        app.fileData=njson
        app.currentData=app.fileData
        unik.setFile(apps.url.replace('file://', ''), app.fileData)
        r.editing=!r.editing
    }
    function close(){
        r.visible=false
    }
}
