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

    //
    property var currentElement: null

    property string path1: ""
    property int number1: 0
    property var menuObject: null
    property string path2: ""
    property int number2: 0

    property int type2: 1
    property int mode2: 1
    property var elements: null
    property string pathElements: ""
    //

    function init(h, un, pw, p) {
        connectedHost = h
        connectedUserName = un
        connectedPassword = pw
        connectedPort = p
    }

    function reloadData1() {
        console.log("reloadData1")
        data1.clear()
        var arr = []
        if (path1.search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus.png", file: true, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })

        number1 = arr.length
        for (var i = 0; i < number1; i++) {
            data1.append(arr[i])
        }
    }
    function reloadData2() {
        console.log("reloadData2")
        data2.clear()
        var arr = []
        if (path2.search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus.png", file: true, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })

        number2 = arr.length
        for (var i = 0; i < number2; i++) {
            data2.append(arr[i])
        }
    }

    function disconnect() {
        console.log("disconnect")
        if (!blocking) {
            blocking = true
            message = "Отключение"

            // код на плюсах

            pageStack.replaceAbove(null, Qt.resolvedUrl("MainPage.qml"))
            message = "Подключено"
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
            path2 = "C:/Users/Alex/AuroraIDEProjects/SFS/qml/pages"

            reloadData2()
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
                    reloadData1()
                else
                    reloadData2()
                blocking = false
            })
        }
    }

//
    function selected1() {
        console.log("selected1")
        var arr = [], elem, i = Number(data1.get(0).name === "..")
        while (i < number1) {
            elem = data1.get(i)
            if (elem.isChecked)
                arr.push(elem)
            i++
        }
        return arr
    }
    function selected2() {
        console.log("selected2")
        var arr = [], elem, i = Number(data2.get(0).name === "..")
        while (i < number2) {
            elem = data2.get(i)
            if (elem.isChecked)
                arr.push(elem)
            i++
        }
        return arr
    }
    function hold1(x, y, rect) {
        if (!blocking) {
            currentElement = rect
            currentElement.z = 2
            var elem = null
            for (var i = 0; i < number1; i++) {
                var curElem = data1.get(i)
                if (curElem.isChecked) {
                    if (elem !== null) {
                        elem = null
                        break
                    }
                    else {
                        elem = curElem
                    }
                }
            }
            if (elem !== null)
                menuObject = largeMenu1.createObject(currentElement)
            else
                menuObject = smallMenu1.createObject(currentElement)
            x = x + menuObject.width > currentElement.width ? currentElement.width - menuObject.width : x
            menuObject.x = x
            menuObject.y = y
        }
    }
    function clearMenus() {
        console.log("clearMenus")
        if (menuObject !== null) {
            menuObject.destroy()
            menuObject = null
            currentElement.z = 0
        }
    }

    function beforeTransfer(type, mode) {
        console.log("beforeTransfer")
        if (type === 1) {
            elements = selected1()
            pathElements = path1
        }
        else {
            elements = selected2()
            pathElements = path2
        }
        type2 = type
        mode2 = mode
    }
    function startTransfer(type, mode) {
        console.log("startTransfer")
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
            arr = type === 1 ? selected1() : selected2()
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
        if (type === 1)
            reloadData1()
        else
            reloadData2()
        blocking = false
    }
    function rename(type, name, file) {
        console.log("rename")
        if (!blocking) {
            var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/RenamePage.qml"))
            dialog.init(type, type === 1 ? path1 : path2, name, file)
            dialog.accepted.connect(function() {
                blocking = true

                // код на плюсах

                if (dialog.type === 1)
                    reloadData1()
                else
                    reloadData2()
                blocking = false
            })
        }
    }
    function properties(type, name, file) {
        console.log("properties")
        if (!blocking) {
            var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/PropertiesPage.qml"))
            dialog.init(type, type === 1 ? path1 : path2, name, file)
        }
    }
//

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
                    onPressed: clearMenus()

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
                    onPressed: clearMenus()

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
                    onPressed: clearMenus()
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
                    onPressed: clearMenus()

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
                    onPressed: clearMenus()

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
                reloadData1()
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

                    MouseArea {
                        anchors.fill: parent
                        onPressed: clearMenus()
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

                    MouseArea {
                        anchors.fill: parent
                        onPressed: clearMenus()
                    }
                }
            }

            ListModel {
                id: data1
            }

            ListView {
                width: parent.width
                height: parent.height - parent.children[0].height
                z: 0
                flickDeceleration: Flickable.VerticalFlick
                model: data1
                delegate: Rectangle {
                    function setPressed() {
                        var flag = name === ".."
                        for (var i = 0; i < number1; i++) {
                            var elem = data1.get(i)
                            if (elem.isChecked !== flag) {
                                elem.isChecked = flag
                                data1.set(i, elem)
                            }
                        }
                        isChecked = true
                    }
                    function setPressed2() {
                        isChecked = !isChecked
                        if (data1.get(0).name !== "..")
                            return
                        var allTrue = true, flag = name === ".."
                        for (var i = 1; i < number1; i++) {
                            var elem = data1.get(i)
                            if (flag && elem.isChecked !== isChecked) {
                                elem.isChecked = isChecked
                                data1.set(i, elem)
                            }
                            if (!elem.isChecked)
                                allTrue = false
                        }
                        elem = data1.get(0)
                        elem.isChecked = allTrue
                        data1.set(0, elem)
                    }

                    property bool localBlocking: false

                    id: rect1
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
                            onPressed: clearMenus()
                            onReleased: rect1.localBlocking = false
                            onClicked: if (!rect1.localBlocking) rect1.setPressed()
                            onPressAndHold: {
                                if (!isChecked)
                                    rect1.setPressed()
                                localBlocking = true
                                hold1(mouseX, mouseY, rect1)
                            }
                            onDoubleClicked: if (!blocking && !file) {
                                if (name === "..")
                                    path1 = path1.slice(0, path1.lastIndexOf("/"))
                                else
                                    path1 += "/" + name
                                reloadData1()
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
                        onPressed: clearMenus()
                        onReleased: rect1.localBlocking = false
                        onClicked: if (!rect1.localBlocking) rect1.setPressed2()
                        onPressAndHold: {
                            if (!isChecked)
                                rect1.setPressed2()
                            localBlocking = true
                            hold1(mouseX, mouseY, rect1)
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
                        property bool file: false
                        property string fileDirectoryName: ""

                        id: rect
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
                                        startTransfer(1, 5)
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
                                text: "Переименовать"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        menuObject.destroy()
                                        rename(1, rect.fileDirectoryName, rect.file)
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
                                        menuObject.destroy()
                                        properties(1, rect.fileDirectoryName, rect.file)
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

                        Component.onCompleted: {
                            var elem = null
                            for (var i = 0; i < number1; i++) {
                                var curElem = data1.get(i)
                                if (curElem.isChecked) {
                                    elem = curElem
                                }
                            }
                            file = elem.file
                            fileDirectoryName = elem.name
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
                                        menuObject.destroy()
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
}

