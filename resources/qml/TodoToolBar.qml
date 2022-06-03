import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id: root

    signal add
    signal clear

    RowLayout {
        anchors.fill: parent

        ToolButton {
            icon.source: "qrc:/icons/add.svg" // use icon.name?
            onClicked: root.add()
        }

        Item {
            Layout.fillWidth: true
        }

        ToolButton {
            text: qsTr("Clear")
            onClicked: root.clear()
        }
    }
}
