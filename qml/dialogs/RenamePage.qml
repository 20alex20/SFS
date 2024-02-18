import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property bool connectedVirtual: true

    property int type: 2
    property string path: ""
    property string name: fileDirectoryName.text
    property bool file: true

    function init(t, p, n, f) {
        type = t
        path = p
        fileDirectoryName.text = n
        file = f
    }

    objectName: "renamePage"
    allowedOrientations: Orientation.Portrait
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
            function fix() {
                if (text.length == 0)
                    label = qsTr("Field is empty")
                else if (!validate(text))
                    label = (file ? qsTr("File") : qsTr("Folder")) + " " + qsTr("with the same name already exists")
                else
                    label = ""
            }
            function validate() {
                // код на плюсах
                var answer = true

                return answer
            }

            id: fileDirectoryName
            width: pageContainer.width
            color: "White"
            placeholderText: ""
            label: ""
            hideLabelOnEmptyField: false
            labelVisible: label !== ""
            acceptableInput: text.length > 0 && validate(text)
            onTextChanged: fix()
        }
    }
}
