import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.0
import StringProcessor 1.0

Window {
    id: root
    visible: true
    width: Screen.desktopAvailableWidth*0.70
    height: Screen.desktopAvailableHeight*0.70
    minimumWidth: 600
    minimumHeight: 470 //600
    title: qsTr("Calculatrice")
    Item {
        id: subroot
        property string windowInterfaceMode: "dark"
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
                                        id: lightTheLayout
                                        anchors.fill: parent
                                        textBtn: "light"
                                        colorBtn: "#151e2a"
                                        radiusBtn: 5
                                        fontSize: settingAreaBtn.height*0.35
                                        onClicked: layoutController.switchMode(lightTheLayout.textBtn)
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
                                    color: "#151e2a"
                                    ButtonCustom {
                                        id: modeBtn
                                        anchors.fill: parent
                                        textBtn: "dark"
                                        colorBtn: "#151e2a"
                                        radiusBtn: 5
                                        fontSize: settingAreaBtn.height*0.35
                                        onClicked: layoutController.switchMode(modeBtn.textBtn)
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
            if (subroot.windowInterfaceMode === "dark") {
                if(layoutController.currentLayout === 0){
                    standardBtnCust.colorBtn = "#6c63ff"
                    scientificBtnCust.colorBtn = "#151e2a"
                } else {
                    scientificBtnCust.colorBtn = "#6c63ff"
                    standardBtnCust.colorBtn = "#151e2a"
                }
            }

        }
        function switchMode(buttonModeStr) {
            if (buttonModeStr === "dark"){
                subroot.windowInterfaceMode = "dark"
                rightArea.color = "#0f1722"
                nameTitle.color = "#0f1722"
                standardBtnArea.color = "#0f1722"
                standardBtn.color = "#0f1722"
                standardBtnCust.colorBtn = "#6c63ff"
                scientificBtnArea.color = "#0f1722"
                scientificBtn.color = "#0f1722"
                scientificBtnCust.colorBtn = "#151e2a"
                helpAndSettingArea.color = "#0f1722"
                settingArea.color = "#0f1722"
                settingAreaBtn.color = "#0f1722"
                lightTheLayout.colorBtn = "#151e2a"
                aboutArea.color = "#0f1722"
                aboutAreaBtn.color = "#151e2a"
                modeBtn.colorBtn = "#151e2a"
            } else if (buttonModeStr === "light"){
                subroot.windowInterfaceMode = "light"
                rightArea.color = "#e3eff9"
                nameTitle.color = "#e3eff9"
                standardBtnArea.color = "#e3eff9"
                standardBtn.color = "#e3eff9"
                standardBtnCust.colorBtn = "#c2ddf0"
                scientificBtnArea.color = "#e3eff9"
                scientificBtn.color = "#e3eff9"
                scientificBtnCust.colorBtn = "#c2ddf0"
                helpAndSettingArea.color = "#e3eff9"
                settingArea.color = "#e3eff9"
                settingAreaBtn.color = "#e3eff9"
                lightTheLayout.colorBtn = "#c2ddf0"
                aboutArea.color = "#e3eff9"
                aboutAreaBtn.color = "#c2ddf0"
                modeBtn.colorBtn = "#c2ddf0"
            }
        }
    }

}
