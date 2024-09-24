import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    minimumWidth: 320
    minimumHeight: 470 //600
    title: qsTr("Calculatrice")
    Item {
        width: parent.width
        height: parent.height
        Column {
            width: parent.width
            height: parent.height
            Rectangle {
                id: topArea
                width: parent.width
                height: parent.height*0.35
                anchors {
                    top: parent.top
                    right: parent.right
                    left: parent.left
                }
                color: "red"
                Column {
                    width: parent.width
                    height: parent.height
                    Rectangle {
                        id: classification
                        width: parent.width
                        anchors {
                            top: parent.top
                            right: parent.right
                            left: parent.left
                        }
                        color: "pink"
                        height: Screen.desktopAvailableHeight*0.053625//parent.height*0.165
                        Text {
                            id: classificationName
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 20
                            color: "white"
                            text: qsTr("Standard")
                        }
                    }
                    Rectangle {
                        id: bufferedOperation
                        width: parent.width
                        anchors {
                            top: classification.bottom
                            right: parent.right
                            left: parent.left
                        }
                        color: "yellow"
                        height: parent.height*0.13
                    }
                    Rectangle {
                        id: inputArea
                        width: parent.width
                        anchors {
                            top: bufferedOperation.bottom
                            right: parent.right
                            left: parent.left
                        }
                        color: "orange"
                        height: parent.height*0.4
                        Text {
                            text: "0"
                            font.pixelSize: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Rectangle {
                        id: memoryManagementArea
                        width: parent.width
                        anchors {
                            top: inputArea.bottom
                            right: parent.right
                            left: parent.left
                            bottom: parent.bottom
                        }
                        color: "purple"
                        Row {
                            width: parent.width
                            height: parent.height

                            spacing: 1

                            Repeater {
                                model: 5
                                Rectangle {
                                    id: memo
                                    width: if (parent.width <= (root.minimumWidth + 80)){
                                               return (parent.width - (4 * 1))/5
                                           } else {
                                               return ((root.minimumWidth + 80) - (4 * 1))/5
                                           }

                                    height: if(parent.height <= (memo.width*0.7)){
                                                return parent.height
                                            } else {
                                                return (memo.width*0.7)
                                            }
//                                    height: parent.height
                                    color: "#45ef96"
//                                    radius: 7
                                    Text {
                                        text: "M..."
                                        anchors.centerIn: parent
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
                color: "green"
                Grid {
                    rows: 5
                    columns: 5
                    spacing: 1
                    width: parent.width
                    height: parent.height
                    Repeater {
                        model: 25
                        Rectangle {
                            width: (parent.width - (4 * 1)) / 5
                            height: (parent.height - (4 * 1)) / 5
                            border {
                                width: 2
                                color: "black"
                            }
//                            radius: 12
                            color: "magenta"
                            Text {
                                text: "OP"
                                font.pixelSize: 25
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
        }
    }
}
