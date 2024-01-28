import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.Portrait

    /*PageHeader {
        objectName: "pageHeader"
        title: qsTr("SFS")
        extraContent.children: [
            IconButton {
                objectName: "aboutButton"
                icon.source: "image://theme/icon-m-about"
                anchors.verticalCenter: parent.verticalCenter

                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        ]
    }*/
    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: pageContainer
            width: parent.width
            spacing: 20

            Column {
                Label {
                    topPadding: 30
                    leftPadding: 30
                    text: "Соединение"
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }

                ComboBox {
                    width: pageContainer.width
                    valueColor: "White"
                    menu: ContextMenu {
                        MenuItem {
                            text: "Новое"
                            color: "White"
                        }
                        MenuItem {
                            text: "196.168.226.40"
                            color: "White"
                        }
                        MenuItem {
                            text: "127.0.0.1"
                            color: "White"
                        }
                        MenuItem {
                            text: "255.255.255.255"
                            color: "White"
                        }
                    }
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: "Хост"
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    width: pageContainer.width
                    color: "White"
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: "Имя пользователя"
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    width: pageContainer.width
                    color: "White"
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: "Пароль"
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    width: pageContainer.width
                    color: "White"
                    echoMode: TextInput.Password
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: "Порт"
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    width: pageContainer.width
                    validator: RegExpValidator { regExp: /^[1-9]+[0-9]*$/ }
                    text: "22"
                    color: "White"
                    inputMethodHints: Qt.ImhDigitsOnly
                }
            }

            Button {
                id: button
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Подключиться"
                border.color: Theme.highlightColor
                border.highlightColor: Theme.highlightColor
                color: Theme.highlightColor
                highlightColor: "White"
                onClicked: pageStack.push(Qt.resolvedUrl("SfsPage.qml"))
            }
        }
    }
}
