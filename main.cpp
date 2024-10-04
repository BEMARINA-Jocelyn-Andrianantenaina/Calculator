#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QIcon>
#include "stringprocessorwrapper.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/images/projet-ENI-icon.png"));
    //Enregistrer le wrapper C++ pour qu'il soit accessible dans QML
    qmlRegisterType<StringProcessorWrapper>("StringProcessor", 1,0,"StringProcessorWrapper");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
