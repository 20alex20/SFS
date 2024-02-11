import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property bool connectedVirtual: true

    property string connectedHost: ""
    property string connectedUserName: ""
    property string connectedPassword: ""
    property string connectedPort: ""

    property bool blocking: false
    property string message: "Подключено"
    property bool transfering: false
    property var elements: null  // Array
    property string pathElements: ""
    property bool remote: false
    property bool copy: false

    property string path1: ""
    property int number1: 0
    property QtObject menuObject1: null
    property string path2: ""
    property int number2: 0
    property QtObject menuObject2: null

    function disconnect() {
        console.log("disconnect")
        if (!blocking) {
            blocking = true
            message = "Отключение..."

            // код на плюсах

            pageStack.replaceAbove(null, Qt.resolvedUrl("../pages/MainPage.qml"))
            message = "Подключено"
            blocking = false
        }
    }
    function reconnect() {
        console.log("reconnect")
        if (!blocking) {
            blocking = true
            message = "Переподключение..."

            // код на плюсах

            path1 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"  // 2
            getData1()  // 2
            message = "Подключено"
            blocking = false
        }
    }

    function getData1() {
        console.log("getData1")
        directory1.clear()
        var arr = []
        if (path1.search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus.png", file: true, date_time: "2013-09-17 10:56:06", size: 46468, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })

        number1 = arr.length
        for (var i = 0; i < number1; i++) {
            directory1.append(arr[i])
        }
    }
    function getData2() {
        console.log("getData2")
        directory2.clear()
        var arr = []
        if (path2.search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus.png", file: true, date_time: "2013-09-17 10:56:06", size: 46468, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })

        number2 = arr.length
        for (var i = 0; i < number2; i++) {
            directory2.append(arr[i])
        }
    }
    function clearMenus() {
        console.log("clearMenus")
        if (menuObject1 !== null) {
            menuObject1.destroy()
            menuObject1 = null
        }
        if (menuObject2 !== null) {
            menuObject2.destroy()
            menuObject2 = null
        }
    }
    function dedicated1() {
        console.log("dedicated1")
        var arr = [], elem, i
        for (i = (directory1.get(0).name === ".." ? 1 : 0); i < number1; i++) {
            elem = directory1.get(i)
            if (elem.isChecked)
                arr.push(elem)
        }
        return arr
    }
    function dedicated2() {
        console.log("dedicated2")
        var arr = [], elem, i
        for (i = (directory2.get(0).name === ".." ? 1 : 0); i < number2; i++) {
            elem = directory2.get(i)
            if (elem.isChecked)
                arr.push(elem)
        }
        return arr
    }
    function beforeTransfer(type, mode) {
        console.log("beforeTransfer")
        if (type === 1) {
            elements = dedicated1()
            pathElements = path1
            remote = false
        }
        else {
            elements = dedicated2()
            pathElements = path2
            remote = true
        }
        copy = mode === 2
    }
    function startTransfer(type, mode) {
        console.log("startTransfer")
        if (!blocking) {
            blocking = true
            var arr
            if (mode !== 5) {
                if (elements === null) {
                    blocking = false
                    return
                }
                arr = elements
                elements = null
            }
            else {
                arr = type === 1 ? dedicated1() : dedicated2()
            }

            // код на плюсах
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
        console.log("stopTransfer")
        if (transfering) {
            message = "Отмена операции"
            transfering = false
        }
    }

    id: page
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
            width: parent.width
            height: (parent.height - parent.children[0].height) / 2
            Component.onCompleted: {
                // код на плюсах

                path1 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"
                getData1()
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
                        text: path1
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
                            onPressed: {
                                for (var i = 0; i < number1; i++) {
                                    var elem = directory1.get(i)
                                    elem.isChecked = name === ".."
                                    directory1.set(i, elem)
                                }
                                isChecked = true
                            }
                            onDoubleClicked: if (!file) {
                                if (name === "..")
                                    path1 = path1.slice(0, path1.lastIndexOf("/"))
                                else
                                    path1 += "/" + name
                                getData1()
                            }
                            onPressAndHold: {
                                clearMenus()
                                parent.parent.z = 2
                                menuObject1 = smallMenu1.createObject(parent.parent)
                                menuObject1.x = mouseX
                                menuObject1.y = mouseY
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
                        onPressed: {
                            isChecked = !isChecked
                            var elem, i
                            if (name === "..") {
                                for (i = 1; i < number1; i++) {
                                    elem = directory1.get(i)
                                    elem.isChecked = isChecked
                                    directory1.set(i, elem)
                                }
                            }
                            else if (directory1.get(0).name === "..") {
                                for (i = 1; i < number1; i++) {
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
                        onPressAndHold: {
                            // подставить
                        }

                        Image {
                            anchors.centerIn: parent
                            source: parent.icon.source
                            width: parent.icon.width
                            height: parent.icon.height
                        }
                    }
                }

                Component {
                    id: largeMenu1

                    Rectangle {
                        color: "White"
                        border.color: Theme.highlightBackgroundColor
                        border.width: 5
                        width: children[0].width + 10
                        height: children[0].height + 10

                        Column {
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.margins: 5

                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Отправить на сервер"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }
                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Копировать"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }
                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Вырезать"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }
                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Удалить"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }
                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Вставить"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }
                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Переименновать"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }
                            Label {
                                leftPadding: 20
                                rightPadding: 20
                                topPadding: 10
                                bottomPadding: 10

                                color: children[0].pressed ? Theme.highlightColor : "Black"
                                font.family: Theme.fontFamily
                                font.pixelSize: 32
                                text: "Свойства"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject1.destroy()
                                    }
                                }
                            }

                            Component.onCompleted: {
                                var n = 7, maxLength = 0, i
                                for (i = 0; i < n; i++) {
                                    var curLength = children[i].width
                                    if (curLength > maxLength)
                                        maxLength = curLength
                                }
                                for (i = 0; i < n; i++) {
                                    children[i].width = maxLength
                                }
                            }
                        }
                    }
                }
            }

            Component {
                id: smallMenu1

                Rectangle {
                    color: "White"
                    border.color: Theme.highlightBackgroundColor
                    border.width: 5
                    width: children[0].width + 10
                    height: children[0].height + 10

                    Column {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: 5

                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 10
                            bottomPadding: 10

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 32
                            text: "Отправить на сервер"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    menuObject1.destroy()
                                    startTransfer(1, 1)
                                }
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 10
                            bottomPadding: 10

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 32
                            text: "Копировать"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    menuObject1.destroy()
                                    beforeTransfer(1, 2)
                                }
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 10
                            bottomPadding: 10

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 32
                            text: "Вырезать"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    menuObject1.destroy()
                                    beforeTransfer(1, 3)
                                }
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 10
                            bottomPadding: 10

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 32
                            text: "Удалить"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    menuObject1.destroy()
                                    startTransfer(1, 4)
                                }
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 10
                            bottomPadding: 10

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 32
                            text: "Вставить"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    menuObject1.destroy()
                                    startTransfer(1, 5)
                                }
                            }
                        }

                        Component.onCompleted: {
                            var n = 5, maxLength = 0, i
                            for (i = 0; i < n; i++) {
                                var curLength = children[i].width
                                if (curLength > maxLength)
                                    maxLength = curLength
                            }
                            for (i = 0; i < n; i++) {
                                children[i].width = maxLength
                            }
                        }
                    }
                }
            }

        }
    }
}

