import QtQuick 2.5
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0
import StringProcessor 1.0

Item {
    id: root
    property alias textBtn: buttonText.text
    property color colorBtn
    property int radiusBtn
    property font fontBtn
    property alias fontSize: buttonText.font.pixelSize
    property bool modeEnabled
    signal clicked()
    Rectangle {
        id: background
        width: parent.width
        height: parent.height
        radius: radiusBtn
        color: if(mouseAreaBtn.containsPress) {
                   return Qt.darker(colorBtn)
               } else if (mouseAreaBtn.containsMouse){
                   return Qt.lighter(colorBtn)
               } else {
                   return colorBtn
               }
    }

//    DropShadow {
//        anchors.fill: background
//        radius: 6
//        samples: 13
//        color: "#573826"
//        horizontalOffset: 2
//        verticalOffset: 2
//        source: background
//    }
    Text {
        id: buttonText
        text: ""
        font.pixelSize: 25
        font.family: root.fontBtn
        color: root.modeEnabled ?"#111111": "#ffffff"
        textFormat: Text.RichText
        visible: (buttonText.text === "dark" || buttonText.text === "light") ? false : true
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
