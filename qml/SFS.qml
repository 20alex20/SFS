import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
    objectName: "applicationWindow"
    initialPage: Qt.resolvedUrl("pages/ConnectionPage.qml")
    cover: Qt.resolvedUrl("cover/Cover.qml")
    allowedOrientations: Orientation.Portrait
}
