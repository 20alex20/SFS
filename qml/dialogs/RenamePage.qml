import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property bool connectedVirtual: true
    property QtObject controller
    property int type: 1
    property bool file: true
    property string name: fileDirectoryName.text
    property string lastName: ""

    function init(c, t, f, n) {
        controller = c
        type = t
        file = f
        lastName = n
        fileDirectoryName.text = n
    }

    objectName: "renamePage"
    showNavigationIndicator: false
    canAccept: fileDirectoryName.acceptableInput

    Column {
        id: pageContainer
        width: parent.width

        DialogHeader {
            acceptText: qsTr("Rename")
            cancelText: qsTr("Cancel")
        }
        Label {
            leftPadding: 30
            bottomPadding: 15
            text: qsTr("Name")
            color: Theme.highlightColor
            font.family: Theme.fontFamilyHeading
        }
        TextField {
            id: fileDirectoryName
            width: pageContainer.width
            color: "White"
            placeholderText: ""
            label: ""
            hideLabelOnEmptyField: false
            labelVisible: label !== ""
            acceptableInput: text.length > 0 && controller.validate(type, file, text, lastName)
            onTextChanged: label = controller.getLabel(type, file, text, lastName)
        }
    }
}
