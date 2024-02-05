import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property bool connectedVirtual: true

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

        text: ">"
        property int length: 1
        property string startLine: ">"
        property bool blocking: false
        onCursorPositionChanged:  {
            if (!blocking) {
                blocking = true
                var pos = textArea.cursorPosition
                if (pos >= length) {
                    readOnly = false
                    textArea.cursorPosition = pos
                }
                else {
                    readOnly = true
                }
                blocking = false
            }
        }
        onTextChanged: {
            if (text[text.length - 1] === '\n') {
                blocking = true
                text += startLine;
                length = text.length;
                textArea.cursorPosition = length
                blocking = false
            }
            else if (text.length < length) {
                blocking = true
                text += ">"
                length = text.length
                textArea.cursorPosition = length
                blocking = false
            }
        }
    }

    function fix(connectedHost, connectedPort) {
        textArea.startLine = connectedHost + ":" + connectedPort + ">"
        textArea.length = textArea.startLine.length
        textArea.text = textArea.startLine
    }
}
