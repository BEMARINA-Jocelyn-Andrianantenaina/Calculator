TEMPLATE = app

QT += qml quick
CONFIG += c++17

SOURCES += main.cpp \
    stringprocessorwrapper.cpp \
    calculator.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += stringprocessorwrapper.h \
    calculator.hpp
