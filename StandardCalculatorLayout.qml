import QtQuick 2.0
import StringProcessor 1.0

Item {
    id: root
    property int idNumber
    property bool visibleLayout
    property int layoutWidth
    property int layoutHeight
    property alias textInputFieldReset: inputField
    property alias textBufferedFieldReset: bufferedOperationArea
    property bool darkMode: true
    property real radiusWindow: 15

    visible: visibleLayout
    FontLoader {
        id: jetbrainsFont
        source: "fonts/JetBrainsMono-Regular.ttf"
    }
    Rectangle {
        width: layoutWidth
        height: layoutHeight
        color: root.darkMode ? "#111111":"#ffffff"
        Rectangle {
            anchors.centerIn: parent
            width: parent.width*0.80
            height: parent.height*0.80
            radius: root.radiusWindow
            color: root.darkMode ? "#573826":"#fef3ec"
            Column {
                height: parent.height
                width: parent.width
                anchors.centerIn: parent
                Rectangle {
                    id: topArea
                    width: parent.width*0.75
                    height: parent.height*0.35
                    anchors {
                        top: parent.top
                        right: parent.right
                        left: parent.left
                    }
                    color: root.darkMode ? "#573826":"#fef3ec"
                    radius: root.radiusWindow
                    Column {
                        width: parent.width*0.95
                        height: parent.height
                        anchors.centerIn: parent
                        Rectangle {
                            id: bufferedOperation
                            width: parent.width
                            anchors {
                                top: parent.top
                                right: parent.right
                                left: parent.left
                            }
                            color: root.darkMode ? "#573826":"#fef3ec"
                            height: parent.height*0.15

                            TextInput {
                                id: bufferedOperationArea
                                text: ""
                                color: root.darkMode ? "white":"black"
                                font.pixelSize: parent.height*0.8
                                width: parent.width
                                horizontalAlignment: TextInput.AlignRight
                                font.family: jetbrainsFont.name
                                clip: true
                                inputMethodHints: Qt.ImhDigitsOnly
                                readOnly: true
                                focus: false
                                onTextChanged: {
                                    if(visibleLayout === false){
                                        bufferedOperationArea.text = ""
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: inputArea
                            width: parent.width
                            anchors {
                                top: bufferedOperation.bottom
                                right: parent.right
                                left: parent.left
                                bottom: memoryManagementArea.top
                            }
                            color: root.darkMode ? "#573826":"#fef3ec"
                            height: parent.height - memoryManagementArea.height
                            TextInput {
                                id: inputField
                                text: "0"
                                color: root.darkMode ? "#fef3ec":"#573826"
                                font.pixelSize: parent.height*0.8
                                width: parent.width*0.95
                                horizontalAlignment: TextInput.AlignRight
                                clip: true
                                font.family: jetbrainsFont.name
                                inputMethodHints: Qt.ImhDigitsOnly
                                readOnly: true
                                focus: visibleLayout ? true : false
                                onTextChanged: {
                                    if(inputField.text === ""){
                                        inputField.text = "0"
                                    }
                                    if(inputField.text.length > 1 && inputField.text.charAt(0) === "0" && inputField.text.charAt(1) === "."){
                                        inputField.text = inputField.text
                                    } else if (inputField.text.length > 1 && inputField.text.charAt(0) === "0"){
                                        inputField.text = inputField.text.slice(1)
                                    }
                                }

                            }
                        }
                        Rectangle {
                            id: memoryManagementArea
                            width: parent.width
                            height: parent.height*0.35
                            anchors {
                                right: parent.right
                                left: parent.left
                                bottom: parent.bottom
                            }
                            color: root.darkMode ? "#573826":"#fef3ec"
                            Row {
                                id: row
                                anchors.centerIn: parent
                                height: parent.height*0.8
                                width: parent.width*0.8
                                spacing: 5
                                Repeater {
                                    model: ["MC", "MR", "M+", "M-", "MS"]
                                    Rectangle {
                                        id: memo
                                        width: (parent.width - (4 * row.spacing))/5
                                        height: parent.height
                                        radius: root.radiusWindow
                                        color: root.darkMode ? "#fef3ec":"#573826"
                                        ButtonCustom {
                                            anchors.fill: parent
                                            textBtn: "" + modelData
                                            modeEnabled: root.darkMode
                                            fontBtn: jetbrainsFont.name
                                            colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                            radiusBtn: memo.radius
                                            fontSize: parent.height*0.50

                                        }

                                    }
                                }
                            }
                        }
                    }

                }
            }
            Rectangle {
                id: bottomArea
                width: parent.width*0.95
                height: parent.height - topArea.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors {
                    top: topArea.bottom
//                    right: parent.right
//                    left: parent.left
                    bottom: parent.bottom
                }
                color: root.darkMode ? "#573826":"#fef3ec"
                Grid {
                    id: grid
                    rows: if (root.height <= 600 && root.width <= 600){
                              return 6
                          }else {
                              return 5
                          }

                    columns: 10 - grid.rows
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: parent.height*0.95
                    Repeater {
                        model: if (root.height <= 600 && root.width <= 600){
                                   return ["(",")", "\u221A","x<sup>2</sup>","CE", "C", "Del", "\u00F7",  "7", "8", "9", "*", "4", "5", "6","-", "1", "2", "3", "+",  "+/-", "0", ".", "="]
                               }else {
                                   return ["\u221A", "CE", "C", "Del", "\u00F7", "x<sup>2</sup>", "7", "8", "9", "*", "x<sup>3</sup>" ,"4", "5", "6","-", "+/-","1", "2", "3", "+", "(",")", "0", ".", "="]
                               }

                        Rectangle {
                            id: buttons
                            width: if (grid.rows === 6){
                                       return ((grid.width - (3 * grid.spacing)) / 4)
                                   }else {
                                       return ((grid.width - (4 * grid.spacing)) / 5)
                                   }

                            height: if (grid.columns === 4){
                                        return ((grid.height - (5 * grid.spacing)) / 6)
                                    } else {
                                        return ((grid.height - (4 * grid.spacing)) / 5)
                                    }
                            radius: root.radiusWindow

                            color: root.darkMode ? "#fef3ec":"#573826"

                            ButtonCustom {
                                id: numericAndOperation
                                anchors.fill: parent
                                modeEnabled: root.darkMode
                                radiusBtn: buttons.radius
                                textBtn: "" + modelData
                                fontBtn: jetbrainsFont.name
                                colorBtn:actionsOfTheStandardLayout.buttonColorSelector(root.darkMode, numericAndOperation.textBtn, buttons.color)
                                fontSize: 25
                                onClicked: actionsOfTheStandardLayout.btnActionToInput(textBtn)
                            }
                        }
                    }
                }
            }
        }


    }
    Keys.onReleased:{
        switch (event.key) {
            case Qt.Key_0:
                actionsOfTheStandardLayout.btnActionToInput("0");
                break;
            case Qt.Key_1:
                actionsOfTheStandardLayout.btnActionToInput("1");
                break;
            case Qt.Key_2:
                actionsOfTheStandardLayout.btnActionToInput("2");
                break;
            case Qt.Key_3:
                actionsOfTheStandardLayout.btnActionToInput("3");
                break;
            case Qt.Key_4:
                actionsOfTheStandardLayout.btnActionToInput("4");
                break;
            case Qt.Key_5:
                actionsOfTheStandardLayout.btnActionToInput("5");
                break;
            case Qt.Key_6:
                actionsOfTheStandardLayout.btnActionToInput("6");
                break;
            case Qt.Key_7:
                actionsOfTheStandardLayout.btnActionToInput("7");
                break;
            case Qt.Key_8:
                actionsOfTheStandardLayout.btnActionToInput("8");
                break;
            case Qt.Key_9:
                actionsOfTheStandardLayout.btnActionToInput("9");
                break;
            case Qt.Key_Plus:
                actionsOfTheStandardLayout.btnActionToInput("+");
                break;
            case Qt.Key_Minus:
                actionsOfTheStandardLayout.btnActionToInput("-");
                break;
            case Qt.Key_Asterisk:
                actionsOfTheStandardLayout.btnActionToInput("*");
                break;
            case Qt.Key_Slash:
                actionsOfTheStandardLayout.btnActionToInput("/");
                break;
            case Qt.Key_Enter:
                actionsOfTheStandardLayout.btnActionToInput("=");
                break;
            case Qt.Key_Backspace:
                actionsOfTheStandardLayout.btnActionToInput("Del");
                break;
            default:
                break;
        }
    }
    StringProcessorWrapper {
        id: process
    }
    QtObject {
        id: actionsOfTheStandardLayout
        property string textToSend
        property string tempResult
//        property string stringToDisplay : " Worked!"
        function buttonColorSelector(mode, buttonText, buttonColor){
            if(mode === true){
                if(buttonText === "=") {
                    return "#6c63ff"
                }else if(buttonText === "0" || buttonText === "1" || buttonText === "2" ||buttonText === "3" ||buttonText === "4" ||buttonText === "5" ||buttonText === "6" ||buttonText === "7" ||buttonText === "8" ||buttonText === "9"){
                    return Qt.lighter(Qt.lighter("#573826"))
                } else {
                    return buttonColor
                }
            } else {
                if(buttonText === "=") {
                    return "#6c63ff"
                }else if(buttonText === "0" || buttonText === "1" || buttonText === "2" ||buttonText === "3" ||buttonText === "4" ||buttonText === "5" ||buttonText === "6" ||buttonText === "7" ||buttonText === "8" ||buttonText === "9"){
                    return Qt.lighter(buttonColor)
                } else {
                    return buttonColor
                }
            }
        }

        function btnActionToInput(stringToWork){
            var recievedText = ""
            var listOfBasicOperator = ["+","-","*","/"]
            if (inputField.text.length === 1 && inputField.text === "0" && stringToWork !== "0"){
                inputField.text = ""
            } else if (inputField.text.length === 1 && inputField.text === "0" && stringToWork === "0") {
                inputField.text = "0"
            }
            if(tempResult=== inputField.text && (stringToWork !== "+" && stringToWork !== "-" && stringToWork !== "+" && stringToWork !== "\u00F7")){
                inputField.text = ""
            }

            if (stringToWork === "\u221A"){
                if(inputField.text.length > 0 && (inputField.text[inputField.text.length - 1] === "+" || inputField.text[inputField.text.length - 1] === "-" || inputField.text[inputField.text.length - 1] === "*" || inputField.text[inputField.text.length - 1] === "/" || inputField.text[inputField.text.length - 1] === "(" || inputField.text[inputField.text.length - 1] === "0")){
                    inputField.text += "\u221A("
                    actionsOfTheStandardLayout.textToSend += "2$("
                } else {
                    actionsOfTheStandardLayout.btnActionToInput("*")
                    inputField.text += "\u221A("
                    actionsOfTheStandardLayout.textToSend += "*"
                    actionsOfTheStandardLayout.textToSend += "2$("
                }
            }else if (stringToWork === "<sup>y</sup>\u221A"){
                if(inputField.text.length > 0 && (inputField.text[inputField.text.length - 1] === "+" || inputField.text[inputField.text.length - 1] === "-" || inputField.text[inputField.text.length - 1] === "*" || inputField.text[inputField.text.length - 1] === "/" || inputField.text[inputField.text.length - 1] === "(" )){
                    inputField.text += "\u221A("
                    actionsOfTheStandardLayout.textToSend += "2$("
                } else {
                    inputField.text += "\u221A("
                    actionsOfTheStandardLayout.textToSend += "$("
                }
            }else if (stringToWork === "x<sup>2</sup>"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    inputField.text += "0^2"
                    actionsOfTheStandardLayout.textToSend += "0^2"
                }else {
                    inputField.text += "^2"
                    actionsOfTheStandardLayout.textToSend += "^2"
                }
            }else if (stringToWork === "x<sup>3</sup>"){
                inputField.text += "^3"
                actionsOfTheStandardLayout.textToSend += "^3"
            }else if (stringToWork === "n!"){
                inputField.text += "!"
                actionsOfTheStandardLayout.textToSend += "!"
            }else if (stringToWork === "\u00F7"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "/"
                    actionsOfTheStandardLayout.textToSend += "0/"
                    inputField.text = "0"
                }else {
                    if(inputField.text.length > 0 && tempResult === inputField.text){
                        inputField.text = "0"
                        bufferedOperationArea.text += "Ans/"
                        actionsOfTheStandardLayout.textToSend += "A/"
                    }else {
                        bufferedOperationArea.text += inputField.text + "/"
                        actionsOfTheStandardLayout.textToSend += "/"
                        inputField.text = "0"
                    }
                }
            }else if (stringToWork === "*"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "*"
                    actionsOfTheStandardLayout.textToSend += "0*"
                    inputField.text = "0"
                }else {
                    if(inputField.text.length > 0 && tempResult ===inputField.text){
                        inputField.text = "0"
                        bufferedOperationArea.text += "Ans*"
                        actionsOfTheStandardLayout.textToSend += "A*"
                    }else {
                        bufferedOperationArea.text += inputField.text + "*"
                        actionsOfTheStandardLayout.textToSend += "*"
                        inputField.text = "0"
                    }

                }
            }else if (stringToWork === "-"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "-"
                    actionsOfTheStandardLayout.textToSend += "0-"
                    inputField.text = "0"
                }else {
                    if(inputField.text.length > 0 && tempResult ===inputField.text){
                        inputField.text = "0"
                        bufferedOperationArea.text += "Ans-"
                        actionsOfTheStandardLayout.textToSend += "A-"
                    }else {
                        bufferedOperationArea.text += inputField.text + "-"
                        actionsOfTheStandardLayout.textToSend += "-"
                        inputField.text = "0"
                    }
                }
            }else if (stringToWork === "+"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "+"
                    actionsOfTheStandardLayout.textToSend += "0+"
                    inputField.text = "0"
                }else {
                    if(inputField.text.length > 0 && tempResult ===inputField.text){
                        bufferedOperationArea.text += "Ans+"
                        actionsOfTheStandardLayout.textToSend += "A+"
                        inputField.text = "0"
                    }else {
                        bufferedOperationArea.text += inputField.text + "+"
                        actionsOfTheStandardLayout.textToSend += "+"
                        inputField.text = "0"
                    }
                }
            }else if (stringToWork === "CE"){
                actionsOfTheStandardLayout.textToSend = actionsOfTheStandardLayout.textToSend.slice(0, -inputField.text.length)
                inputField.text = "0"
            }else if (stringToWork === "HYP"){
                root.hypMode = !root.hypMode
            }else if (stringToWork === "C"){
                inputField.text = "0"
                bufferedOperationArea.text = ""
                actionsOfTheStandardLayout.textToSend = ""
            }else if (stringToWork === "Del"){
                 if(inputField.text[inputField.text.length - 1] === "(" && inputField.text[inputField.text.length - 2] === "-"){
                    inputField.text = inputField.text.slice(0, -2)
                    actionsOfTheStandardLayout.textToSend = actionsOfTheStandardLayout.textToSend.slice(0, -4)
                }else {
                    inputField.text = inputField.text.slice(0, -1)
                    actionsOfTheStandardLayout.textToSend = actionsOfTheStandardLayout.textToSend.slice(0, -1)
                }
            }else if (stringToWork === "Mod"){
                bufferedOperationArea.text += inputField.text +"Mod"
                actionsOfTheStandardLayout.textToSend += "%"
                inputField.text = "0"
            }else if (stringToWork === "ln"){
                inputField.text += "ln("
                actionsOfTheStandardLayout.textToSend += "ln("
            }else if (stringToWork === "log"){
                inputField.text += "log("
                actionsOfTheStandardLayout.textToSend += "log("
            }else if (stringToWork === "Exp"){
                inputField.text += "exp("
                actionsOfTheStandardLayout.textToSend += "exp("
            }else if (stringToWork === "x<sup>y</sup>"){
                bufferedOperationArea.text += inputField.text + "^"
                actionsOfTheStandardLayout.textToSend += "^"
                inputField.text = "0"
            }else if (stringToWork === "sin"){
                inputField.text += "sin("
                actionsOfTheStandardLayout.textToSend += "sin("
            }else if (stringToWork === "cos"){
                inputField.text += "cos("
                actionsOfTheStandardLayout.textToSend += "cos("
            }else if (stringToWork === "tan"){
                inputField.text += "tan("
                actionsOfTheStandardLayout.textToSend += "tan("
            }else if (stringToWork === "sin<sup>-1</sup>"){
                inputField.text += "asin("
                actionsOfTheStandardLayout.textToSend += "asin("
            }else if (stringToWork === "cos<sup>-1</sup>"){
                inputField.text += "acos("
                actionsOfTheStandardLayout.textToSend += "acos("
            }else if (stringToWork === "tan<sup>-1</sup>"){
                inputField.text += "atan("
                actionsOfTheStandardLayout.textToSend += "atan("
            }else if (stringToWork === "sinh"){
                inputField.text += "sinh("
                actionsOfTheStandardLayout.textToSend += "sh("
            }else if (stringToWork === "cosh"){
                inputField.text += "cosh("
                actionsOfTheStandardLayout.textToSend += "ch("
            }else if (stringToWork === "tanh"){
                inputField.text += "tanh("
                actionsOfTheStandardLayout.textToSend += "th("
            }else if (stringToWork === "sinh<sup>-1</sup>"){
                inputField.text += "asinh("
                actionsOfTheStandardLayout.textToSend += "ash("
            }else if (stringToWork === "cosh<sup>-1</sup>"){
                inputField.text += "acosh("
                actionsOfTheStandardLayout.textToSend += "ach("
            }else if (stringToWork === "tanh<sup>-1</sup>"){
                inputField.text += "atanh("
                actionsOfTheStandardLayout.textToSend += "ath("
            }else if (stringToWork === "abs"){
                inputField.text += "abs("
                actionsOfTheStandardLayout.textToSend += "abs("
            }else if (stringToWork === "ceil"){
                inputField.text += "ceil("
                actionsOfTheStandardLayout.textToSend += "ceil("
            }else if (stringToWork === "floor"){
                inputField.text += "floor("
                actionsOfTheStandardLayout.textToSend += "floor("
            }else if (stringToWork === "round"){
                inputField.text += "round("
                actionsOfTheStandardLayout.textToSend += "round("
            }else if (stringToWork === "+/-"){
                inputField.text += "-("
                actionsOfTheStandardLayout.textToSend += "-1*("
            }else if (stringToWork === "10<sup>x</sup>"){
                inputField.text += "10^"
                actionsOfTheStandardLayout.textToSend += "10^"
            }else if (stringToWork === "pi"){
                inputField.text += "pi"
                actionsOfTheStandardLayout.textToSend += "P"
            }else if (stringToWork === "|x|"){
                inputField.text += "abs("
                actionsOfTheStandardLayout.textToSend += "abs("
            }else if (stringToWork === "e<sup>x</sup>"){
                inputField.text += "exp("
                actionsOfTheStandardLayout.textToSend += "exp("
            }else if (stringToWork === "Ans"){
                inputField.text += "Ans"
                actionsOfTheStandardLayout.textToSend += "A"
            }else if (stringToWork === "1/x"){
                inputField.text += "1/("
                actionsOfTheStandardLayout.textToSend += "1/("
            }else if(stringToWork === "=") {
                if (inputField.text.length === 1 && inputField.text === "0") {
                    actionsOfTheStandardLayout.textToSend += "0"
                }
                recievedText = process.processTheOperation(actionsOfTheStandardLayout.textToSend)
                inputField.text = recievedText
                tempResult = recievedText
                actionsOfTheStandardLayout.textToSend = ""
                bufferedOperationArea.text = ""
            }else{
                if (inputField.text.length === 1 && inputField.text === "0" && stringToWork === "0") {
                    inputField.text = "0"
                } else {
                    inputField.text += stringToWork
                    actionsOfTheStandardLayout.textToSend += stringToWork
                }
            }
        }

    }
}
