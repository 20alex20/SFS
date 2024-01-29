import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    objectName: "defaultCover"
    id: cover

    Column {
        width: parent.width
        spacing: 30
        anchors.top: parent.top
        anchors.topMargin: 35

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            id: image
            source: Qt.resolvedUrl("../icons/SFS.png")
            sourceSize {
                width: 172
                height: 172
            }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("SFS")
            color: "White"
            font.family: "Ubuntu"
            font.pixelSize: 35
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        spacing: 5

        property bool connected: true
        Text {
            text: qsTr("Хост:")
            font.bold: true
            font.pixelSize: 30
            color: "#ababab"
        }
        Text {
            text: parent.connected ? qsTr("255.255.255.255") : "-"
            font.pixelSize: 30
            color: "#ababab"
        }

        Text {
            text: qsTr("Порт:")
            font.bold: true
            font.pixelSize: 30
            color: "#ababab"
        }
        Text {
            text: parent.connected ? qsTr("22") : "-"
            font.pixelSize: 30
            color: "#ababab"
        }
    }
}
