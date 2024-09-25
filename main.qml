import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.0


Window {
    id: root
    visible: true
    width: Screen.desktopAvailableWidth*0.70
    height: Screen.desktopAvailableHeight*0.70
    minimumWidth: 600
    minimumHeight: 470 //600
    title: qsTr("Calculatrice")
    Item {
        width: parent.width
        height: parent.height
        Row {
            anchors.fill: parent
            Rectangle {
                id: rightArea
                width: parent.width*0.30
                height: parent.height
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }
                color: "#0f1722"
                Column {
                    anchors.fill: parent
                    Rectangle {
                        id: nameTitle
                        width: parent.width
                        height: parent.height*0.25
                        color: "#0f1722"
                        anchors {
                            top: parent.top
                            right: parent.right
                            left: parent.left
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "Calculator"
                            color: "white"
                            font.pixelSize: parent.height*0.35
                        }
                    }
                    Rectangle {
                        id: standardBtnArea
                        width: parent.width
                        height: parent.height*0.25
                        color: "#0f1722"
                        anchors {
                            top: nameTitle.bottom
                            right: parent.right
                            left: parent.left
                        }
                        Rectangle {
                            id: standardBtn
                            anchors.centerIn: parent
                            width: parent.width*0.25
                            height: standardBtn.width
                            color: "#0f1722"
                            radius: 5
                            ButtonCustom {
                                id: standardBtnCust
                                anchors.fill: parent
                                textBtn: "123"
                                colorBtn: "#6c63ff"
                                radiusBtn: standardBtn.radius
                                fontSize: parent.height*0.45
                                onClicked: {
                                    layoutController.currentLayout = 0
                                    layoutController.switchLayout()
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: scientificBtnArea
                        width: parent.width
                        height: parent.height*0.25
                        color: "#0f1722"
                        anchors {
                            top: standardBtnArea.bottom
                            right: parent.right
                            left: parent.left
                        }
                        Rectangle {
                            id: scientificBtn
                            anchors.centerIn: parent
                            width: parent.width*0.25
                            height: scientificBtn.width
                            color: "#0f1722"
                            radius: 5
                            ButtonCustom {
                                id: scientificBtnCust
                                anchors.fill: parent
                                textBtn: "Scie"

                                colorBtn:  "#151e2a"
                                radiusBtn: scientificBtn.radius
                                fontSize: parent.height*0.45
                                onClicked: {
                                    layoutController.currentLayout = 1
                                    layoutController.switchLayout()
                                }
                            }
                        }
                    }
                    Rectangle {
                        id: helpAndSettingArea
                        width: parent.width
                        height: parent.height*0.25
                        color: "#0f1722"
                        anchors {
                            top: scientificBtnArea.bottom
                            right: parent.right
                            left: parent.left
                            bottom: parent.bottom
                        }
                        Row {
                            anchors.fill: parent
                            Rectangle {
                                id: settingArea
                                width: parent.width /2
                                height: parent.height
                                color: "#0f1722"
                                anchors {
                                    top: parent.top
                                    bottom: parent.bottom
                                    right: paren.right
                                }

                                Rectangle {
                                    id: settingAreaBtn
                                    anchors.centerIn: parent
                                    width: parent.width * 0.4
                                    height: settingAreaBtn.width
                                    color: "#0f1722"
                                    ButtonCustom {
                                        anchors.fill: parent
                                        textBtn: "Set.."
                                        colorBtn: "#151e2a"
                                        radiusBtn: 5
                                        fontSize: settingAreaBtn.height*0.35
                                    }
                                }
                            }
                            Rectangle {
                                id: aboutArea
                                width: parent.width /2
                                height: parent.height
                                color: "#0f1722"
                                anchors {
                                    top: parent.top
                                    bottom: parent.bottom
                                    right: parent.right
                                    left: settingArea.right
                                }
                                Rectangle {
                                    id: aboutAreaBtn
                                    anchors.centerIn: parent
                                    width: parent.width * 0.4
                                    height: settingAreaBtn.width
                                    color: "#0f1722"
                                    ButtonCustom {
                                        anchors.fill: parent
                                        textBtn: "about"
                                        colorBtn: "#151e2a"
                                        radiusBtn: 5
                                        fontSize: settingAreaBtn.height*0.35
                                    }
                                }
                            }

                        }
                    }
                }

            }
            StandardCalculatorLayout {
                id: standardSelect
                idNumber: 0
                visibleLayout: layoutController.currentLayout === standardSelect.idNumber
                layoutWidth: parent.width - rightArea.width
                layoutHeight: parent.height
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: rightArea.right
                    right: parent.right
                }
            }
            ScientificCalculatorLayout{
                id: scientificSelect

                idNumber: 1
                visibleLayout: layoutController.currentLayout === scientificSelect.idNumber
                layoutWidth: parent.width - rightArea.width
                layoutHeight: parent.height
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: rightArea.right
                    right: parent.right
                }
            }
        }

    }
    QtObject {
        id: layoutController
        property int currentLayout: 0
        property int layoutCount: 2
        function switchLayout() {
            if(layoutController.currentLayout === 0){
                standardBtnCust.colorBtn = "#6c63ff"
                scientificBtnCust.colorBtn = "#151e2a"
            } else {
                scientificBtnCust.colorBtn = "#6c63ff"
                standardBtnCust.colorBtn = "#151e2a"
            }
        }
    }
}
