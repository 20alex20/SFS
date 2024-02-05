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
                if (!transfering)
                    break
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
            message = "Остановка операции"
            transfering = false
        }
    }

    objectName: "sftpPage"
    allowedOrientations: Orientation.Portrait
    backgroundColor: "Red"

    PageHeader {
        objectName: "pageHeader"
        title: qsTr("SFS")
        extraContent.children: [
            IconButton {
                objectName: "aboutButton"
                icon.source: "image://theme/icon-m-about"
                anchors.verticalCenter: parent.verticalCenter

                onClicked:  {
                    pageStack.popAttached()
                    pageStack.replace(Qt.resolvedUrl("MainPage.qml"))
                }
            }
        ]
    }
}

