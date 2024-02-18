import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property bool connectedVirtual: true

    property int type: 2
    property string path: ""
    property string name: ""
    property bool file: true

    function init(t, p, n, f) {
        type = t
        path = p
        name = n
        file = f
        var units = [qsTr("B"), qsTr("Kb"), qsTr("Mb"), qsTr("Gb")]

        // код на плюсах
        dateTime.text = "12.02.2024"

        size.text = "12" + " " + units[2]
    }

    objectName: "propertiesPage"
    allowedOrientations: Orientation.Portrait
    showNavigationIndicator: false
    canAccept: false

    Column {
        id: pageContainer
        width: parent.width

        DialogHeader {
            acceptText: ""
            cancelText: qsTr("Back")
        }

        Column {
            Label {
                leftPadding: 30
                bottomPadding: 15
                text: qsTr("Type")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                width: pageContainer.width
                color: "White"
                readOnly: true
                text: file ? qsTr("File") : qsTr("Folder")
            }
        }

        Column {
            Label {
                topPadding: 20
                leftPadding: 30
                bottomPadding: 15
                text: qsTr("Name")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                width: pageContainer.width
                color: "White"
                readOnly: true
                text: name
            }
        }

        Column {
            Label {
                topPadding: 20
                leftPadding: 30
                bottomPadding: 15
                text: qsTr("Size")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                id: size
                width: pageContainer.width
                readOnly: true
                color: "White"
            }
        }

        Column {
            Label {
                topPadding: 20
                leftPadding: 30
                bottomPadding: 15
                text: qsTr("Modification date")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                id: dateTime
                width: pageContainer.width
                readOnly: true
                color: "White"
            }
        }
    }
}
