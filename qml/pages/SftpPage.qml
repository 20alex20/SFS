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
                    icon.source: "../icons/buttons/70x70/disconnect.png"
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
                    icon.source: "../icons/buttons/70x70/refresh.png"
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

                    Image {
                        anchors.centerIn: parent
                        source: parent.icon.source
                        width: parent.icon.width
                        height: parent.icon.height
                    }
                }
            }
        }

        Column {
            property string path1: ""
            property int number1: 0

            function getData() {
                directory1.clear()
                var arr = []
                if (path1.search("/") !== -1)
                    arr.push({ name: "..", file: false, isChecked: false })

                // код на C++
                arr.push({ name: "amogus.png", file: true, date_time: "2013-09-17 10:56:06", size: 46468, isChecked: false })
                arr.push({ name: "life", file: false, isChecked: false })

                number1 = arr.length
                for (var i = 0; i < number1; i++) {
                    directory1.append(arr[i])
                }
            }

            id: local
            width: parent.width
            height: (parent.height - parent.children[0].height) / 2
            Component.onCompleted: {
                // код на плюсах
                path1 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"
                getData()
            }

            Row {
                width: parent.width
                z: 1

                Rectangle {
                    color: Theme.highlightBackgroundColor
                    width: children[0].width
                    height: children[0].height

                    Label {
                        topPadding: 8
                        bottomPadding: 8
                        leftPadding: 8
                        textFormat: Text.StyledText
                        horizontalAlignment: Text.AlignHCenter
                        color: "White"
                        font.family: Theme.fontFamilyHeading
                        font.pixelSize: 30
                        font.bold: true
                        text: "Локальный<br>сервер"
                    }
                }

                Rectangle {
                    height: parent.children[0].height
                    width: parent.width - parent.children[0].width
                    border.color: Theme.highlightBackgroundColor
                    border.width: 8
                    color: "White"

                    Label {
                        width: parent.width - 30
                        anchors.centerIn: parent
                        elide: Text.ElideMiddle
                        color: "Black"
                        font.family: Theme.fontFamily
                        font.pixelSize: 32
                        text: local.path1
                    }
                }
            }

            ListModel {
                id: directory1
            }
            ListView {
                width: parent.width
                height: parent.height - parent.children[0].height
                z: 0
                flickDeceleration: Flickable.VerticalFlick
                model: directory1
                delegate: Rectangle {
                    width: parent.width
                    height: 80
                    color: isChecked ? Theme.highlightColor.toString().replace("#", "#80") : "transparent"

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: parent.width - parent.children[1].width
                        height: parent.height
                        color: "transparent"

                        Image {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.margins: 15
                            width: 50
                            height: 50
                            source: file ? "../icons/file_manager/file.png" : "../icons/file_manager/folder.png"
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 15
                            width: parent.width - 95
                            height: parent.height

                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideMiddle
                            color: "White"
                            font.pixelSize: 32
                            text: name
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                for (var i = 0; i < local.number1; i++) {
                                    var elem = directory1.get(i)
                                    elem.isChecked = name === ".."
                                    directory1.set(i, elem)
                                }
                                isChecked = true
                            }
                            onDoubleClicked: if (!file) {
                                if (name === "..")
                                    local.path1 = local.path1.slice(0, local.path1.lastIndexOf("/"))
                                else
                                    local.path1 += "/" + name
                                local.getData()
                            }
                        }
                    }

                    IconButton {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        width: parent.height
                        height: parent.height
                        icon.source: isChecked ? "../icons/file_manager/checkbox.png" : "../icons/file_manager/empty_checkbox.png"
                        icon.width: 40
                        icon.height: 40
                        icon.visible: false
                        onContainsPressChanged: {
                            icon.visible = containsPress
                            children[1].visible = !containsPress
                        }
                        onClicked: {
                            isChecked = !isChecked
                            var elem, i
                            if (name === "..") {
                                for (i = 1; i < local.number1; i++) {
                                    elem = directory1.get(i)
                                    elem.isChecked = isChecked
                                    directory1.set(i, elem)
                                }
                            }
                            else {
                                for (i = 1; i < local.number1; i++) {
                                    if (!directory1.get(i).isChecked) {
                                        elem = directory1.get(0)
                                        elem.isChecked = false
                                        directory1.set(0, elem)
                                        return
                                    }
                                }
                                elem = directory1.get(0)
                                elem.isChecked = true
                                directory1.set(0, elem)
                            }
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
}

