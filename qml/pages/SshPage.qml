import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property QtObject model
    property QtObject controller

    function init(m, c) {
        model = m
        controller = c
        textArea.startLine = model.host + ":" + model.port + ">"
        textArea.length = textArea.startLine.length
        textArea.text = textArea.startLine
    }

    objectName: "sshPage"
    showNavigationIndicator: false
    backgroundColor: "Black"

    TextArea {
        property int length: 1
        property string startLine: ">"
        property bool localBlocking: false

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
        text: ">"
        onCursorPositionChanged: if (!localBlocking) {
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
                localBlocking = true

                if (!model.blocking && text.length !== length + 1)
                    text += controller.sendRequest(text.slice(length, text.length - 1)) + "\n"

                text += startLine
                length = text.length
                cursorPosition = length
                localBlocking = false
            }
            else if (text[length - 1] !== ">") {
                localBlocking = true
                text = text.slice(0, length - 1) + ">" + text.slice(length - 1)
                cursorPosition = length - 1
                localBlocking = false
            }
        }
    }
}
