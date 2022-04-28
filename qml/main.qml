import QtQml 2.15
import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQml.Models 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    property string arr_up: 'data:image/svg+xml;utf8,<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="#00aa00"><path d="M8.70252842,0.47628569 L15.1895201,7.12866584 C15.5110623,7.51025512 15.5442154,8.05211791 15.2596267,8.49614286 L15.1818429,8.60496144 L8.9068379,15.4762857 L7.93120592,14.5853227 L13.477,8.51328569 L1,8.51348395 L1,7.19224483 L13.408,7.19128569 L7.75676019,1.39888814 L8.70252842,0.47628569 Z" transform="translate(8.226760, 7.976286) scale(1, -1) rotate(90.000000) translate(-8.226760, -7.976286) "></path></svg>'
    property string arr_down: 'data:image/svg+xml;utf8,<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="#cc0000"><path d="M8.70252842,0.47628569 L15.1895201,7.12866584 C15.5110623,7.51025512 15.5442154,8.05211791 15.2596267,8.49614286 L15.1818429,8.60496144 L8.9068379,15.4762857 L7.93120592,14.5853227 L13.477,8.51328569 L1,8.51348395 L1,7.19224483 L13.408,7.19128569 L7.75676019,1.39888814 L8.70252842,0.47628569 Z" transform="translate(8.226760, 7.976286) rotate(90.000000) translate(-8.226760, -7.976286) "></path></svg>'
    property string right_arr: 'data:image/svg+xml;utf8,<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#ccc"><g><polygon points="5.8,19.5 13.5,12 5.8,4.3 8.2,2 18.2,12 8.2,22"/></g></svg>'
    property string back_arr: 'data:image/svg+xml;utf8,<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#333"><g><path d="M20,11H7.8l5.6-5.6L12,4l-8,8l8,8l1.4-1.4L7.8,13H20V11z"/></g></svg>'

    property variant tickets: ["XBTUSD", "ETHUSD", "AVAXUSD", "METAMEXTUSDT", "SOLUSD", "LTCUSD", "LUNAUSD", "BCHUSD", "ALTMEXTUSDT", "BNBUSD"]
    property string tickets_request_str: ""
    property string orerbook_request_str: ""
    ListModel {id: ticketModel}
    ListModel {id: bidsModel}
    ListModel {id: asksModel}

    function fin(symbol, num) {
        for (var i=0; i<ticketModel.count; i++) {
            if (ticketModel.get(i).ticket===symbol) {
                var last=Number.parseFloat(ticketModel.get(i).price)
                var curr=Number.parseFloat(num).toFixed(2)
                ticketModel.set(i, {"price":curr})
                if (last!==0 && last!==curr) {
                    if (last>curr) {
                        ticketModel.set(i, {"price_inc":""})
                        ticketModel.set(i, {"price_dec":Number.parseFloat(last-curr).toFixed(2)})
                    } else {
                        ticketModel.set(i, {"price_inc":Number.parseFloat(curr-last).toFixed(2)})
                        ticketModel.set(i, {"price_dec":""})
                    }
                }
            }
        }
    }
    function view_ob (ticket) {
        bidsModel.clear()
        asksModel.clear()
        order_book.ob_ticket=ticket
        wsThread.receiveFromQml('{"op": "subscribe", "args": ["orderBook10:'+ticket+'"]}')
        main_stack.currentIndex=1
    }
    function close_ob() {
        main_stack.currentIndex=0
        wsThread.receiveFromQml('{"op": "unsubscribe", "args": ["orderBook10:'+order_book.ob_ticket+'"]}')
        order_book.ob_ticket=""
    }

    Connections {
        target: wsThread
        function onSendToQml(mes) {
            var json=JSON.parse(mes);
            if (json.info && json.info==="Welcome to the BitMEX Realtime API.") wsThread.receiveFromQml(tickets_request_str)
            if (json.table && json.action) {
                if (json.table==="instrument" && json.action==="update") {
                    if (json.data[0].lastPriceProtected) fin(json.data[0].symbol, json.data[0].lastPriceProtected)
                    if (json.data[0].lastPrice) fin(json.data[0].symbol, json.data[0].lastPrice)
                    if (json.data[0].fairPrice) fin(json.data[0].symbol, json.data[0].fairPrice)
                }
                if (json.table==="orderBook10") {
                    var i
                    if (json.action==="partial") {
                        for (i=0; i<10; i++) {
                            bidsModel.append({"price": json.data[0].bids[i][0], "size": json.data[0].bids[i][1]});
                            asksModel.append({"price": json.data[0].asks[i][0], "size": json.data[0].asks[i][1]});
                        }
                    } else if (json.action==="update") {
                        for (i=0; i<10; i++) {
                            bidsModel.set(i, {"price": json.data[0].bids[i][0], "size": json.data[0].bids[i][1]});
                            asksModel.set(i, {"price": json.data[0].asks[i][0], "size": json.data[0].asks[i][1]});
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        tickets_request_str='{"op": "subscribe", "args": ['
        for (var i=0; i<tickets.length; i++) {
            if (i>0) tickets_request_str+=','
            tickets_request_str+='"instrument:'+tickets[i]+'"'
            ticketModel.append({"ticket": tickets[i], "price": "0.00", "price_inc": "", "price_dec": ""});
        }
        tickets_request_str+=']}'
        wsThread.receiveFromQml("start")
    }

    id: main_win
    width: 360; height: 540
    visible: true
    title: "Test_App"
    StackLayout {
        id: main_stack
        anchors.fill: parent
        currentIndex: 0
        TicketsList {id: tickets_list}
        OrderBook {id: order_book}
    }
}
