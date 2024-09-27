#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "stringprocessorwrapper.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //Enregistrer le wrapper C++ pour qu'il soit accessible dans QML
    qmlRegisterType<StringProcessorWrapper>("StringProcessor", 1,0,"StringProcessorWrapper");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
