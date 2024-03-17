import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property QtObject controller
    property int type: 1
    property bool file: true
    property string name: fileDirectoryName.text

    function init(t, f, n) {
        type = t
        file = f
        fileDirectoryName.text = n
        controller = pageStack.previousPage().controller
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
            acceptableInput: text.length > 0 && controller.validate(type, file, text)
            onTextChanged: {
                if (text.length == 0)
                    label = qsTr("Field is empty")
                else if (!validate(text))
                    label = (file ? qsTr("File") : qsTr("Folder")) + " " + qsTr("with the same name already exists")
                else
                    label = ""
            }
        }
    }
}
