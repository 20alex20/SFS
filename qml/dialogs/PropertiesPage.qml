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

        // код на плюсах
        dateTime.text = "12.02.2024"
        size.text = "12 Мб"
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
            cancelText: "Назад"
        }

        Column {
            Label {
                leftPadding: 30
                bottomPadding: 15
                text: "Тип"
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
            }
            TextField {
                width: pageContainer.width
                color: "White"
                readOnly: true
                text: file ? "Файл" : "Папка"
            }
        }

        Column {
            Label {
                topPadding: 20
                leftPadding: 30
                bottomPadding: 15
                text: "Название"
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
                text: "Дата изменения"
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
                text: "Дата изменения"
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
