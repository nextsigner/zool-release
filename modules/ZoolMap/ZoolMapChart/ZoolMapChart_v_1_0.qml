import QtQuick 2.0
import QtCharts 2.0

Item {
    id: r
    anchors.fill: parent
    property var colors: ['red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6', 'red', '#FBE103', '#09F4E2', '#0D9FD6']
    property int currentIndex: zoolMap.currentIndexSign

    onCurrentIndexChanged: {
        for(var i=0;i<12;i++){
            pieSeries.find(zoolMap.signos[i]).exploded = false;
        }
        pieSeries.find(zoolMap.signos[r.currentIndex]).exploded = true;
    }

    ChartView {
        id: chart
        width: r.parent.width*1.43//zoolMap.width*1.4-(zoolMap.housesNumWidth*2)-(zoolMap.housesNumMargin*2)
        height: width
        legend.alignment: Qt.AlignBottom
        legend.visible: false
        antialiasing: true
        margins.top: 0
        margins.bottom: 0
        margins.left: 0
        margins.right: 0
        //implicitWidth: zoolMap.width
        enabled: false
        backgroundColor: 'transparent'
        anchors.centerIn: parent
        PieSeries {
            id: pieSeries
            PieSlice { value: 30.0; color: r.colors[8]; label: zoolMap.signos[8]}
            PieSlice { value: 30.0; color: r.colors[7]; label: zoolMap.signos[7]}
            PieSlice { value: 30.0; color: r.colors[6]; label: zoolMap.signos[6]}
            PieSlice { value: 30.0; color: r.colors[5]; label: zoolMap.signos[5]}
            PieSlice { value: 30.0; color: r.colors[4]; label: zoolMap.signos[4]}
            PieSlice { value: 30.0; color: r.colors[3]; label: zoolMap.signos[3]}
            PieSlice { value: 30.0; color: r.colors[2]; label: zoolMap.signos[2]}
            PieSlice { value: 30.0; color: r.colors[1]; label: zoolMap.signos[1]}
            PieSlice { value: 30.0; color: r.colors[0]; label: zoolMap.signos[0]}
            PieSlice { value: 30.0; color: r.colors[11]; label: zoolMap.signos[11]}
            PieSlice { value: 30.0; color: r.colors[10]; label: zoolMap.signos[10]}
            PieSlice { value: 30.0; color: r.colors[9]; label: zoolMap.signos[9]}
        }
    }
}
