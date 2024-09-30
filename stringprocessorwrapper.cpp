#include "stringprocessorwrapper.h"

StringProcessorWrapper::StringProcessorWrapper(QObject *parent) : QObject(parent)
{

}
QString StringProcessorWrapper::processTheOperation(const QString &input) {
    //Convertir QString en std::string
    std::string inputStd = input.toStdString();
    //Appeler la fonction C++ independante
    std::string outputStd = calculateProcess.calculate(inputStd);
    //Convertir le resultat en QString pour le renvoyer à QML
    return QString::fromStdString(outputStd);
}
void StringProcessorWrapper::setAngle(const QString &input) {
    std::string inputStd = input.toStdString();
    char inputChr = inputStd[0];
    calculateProcess.setAngle(inputChr);
}
void StringProcessorWrapper::setMode(const QString &input) {
    std::string inputStd = input.toStdString();
    char inputChr = inputStd[0];
    calculateProcess.setMode(inputChr);
}
QString StringProcessorWrapper::getState(){
    char stateChr= calculateProcess.getState();
    QString stateQstring = QString(stateChr);
    return stateQstring;
}
