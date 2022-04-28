#ifndef WSTHREAD_H
#define WSTHREAD_H

#include <QThread>
#include <QtWebSockets/QWebSocket>

class WSThread : public QThread
{
   Q_OBJECT

protected:
   virtual void run();

private Q_SLOTS:
    void onConnected();
    void onTextMessageReceived(QString message);
    void onSslErrors(const QList<QSslError> &errors);

public slots:
    void receiveFromQml(QString);

signals:
   void sendToQml(QString);

private:
   QString mes;
   QWebSocket m_webSocket;
};

#endif // WSTHREAD_H
