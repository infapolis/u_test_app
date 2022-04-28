import QtQml 2.15
import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQml.Models 2.3
import QtQuick.Layouts 1.3

Column {
    property string ob_ticket: ""
    Rectangle {
        width: parent.width
        height: parent.height/10
        color: '#fff'
        Text {
            id: t_name
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height*0.1
            font.pixelSize: parent.height*0.4
            font.bold: true
            color: '#333'
            text: ob_ticket
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height-this.height-parent.height*0.1
            font.pixelSize: parent.height*0.2
            color: '#333'
            text: "ORDERBOOK"
        }
        Image {
            x: main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            source: back_arr
            sourceSize.width: parent.height*0.5
        }
        MouseArea {
            anchors.fill: parent
            onClicked: close_ob()
        }
    }
    Rectangle {
        width: parent.width
        height: parent.height/20
        color: '#f8f8f8'
        Label {
            x: main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.5
            color: '#333'
            text: "<b>BIDS</b> Price"
        }
        Text {
            x: parent.width/3+main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.5
            color: '#333'
            text: "Size (USD)"
        }
        Text {
            x: parent.width/3*2+main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.5
            color: '#333'
            text: "Total (USD)"
        }
    }
    ListView {
        width: parent.width
        height: (parent.height-parent.height/5)/2
        model: bidsModel
        delegate: Rectangle {
            width: main_win.width
            height: (main_win.height-main_win.height/5)/20
            Rectangle {
                width: parent.width
                height: 1
                color: '#ccc'
                visible: index===0?false:true
            }
            Text {
                x: main_win.width/30
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height*0.5
                color: '#0a0'
                text: Number.parseFloat(price).toFixed(2)
            }
            Text {
                x: parent.width/3+main_win.width/30
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height*0.5
                color: '#0a0'
                text: size
            }
            Text {
                x: parent.width/3*2+main_win.width/30
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height*0.5
                color: '#0a0'
                text: Number.parseFloat(price*size).toFixed(2)
            }
        }
    }
    Rectangle {
        width: parent.width
        height: parent.height/20
        color: '#f8f8f8'
        Label {
            x: main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.5
            color: '#333'
            text: "<b>ASKS</b> Price"
        }
        Text {
            x: parent.width/3+main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.5
            color: '#333'
            text: "Size (USD)"
        }
        Text {
            x: parent.width/3*2+main_win.width/30
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.5
            color: '#333'
            text: "Total (USD)"
        }
    }
    ListView {
        width: parent.width
        height: (parent.height-parent.height/5)/2
        model: asksModel
        delegate: Rectangle {
            width: main_win.width
            height: (main_win.height-main_win.height/5)/20
            Rectangle {
                width: parent.width
                height: 1
                color: '#ccc'
                visible: index===0?false:true
            }
            Text {
                x: main_win.width/30
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height*0.5
                color: '#c00'
                text: Number.parseFloat(price).toFixed(2)
            }
            Text {
                x: parent.width/3+main_win.width/30
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height*0.5
                color: '#c00'
                text: size
            }
            Text {
                x: parent.width/3*2+main_win.width/30
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: parent.height*0.5
                color: '#c00'
                text: Number.parseFloat(price*size).toFixed(2)
            }
        }
    }
}
