import QtQuick 2.0
import ZoolText 1.2
import comps.FocusSen 1.0

Rectangle {
    id: r
    width: row.width//+app.fs
    //height: labelText===''?colAll.height:colAll.height+txtLabelText.height+r.fs*0.1
    height: colAll.height
    color: apps.backgroundColor
    border.width: 0
    border.color: apps.fontColor
    property bool locked: false
    property string labelText: ''
    property bool enableGMT: true
    property bool verHoraMinuto: true
    property bool isBack: false
    property var currentDate: !isBack?app.currentDate:app.currentDateBack
    property int anio: 0
    property int mes: 0
    property int dia: 0
    property int hora: 0
    property int minuto: 0
    property real gmt: !r.isBack?zm.currentGmt:zm.currentGmtBack
    property int fs: app.fs?app.fs*0.5:16
    property bool setAppTime: false

    property bool restartCFocusFromZero: true
    property int fsbw: app.fs*0.1 // FocusSen Border Width

    onFocusChanged: {
        if(!focus)controlTimeFecha.cFocus=-1
        if(focus)controlTimeFecha.cFocus=0
    }
    onCurrentDateChanged: {
        if(!r.currentDate)return
        r.anio=r.currentDate.getFullYear()
        r.mes=r.currentDate.getMonth() + 1
        r.dia=r.currentDate.getDate()
        r.hora=r.currentDate.getHours()
        r.minuto=r.currentDate.getMinutes()
        if(r.setAppTime){
            //log.l('222 Reload CD1...')
            //log.visible=true
            //log.l('-1 Reload CD1... '+r.setAppTime)
            //log.visible=true
            if(!r.isBack){
                zm.currentDate=r.currentDate
            }else{
                zm.currentDateBack=r.currentDate
            }
        }else{
            //log.l('333 Reload CD1...')
            //log.visible=true
        }
        //r.setAppTime=true
    }

    Column{
        id: colAll
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        ZoolText {
            id: txtLabelText
            text: r.labelText
            font.pixelSize: r.fs
            color: 'white'
            visible: r.labelText!==''
        }
        Item{width: 1; height:r.fs*0.25;visible: r.labelText!==''}
        Row{
            Rectangle{
                width: row2.width
                height: r.fs*1.2
                Text {
                    id: labelFecha
                    text: 'Fecha'
                    font.pixelSize: r.fs*0.5
                    anchors.centerIn: parent
                }
            }

            Item{
                width: r.fs
                height: 2
                visible: !r.enableGMT
            }
            Rectangle{
                id: xLabelGmt
                width: r.fs*3
                height: r.fs*1.2
                visible: r.enableGMT || r.verHoraMinuto
                Text {
                    id: labelGmt
                    text: 'GMT'
                    font.pixelSize: r.fs*0.5
                    anchors.centerIn: parent
                }
            }
            Rectangle{
                width: row1.width
                height: r.fs*1.2
                visible: r.verHoraMinuto
                Text {
                    id: labelHora
                    text: 'Hora'
                    font.pixelSize: r.fs*0.5
                    anchors.centerIn: parent
                }
            }
        }
        Row{
            id: row
            //anchors.bottom: parent.bottom
            Row{
                id: row2
                spacing: -1
                Rectangle{
                    id: xAnio
                    width: r.fs*3
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    objectName: 'xanio'
                    property int xi: 0
                    FocusSen{visible: r.cFocus===parent.xi; bw:fsbw}
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            if(r.cFocus!==0){
                                r.cFocus=0
                                editCellData.parent=parent
                                editCellData.max=t1.text.length
                                return
                            }
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if (mouse.button === Qt.RightButton) {
                                d2.setFullYear(d2.getFullYear() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setFullYear(d2.getFullYear() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                        onWheel: {
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if(wheel.angleDelta.y>=0){
                                d2.setFullYear(d2.getFullYear() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setFullYear(d2.getFullYear() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                    }
                    Text{
                        id: t1
                        text: r.anio
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    id: xMes
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    property int xi: 1
                    objectName: 'xmes'
                    FocusSen{visible: r.cFocus===parent.xi; bw:fsbw}
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            if(r.cFocus!==1){
                                r.cFocus=1
                                editCellData.parent=parent
                                editCellData.max=t2.text.length
                                return
                            }
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if (mouse.button === Qt.RightButton) {
                                d2.setMonth(d2.getMonth() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setMonth(d2.getMonth() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                        onWheel: {
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if(wheel.angleDelta.y>=0){
                                d2.setMonth(d2.getMonth() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setMonth(d2.getMonth() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                    }
                    Text{
                        id: t2
                        text: r.mes>9?r.mes:'0'+r.mes
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                    Rectangle{
                        width: tb1.contentWidth+2
                        height: tb1.contentHeight+2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.left
                        color: apps.backgroundColor
                        Text{
                            id: tb1
                            text: '/'
                            color: apps.fontColor
                            font.pixelSize: r.fs*0.65
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                Rectangle{
                    id: xDia
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    property int xi: 2
                    objectName: 'xdia'
                    FocusSen{visible: r.cFocus===parent.xi; bw:fsbw}
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            if(r.cFocus!==2){
                                r.cFocus=2
                                editCellData.parent=parent
                                editCellData.max=t3.text.length
                                return
                            }
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if (mouse.button === Qt.RightButton) {
                                d2.setDate(d2.getDate() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setDate(d2.getDate() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                        onWheel: {
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if(wheel.angleDelta.y>=0){
                                d2.setDate(d2.getDate() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setDate(d2.getDate() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                    }
                    Text{
                        id: t3
                        text: r.dia
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                    Rectangle{
                        width: tb2.contentWidth+2
                        height: tb2.contentHeight+2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.left
                        color: apps.backgroundColor
                        Text{
                            id: tb2
                            text: '/'
                            color: apps.fontColor
                            font.pixelSize: r.fs*0.65
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
            Item{
                width: r.fs
                height: 2
                visible: !r.enableGMT
            }
            Rectangle{
                id: xGmt
                width: xLabelGmt.width
                height: r.fs*1.8
                color: apps.backgroundColor
                border.width: 1
                border.color: apps.fontColor
                visible: r.enableGMT || r.verHoraMinuto
                property int xi: 3
                objectName: 'xgmt'
                FocusSen{visible: r.cFocus===parent.xi; bw:fsbw}
                Text{
                    id: t8
                    text: r.gmt
                    color: apps.fontColor
                    font.pixelSize: r.fs
                    anchors.centerIn: parent
                }
                MouseArea{
                    id: maw
                    anchors.fill: parent
                    //onClicked: r.v=!r.v
                    property int m:0
                    property date uDate//: app.currentDate
                    property int f: 0
                    property int uY: 0
                    acceptedButtons: Qt.AllButtons;
                    onClicked: {
                        if(r.cFocus!==3){
                            r.cFocus=3
                            editCellData.parent=parent
                            editCellData.max=t8.text.length
                            return
                        }
                        let cgmt
                        cgmt=r.gmt
                        if (mouse.button === Qt.RightButton) {
                            if(cgmt<12.00){
                                cgmt+=1.0//0.1
                            }else{
                                cgmt=-12.00
                            }
                        }else{
                            if(cgmt>-12.00){
                                cgmt-=1.0//0.1
                            }else{
                                cgmt=12.00
                            }
                        }
                        r.gmt=parseFloat(cgmt).toFixed(1)
                    }
                    onWheel: {
                        let cgmt
                        cgmt=r.gmt
                        if(wheel.angleDelta.y===120){
                            if(cgmt<12.00){
                                cgmt+=0.1
                            }else{
                                cgmt=-12.00
                            }
                        }else{
                            if(cgmt>-12.00){
                                cgmt-=0.1
                            }else{
                                cgmt=12.00
                            }
                        }
                        r.gmt=parseFloat(cgmt).toFixed(1)
                    }
                }
            }
            Row{
                id: row1
                visible: r.verHoraMinuto
                Rectangle{
                    id: xHora
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    property int xi: 4
                    objectName: 'xhora'
                    FocusSen{visible: r.cFocus===parent.xi; bw:fsbw}
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            if(r.cFocus!==4){
                                r.cFocus=4
                                editCellData.parent=parent
                                editCellData.max=t4.text.length
                                return
                            }
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if (mouse.button === Qt.RightButton) {
                                d2.setHours(d2.getHours() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setHours(d2.getHours() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                        onWheel: {
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if(wheel.angleDelta.y>=0){
                                d2.setHours(d2.getHours() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setHours(d2.getHours() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                    }
                    Text{
                        id: t4
                        text: r.hora
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                }

                Rectangle{
                    id: xMinuto
                    width: r.fs*2
                    height: r.fs*1.8
                    color: apps.backgroundColor
                    border.width: 1
                    border.color: apps.fontColor
                    property int xi: 5
                    objectName: 'xminuto'
                    FocusSen{visible: r.cFocus===parent.xi; bw:fsbw}
                    MouseArea{
                        enabled: !r.locked
                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons;
                        onClicked: {
                            if(r.cFocus!==5){
                                r.cFocus=5
                                editCellData.parent=parent
                                editCellData.max=t6.text.length
                                return
                            }
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if (mouse.button === Qt.RightButton) {
                                d2.setMinutes(d2.getMinutes() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setMinutes(d2.getMinutes() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                        onWheel: {
                            let d = r.currentDate
                            let d2=new Date(d.getTime())
                            if(wheel.angleDelta.y>=0){
                                d2.setMinutes(d2.getMinutes() + 1)
                                r.currentDate = new Date(d2)
                            }else{
                                d2.setMinutes(d2.getMinutes() - 1)
                                r.currentDate = new Date(d2)
                            }
                        }
                    }
                    Text{
                        id: t6
                        text: r.minuto>9?r.minuto:'0'+r.minuto
                        color: apps.fontColor
                        font.pixelSize: r.fs
                        anchors.centerIn: parent
                    }
                    Rectangle{
                        width: t5.contentWidth+2
                        height: t5.contentHeight+2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.left
                        color: apps.backgroundColor
                        Text{
                            id: t5
                            text: ':'
                            color: apps.fontColor
                            font.pixelSize: r.fs*0.65
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
    property var aRect: [t4, t6, t8, t3, t2, t1]
    property int cFocus: -1
    onCFocusChanged: {
        t1.visible=true
        t2.visible=true
        t3.visible=true
        t4.visible=true
        t5.visible=true
        t6.visible=true
        //t7.visible=true
        t8.visible=true
        if(cFocus===0){
            editCellData.parent=xAnio
        }
        if(cFocus===1){
            editCellData.parent=xMes
        }
        if(cFocus===2){
            editCellData.parent=xDia
        }
        if(cFocus===3){
            editCellData.parent=xGmt
        }
        if(cFocus===4){
            editCellData.parent=xHora
        }
        if(cFocus===5){
            editCellData.parent=xMinuto
        }
        if(cFocus===-1){
            editCellData.parent=r
        }
    }
    Timer{
        running: false//r.cFocus>=0 && editCellData.parent!==r
        repeat: true
        interval: 250
        onTriggered: {
            let b=!aRect[r.cFocus].visible
            if(aRect[r.cFocus]!==t1)t1.visible=true
            if(aRect[r.cFocus]!==t2)t2.visible=true
            if(aRect[r.cFocus]!==t3)t3.visible=true
            if(aRect[r.cFocus]!==t4)t4.visible=true
            if(aRect[r.cFocus]!==t5)t5.visible=true
            if(aRect[r.cFocus]!==t6)t6.visible=true
            if(aRect[r.cFocus]!==t8)t8.visible=true
            aRect[r.cFocus].visible=b
        }
    }
    Rectangle{
        id: editCellData
        width: parent.width-(r.fsbw*2)
        height: parent.height-(r.fsbw*2)
        anchors.centerIn: parent
        color: apps.backgroundColor
        clip: true
        visible: parent!==r
        property int max: 1
        onParentChanged: {
            if(parent!==r){
                let n = parent.objectName
                //log.lv('n: '+n)
                let data=-1
                if(n==='xanio'){
                    editCellData.max=4
                    data=r.anio
                }
                if(n==='xmes'){
                    editCellData.max=2
                    data=r.mes
                }
                if(n==='xdia'){
                    editCellData.max=2
                    data=r.dia
                }
                if(n==='xgmt'){
                    editCellData.max=3
                    data=r.gmt
                }
                if(n==='xhora'){
                    editCellData.max=2
                    data=r.hora
                }
                if(n==='xminuto'){
                    editCellData.max=2
                    data=r.minuto
                }
                tiData.text=''+data
                tiData.selectAll()
            }
        }
        onVisibleChanged: {
            //let n = parent.objectName
            if(visible){
                let n = parent.objectName
                tiData.focus=true
                /*let data
                if(n==='xanio'){
                    data=r.anio
                }
                if(n==='xmes'){
                    data=r.mes
                }
                if(n==='xdia'){
                    data=r.dia
                }
                if(n==='xgmt'){
                    data=r.gmt
                }
                if(n==='xhora'){
                    data=r.hora
                }
                if(n==='xminuto'){
                    data=r.minuto
                }
                tiData.text=''+data
                tiData.selectAll()*/
            }else{
                /*let i=-1
                let n = parent.objectName
                //log.lv('2 n: '+n)
                if(n==='xanio'){
                    i=0
                }
                if(n==='xmes'){
                    i=1
                }
                if(n==='xdia'){
                    i=2
                }
                if(n==='xgmt'){
                    i=3
                }
                if(n==='xhora'){
                    i=4
                }
                if(n==='xminuto'){
                    i=5
                }
                //log.lv('i: '+i)
                setCellData(parseInt(tiData.text), i)
                if(!r.verHoraMinuto){
                    if(r.cFocus<2){
                        r.cFocus++
                    }else{
                        r.cFocus=0
                    }
                }else{
                    if(r.cFocus<5){
                        r.cFocus++
                    }else{
                        r.cFocus=0
                    }
                }*/
            }
        }
        TextInput{
            id: tiData
            //anchors.fill: parent
            anchors.centerIn: parent
            color: apps.fontColor
            font.pixelSize: r.fs
            maximumLength: editCellData.max
            validator: IntValidator {
                bottom: editCellData.parent===xGmt?-12:1  // Opcional: número mínimo aceptado
                //top: 3000 // Opcional: número máximo aceptado
            }
            Keys.onReturnPressed: sd()
            Keys.onEnterPressed: sd()
            Keys.onEscapePressed: {
                editCellData.parent=r
                tiData.focus=false
            }
            function sd(){
                let i=-1
                let n = parent.parent.objectName
                //log.lv('2 n: '+n)
                if(n==='xanio'){
                    i=0
                }
                if(n==='xmes'){
                    i=1
                }
                if(n==='xdia'){
                    i=2
                }
                if(n==='xgmt'){
                    i=3
                }
                if(n==='xhora'){
                    i=4
                }
                if(n==='xminuto'){
                    i=5
                }
                //log.lv('i: '+i)
                if(!isNaN(parseInt(tiData.text))){
                    setCellData(parseInt(tiData.text), i)
                }else{
                    return
                }
                if(!r.verHoraMinuto){
                    //log.lv('r.verHoraMinuto: '+r.verHoraMinuto)
                    if(r.cFocus<2){
                        r.cFocus++
                    }else{
                        r.cFocus=r.restartCFocusFromZero?0:-1
                    }
                }else{
                    if(r.cFocus<5){
                        r.cFocus++
                    }else{
                        r.cFocus=r.restartCFocusFromZero?0:-1
                    }
                    //editCellData.parent=r
                }
                if(r.cFocus===0){
                    editCellData.parent=xAnio
                }else if(r.cFocus===1){
                    editCellData.parent=xMes
                }else if(r.cFocus===2){
                    editCellData.parent=xDia
                }else if(r.cFocus===3){
                    editCellData.parent=xGmt
                }else if(r.cFocus===4){
                    editCellData.parent=xHora
                }else if(r.cFocus===5){
                    editCellData.parent=xMinuto
                }else{
                    editCellData.parent=r
                }
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                editCellData.parent=r
            }
        }
    }
    Component.onCompleted: {
        if(!r.currentDate || r.currentDate.toString().indexOf('Invalid')>=0){
            r.currentDate=new Date(Date.now())
            //log.ls('r.currentDate now:'+r.currentDate.toString(), 0, xLatIzq.width)
        }
        r.anio=r.currentDate.getFullYear()
        r.mes=r.currentDate.getMonth() + 1
        r.dia=r.currentDate.getDate()
        r.hora=r.currentDate.getHours()
        r.minuto=r.currentDate.getMinutes()
    }
    function setTime(datetime){
        let sap=r.setAppTime
        r.setAppTime=false
        r.currentDate=datetime
        r.setAppTime=sap
    }

    function setEditData(){
        //zpn.log('ZoolControlsTime.setEditData()')
        if(editCellData.parent!==r){
            //log.lv('tiData.text: '+tiData.text)
            let n = editCellData.parent.objectName
            //log.lv('n: '+n)
            let data=-1
            if(r.cFocus===0){
                r.anio=parseInt(tiData.text)
            }
            if(r.cFocus===1){
                r.mes=parseInt(tiData.text)
            }
            if(r.cFocus===2){
                r.dia=parseInt(tiData.text)
            }
            if(r.cFocus===3){
                r.gmt=parseInt(tiData.text)
            }
            if(r.cFocus===4){
                r.hora=parseInt(tiData.text)
            }
            if(r.cFocus===5){
                r.minuto=parseInt(tiData.text)
            }
        }
    }

    //-->Teclado
    function toRight(){
        if(r.cFocus<5){
            r.cFocus++
        }else{
            r.cFocus=0
        }
    }
    function toLeft(){
        if(r.cFocus>0){
            r.cFocus--
        }else{
            r.cFocus=5
        }
    }
    function toUp(){
        let cgmt
        if(r.cFocus>=0&&r.cFocus!==2){
            let d = controlTimeFecha.currentDate
            let d2
            if(r.cFocus===0){
                d2 = new Date(d)
                d2=d2.setHours(d2.getHours() + 1)
            }
            if(r.cFocus===1){
                d2 = new Date(d)
                d2=d2.setMinutes(d2.getMinutes() + 1)
            }
            if(r.cFocus===2){
                let cgmt
                cgmt=r.gmt
                if(cgmt<12.00){
                    cgmt+=0.1
                }else{
                    cgmt=-12.00
                }
                r.gmt=parseFloat(cgmt).toFixed(1)
            }
            if(r.cFocus===3){
                d2 = new Date(d)
                d2=d2.setDate(d2.getDate() + 1)
            }
            if(r.cFocus===4){
                d2 = new Date(d)
                d2=d2.setMonth(d2.getMonth() + 1)
            }
            if(r.cFocus===5){
                d2 = new Date(d)
                d2=d2.setFullYear(d2.getFullYear() + 1)
            }
            controlTimeFecha.currentDate=new Date(d2)
        }
        if(r.cFocus===2){
            cgmt=r.gmt
            if(cgmt<12.00){
                cgmt+=0.1
            }else{
                cgmt=-12.00
            }
            r.gmt=parseFloat(cgmt).toFixed(1)
        }
    }
    function toDown(){
        let cgmt
        if(r.cFocus>=0&&r.cFocus!==2){
            let d = controlTimeFecha.currentDate
            let d2
            if(r.cFocus===0){
                d2 = new Date(d)
                d2=d2.setHours(d2.getHours() - 1)
            }
            if(r.cFocus===1){
                d2 = new Date(d)
                d2=d2.setMinutes(d2.getMinutes() - 1)
            }
            if(r.cFocus===2){
                cgmt=r.gmt
                if(cgmt>-12.00){
                    cgmt-=0.1
                }else{
                    cgmt=12.00
                }
                r.gmt=parseFloat(cgmt).toFixed(1)
            }
            if(r.cFocus===3){
                d2 = new Date(d)
                d2=d2.setDate(d2.getDate() - 1)
            }
            if(r.cFocus===4){
                d2 = new Date(d)
                d2=d2.setMonth(d2.getMonth() - 1)
            }
            if(r.cFocus===5){
                d2 = new Date(d)
                d2=d2.setFullYear(d2.getFullYear() - 1)
            }
            controlTimeFecha.currentDate=new Date(d2)
        }
        if(r.cFocus===2){
            cgmt=r.gmt
            if(cgmt>-12.00){
                cgmt-=0.1
            }else{
                cgmt=12.00
            }
            r.gmt=parseFloat(cgmt).toFixed(1)
        }
    }
    function toEscape(){
        r.cFocus=-1
        editCellData.parent=r
    }
    //<--Teclado

    function setCellData(n, i){
        if(isNaN(n)){
            return
        }
        if(editCellData.parent===xAnio && (n<3000 || n>10000)){
            return
        }
        if(editCellData.parent===xMes && (n<1 || n>12)){
            return
        }
        if(editCellData.parent===xDia && (n<1 || n>31)){
            return
        }
        if(editCellData.parent===xGmt && (n<-12 || n>12)){
            return
        }
        if(editCellData.parent===xHora && (n<0 || n>24)){
            return
        }
        if(editCellData.parent===xMinuto && (n<0 || n>59)){
            return
        }
        let d = new Date(r.currentDate)
        //log.lv('d: '+d.toString())
        let nd
        //zpn.log('ZoonControlsTime.setCellData('+n+', '+i+').verHoraMinuto: '+r.verHoraMinuto)
        if(i!==3){
            if(i===0){
                nd = new Date(n, d.getMonth(), d.getDate(), d.getHours(), d.getMinutes())
            }
            if(i===1){
                nd = new Date(d.getFullYear(), n - 1, d.getDate(), d.getHours(), d.getMinutes())
            }
            if(i===2){
                nd = new Date(d.getFullYear(), d.getMonth(), n, d.getHours(), d.getMinutes())
            }
            if(i===4){
                nd = new Date(d.getFullYear(), d.getMonth(), d.getDate(), n, d.getMinutes())
            }
            if(i===5){
                nd = new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), n)
            }
            r.currentDate = nd
        }else{
            r.gmt=n
        }
    }
    function isFocus(){
        return r.cFocus>=0
    }
}
