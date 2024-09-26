import QtQuick 2.0
import StringProcessor 1.0

Item {
    id: root
    property int idNumber
    property bool visibleLayout
    property int layoutWidth
    property int layoutHeight
    property var allowedStrings: ["sin", "cos", "tan", "+"]
    visible: visibleLayout
    Rectangle {
        width: layoutWidth
        height: layoutHeight
        color: "#1d293a"
        Column {
            width: parent.width*0.75
            height: parent.height*0.75
            anchors.centerIn: parent
            Rectangle {
                id: topArea
                width: parent.width
                height: parent.height*0.30
                anchors {
                    top: parent.top
                    right: parent.right
                    left: parent.left
                }

                Column {
                    width: parent.width
                    height: parent.height
                    Rectangle {
                        id: bufferedOperation
                        width: parent.width
                        anchors {
                            top: classification.bottom
                            right: parent.right
                            left: parent.left
                        }
                        color: "#1d293a"
                        height: parent.height*0.15
                        TextInput {
                            id: bufferedOperationArea
                            text: ""
                            color: "white"
                            font.pixelSize: parent.height*0.8
                            width: parent.width
                            horizontalAlignment: TextInput.AlignRight
                            clip: true
                            inputMethodHints: Qt.ImhDigitsOnly
                            readOnly: true
                            focus: false
//                            onTextChanged: {
//                                bufferedOperationArea.text
//                            }
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
                        color: "#1d293a"
                        height: parent.height - memoryManagementArea.height
                        TextInput {
                            id: inputField
                            text: "0"
                            color: "white"
                            font.pixelSize: parent.height*0.8
                            width: parent.width
                            horizontalAlignment: TextInput.AlignRight
                            clip: true
                            inputMethodHints: Qt.ImhDigitsOnly
                            //readOnly: true
                            focus: false

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
                        color: "#1d293a"
                        Row {
                            id: row
                            //anchors.verticalCenter: parent.verticalCenter
                            //anchors.horizontalCenter: parent.horizontalCenter
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
                                    radius: 5
                                    color: "#0f1722"
                                    ButtonCustom {
                                        anchors.fill: parent
                                        textBtn: "" + modelData
                                        colorBtn: "#0f1722"
                                        radiusBtn: memo.radius
                                        fontSize: parent.height*0.50
                                    }
                                }
                            }
                        }
                    }
                }

            }
            Rectangle {
                id: bottomArea
                width: parent.width
                height: parent.height - topArea.height
                anchors {
                    top: topArea.bottom
                    right: parent.right
                    left: parent.left
                    bottom: parent.bottom
                }
                color: "#1d293a"
                Grid {
                    id: grid
                    rows: if (root.height <= 600 && root.width <= 600){
                              return 6
                          }else {
                              return 5
                          }

                    columns: 10 - grid.rows
                    spacing: 10
                    width: parent.width
                    height: parent.height
                    Repeater {
                        model: if (root.height <= 600 && root.width <= 600){
                                   return ["(",")", "\u221A","x²","CE", "C", "Del", "\u00F7",  "7", "8", "9", "*", "4", "5", "6","-", "1", "2", "3", "+",  "+/-", "0", ",", "="]
                               }else {
                                   return ["\u221A", "CE", "C", "Del", "\u00F7", "x²", "7", "8", "9", "*", "x³" ,"4", "5", "6","-", "+/-","1", "2", "3", "+", "(",")", "0", ",", "="]
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
                            radius:7

                            color: "#354356"

                            ButtonCustom {
                                anchors.fill: parent
                                radiusBtn: buttons.radius
                                textBtn: "" + modelData
                                colorBtn: if(textBtn === "=") {
                                              return "#6c63ff"
                                          }else if(textBtn === "0" || textBtn === "1" || textBtn === "2" ||textBtn === "3" ||textBtn === "4" ||textBtn === "5" ||textBtn === "6" ||textBtn === "7" ||textBtn === "8" ||textBtn === "9"){
                                              return "#090e15"
                                          } else {
                                              return "#354356"
                                          }

                                fontSize: 20
                                onClicked: actionsOfTheStandardLayout.btnActionToInput(textBtn)
                            }
                        }
                    }
                }
            }
        }
    }

    StringProcessorWrapper {
        id: process
    }
    QtObject {
        id: actionsOfTheStandardLayout
        property string textToSend : bufferedOperationArea.text + inputField.text
        property string stringToDisplay : " Worked!"
        function btnActionToInput(stringToWork){
            var recievedText = ""
            if (inputField.text.length === 1 && inputField.text === "0" && stringToWork !== "0"){
                inputField.text = ""
            } else if (inputField.text.length === 1 && inputField.text === "0" && stringToWork === "0") {
                inputField.text = "0"
            }

            if (stringToWork === "\u221A"){
                inputField.text += "sqrt"
                inputField.text += "("
            }else if (stringToWork === "x²"){
                inputField.text += stringToWork
                inputField.text += "sqr("
            }else if (stringToWork === "\u00F7"){
                bufferedOperationArea.text += inputField.text + "/"
                inputField.text = ""
            }else if (stringToWork === "*"){
                bufferedOperationArea.text += inputField.text + "*"
                inputField.text = ""
            }else if (stringToWork === "-"){
                bufferedOperationArea.text += inputField.text + "-"
                inputField.text = ""
            }else if (stringToWork === "+"){
                bufferedOperationArea.text += inputField.text + "+"
                inputField.text = ""
            }else if (stringToWork === "CE"){
                inputField.text = ""
            }else if (stringToWork === "C"){
                inputField.text = ""
                bufferedOperationArea.text = ""
            }else if (stringToWork === "Del"){
                inputField.text = inputField.text.slice(0, -1)
            }else if(stringToWork === "=") {
                recievedText = process.process(actionsOfTheStandardLayout.textToSend)
                bufferedOperationArea.text = ""
                inputField.text = recievedText
            }else{
                if (inputField.text.length === 1 && inputField.text === "0" && stringToWork === "0") {
                    inputField.text = "0"
                } else {
                    inputField.text += stringToWork
                }
            }
        }

    }
}
