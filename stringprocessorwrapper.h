#ifndef STRINGPROCESSORWRAPPER_H
#define STRINGPROCESSORWRAPPER_H

#include <QObject>
#include <QString>
#include "calculator.hpp"
#include <string>

class StringProcessorWrapper : public QObject
{
    Q_OBJECT
public:
    explicit StringProcessorWrapper(QObject *parent = nullptr);
    Calculator calculateProcess;
    Q_INVOKABLE QString processTheOperation(const QString &input);
    Q_INVOKABLE void setAngle(const QString &input);
    Q_INVOKABLE void setMode(const QString &input);
    Q_INVOKABLE QString getState();
};

#endif // STRINGPROCESSORWRAPPER_H
