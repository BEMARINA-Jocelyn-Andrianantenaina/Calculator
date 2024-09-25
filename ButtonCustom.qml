import QtQuick 2.5
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0

Item {
    id: root
    property alias textBtn: buttonText.text
    property color colorBtn
    property int radiusBtn
    property alias fontSize: buttonText.font.pixelSize

    signal clicked()


    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        color: if(mouseAreaBtn.containsPress) {
                   return Qt.darker(colorBtn)
               } else if (mouseAreaBtn.containsMouse){
                   return Qt.lighter(colorBtn)
               } else {
                   return colorBtn
               }
        radius: radiusBtn
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "blue"}
//            GradientStop { position: 1.0; color: "white"}
//        }
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
        color: "white"
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
