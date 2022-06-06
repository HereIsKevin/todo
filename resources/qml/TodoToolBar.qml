import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id: root

    property bool clearAllEnabled: true

    signal add
    signal clearAll
    signal clearCompleted
    signal quit

    function clearCompletedCheck() {
        return true
    }

    RowLayout {
        anchors.fill: parent

        ToolButton {
            icon.source: "../icons/add.svg"

            action: Action {
                shortcut: StandardKey.New
                onTriggered: root.add()
            }
        }

        Item {
            Layout.fillWidth: true
        }

        ToolButton {
            icon.source: "../icons/more.svg"
            enabled: !menu.opened

            onClicked: {
                menu.clearCompletedEnabled = root.clearCompletedCheck()
                menu.open()
            }

            Menu {
                id: menu

                property bool clearCompletedEnabled: false

                y: parent.height

                MenuItem {
                    text: "Clear All"
                    enabled: root.clearAllEnabled

                    onTriggered: root.clearAll()
                }

                MenuItem {
                    text: "Clear Completed"
                    enabled: menu.clearCompletedEnabled

                    onTriggered: root.clearCompleted()
                }

                MenuSeparator {}

                MenuItem {
                    text: "Quit Todo"
                    onTriggered: root.quit()
                }
            }
        }
    }
}
