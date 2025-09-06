import QtQuick 2.0

Item{
    id: r
    width: w//rowCentral.width
    height: col.height

    property bool showLetras: false

    property var modNumPit

    property int w: app.fs*8
    property int spacing: app.fs*0.5

    property int wl: 2
    property int hlEFKL: w*0.2
    property real esferaScale: 0.65
    property real esferaFsScale: 0.7



    property var aKAVPM: []
    property var aKAVPMLetras: ['A', 'B', 'C', 'D']

    property int vE: -1
    property int vF: -2
    property int vG: -3
    property int vH: -4
    property int vI: -5
    property int vJ: -6
    property int vK: -7
    property int vL: -8
    property int vM: -9
    property int vN: -10
    property int vO: -11

    Column{
        id: col
        spacing: r.spacing*0.75
        Rectangle{
            id:xH
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing
            antialiasing: true
            property int rot: 22
            property int hl: height*4
            Rectangle{
                width: parent.width*r.esferaScale
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wl
                border.color: apps.fontColor
                anchors.centerIn: parent
                antialiasing: true

                Text{
                    text: 'H'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                    visible: r.showLetras
                }
                Item{
                    width: 1
                    height: 1
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot-40
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    //anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl*0.65
                        antialiasing: true
                    }
                }
                Text{
                    text: r.vH
                    font.pixelSize: parent.width*r.esferaFsScale
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xG
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing
            antialiasing: true
            property int rot: 30
            property int hl: height+app.fs*0.35
            Rectangle{
                width: parent.width*r.esferaScale
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wl
                border.color: apps.fontColor
                anchors.centerIn: parent
                antialiasing: true

                Text{
                    text: 'G'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                    visible: r.showLetras
                }
                Item{
                    width: 1
                    height: 1
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Text{
                    text: r.vG
                    font.pixelSize: parent.width*r.esferaFsScale
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xI
            width: (r.width-r.spacing*3)/4
            height: width*0.1
            radius: width*0.5
            color: 'transparent'
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing
            antialiasing: true
            Rectangle{
                width: parent.width*r.esferaScale
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wl
                border.color: apps.fontColor
                anchors.centerIn: parent
                anchors.verticalCenterOffset: width*0.25
                antialiasing: true
                Text{
                    text: 'I'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                    visible: r.showLetras
                }
                Text{
                    text: r.vI
                    font.pixelSize: parent.width*r.esferaFsScale
                    color: apps.fontColor
                    anchors.centerIn: parent
                }
            }
        }
        Row{
            id: rowEF
            spacing: r.spacing
            //z:rowCentral.z+1
            Repeater{
                id: repEF
                model: 4
                Rectangle{
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.5
                    color: 'transparent'
                    border.width: 0
                    border.color: apps.fontColor
                    antialiasing: true
                    Rectangle{
                        width: parent.width*r.esferaScale
                        height: width
                        radius: width*0.5
                        color: apps.backgroundColor
                        border.width: r.wl
                        border.color: apps.fontColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 0-(width*0.5)-(parent.parent.spacing*0.5)
                        visible: index===1 || index===2
                        antialiasing: true
                        Text{
                            text: index===1?'E':'F'
                            font.pixelSize: parent.width*0.25
                            color: apps.fontColor
                            anchors.top:  parent.top
                            anchors.topMargin: 0-parent.width*0.075
                            anchors.left: parent.left
                            anchors.leftMargin: 0-parent.width*0.075
                            visible: r.showLetras
                        }
                        Item{
                            width: 1
                            height: 1
                            rotation: 45
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: parent.width*0.25
                            anchors.horizontalCenterOffset: 0-parent.width*0.2
                            z: parent.z-1
                            Rectangle{
                                width: 1
                                height: parent.parent.height*1.1
                                antialiasing: true
                            }
                        }
                        Item{
                            width: 1
                            height: 1
                            rotation: -45
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: parent.width*0.25
                            anchors.horizontalCenterOffset: parent.width*0.2
                            z: parent.z-2
                            Rectangle{
                                width: 1
                                height: parent.parent.height*1.1
                                antialiasing: true
                            }
                        }
                        Text{
                            text: index===1?r.vE:r.vF
                            font.pixelSize: parent.width*r.esferaFsScale
                            color: apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        Row{
            id: rowCentral
            spacing: r.spacing
            Repeater{
                id: repKAVPM
                //model: ['KARMA', 'ALMA', 'VIDA PASADA', 'MISIÓN']
                Rectangle{
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.2
                    color: apps.backgroundColor
                    border.width: r.wl
                    border.color: apps.fontColor
                    clip: true
                    antialiasing: true
                    Text{
                        text: r.aKAVPMLetras[index]
                        font.pixelSize: parent.width*0.25
                        color: apps.fontColor
                        anchors.top:  parent.top
                        anchors.topMargin: parent.width*0.075
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width*0.075
                        visible: r.showLetras
                    }
                    Text{
                        text: modelData
                        font.pixelSize: parent.width*r.esferaFsScale
                        color: apps.fontColor
                        anchors.centerIn: parent
                    }
                }
            }
            Item{
                id: xCirJ
                width: 1
                height: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 0-xJ.height*3
                Rectangle{
                    id:xJ
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.5
                    color: 'transparent'//apps.backgroundColor
                    border.width: 0
                    border.color: apps.fontColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing//*0.5
                    antialiasing: true
                    Rectangle{
                        width: parent.width*r.esferaScale
                        height: width
                        radius: width*0.5
                        color: apps.backgroundColor
                        border.width: r.wl
                        border.color: apps.fontColor
                        anchors.centerIn: parent
                        antialiasing: true
                        Rectangle{
                            width: 1
                            height: parent.height*2.6
                            color: apps.fontColor
                            anchors.top: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            antialiasing: true
                        }
                        Text{
                            text: 'J'
                            font.pixelSize: parent.width*0.25
                            color: apps.fontColor
                            anchors.top:  parent.top
                            anchors.topMargin: 0-parent.width*0.075
                            anchors.left: parent.left
                            anchors.leftMargin: 0-parent.width*0.075
                            visible: r.showLetras
                        }
                        Text{
                            text: r.vJ
                            font.pixelSize: parent.width*r.esferaFsScale
                            color: apps.fontColor
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        Row{
            id: rowKL
            spacing: r.spacing
            //z:rowCentral.z+1
            Repeater{
                id: repKL
                model: 4
                Rectangle{
                    width: (r.width-r.spacing*3)/4
                    height: width
                    radius: width*0.5
                    color: 'transparent'
                    border.width: 0
                    border.color: apps.fontColor
                    antialiasing: true
                    Rectangle{
                        width: parent.width*r.esferaScale
                        height: width
                        radius: width*0.5
                        color: apps.backgroundColor
                        border.width: r.wl
                        border.color: apps.fontColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 0-(width*0.5)-(parent.parent.spacing*0.5)
                        visible: index===1 || index===2
                        rotation: 180
                        antialiasing: true
                        Text{
                            text: index===1?'K':'L'
                            font.pixelSize: parent.width*0.25
                            color: apps.fontColor
                            rotation: 180
                            anchors.top:  parent.top
                            anchors.topMargin: 0-parent.width*0.075
                            anchors.left: parent.left
                            anchors.leftMargin: 0-parent.width*0.075
                            visible: r.showLetras
                        }
                        Item{
                            width: 1
                            height: 1
                            rotation: 45
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: parent.width*0.25
                            anchors.horizontalCenterOffset: 0-parent.width*0.2
                            z: parent.z-1
                            Rectangle{
                                width: 1
                                height: parent.parent.height*1.1
                                antialiasing: true
                            }
                        }
                        Item{
                            width: 1
                            height: 1
                            rotation: -45
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: parent.width*0.25
                            anchors.horizontalCenterOffset: parent.width*0.2
                            z: parent.z-2
                            Rectangle{
                                width: 1
                                height: parent.parent.height*1.1
                                antialiasing: true
                            }
                        }
                        Text{
                            text: index===1?r.vK:r.vL
                            font.pixelSize: parent.width*r.esferaFsScale
                            color: apps.fontColor
                            rotation: 180
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        Rectangle{
            id:xO
            width: (r.width-r.spacing*3)/4
            height: width*0.1
            radius: width*0.5
            color: 'transparent'
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing
            antialiasing: true
            Rectangle{
                width: parent.width*r.esferaScale
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wl
                border.color: apps.fontColor
                rotation: 180
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 0-width*0.25
                antialiasing: true
                Text{
                    text: 'O'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                    visible: r.showLetras
                }
                Text{
                    text: r.vO
                    font.pixelSize: parent.width*r.esferaFsScale
                    color: apps.fontColor
                    rotation: 180
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xM
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            //rotation: 180
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing
            antialiasing: true
            property int rot: 30
            property int hl: height+app.fs*0.35
            Rectangle{
                width: parent.width*r.esferaScale
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wl
                border.color: apps.fontColor
                rotation: 180
                anchors.centerIn: parent
                antialiasing: true

                Text{
                    text: 'M'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    rotation: 180
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                    visible: r.showLetras
                }
                Item{
                    width: 1
                    height: 1
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Text{
                    text: r.vM
                    font.pixelSize: parent.width*r.esferaFsScale
                    color: apps.fontColor
                    rotation: 180
                    anchors.centerIn: parent
                }
            }
        }
        Rectangle{
            id:xN
            width: (r.width-r.spacing*3)/4
            height: width
            radius: width*0.5
            color: apps.backgroundColor
            border.width: 0
            border.color: apps.fontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0-width*0.5-rowCentral.spacing
            z:rowCentral.z-1
            antialiasing: true
            property int rot: 22
            property int hl: height*4
            Rectangle{
                width: parent.width*r.esferaScale
                height: width
                radius: width*0.5
                color: apps.backgroundColor
                border.width: r.wl
                border.color: apps.fontColor
                rotation: 180
                anchors.centerIn: parent
                antialiasing: true

                Text{
                    text: 'N'
                    font.pixelSize: parent.width*0.25
                    color: apps.fontColor
                    rotation: 180
                    anchors.top:  parent.top
                    anchors.topMargin: 0-parent.width*0.075
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.075
                    visible: r.showLetras
                }
                Item{
                    width: 1
                    height: 1
                    rotation: parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: 0-parent.width*0.25
                    z: parent.z-1
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Item{
                    width: 1
                    height: 1
                    rotation: 0-parent.parent.rot
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: parent.width*0.25
                    anchors.horizontalCenterOffset: parent.width*0.25
                    z: parent.z-2
                    Rectangle{
                        width: 1
                        height: parent.parent.parent.hl
                        antialiasing: true
                    }
                }
                Text{
                    text: r.vN
                    font.pixelSize: parent.width*r.esferaFsScale
                    color: apps.fontColor
                    rotation: 180
                    anchors.centerIn: parent
                }
            }
        }
    }
    function load(m, d, a, mision){
        let aKAVPM = []
        aKAVPM.push(m)
        aKAVPM.push(d)
        aKAVPM.push(a)
        aKAVPM.push(mision)
        repKAVPM.model=aKAVPM

        r.vE=modNumPit.bigNumToPitNum(m+d, true)
        r.vF=modNumPit.bigNumToPitNum(d+a, true)
        r.vG=modNumPit.bigNumToPitNum(r.vE+r.vF, true)
        r.vH=modNumPit.bigNumToPitNum(m+a, true)
        r.vI=modNumPit.bigNumToPitNum(r.vE+r.vF+r.vG, true)
        r.vK=Math.abs(modNumPit.bigNumToPitNumNeg(m-d))
        let n2=modNumPit.bigNumToPitNum(a, false)
        r.vL=Math.abs(d-n2)
        r.vM=Math.abs(r.vK-r.vL)

        r.vN=Math.abs(modNumPit.bigNumToPitNumNeg(m-a))

        r.vO=Math.abs(modNumPit.bigNumToPitNum(r.vK+r.vL+r.vM, true))
        r.vJ=modNumPit.bigNumToPitNum( r.vH+mision,true)

    }
}
