#ifndef STRINGPROCESSORWRAPPER_H
#define STRINGPROCESSORWRAPPER_H

#include <QObject>
#include <QString>
#include "string_processor.h"

class StringProcessorWrapper : public QObject
{
    Q_OBJECT
public:
    explicit StringProcessorWrapper(QObject *parent = nullptr);

    Q_INVOKABLE QString process(const QString &input) {
        //Convertir QString en std::string
        std::string inputStd = input.toStdString();
        //Appeler la fonction C++ independante
        std::string outputStd = processString(inputStd);
        //Convertir le resultat en QString pour le renvoyer à QML
        return QString::fromStdString(outputStd);
    }
};

#endif // STRINGPROCESSORWRAPPER_H
