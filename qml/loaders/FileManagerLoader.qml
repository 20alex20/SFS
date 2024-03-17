import QtQuick 2.0
import QtGraphicalEffects 1.0
import Sailfish.Silica 1.0

Column {
    property QtObject model
    property QtObject controller
    property int type: 1

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
                onPressed: controller.closeMenu()
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
                onTextChanged: controller.reloadData()
            }
            MouseArea {
                anchors.fill: parent
                onPressed: controller.closeMenu()
            }
        }
    }

    ListView {
        width: parent.width
        height: parent.height - parent.children[0].height
        z: 0
        flickDeceleration: Flickable.VerticalFlick
        onMovementStarted: controller.closeMenu()
        model: model.records[type - 1]
        delegate: Rectangle {
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
                    onPressed: controller.closeMenu()
                    onClicked: { controller.setPressed(type); isChecked = true }
                    onPressAndHold: {
                        if (!isChecked) {
                            controller.setPressed(type)
                            isChecked = true
                        }
                        controller.openMenu(type, mouseX, mouseY, row, rect,
                                            controller.selected().length === 1 ? largeMenu : smallMenu)
                    }
                    onDoubleClicked: if (!file) controller.openDirectory(type, name === "..")
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
                onPressed: controller.closeMenu()
                onClicked: { isChecked = !isChecked; controller.setPressed2(type) }
                onPressAndHold: {
                    if (!isChecked) {
                        isChecked = !isChecked
                        controller.setPressed2(type)
                    }
                    controller.openMenu(type, mouseX + parent.children[0].width, mouseY, row, rect,
                                        controller.selected().length === 1 ? largeMenu : smallMenu)
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
                                onClicked: controller.startTransfer(type, 1)
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
                                onClicked: controller.beforeTransfer(type, 2)
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
                                onClicked: controller.beforeTransfer(type, 3)
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
                                onClicked: controller.startTransfer(type, 4)
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
                                onClicked: controller.startTransfer(type, 5)
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
                                onClicked: controller.openDialog(type, 6)
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
                                onClicked: controller.openDialog(type, 7)
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
                                onClicked: controller.startTransfer(type, 1)
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
                                onClicked: controller.beforeTransfer(type, 2)
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
                                onClicked: controller.beforeTransfer(type, 3)
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
                                onClicked: controller.startTransfer(type, 4)
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
                                onClicked: controller.startTransfer(type, 5)
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
