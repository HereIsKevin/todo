import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Pane {
    id: root

    property alias checkState: checkBox.checkState
    property alias text: textField.text

    signal remove

    RowLayout {
        anchors.fill: parent

        CheckBox {
            id: checkBox

            checkState: Qt.Unchecked
            tristate: true

            MouseArea {
                property bool empty: true

                acceptedButtons: Qt.LeftButton | Qt.RightButton
                anchors.fill: parent

                onClicked: (mouse) => {
                    if (empty) {
                        if (mouse.button === Qt.RightButton) {
                            checkBox.checkState = Qt.PartiallyChecked
                        } else {
                            checkBox.checkState = Qt.Checked
                        }

                        empty = false
                    } else {
                        checkBox.checkState = Qt.Unchecked
                        empty = true
                    }
                }
            }
        }

        TextField { // use TextArea?
            id: textField

            Layout.alignment: Qt.AlignBottom // compensate for bottom line
            Layout.fillWidth: true

            selectByMouse: true
            wrapMode: TextField.Wrap

            Keys.onEscapePressed: focus = false // only way to kill the focus
        }

        RoundButton { // use ToolButton?
            Material.elevation: 0 // remove shadow and background

            icon.source: "qrc:/icons/delete.svg" // use icon.name?
            onClicked: root.remove()
        }
    }
}
