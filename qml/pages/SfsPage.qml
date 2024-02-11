import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property bool connectedVirtual: true

    function fix(connectedHost, connectedPort) {
        textArea.startLine = connectedHost + ":" + connectedPort + ">"
        textArea.length = textArea.startLine.length
        textArea.text = textArea.startLine
    }

    objectName: "sfsPage"
    allowedOrientations: Orientation.Portrait
    backgroundColor: "Black"

    TextArea {
        id: textArea
        anchors.fill: parent
        textLeftMargin: 10
        textRightMargin: 10
        font.family: "Consolas"
        font.pixelSize: 30
        color: "White"
        backgroundStyle: TextEditor.NoBackground
        wrapMode: TextEdit.WrapAnywhere
        inputMethodHints: Qt.ImhNoAutoUppercase

        property int length: 1
        property string startLine: ">"
        property bool blocking: false
        text: ">"
        onCursorPositionChanged: if (!blocking) {
            var pos = cursorPosition
            if (pos >= length) {
                readOnly = false
                cursorPosition = pos
            }
            else {
                readOnly = true
            }
        }
        onTextChanged: {
            if (text[text.length - 1] === "\n") {
                blocking = true

                // код на плюсах

                text += startLine
                length = text.length
                cursorPosition = length
                blocking = false
            }
            else if (text[length - 1] !== ">") {
                blocking = true
                text = text.slice(0, length - 1) + ">" + text.slice(length - 1)
                cursorPosition = length - 1
                blocking = false
            }
        }
    }
}
