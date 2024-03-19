import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property bool connectedVirtual: true
    property QtObject controller
    property int type: 1
    property bool file: true
    property string name: ""

    function init(c, t, f, n) {
        controller = c
        type = t
        file = f
        name = n

        var answer = controller.getInfo(type, file, name)
        path.text = answer[0]
        dateTime.text = answer[1]
        size.text = answer[2]
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
                id: path
                width: pageContainer.width
                wrapMode: TextInput.WordWrap
                color: "White"
                readOnly: true
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
