import QtQuick 2.0

Item {
    id: root
    property int idNumber
    property bool visibleLayout
    property int layoutWidth
    property int layoutHeight
    visible: visibleLayout
    Rectangle {
        width: layoutWidth
        height: layoutHeight
        color: "#1d293a"
        Column {
            width: parent.width*0.85
            height: parent.height*0.90
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
                            //Intercepter les modificationsde texte
                            onTextChanged: {
                                var validText = inputField.text.replace(/[^0-9\(\)\+\-\*\\\.]/g, "")
                                if(validText !== inputField.text){
                                    inputField.text = validText;
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
                                model: ["DEG","HYP","F-E","MC", "MR", "M+", "M-", "MS"]
                                Rectangle {
                                    id: memo
                                    width: (parent.width - (7 * row.spacing))/8
                                    height: parent.height
                                    radius: 5
                                    color: "#0f1722"
                                    ButtonCustom {
                                        anchors.fill: parent
                                        textBtn: "" + modelData
                                        colorBtn: "#0f1722"
                                        radiusBtn: memo.radius
                                        fontSize: parent.height*0.40
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
                              return 7
                          }else {
                              return 5
                          }

                    columns: if (root.height <= 600 && root.width <= 600){
                                 return 5
                             }else {
                                 return 9
                             }
                    spacing: 10
                    width: parent.width
                    height: parent.height
                    Repeater {
                        model: if (root.height <= 600 && root.width <= 600){
                                   return ["x²", "x^y","sin","cos", "tan","sqrt","10^x", "log", "Exp", "Mod","Ans","CE", "C", "Del", "/",  "pi", "7", "8", "9", "*","n!", "4", "5", "6","-", "+/-","1", "2", "3", "+",  "(",")", "0", ",", "="]
                               }else {
                                   return ["x²", "x^y","sin","cos", "tan","CE", "C", "Del", "/", "x³", "y sqrt","sin^-1", "cos^-1", "tan^-1", "7", "8", "9", "*", "sqrt","10^x", "log", "Exp", "Mod","4", "5", "6","-","1/x", "e^x", "ln","dms","deg", "1", "2", "3", "+", "Ans", "pi","n!","(",")","+/-", "0", ",", "="]
                               }

                        Rectangle {
                            id: buttons
                            width: if (grid.rows === 7){
                                       return ((grid.width - (4 * grid.spacing)) / 5)
                                   }else {
                                       return ((grid.width - (8 * grid.spacing)) / 9)
                                   }

                            height: if (grid.columns === 5){
                                        return ((grid.height - (6 * grid.spacing)) / 7)
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

                            }
                        }
                    }
                }
            }
        }
    }

}
