import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "sfsPage"
    allowedOrientations: Orientation.Portrait

    Rectangle {
        anchors.fill: parent
        color: "Black"

        TextArea {
            id: textArea
            anchors.fill: parent
            textLeftMargin: 10
            textRightMargin: 10
            font.family: "Consolas"
            font.pixelSize: 40
            color: "White"
            backgroundStyle: TextEditor.NoBackground
            wrapMode: TextEdit.WrapAnywhere

            text: "> "
            property int length: 2
            property bool blocking: false
            onCursorPositionChanged:  {
                if (!blocking) {
                    var pos = textArea.cursorPosition
                    if (pos >= length) {
                        if (readOnly)
                            readOnly = false
                    }
                    else if (length - pos <= 2) {
                        pos = length
                        if (readOnly)
                            readOnly = false
                    }
                    else {
                        if (!readOnly)
                            readOnly = true
                    }
                    textArea.cursorPosition = pos
                }
            }
            onTextChanged: {
                if (text.length < length) {
                    blocking = true
                    text += " "
                    length = text.length
                    textArea.cursorPosition = length
                    blocking = false
                }
                else if (text[text.length - 1] === '\n') {
                    blocking = true
                    text += "> ";
                    length = text.length;
                    textArea.cursorPosition = length
                    blocking = false
                }
            }
        }
    }
}
