import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property bool connectedVirtual: true

    property string connectedHost: ""
    property string connectedUserName: ""
    property string connectedPassword: ""
    property string connectedPort: ""

    property string message: "Подключено"
    property bool blocking: false
    property bool transfering: false
    property string path1: ""
    property string path2: ""
    property var reload1: null
    property var reload2: null
    property var menuObject: null
    property var currentElement: null
    property var currentRow: null

    property int typeElements: 1
    property int modeElements: 1
    property string pathElements: ""
    property var elements: null


    function init(ch, cun, cpw, cp) {
        connectedHost = ch
        connectedUserName = cun
        connectedPassword = cpw
        connectedPort = cp
    }

    function closeMenu() {
        if (menuObject !== null) {
            menuObject.destroy()
            menuObject = null
            currentElement.z = 0
            currentRow.z = 1
            loader1.z = 0
        }
    }

    function disconnect() {
        console.log("disconnect")
        if (!blocking) {
            blocking = true
            message = "Отключение"

            // код на плюсах

            pageStack.replaceAbove(null, Qt.resolvedUrl("MainPage.qml"))
            blocking = false
        }
    }
    function reconnect() {
        console.log("reconnect")
        if (!blocking) {
            blocking = true
            message = "Переподключение"
            pageStack.popAttached()

            // код на плюсах
            path2 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml"

            pageStack.pushAttached(Qt.resolvedUrl("SshPage.qml"))
            pageStack.nextPage().init(connectedHost, connectedPort)
            message = "Подключено"
            blocking = false
        }
    }
    function stopTransfer() {
        console.log("stopTransfer")
        if (transfering) {
            message = "Отмена операции"
            transfering = false
        }
    }
    function addDirectory() {
        console.log("addDirectory")
        if (!blocking) {
            var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/AddDirectoryPage.qml"))
            dialog.init(path1, path2)
            dialog.accepted.connect(function() {
                blocking = true

                // код на плюсах

                if (dialog.type === 1)
                    reload1.data()
                else
                    reload2.data()
                blocking = false
            })
        }
    }


    objectName: "sftpPage"
    allowedOrientations: Orientation.Portrait
    showNavigationIndicator: false

    Column {
        anchors.fill: parent

        Row {
            width: parent.width
            spacing: 15

            Row {
                IconButton {
                    width: 100
                    height: 100
                    icon.source: "../icons/buttons/70x70/disconnect.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: disconnect()
                    onPressed: closeMenu()

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
                    icon.source: "../icons/buttons/70x70/refresh.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: reconnect()
                    onPressed: closeMenu()

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

                border.color: Theme.highlightBackgroundColor
                border.width: 5
                radius: 10
                color: "White"

                Label {
                    width: parent.width - parent.radius
                    anchors.centerIn: parent

                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    color: "Black"
                    font.family: Theme.fontFamilyHeading
                    font.pixelSize: 32
                    text: message
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: closeMenu()
                }
            }

            Row {
                IconButton {
                    width: 100
                    height: 100
                    icon.source: transfering ? "../icons/buttons/70x70/cancel.png" : "../icons/buttons/70x70/cancel_2.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: stopTransfer()
                    onPressed: closeMenu()

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
                    icon.source: "../icons/buttons/70x70/cancel.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: addDirectory()
                    onPressed: closeMenu()

                    Image {
                        anchors.centerIn: parent
                        source: parent.icon.source
                        width: parent.icon.width
                        height: parent.icon.height
                    }
                }
            }
        }

        Loader {
            id: loader1
            width: parent.width
            height: (parent.height - parent.children[0].height) / 2
            z: 0
            Component.onCompleted: setSource("../loaders/FileManagerLoader.qml", { "type": 1 })
            onLoaded: {
                // код на плюсах
                path1 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"
            }
        }

        Loader {
            id: loader2
            width: parent.width
            height: parent.height - parent.children[0].height - parent.children[1].height
            z: 0
            Component.onCompleted: setSource("../loaders/FileManagerLoader.qml", { "type": 2 })
            onLoaded: {
                // код на плюсах
                path2 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"
            }
        }
    }
}

