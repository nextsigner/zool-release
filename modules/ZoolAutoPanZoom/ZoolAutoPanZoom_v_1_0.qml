import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle{
    id: r
    visible: app.dev
    width: parent.width
    height: parent.height
    color: 'transparent'
    border.width: 4
    border.color: 'red'
    XCuadrante{
        id: r4
        width: r.width*0.5
        height: r.height*0.5
        c:4
        aHouses: [12, 11, 10]
    }
    XCuadrante{
        id: r3
        width: r.width*0.5
        height: r.height*0.5
        x:r4.width
        c:3
        aHouses: [9, 8, 7]
    }
    XCuadrante{
        id: r1
        width: r.width*0.5
        height: r.height*0.5
        y:r4.height
        c:1
        aHouses: [3, 2, 1]
    }
    XCuadrante{
        id: r2
        width: r.width*0.5
        height: r.height*0.5
        x:r4.width
        y:r4.height
        c:2
        aHouses: [6, 5, 4]
    }
}
