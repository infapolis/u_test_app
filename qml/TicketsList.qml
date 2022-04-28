import QtQml 2.15
import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQml.Models 2.3
import QtQuick.Layouts 1.3

ListView {
    model: ticketModel
    delegate: Rectangle {
        width: main_win.width
        height: main_win.height/10
        Rectangle {
            width: parent.width
            height: 1
            color: '#ccc'
            visible: index===0?false:true
        }
        Text {
            id: t_name
            x: parent.height/5
            y: parent.height/10
            font.bold: true
            font.pixelSize: parent.height*0.2
            color: '#333'
            text: ticket
        }
        Text {
            id: t_price
            x: parent.height/5
            y: parent.height/10+t_name.height*0.2
            font.bold: true
            font.pixelSize: parent.height*0.6
            color: {
                if (t_price_inc.text!=='' || t_price_dec.text!=='') {
                    if (t_price_inc.text!=='') return '#0a0'
                    else return '#c00'
                } else return '#333'
            }
            text: Number.parseFloat(price).toFixed(2)
        }
        Image {
            x: t_price.x*2+t_price.width
            id: arr
            anchors.verticalCenter: t_price.verticalCenter
            source: {
                if (t_price_inc.text!=='') return arr_up
                else return arr_down
            }
            visible: {
                if (t_price_inc.text!=='' || t_price_dec.text!=='') return true
                else return false
            }
            sourceSize.width: parent.height*0.5
        }
        Text {
            id: t_price_inc
            x: t_price.x*3+t_price.width+arr.width
            anchors.top: arr.top
            font.pixelSize: parent.height*0.2
            color: '#0a0'
            text: price_inc
        }
        Text {
            id: t_price_dec
            x: t_price.x*3+t_price.width+arr.width
            anchors.bottom: arr.bottom
            font.pixelSize: parent.height*0.2
            color: '#c00'
            text: price_dec
        }
        Image {
            x: parent.width-t_price.x-this.width
            anchors.verticalCenter: parent.verticalCenter
            source: right_arr
            sourceSize.width: parent.height*0.5
        }
        MouseArea {
            anchors.fill: parent
            onClicked: view_ob(ticket)
        }
    }
}

