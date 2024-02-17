import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property bool connectedVirtual: false

    objectName: "mainPage"
    allowedOrientations: Orientation.Portrait

    Flickable {
        id: flicked
        anchors.fill: parent
        onMovementStarted: {
            host.focus = false
            userName.focus = false
            password.focus = false
            port.focus = false
        }
        onMovementEnded: {
            flickableDirection = Flickable.AutoFlickDirection
        }

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
                    id: connection
                    width: pageContainer.width
                    valueColor: "White"
                    menu: ContextMenu {
                        property string lastItemText: "Новое"

                        MenuItem {
                            text: "Новое"
                            property string host: ""
                            property string userName: ""
                            property string password: ""
                            property string port: "22"
                        }
                        MenuItem {
                            text: "196.168.226.40"
                            property string host: "196.168.226.40"
                            property string userName: "qwerty"
                            property string password: "qwerty123"
                            property string port: "22"
                        }
                        MenuItem {
                            text: "127.0.0.1"
                            property string host: "127.0.0.1"
                            property string userName: "alex"
                            property string password: "alex456"
                            property string port: "22"
                        }
                        MenuItem {
                            text: "255.255.255.255"
                            property string host: "255.255.255.255"
                            property string userName: "fnaf"
                            property string password: "fnaf123"
                            property string port: "22"
                        }

                        Component.onCompleted: {
                            for(var i = 0; i < children.length; i++)
                                children[i].color = "White"
                        }
                        onActivated: {
                            var item = children[index]
                            if (lastItemText === item.text)
                                return

                            var flag = lastItemText == "Новое"
                            if (flag) {
                                children[0].host = host.text
                                children[0].userName = userName.text
                                children[0].password = password.text
                                children[0].port = port.text
                            }
                            lastItemText = item.text

                            host.readOnly = flag
                            userName.readOnly = flag
                            password.readOnly = flag
                            port.readOnly = flag

                            host.text = item.host
                            userName.text = item.userName
                            password.text = item.password
                            port.text = item.port
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
                    property var validate: new RegExp(/^(([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.){3}([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$/)
                    property bool blocking: true

                    function fix() {
                        if (text.length == 0)
                            label = "Поле не заполненно"
                        else if (!validate.test(text))
                            label = "Поле заполненно не верно"
                        else
                            label = ""
                    }

                    id: host
                    width: pageContainer.width
                    color: "White"
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    placeholderText: "IP-адрес"
                    label: ""
                    hideLabelOnEmptyField: false
                    labelVisible: label !== ""
                    acceptableInput: blocking || (text.length > 0 && validate.test(text))
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            fix()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            fix()
                    }
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
                    property bool blocking: true

                    function fix() {
                        labelVisible = text.length == 0
                    }

                    id: userName
                    width: pageContainer.width
                    color: "White"
                    placeholderText: ""
                    label: "Поле не заполненно"
                    hideLabelOnEmptyField: false
                    labelVisible: false
                    acceptableInput: blocking || text.length > 0
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            fix()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            fix()
                    }
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
                    property bool blocking: true

                    function fix() {
                        labelVisible = text.length == 0
                    }

                    id: password
                    width: pageContainer.width
                    color: "White"
                    echoMode: TextInput.Password
                    placeholderText: ""
                    label: "Поле не заполненно"
                    hideLabelOnEmptyField: false
                    labelVisible: false
                    acceptableInput: blocking || text.length > 0
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            fix()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            fix()
                    }
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
                    property bool blocking: true

                    function fix() {
                        if (text.length == 0)
                            label = "Поле не заполненно"
                        else if (!validate(text))
                            label = "Поле заполненно не верно"
                        else
                            label = ""
                    }
                    function validate() {
                        var s = ""
                        if (!RegExp(/^[0-9]+$/).test(text))
                            return false
                        var num = Number(text)
                        return 0 <= num && num <= 65535
                    }

                    id: port
                    width: pageContainer.width
                    color: "White"
                    text: "22"
                    inputMethodHints: Qt.ImhDigitsOnly
                    placeholderText: "0 - 65535"
                    label: ""
                    hideLabelOnEmptyField: false
                    labelVisible: label !== ""
                    acceptableInput: blocking || (text.length > 0 && validate(text))
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            fix()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            fix()
                    }
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
                onClicked: {
                    host.blocking = false
                    userName.blocking = false
                    password.blocking = false
                    port.blocking = false

                    if (host.acceptableInput && userName.acceptableInput && password.acceptableInput && port.acceptableInput) {
                        // код на плюсах

                        var page = pageStack.replace(Qt.resolvedUrl("SftpPage.qml"))
                        page.connectedHost = host.text
                        page.connectedUserName = userName.text
                        page.connectedPassword = password.text
                        page.connectedPort = port.text

                        pageStack.pushAttached(Qt.resolvedUrl("SshPage.qml"))
                        pageStack.nextPage().init(host.text, port.text)
                    }
                    else {
                        host.readOnly = true
                        userName.readOnly = true
                        password.readOnly = true
                        port.readOnly = true

                        host.focus = true
                        userName.focus = true
                        password.focus = true
                        port.focus = true
                        port.focus = false

                        host.readOnly = false
                        userName.readOnly = false
                        password.readOnly = false
                        port.readOnly = false
                    }
                }
            }
        }
    }
}
