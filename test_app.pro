TEMPLATE = app
TARGET = test_app
QT += gui qml core quick quickcontrols2 svg websockets

target.path = /test_app
INSTALLS += target

SOURCES += \
    wsthread.cpp \
    main.cpp 

RESOURCES += \
    qml/main.qml \
    qml/TicketsList.qml \
    qml/OrderBook.qml

HEADERS += \
    wsthread.h 

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/OpenSSL/latest/arm64/libcrypto_1_1.so \
        $$PWD/OpenSSL/latest/arm64/libssl_1_1.so
}

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/OpenSSL/latest/arm64/libcrypto_1_1.so \
        $$PWD/OpenSSL/latest/arm64/libssl_1_1.so
}
