import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    property QtObject model
    property QtObject controller
    property bool connectedVirtual: pageStack.currentPage.connectedVirtual
    onConnectedVirtualChanged: {
        if (connectedVirtual) {
            model = pageStack.currentPage.model
            controller = pageStack.currentPage.controller
        }
        else {
            model = null
            controller = null
        }
    }

    objectName: "сover"

    CoverActionList {
        CoverAction {
            iconSource: connectedVirtual && !model.blocking ? "../icons/buttons/40x40/disconnect.png" : "../icons/buttons/40x40/disconnect_2.png"
            onTriggered: if (connectedVirtual) controller.disconnect()
        }
        CoverAction {
            iconSource: connectedVirtual && !model.blocking ? "../icons/buttons/40x40/refresh.png" : "../icons/buttons/40x40/refresh_2.png"
            onTriggered: if (connectedVirtual) controller.reconnect()
        }
        CoverAction {
            iconSource: connectedVirtual && model.transfering ? "../icons/buttons/40x40/cancel.png" : "../icons/buttons/40x40/cancel_2.png"
            onTriggered: if (connectedVirtual) controller.stopTransfer()
        }
    }

    Column {
        id: column
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        spacing: 5

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "SFS"
            color: "White"
            font.bold: true
            font.pixelSize: 40
        }
        Label {
            text: qsTr("Host:")
            font.bold: true
            font.pixelSize: 32
            color: Theme.highlightColor
            font.family: Theme.fontFamilyHeading
        }
        Label {
            text: connectedVirtual ? model.host : "-"
            font.pixelSize: 32
            color: Theme.highlightColor
            font.family: Theme.fontFamily
        }

        Label {
            text: qsTr("Port:")
            font.bold: true
            font.pixelSize: 32
            color: Theme.highlightColor
            font.family: Theme.fontFamilyHeading
        }
        Label {
            text: connectedVirtual ? model.port : "-"
            font.pixelSize: 32
            color: Theme.highlightColor
            font.family: Theme.fontFamily
        }
    }

    Label {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: (parent.height - column.height - 87.5 - height) / 2 + 87.5

        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        text: connectedVirtual ? model.message : qsTr("Not connected")
        color: "White"
        font.pixelSize: 32
    }
}
