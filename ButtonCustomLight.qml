import QtQuick 2.5
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0
import StringProcessor 1.0

Item {
    id: root
    property alias textBtn: buttonText.text
    property color colorBtn1
    property color colorBtn2
    property int radiusBtn
    property alias fontSize: buttonText.font.pixelSize
    property bool modeEnabled
    signal clicked()
    visible: modeEnabled
    Rectangle {
        id: fadeGradientRect
        anchors.fill: parent
        radius: radiusBtn
        color: "red"
        gradient: Gradient {
            GradientStop { position: 0.0; color: colorBtn1}
            GradientStop { position: 1.0; color: colorBtn2}
        }
    }

    DropShadow {
        anchors.fill: background
        radius: 6
        samples: 13
        color: "#151e2b"
        horizontalOffset: 2
        verticalOffset: 2
        source: background
    }
    Text {
        id: buttonText
        text: "OP"
        font.pixelSize: 25
        color: "#0084ff"
        anchors.centerIn: parent
    }


    MouseArea {
        id:mouseAreaBtn
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.clicked()
        }
    }

}
