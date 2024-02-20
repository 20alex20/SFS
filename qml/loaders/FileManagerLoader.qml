import QtQuick 2.0
import QtGraphicalEffects 1.0
import Sailfish.Silica 1.0

Column {
    property bool onCompleted: false
    QtObject {
        id: reload
        function data() {
            reloadData()
        }
    }
    property var vars: {
        var page = pageStack.currentPage, p
        if (page.objectName === "sftpPage")
            p = page
        else
            p = pageStack.previousPage()
        if (!onCompleted && p !== null) {
            if (type === 1)
                p.reload1 = reload
            else
                p.reload2 = reload
            onCompleted = true
        }
        return p
    }
    property int type: 1
    property string path: vars !== null ? (type === 1 ? vars.path1 : vars.path2) : ""
    property bool blockingReloadData: false

    function reloadData() {
        records.clear()
        if (path === "")
            return
        var arr = []
        if (path.search("/") !== -1)
            arr.push({ name: "..", file: false, isChecked: false })

        // код на плюсах
        arr.push({ name: "amogus.png", file: true, isChecked: false })
        arr.push({ name: "life", file: false, isChecked: false })

        for (var i = 0; i < arr.length; i++) {
            records.append(arr[i])
        }
    }
    function selected() {
        var arr = [], elem, i = Number(records.get(0).name === "..")
        while (i < records.count) {
            elem = records.get(i)
            if (elem.isChecked)
                arr.push(elem)
            i++
        }
        return arr
    }
    function hold(x, y, rect) {
        if (!vars.blocking) {
            if (type === 1)
                vars.children[0].children[1].z = 1
            row.z = 0
            rect.z = 2
            var menuObject
            if (selected().length === 1)
                menuObject = largeMenu.createObject(rect)
            else
                menuObject = smallMenu.createObject(rect)
            x = x + menuObject.width > rect.width ? x - menuObject.width : x
            if (type === 2)
                y -= menuObject.height
            menuObject.x = x
            menuObject.y = y
            vars.currentElement = rect
            vars.menuObject = menuObject
            vars.currentRow = row
        }
    }

    function beforeTransfer(mode) {
        console.log("beforeTransfer")
        vars.closeMenu()
        vars.typeElements = type
        vars.modeElements = mode
        vars.elements = selected()
        vars.pathElements = path
    }
    function startTransfer(mode) {
        console.log("startTransfer")
        vars.closeMenu()
        vars.blocking = true
        var arr
        if (mode !== 5) {
            if (vars.elements === null) {
                vars.blocking = false
                return
            }
            arr = vars.elements
            vars.elements = null
        }
        else {
            arr = selected()
        }

        // код на плюсах
        var quantity = 41

        vars.transfering = true
        for (var num = 0; num < quantity; num++) {
            if (!vars.transfering) {
                // код на плюсах

                break
            }
            vars.message = qsTr("Processed") + num + " " + qsTr("out of") + " " + quantity

            // код на плюсах
        }
        vars.transfering = false
        vars.message = qsTr("Connected")
        reloadData()
        vars.blocking = false
    }
    function openDialog(mode) {
        console.log("openDialog")
        closeMenu()
        if (!blocking) {
            var elem = selected()[0]
            var dialog = pageStack.push(Qt.resolvedUrl(mode === 6 ? "../dialogs/RenamePage.qml" : "../dialogs/PropertiesPage.qml"))
            dialog.init(type, path, elem.name, elem.file)
            if (mode === 6)
                dialog.accepted.connect(function() {
                    vars.blocking = true

                    // код на плюсах

                    reloadData()
                    vars.blocking = false
                })
        }
    }

    Row {
        id: row
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
                text: type === 1 ? qsTr("Local storage").replace(" ", "<br>") : qsTr("Remote storage").replace(" ", "<br>")
            }
            MouseArea {
                anchors.fill: parent
                onPressed: closeMenu()
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
                text: path
                onTextChanged: reloadData()
            }
            MouseArea {
                anchors.fill: parent
                onPressed: closeMenu()
            }
        }
    }

    ListModel {
        id: records
    }

    ListView {
        width: parent.width
        height: parent.height - parent.children[0].height
        z: 0
        flickDeceleration: Flickable.VerticalFlick
        onMovementStarted: vars.closeMenu()
        model: records
        delegate: Rectangle {
            function setPressed() {
                var flag = name === ".."
                for (var i = 0; i < records.count; i++) {
                    var elem = records.get(i)
                    if (elem.isChecked !== flag) {
                        elem.isChecked = flag
                        records.set(i, elem)
                    }
                }
                isChecked = true
            }
            function setPressed2() {
                isChecked = !isChecked
                if (records.get(0).name !== "..")
                    return
                var allTrue = true, flag = name === ".."
                for (var i = 1; i < records.count; i++) {
                    var elem = records.get(i)
                    if (flag && elem.isChecked !== isChecked) {
                        elem.isChecked = isChecked
                        records.set(i, elem)
                    }
                    if (!elem.isChecked)
                        allTrue = false
                }
                elem = records.get(0)
                elem.isChecked = allTrue
                records.set(0, elem)
            }

            property bool localBlocking: false

            id: rect
            width: parent.width
            height: 80
            color: isChecked ? Theme.highlightColor.toString().replace("#", "#80") : "Transparent"

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                width: parent.width - parent.children[1].width
                height: parent.height
                color: "Transparent"

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
                    onPressed: closeMenu()
                    onReleased: rect.localBlocking = false
                    onClicked: if (!rect.localBlocking) rect.setPressed()
                    onPressAndHold: {
                        if (!isChecked)
                            rect.setPressed()
                        localBlocking = true
                        hold(mouseX, mouseY, rect)
                    }
                    onDoubleClicked: if (!vars.blocking && !file) {
                        var p
                        if (name === "..")
                            p = path.slice(0, path.lastIndexOf("/"))
                        else
                            p = path + "/" + name
                        if (type === 1)
                            vars.path1 = p
                        else
                            vars.path2 = p
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
                onPressed: closeMenu()
                onReleased: rect.localBlocking = false
                onClicked: if (!rect.localBlocking) rect.setPressed2()
                onPressAndHold: {
                    if (!isChecked)
                        rect.setPressed2()
                    localBlocking = true
                    hold(mouseX + parent.children[0].width, mouseY, rect)
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
            id: largeMenu

            Item {
                width: children[0].width
                height: children[0].height

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
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: type === 1 ? qsTr("Upload to server") : qsTr("Download from server")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: startTransfer(1)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Copy")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: beforeTransfer(2)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Cut")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: beforeTransfer(3)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Delete")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: startTransfer(4)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Insert")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: startTransfer(5)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Rename")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: openDialog(6)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Properties")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: openDialog(7)
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

                DropShadow {
                    anchors.fill: parent.children[0]
                    horizontalOffset: 8
                    verticalOffset: 8
                    radius: 10
                    samples: 21
                    color: "#80000000"
                    source: parent.children[0]
                }
            }
        }

        Component {
            id: smallMenu

            Item {
                width: children[0].width
                height: children[0].height

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
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: type === 1 ? qsTr("Upload to server") : qsTr("Download from server")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: startTransfer(1)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Copy")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: beforeTransfer(2)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Cut")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: beforeTransfer(3)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Delete")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: startTransfer(4)
                            }
                        }
                        Label {
                            leftPadding: 20
                            rightPadding: 20
                            topPadding: 8
                            bottomPadding: 8

                            color: children[0].pressed ? Theme.highlightColor : "Black"
                            font.family: Theme.fontFamily
                            font.pixelSize: 30
                            text: qsTr("Insert")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: startTransfer(5)
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

                DropShadow {
                    anchors.fill: parent.children[0]
                    horizontalOffset: 8
                    verticalOffset: 8
                    radius: 10
                    samples: 21
                    color: "#80000000"
                    source: parent.children[0]
                }
            }
        }
    }
}
