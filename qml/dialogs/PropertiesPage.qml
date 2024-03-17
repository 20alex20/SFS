import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property int type: 1
    property string path: ""
    property bool file: true
    property string name: ""

    function init(t, f, n) {
        type = t
        path = pageStack.previousPage().model.path[type - 1]
        file = f
        name = n
        var units = [qsTr("B"), qsTr("Kb"), qsTr("Mb"), qsTr("Gb")]

        // код на плюсах
        dateTime.text = "12.02.2024"

        size.text = "12" + " " + units[2]
    }

    objectName: "propertiesPage"
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
                text: qsTr("Path")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                width: pageContainer.width
                color: "White"
                readOnly: true
                text: path
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
