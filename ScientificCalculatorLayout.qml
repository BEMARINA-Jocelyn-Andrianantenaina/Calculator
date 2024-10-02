import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
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
    property var listHypMode: ["x<sup>2</sup>", "HYP","sinh","cosh", "tanh","CE", "C", "Del", "\u00F7", "x<sup>3</sup>", "x<sup>y</sup>","sinh<sup>-1</sup>", "cosh<sup>-1</sup>", "tanh<sup>-1</sup>", "7", "8", "9", "*", "\u221A","<sup>y</sup>\u221A", "10<sup>x</sup>", "log", "e<sup>x</sup>","4", "5", "6","-","1/x", "|x|", "ln","n!","Mod", "1", "2", "3", "+", "Ans", "pi","(",")","+/-",  ".","0", "="]
    property var listNonHypMode: ["x<sup>2</sup>", "HYP","sin","cos", "tan","CE", "C", "Del", "\u00F7", "x<sup>3</sup>", "x<sup>y</sup>","sin<sup>-1</sup>", "cos<sup>-1</sup>", "tan<sup>-1</sup>", "7", "8", "9", "*", "\u221A","<sup>y</sup>\u221A", "10<sup>x</sup>", "log", "e<sup>x</sup>","4", "5", "6","-","1/x", "|x|", "ln","n!","Mod", "1", "2", "3", "+", "Ans", "pi","(",")","+/-",  ".","0", "="]
    property bool hypMode: false
    visible: visibleLayout
    FontLoader {
        id: jetbrainsFont
        source: "fonts/JetBrainsMono-Regular.ttf"
    }
    Rectangle {
        width: layoutWidth
        height: layoutHeight
        color:root.darkMode ? "#111111":"#ffffff"
        Rectangle {
            anchors.centerIn: parent
            width: parent.width*0.95
            height: parent.height*0.95
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
                    Row {
                        visible: true
                        height: parent.height*0.20
                        width: parent.width*0.45
                        z:1
                        Rectangle{
                            id: degreModeSwitcher
                            width: parent.width/3
                            height: parent.height/2
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                left: parent.left
                            }

                            color: root.darkMode ? "#573826":"#fef3ec"
                            ButtonCustom{
                                id: degreModeBtn
                                anchors.fill: parent
                                textBtn: "DEG"
                                modeEnabled: root.darkMode
                                fontBtn: jetbrainsFont.name
                                colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                radiusBtn: 10
                                fontSize: parent.width*(1/degreModeBtn.textBtn.length)
                                onClicked: {
                                    if(degreMode.visible === false){
                                        degreMode.visible = true
                                        degreModeList.visible = true
                                        operationMode.visible = false
                                        operationModeList.visible = false
                                        functionButtonWindowDisplayed.visible = false
                                        functionList.visible = false
                                    } else {
                                        degreMode.visible = false
                                        degreModeList.visible = false
                                    }
                                }
                            }

                        }
                        Rectangle{
                            id: degreMode
                            color: root.darkMode ? "#573826":"#fef3ec"
                            anchors {
                                top: degreModeSwitcher.bottom
                                left: degreModeSwitcher.left
                            }
                            radius: root.radiusWindow
                            width:parent.width
                            height: parent.height
                            visible: false
                            Row{
                                id: degreModeList
                                anchors.fill: parent
                                visible: false
                                ButtonCustom{
                                    id: degre
                                    width: parent.width/3
                                    textBtn: "DEG"
                                    anchors{
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: parent.left
                                    }
                                    radiusBtn: degreMode.radius - 5
                                    modeEnabled: root.darkMode
                                    fontBtn: jetbrainsFont.name
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: degre.width*(1/degre.textBtn.length)
                                    onClicked: {
                                        process.setAngle("D")
                                        degreModeBtn.textBtn = degre.textBtn
                                        degreMode.visible = false
                                        degreModeList.visible = false
                                    }
                                }
                                ButtonCustom{
                                    id: radient
                                    width: parent.width/3
                                    textBtn: "RAD"
                                    anchors{
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: degre.right
                                    }
                                    radiusBtn: degreMode.radius - 5
                                    modeEnabled: root.darkMode
                                    fontBtn: jetbrainsFont.name
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: radient.width*(1/radient.textBtn.length)
                                    onClicked: {
                                        process.setAngle("R")
                                        degreModeBtn.textBtn = radient.textBtn
                                        degreMode.visible = false
                                        degreModeList.visible = false
                                    }
                                }
                                ButtonCustom{
                                    id: grade
                                    width: parent.width/3
                                    textBtn: "GRA"
                                    anchors{
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: radient.right
                                        right: parent.right
                                    }
                                    radiusBtn: degreMode.radius - 5
                                    modeEnabled: root.darkMode
                                    fontBtn: jetbrainsFont.name
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: grade.width*(1/grade.textBtn.length)
                                    onClicked: {
                                        process.setAngle("G")
                                        degreModeBtn.textBtn = grade.textBtn
                                        degreMode.visible = false
                                        degreModeList.visible = false
                                    }
                                }
                            }
                        }

                        Rectangle{
                            id: swicthingButton
                            width: parent.width/3
                            height: parent.height/2
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                left: degreModeSwitcher.right
                            }
                            color: root.darkMode ? "#573826":"#fef3ec"
                            ButtonCustom{
                                id: opMethMode
                                anchors.fill: parent
                                textBtn: "Normal"
                                fontBtn: jetbrainsFont.name
                                modeEnabled: root.darkMode
                                colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                radiusBtn: 10
                                fontSize: opMethMode.width*(1/opMethMode.textBtn.length)
                                onClicked: {
                                    if(operationMode.visible === false){
                                        operationMode.visible = true
                                        operationModeList.visible = true
                                        degreMode.visible = false
                                        degreModeList.visible = false
                                        functionButtonWindowDisplayed.visible = false
                                        functionList.visible = false
                                    } else {
                                        operationMode.visible = false
                                        operationModeList.visible = false
                                    }
                                }
                            }

                        }
                        Rectangle{
                            id: operationMode
                            color:root.darkMode ? "#573826":"#fef3ec"
                            anchors {
                                top: swicthingButton.bottom
                                left: swicthingButton.left
                            }
                            radius: root.radiusWindow
                            width:parent.width
                            height: parent.height
                            visible: false
                            Row{
                                id: operationModeList
                                anchors.fill: parent

                                visible: false
                                ButtonCustom{
                                    id: normal
                                    width: parent.width/3
                                    textBtn: "Normal"
                                    anchors{
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: parent.left
                                    }
                                    fontBtn: jetbrainsFont.name
                                    radiusBtn: operationMode.radius - 5
                                    modeEnabled: root.darkMode
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: normal.width*(1/normal.textBtn.length)
                                    onClicked: {
                                        process.setMode("N")
                                        opMethMode.textBtn = normal.textBtn
                                        operationMode.visible = false
                                        operationModeList.visible = false
                                    }
                                }
                                ButtonCustom{
                                    id: scientificLy
                                    width: parent.width/3
                                    textBtn: "F-E"
                                    anchors{
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: normal.right
                                    }
                                    fontBtn: jetbrainsFont.name
                                    modeEnabled: root.darkMode
                                    radiusBtn: operationMode.radius - 5
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: scientificLy.width*(1/scientificLy.textBtn.length)
                                    onClicked: {
                                        process.setMode("F")
                                        opMethMode.textBtn = scientificLy.textBtn
                                        operationMode.visible = false
                                        operationModeList.visible = false
                                    }
                                }
                                ButtonCustom{
                                    id: dmsMode
                                    width: parent.width/3
                                    textBtn: "dms"
                                    anchors{
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: radient.left
                                        right: parent.right
                                    }
                                    fontBtn: jetbrainsFont.name
                                    radiusBtn: operationMode.radius - 5
                                    modeEnabled: root.darkMode
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: dmsMode.width*(1/dmsMode.textBtn.length)
                                    onClicked: {
                                        process.setMode("D")
                                        opMethMode.textBtn = dmsMode.textBtn
                                        operationMode.visible = false
                                        operationModeList.visible = false
                                    }
                                }
                            }
                        }
                        Rectangle{
                            id: functionButtonArea
                            width: parent.width/3
                            height: parent.height/2
                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                right: parent.right
                                left: swicthingButton.right
                            }
                            color: root.darkMode ? "#573826":"#fef3ec"
                            ButtonCustom{
                                id: functionButtonDisplay
                                anchors.fill: parent
                                textBtn: "Function"
                                fontBtn: jetbrainsFont.name
                                modeEnabled: root.darkMode
                                colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                radiusBtn: 10
                                fontSize: parent.width*(1/functionButtonDisplay.textBtn.length)
                                onClicked: {
                                    if(functionButtonWindowDisplayed.visible === false){
                                        functionButtonWindowDisplayed.visible = true
                                        functionList.visible = true
                                        operationMode.visible = false
                                        operationModeList.visible = false
                                        degreMode.visible = false
                                        degreModeList.visible = false
                                    } else {
                                        functionButtonWindowDisplayed.visible = false
                                        functionList.visible = false
                                    }
                                }
                            }

                        }
                        Rectangle{
                            id: functionButtonWindowDisplayed
                            color:root.darkMode ? "#fef3ec":"#573826"
                            anchors {
                                top: functionButtonArea.bottom
                                left: functionButtonArea.left
                            }
                            radius: root.radiusWindow
                            width:parent.width/3
                            height: parent.height*3
                            visible: false
                            Column{
                                id: functionList
                                width: parent.width
                                height: parent.height
                                visible: false
                                ButtonCustom{
                                    id: roundFunction
                                    height: parent.height/3
                                    textBtn: "round"
                                    anchors{
                                        top: functionList.top
                                        left: functionList.left
                                        right: functionList.right
                                    }
                                    fontBtn: jetbrainsFont.name
                                    modeEnabled: root.darkMode
                                    radiusBtn: operationMode.radius - 5
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: roundFunction.width*(1/roundFunction.textBtn.length)
                                    onClicked: {
                                        actionsOfTheStandardLayout.btnActionToInput(roundFunction.textBtn)
                                        functionButtonWindowDisplayed.visible = false
                                        functionList.visible = false
                                    }
                                }
                                ButtonCustom{
                                    id: floorFunction
                                    height: parent.height/3
                                    textBtn: "floor"
                                    anchors{
                                        top: roundFunction.bottom
                                        left: functionList.left
                                        right: functionList.right
                                    }
                                    fontBtn: jetbrainsFont.name
                                    radiusBtn: operationMode.radius - 5
                                    modeEnabled: root.darkMode
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: floorFunction.width*(1/floorFunction.textBtn.length)
                                    onClicked: {
                                        actionsOfTheStandardLayout.btnActionToInput(floorFunction.textBtn)
                                        functionButtonWindowDisplayed.visible = false
                                        functionList.visible = false
                                    }
                                }
                                ButtonCustom{
                                    id: ceilFunction
                                    height: parent.height/3
                                    textBtn: "ceil"
                                    anchors{
                                        top: floorFunction.bottom
                                        bottom: parent.bottom
                                        left: parent.left
                                        right: parent.right
                                    }
                                    fontBtn: jetbrainsFont.name
                                    radiusBtn: operationMode.radius - 5
                                    modeEnabled: root.darkMode
                                    colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                    fontSize: ceilFunction.width*(1/ceilFunction.textBtn.length)
                                    onClicked: {
                                        actionsOfTheStandardLayout.btnActionToInput(ceilFunction.textBtn)
                                        functionButtonWindowDisplayed.visible = false
                                        functionList.visible = false
                                    }
                                }
                            }
                        }
                    }
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
                                clip: true
                                inputMethodHints: Qt.ImhDigitsOnly
                                readOnly: true
                                focus: false
                                font.family: jetbrainsFont.name
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
                                //bottom: memoryManagementArea.top
                            }
                            color: root.darkMode ? "#573826":"#fef3ec"
                            height: parent.height - parent.height*0.40
                            z:0
                            TextInput {
                                id: inputField
                                text: "0"
                                color: root.darkMode ? "#fef3ec":"#573826"
                                font.pixelSize: parent.height*0.95
                                width: parent.width*0.95
                                horizontalAlignment: TextInput.AlignRight
                                anchors.centerIn: parent
                                inputMethodHints: Qt.ImhDigitsOnly
                                readOnly: true
                                clip: true
                                focus: visibleLayout ? true : false
                                font.family: jetbrainsFont.name
                                onTextChanged: {
                                    if(inputField.text === ""){
                                        inputField.text = 0
                                    }
                                    if(inputField.text.length > 1 && inputField.text.charAt(0) === "0"){
                                        inputField.text = inputField.text.slice(1)
                                    }
//                                    if(visibleLayout === false){
//                                        inputField.text = "0"
//                                    }
                                }


                            }
                        }
                        Rectangle {
                            id: memoryManagementArea
                            width: parent.width
                            height: parent.height*0.35
                            anchors {
                                top: inputArea.bottom
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
                                            colorBtn: root.darkMode ? "#fef3ec":"#573826"
                                            radiusBtn: memo.radius
                                            fontBtn: jetbrainsFont.name
                                            fontSize: parent.width*0.50
                                            onClicked:actionsOfTheStandardLayout.btnActionToInput(textBtn)
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
                anchors {
                    top: topArea.bottom
//                    right: parent.right
//                    left: parent.left
                    bottom: parent.bottom
                }
                anchors.horizontalCenter: parent.horizontalCenter
                color: root.darkMode ? "#573826":"#fef3ec"
                GridLayout {
                    id: grid
                    rows: if (root.height <= 600 && root.width <= 600){
                              return 7
                          }else {
                              return 5
                          }

                    columns: if (root.height <= 600 && root.width <= 600){
                                 return 5
                             }else {
                                 return 9
                             }
                    rowSpacing: 10
                    columnSpacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    height: parent.height*0.95
                    Repeater {
                        id: repeaterArea
                        model: if (root.height <= 600 && root.width <= 600){
                                   return ["x<sup>2</sup>", "x<sup>y</sup>","sin","cos", "tan","\u221A","10<sup>x</sup>", "log", "Exp", "Mod","Ans","CE", "C", "Del", "/",  "pi", "7", "8", "9", "*","n!", "4", "5", "6","-", "+/-","1", "2", "3", "+",  "(",")", "0", ",", "="]
                               }else {
                                   return root.hypMode ? root.listHypMode : root.listNonHypMode
                               }
                        Rectangle {
                            id: buttons
                            width: if (grid.rows === 7){
                                       return ((grid.width - (4 * grid.columnSpacing)) / 5)
                                   }else {
                                       if(modelData == "="){
                                           return((grid.width - (8 * grid.columnSpacing)) / 9) * 2
                                       }else {
                                           return ((grid.width - (8 * grid.columnSpacing)) / 9)
                                       }
                                   }
                            Layout.columnSpan: if(modelData == "="){
                                                   return 2
                                               } else {
                                                   return 1
                                               }

                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            height: if (grid.columns === 5){
                                        return ((grid.height - (6 * grid.rowSpacing)) / 7)
                                    } else {
                                        return ((grid.height - (4 * grid.rowSpacing)) / 5)
                                    }
                            radius: root.radiusWindow
                            color: root.darkMode ? "#fef3ec":"#573826"
                            ButtonCustom {
                                id: numericAndOperation
                                anchors.fill: parent
                                radiusBtn: buttons.radius
                                modeEnabled: root.darkMode
                                textBtn: "" + modelData
                                fontBtn: jetbrainsFont.name
                                colorBtn: actionsOfTheStandardLayout.buttonColorSelector(root.darkMode, numericAndOperation.textBtn, buttons.color)
                                fontSize:parent.width *0.35
                                onClicked: {
                                    actionsOfTheStandardLayout.btnActionToInput(textBtn)
                                }
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
                    bufferedOperationArea.text += inputField.text + "/"
                    actionsOfTheStandardLayout.textToSend += "/"
                    inputField.text = "0"
                }
            }else if (stringToWork === "*"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "*"
                    actionsOfTheStandardLayout.textToSend += "0*"
                    inputField.text = "0"
                }else {
                    bufferedOperationArea.text += inputField.text + "*"
                    actionsOfTheStandardLayout.textToSend += "*"
                    inputField.text = "0"
                }
            }else if (stringToWork === "-"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "-"
                    actionsOfTheStandardLayout.textToSend += "0-"
                    inputField.text = "0"
                }else {
                    bufferedOperationArea.text += inputField.text + "-"
                    actionsOfTheStandardLayout.textToSend += "-"
                    inputField.text = "0"
                }
            }else if (stringToWork === "+"){
                if (inputField.text.length === 1 && inputField.text === "0") {
                    bufferedOperationArea.text += inputField.text + "+"
                    actionsOfTheStandardLayout.textToSend += "0+"
                    inputField.text = "0"
                }else {
                    bufferedOperationArea.text += inputField.text + "+"
                    actionsOfTheStandardLayout.textToSend += "+"
                    inputField.text = "0"
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
                inputField.text = inputField.text.slice(0, -1)
                actionsOfTheStandardLayout.textToSend = actionsOfTheStandardLayout.textToSend.slice(0, -1)
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
                actionsOfTheStandardLayout.textToSend += "-("
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
                recievedText = process.processTheOperation(actionsOfTheStandardLayout.textToSend)
                inputField.text = recievedText
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

