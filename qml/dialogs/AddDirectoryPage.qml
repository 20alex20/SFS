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
    canAccept: directotyName.acceptableInput

    Column {
        id: pageContainer
        width: parent.width

        DialogHeader {
            acceptText: "Создать"
            cancelText: "Отмена"
        }

        Column {
            Label {
                topPadding: 30
                leftPadding: 30
                text: "Хранилище"
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }

            ComboBox {
                id: storage
                width: pageContainer.width
                valueColor: "White"
                menu: ContextMenu {
                    MenuItem {
                        text: "Удаленное"
                    }
                    MenuItem {
                        text: "Локальное"
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
                text: "Название папки"
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                function fix() {
                    if (text.length == 0)
                        label = "Поле не заполненно"
                    else if (!validate(text))
                        label = "Папка с таким именем уже существует"
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
                label: ""
                hideLabelOnEmptyField: false
                labelVisible: label !== ""
                acceptableInput: text.length > 0 && validate(text)
                onTextChanged: fix()
            }
        }
    }
}
