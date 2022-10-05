import QtQuick 2.0

Item{
    id: r
    width: parent.width
    height: parent.height
    transform: Scale {
        id: tform
    }
    MouseArea {
        anchors.fill: parent
        property double factor: 2.0
        onWheel:
        {
            if(wheel.angleDelta.y > 0)  // zoom in
                var zoomFactor = factor
            else                        // zoom out
                zoomFactor = 1/factor

            var realX = wheel.x * tform.xScale
            var realY = wheel.y * tform.yScale
            r.x += (1-zoomFactor)*realX
            r.y += (1-zoomFactor)*realY
            tform.xScale *=zoomFactor
            tform.yScale *=zoomFactor

        }
    }
}
