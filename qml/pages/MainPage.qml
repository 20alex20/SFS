import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"

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
                    text: qsTr("Connection")
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }

                ListModel {
                    id: records

                    ListElement {
                        t: qsTr("New")
                        h: ""
                        un: ""
                        pw: ""
                        p: "22"
                    }
                }

                ComboBox {
                    id: connection
                    width: pageContainer.width
                    valueColor: "White"
                    menu: ContextMenu {
                        property int lastIndex: 0

                        Repeater {
                            model: records

                            MenuItem {
                                text: t
                                property string host: h
                                property string userName: un
                                property string password: pw
                                property string port: p
                                color: "White"
                            }
                        }

                        Component.onCompleted: {
                            var arr = []

                            // код на плюсах
                            arr.push({ "t": "196.168.226.40", "h": "196.168.226.40", "un": "qwerty", "pw": "qwerty123", "p": "2222" })
                            arr.push({ "t": "127.0.0.1", "h": "127.0.0.1", "un": "alex", "pw": "alex356", "p": "22" })
                            arr.push({ "t": "255.255.255.255", "h": "255.255.255.255", "un": "fnaf", "pw": "fnaf", "p": "2222" })

                            for (var i = 0; i < arr.length; i++) {
                                records.append(arr[i])
                            }
                        }
                        onActivated: {
                            if (lastIndex === index)
                                return

                            if (lastIndex === 0)
                                records.set(0, { "t": qsTr("New"), "h": host.text, "un": userName.text, "pw": password.text, "p": port.text })
                            lastIndex = index

                            var flag = index !== 0
                            host.readOnly = flag
                            userName.readOnly = flag
                            password.readOnly = flag
                            port.readOnly = flag
                            
                            var item = records.get(index)
                            host.text = item.h
                            userName.text = item.un
                            password.text = item.pw
                            port.text = item.p
                        }
                    }
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: qsTr("Host")
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    property var validate: new RegExp(/^(([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.){3}([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])$/)
                    property bool blocking: true

                    function getMessage() {
                        if (text.length == 0)
                            label = qsTr("Field is empty")
                        else if (!validate.test(text))
                            label = qsTr("The field is filled in incorrectly")
                        else
                            label = ""
                    }

                    id: host
                    width: pageContainer.width
                    color: "White"
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    placeholderText: qsTr("IP-address")
                    label: ""
                    hideLabelOnEmptyField: false
                    labelVisible: label !== ""
                    acceptableInput: blocking || (text.length > 0 && validate.test(text))
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            getMessage()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            getMessage()
                    }
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: qsTr("User name")
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    property bool blocking: true

                    function getMessage() {
                        labelVisible = text.length == 0
                    }

                    id: userName
                    width: pageContainer.width
                    color: "White"
                    placeholderText: ""
                    label: qsTr("Field is empty")
                    hideLabelOnEmptyField: false
                    labelVisible: false
                    acceptableInput: blocking || text.length > 0
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            getMessage()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            getMessage()
                    }
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: qsTr("Password")
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    property bool blocking: true

                    function getMessage() {
                        labelVisible = text.length == 0
                    }

                    id: password
                    width: pageContainer.width
                    color: "White"
                    echoMode: TextInput.Password
                    placeholderText: ""
                    label: qsTr("Field is empty")
                    hideLabelOnEmptyField: false
                    labelVisible: false
                    acceptableInput: blocking || text.length > 0
                    onFocusChanged: {
                        if (focus)
                            flicked.flickableDirection = Flickable.VerticalFlick
                        else {
                            getMessage()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            getMessage()
                    }
                }
            }

            Column {
                Label {
                    leftPadding: 30
                    bottomPadding: 15
                    text: qsTr("Port")
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                }
                TextField {
                    property bool blocking: true

                    function getMessage() {
                        if (text.length == 0)
                            label = qsTr("Field is empty")
                        else if (!validate(text))
                            label = qsTr("The field is filled in incorrectly")
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
                            getMessage()
                            blocking = false
                        }
                    }
                    onTextChanged: {
                        if (!blocking)
                            getMessage()
                    }
                }
            }

            Button {
                id: button
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Connect")
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
                        var model = Qt.createComponent("../mvc/Model.qml").createObject(page)
                        model.init(host.text, userName.text, password.text, port.text)
                        var controller = Qt.createComponent("../mvc/Controller.qml").createObject(page)
                        controller.init(model)
                        page.init(model, controller)

                        page = pageStack.pushAttached(Qt.resolvedUrl("SshPage.qml"))
                        page.init(model, controller)
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
