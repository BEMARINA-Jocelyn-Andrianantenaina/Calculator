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
//    icon: ":/images/projet-ENI-icon.png"
    FontLoader {
        id: jetbrainsFont
        source: "fonts/JetBrainsMono-Regular.ttf"
    }

    Item {
        id: subroot
        property bool layoutMode: true
        property real radiusWindow: 15
        property font universalFont: jetbrainsFont.name
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
                color: subroot.layoutMode ? "#111111":"#ffffff"
                Rectangle{
                    width: parent.width*0.80
                    height: parent.height*0.80
                    anchors.centerIn: parent
                    color: subroot.layoutMode ? "#fef3ec" : "#573826"
                    radius: subroot.radiusWindow
                    Column {
                        width: parent.width*0.97
                        height: parent.height*0.97
                        anchors.centerIn: parent
                        Rectangle {
                            id: nameTitle
                            width: parent.width
                            height: parent.height*0.25
                            color: subroot.layoutMode ? "#fef3ec" : "#573826"
                            anchors {
                                top: parent.top
                                right: parent.right
                                left: parent.left
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "Calculator"
                                color: "black"
                                font.family: subroot.universalFont
                                font.pixelSize: parent.height*0.35
                            }
                        }
                        Rectangle {
                            id: standardBtnArea
                            width: parent.width
                            height: parent.height*0.25
                            color: subroot.layoutMode ? "#fef3ec" : "#573826"
                            anchors {
                                top: nameTitle.bottom
                                right: parent.right
                                left: parent.left
                            }
                            Rectangle {
                                id: standardBtn
                                anchors.centerIn: parent
                                width: parent.width*0.45
                                height: parent.height*0.60
                                color: subroot.layoutMode ? "#fef3ec" : "#573826"
                                radius: subroot.radiusWindow
                                ButtonCustom {
                                    id: standardBtnCust
                                    anchors.fill: parent
                                    textBtn: "123"
                                    modeEnabled: !subroot.layoutMode
                                    colorBtn: "#573826"
                                    fontBtn: subroot.universalFont
                                    radiusBtn: standardBtn.radius
                                    fontSize: parent.height*0.45
                                    onClicked: {
                                        layoutController.currentLayout = 0
                                        scientificSelect.textInputFieldReset.text = "0"
                                        scientificSelect.textBufferedFieldReset.text = ""
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: scientificBtnArea
                            width: parent.width
                            height: parent.height*0.25
                            color: subroot.layoutMode ? "#fef3ec" : "#573826"
                            anchors {
                                top: standardBtnArea.bottom
                                right: parent.right
                                left: parent.left
                            }
                            Rectangle {
                                id: scientificBtn
                                anchors.centerIn: parent
                                width: parent.width*0.45
                                height: parent.height*0.60
                                color: subroot.layoutMode ? "#fef3ec" : "#573826"
                                radius: subroot.radiusWindow
                                ButtonCustom {
                                    id: scientificBtnCust
                                    anchors.fill: parent
                                    textBtn: "Scie"
                                    colorBtn:  "#573826"
                                    modeEnabled: !subroot.layoutMode
                                    fontBtn: subroot.universalFont
                                    radiusBtn: scientificBtn.radius
                                    fontSize: parent.height*0.45
                                    onClicked: {
                                        layoutController.currentLayout = 1
                                        standardSelect.textInputFieldReset.text = "0"
                                        standardSelect.textBufferedFieldReset.text = ""
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: helpAndSettingArea
                            width: parent.width
                            height: parent.height*0.25
                            color: subroot.layoutMode ? "#fef3ec" : "#573826"
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
                                    color: subroot.layoutMode ? "#fef3ec" : "#573826"
                                    anchors {
                                        top: parent.top
                                        bottom: parent.bottom
                                        left: parent.left
                                    }
                                    Rectangle {
                                        id: settingAreaBtn
                                        anchors.centerIn: parent
                                        width: parent.width * 0.6
                                        height: parent.height * 0.5
                                        radius: subroot.radiusWindow
                                        color: subroot.layoutMode ? "#fef3ec" : "#573826"
                                        ButtonCustom {
                                            id: lightTheLayout
                                            anchors.fill: parent
                                            textBtn: "light"
                                            colorBtn: subroot.layoutMode ? "#573826" :"#fef3ec"
                                            radiusBtn: settingAreaBtn.radius
                                            fontBtn: subroot.universalFont
                                            modeEnabled: !subroot.layoutMode
                                            fontSize: settingAreaBtn.height*0.35
                                            onClicked: layoutController.switchMode(lightTheLayout.textBtn)
                                            Image {
                                                source: subroot.layoutMode ? "images/light-button-lighted-pink.png" : "images/light-button-lighted.png"
                                                anchors.centerIn: parent
                                                width: parent.width*0.90
                                                height: parent.height*0.90
                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }
                                    }
                                }
                                Rectangle {
                                    id: aboutArea
                                    width: parent.width /2
                                    height: parent.height
                                    color: subroot.layoutMode ? "#fef3ec" : "#573826"
                                    anchors {
                                        top: parent.top
                                        bottom: parent.bottom
                                        right: parent.right
                                        left: settingArea.right
                                    }

                                    Rectangle {
                                        id: aboutAreaBtn
                                        anchors.centerIn: parent
                                        width: parent.width * 0.6
                                        height: parent.height * 0.5
                                        color: subroot.layoutMode ? "#fef3ec" :"#573826"
                                        radius: subroot.radiusWindow
                                        ButtonCustom {
                                            id: modeBtn
                                            anchors.fill: parent
                                            textBtn: "dark"
                                            colorBtn: subroot.layoutMode ? "#573826" :"#fef3ec"
                                            radiusBtn: aboutAreaBtn.radius
                                            fontBtn: subroot.universalFont
                                            modeEnabled: !subroot.layoutMode
                                            fontSize: settingAreaBtn.height*0.35
                                            onClicked: layoutController.switchMode(modeBtn.textBtn)
                                            Image {
                                                source: subroot.layoutMode ? "images/dark-button-pink.png" : "images/dark-button-brown.png"
                                                anchors.centerIn: parent
                                                width: parent.width*0.90
                                                height: parent.height*0.90
                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }
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
        function switchMode(buttonModeStr) {
            if (buttonModeStr === "dark"){
                standardSelect.darkMode = true
                subroot.layoutMode = true
                scientificSelect.darkMode = true
                standardBtnCust.colorBtn = "#573826"
                scientificBtnCust.colorBtn = "#573826"
            } else if (buttonModeStr === "light"){
                standardSelect.darkMode = false
                subroot.layoutMode = false
                scientificSelect.darkMode = false
                standardBtnCust.colorBtn = "#fef3ec"
                scientificBtnCust.colorBtn = "#fef3ec"

            }
        }
    }

}
