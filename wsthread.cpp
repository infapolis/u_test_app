#include <QString>
#include <QtWebSockets/QWebSocket>
#include <QCoreApplication>
#include "wsthread.h"

void WSThread::run()
{
    connect(&m_webSocket, &QWebSocket::connected, this, &WSThread::onConnected);
    connect(&m_webSocket, QOverload<const QList<QSslError>&>::of(&QWebSocket::sslErrors),
            this, &WSThread::onSslErrors);
}
void WSThread::receiveFromQml(QString qmlmes)
{
    if (qmlmes=="start") {
        m_webSocket.open(QUrl(QStringLiteral("wss://ws.bitmex.com/realtime/websocket?accessToken=sPVx5s3R1y94wcsHXxsD6VN4j-4NQngDaH7ZBds6ns8RBrHk")));
    } else {
        m_webSocket.sendTextMessage(qmlmes);
    }
}

void WSThread::onConnected()
{
    qDebug() << "WebSocket connected";
    connect(&m_webSocket, &QWebSocket::textMessageReceived,
            this, &WSThread::onTextMessageReceived);
}

void WSThread::onTextMessageReceived(QString message)
{
    emit sendToQml(message);
}

void WSThread::onSslErrors(const QList<QSslError> &errors)
{
    Q_UNUSED(errors);
    m_webSocket.ignoreSslErrors();
}

