import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property bool connectedVirtual: true

    property int type: 2
    property string path1: ""
    property string path2: ""
    property string name: directoryName.text

    function init(p1, p2) {
        path1 = p1
        path2 = p2
    }

    objectName: "addDirectoryPage"
    allowedOrientations: Orientation.Portrait
    showNavigationIndicator: false
    canAccept: directoryName.acceptableInput

    Column {
        id: pageContainer
        width: parent.width

        DialogHeader {
            acceptText: qsTr("Create")
            cancelText: qsTr("Cancel")
        }

        Column {
            Label {
                topPadding: 30
                leftPadding: 30
                text: qsTr("Storage")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }

            ComboBox {
                id: storage
                width: pageContainer.width
                valueColor: "White"
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Remote")
                    }
                    MenuItem {
                        text: qsTr("Local")
                    }

                    onActivated: type = index === 0 ? 2 : 1
                    Component.onCompleted: {
                        for(var i = 0; i < children.length; i++)
                            children[i].color = "White"
                    }
                }
            }
        }

        Column {
            Label {
                topPadding: 20
                leftPadding: 30
                bottomPadding: 15
                text: qsTr("Folder name")
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                function fix() {
                    if (text.length == 0)
                        label = qsTr("Field is empty")
                    else if (!validate(text))
                        label = qsTr("A folder with the same name already exists")
                    else
                        label = ""
                }
                function validate() {
                    // код на плюсах
                    var answer = text !== "life"

                    return answer
                }

                id: directoryName
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
}
