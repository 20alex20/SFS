import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property QtObject controller
    property int type: 1
    property string name: directoryName.text

    function init() {
        controller = pageStack.previousPage().controller
    }

    objectName: "addDirectoryPage"
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
                        text: qsTr("Local")
                    }
                    MenuItem {
                        text: qsTr("Remote")
                    }

                    onActivated: type = index + 1
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
                id: directoryName
                width: pageContainer.width
                color: "White"
                placeholderText: ""
                label: ""
                hideLabelOnEmptyField: false
                labelVisible: label !== ""
                acceptableInput: text.length > 0 && controller.validate(type, true, text)
                onTextChanged: {
                    if (text.length == 0)
                        label = qsTr("Field is empty")
                    else if (!validate(text))
                        label = qsTr("A folder with the same name already exists")
                    else
                        label = ""
                }
            }
        }
    }
}
