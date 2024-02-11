import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    property bool connectedVirtual: pageStack.currentPage.connectedVirtual

    function getFirstPage() {
        var page = pageStack.currentPage
        if (page.objectName === "sftpPage")
            return page
        else
            return pageStack.previousPage()
    }

    objectName: "defaultCover"

    CoverActionList {
        CoverAction {
            iconSource: connectedVirtual ? "../icons/buttons/40x40/disconnect.png" : "../icons/buttons/40x40/disconnect_2.png"
            onTriggered: if (connectedVirtual) getFirstPage().disconnect()
        }
        CoverAction {
            iconSource: connectedVirtual ? "../icons/buttons/40x40/refresh.png" : "../icons/buttons/40x40/refresh_2.png"
            onTriggered: if (connectedVirtual) getFirstPage().reconnect()
        }
        CoverAction {
            iconSource: connectedVirtual && getFirstPage().transfering ? "../icons/buttons/40x40/cancel.png" : "../icons/buttons/40x40/cancel_2.png"
            onTriggered: if (connectedVirtual) getFirstPage().stopTransfer()
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
            text: qsTr("SFS")
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
            text: connectedVirtual ? getFirstPage().connectedHost : "-"
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
            text: connectedVirtual ? getFirstPage().connectedPort : "-"
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
        text: connectedVirtual ? getFirstPage().message : "Неподключено"
        color: "White"
        font.pixelSize: 32
    }
}
