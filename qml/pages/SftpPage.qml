import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property bool connectedVirtual: true

    property string connectedHost: ""
    property string connectedUserName: ""
    property string connectedPassword: ""
    property string connectedPort: ""

    property bool blocking: false
    property bool connected: true
    property bool transfering: false
    property string message: "Подключено"


    function disconnect() {
        if (!blocking) {
            blocking = true
            connected = false
            message = "Отключение..."
            // код на плюсах
            pageStack.replaceAbove(null, Qt.resolvedUrl("../pages/MainPage.qml"))
            message = "Подключено"
            blocking = false
        }
    }
    function reconnect() {
        if (!blocking) {
            blocking = true
            connected = false
            message = "Переподключение..."
            // код на плюсах
            connected = true
            message = "Подключено"
            blocking = false
        }
    }
    function startTransfer() {
        if (!blocking) {
            blocking = true

            // код на js
            var quantity = 41

            transfering = true
            for (var number = 0; number < quantity; number++) {
                if (!transfering) {
                    // код на плюсах
                    break
                }
                message = "Обработано файлов" + number + " из " + quantity
                // код на плюсах
            }
            transfering = false
            message = "Подключено"
            blocking = false
        }
    }
    function stopTransfer() {
        if (transfering) {
            message = "Отмена операции"
            transfering = false
        }
    }

    objectName: "sftpPage"
    allowedOrientations: Orientation.Portrait

    Column {
        anchors.fill: parent

        Row {
            width: parent.width
            spacing: 15

            Row {
                IconButton {
                    width: 100
                    height: 100
                    icon.source: "../icons/buttons/40x40/disconnect.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: disconnect()

                    Image {
                        anchors.centerIn: parent
                        source: parent.icon.source
                        width: parent.icon.width
                        height: parent.icon.height
                    }
                }

                IconButton {
                    width: 100
                    height: 100
                    icon.source: "../icons/buttons/40x40/refresh.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: reconnect()

                    Image {
                        anchors.centerIn: parent
                        source: parent.icon.source
                        width: parent.icon.width
                        height: parent.icon.height
                    }
                }
            }

            Rectangle {
                width: parent.width - parent.children[0].width * 2 - 30
                height: parent.children[0].height - 20
                anchors.top: parent.top
                anchors.topMargin: 10

                border.color: Theme.highlightColor
                border.width: 4
                radius: 10
                color: "transparent"

                Label {
                    width: parent.width - parent.radius
                    anchors.centerIn: parent

                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    color: "White"
                    font.family: Theme.fontFamilyHeading
                    font.pixelSize: 32
                    text: message
                }
            }

            Row {
                IconButton {
                    width: 100
                    height: 100
                    icon.source: transfering ? "../icons/buttons/40x40/cancel.png" : "../icons/buttons/40x40/cancel 2.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }

                    Image {
                        anchors.centerIn: parent
                        source: parent.icon.source
                        width: parent.icon.width
                        height: parent.icon.height
                    }
                }

                IconButton {
                    width: 100
                    height: 100
                    icon.source: "../icons/buttons/40x40/cancel.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }

                    Image {
                        anchors.centerIn: parent
                        source: parent.icon.source
                        width: parent.icon.width
                        height: parent.icon.height
                    }
                }
            }
        }
    }
}

