import QtQuick 2.0

Item {
    property var onDestruction

    function init(h, un, pw, p, od, spo) {
        host = h
        userName = un
        password = pw
        port = p

        onDestruction = od

        sftpPageObject = spo
    }

    Component.onDestruction: onDestruction()


    property bool blocking: false
    property bool transfering: false
    property string message: qsTr("Connected")

    property string host: ""
    property string userName: ""
    property string password: ""
    property string port: ""

    property var path: ["", ""]
    ListModel { id: records1 }
    ListModel { id: records2 }
    property var records: [records1, records2]

    property int typeElements: 1
    property int modeElements: 1
    property string pathElements: ""
    property var elements: []

    property QtObject sftpPageObject: null
    property QtObject menuObject: null
}
