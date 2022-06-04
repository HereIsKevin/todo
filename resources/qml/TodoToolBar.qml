import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id: root

    property bool clearAllEnabled: true
    property var clearCompletedCheck: () => true

    signal add
    signal clearAll
    signal clearCompleted

    RowLayout {
        anchors.fill: parent

        ToolButton {
            icon.source: "qrc:/icons/add.svg"
            onClicked: root.add()
        }

        Item {
            Layout.fillWidth: true
        }

        ToolButton {
            text: qsTr("Clear")
            enabled: clearAllEnabled && !menu.opened

            onClicked: {
                if (clearCompletedCheck()) {
                     menu.open()
                } else {
                    root.clearAll()
                }
            }

            Menu {
                id: menu

                y: parent.height

                MenuItem {
                    text: "Clear All"
                    onTriggered: root.clearAll()
                }

                MenuItem {
                    text: "Clear Completed"
                    onTriggered: root.clearCompleted()
                }
            }
        }
    }
}
