TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp \
    string_processor.cpp \
    stringprocessorwrapper.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    string_processor.h \
    stringprocessorwrapper.h
