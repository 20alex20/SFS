import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property QtObject model
    property QtObject controller

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
                    icon.source: !model.blocking ? "../icons/buttons/70x70/disconnect.png" : "../icons/buttons/70x70/disconnect_2.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: if (!model.blocking) {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: controller.disconnect()
                    onPressed: controller.closeMenu()

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
                    icon.source: !model.blocking ? "../icons/buttons/70x70/refresh.png" : "../icons/buttons/70x70/refresh_2.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: if (!model.blocking) {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: controller.reconnect()
                    onPressed: controller.closeMenu()

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
                    text: model.message
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: controller.closeMenu()
                }
            }

            Row {
                IconButton {
                    width: 100
                    height: 100
                    icon.source: !model.blocking ? "../icons/buttons/70x70/cancel.png" : "../icons/buttons/70x70/cancel_2.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: if (!model.blocking) {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: controller.stopTransfer()
                    onPressed: controller.closeMenu()

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
                    icon.source: !model.blocking ? "../icons/buttons/70x70/add_directory.png" : "../icons/buttons/70x70/add_directory.png"
                    icon.width: 70
                    icon.height: 70
                    icon.visible: false
                    onContainsPressChanged: if (!model.blocking) {
                        icon.visible = containsPress
                        children[1].visible = !containsPress
                    }
                    onClicked: controller.addDirectory()
                    onPressed: controller.closeMenu()

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
            z: model.loader1_z
            Component.onCompleted: setSource("../loaders/FileManagerLoader.qml", { "type": 1, "model": model, "controller": controller })
            onLoaded: controller.reboot(1)
        }

        Loader {
            id: loader2
            width: parent.width
            height: parent.height - parent.children[0].height - parent.children[1].height
            z: 0
            Component.onCompleted: setSource("../loaders/FileManagerLoader.qml", { "type": 2, "model": model, "controller": controller })
            onLoaded: controller.reboot(2)
        }
    }
}

