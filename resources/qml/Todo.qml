import QtQuick
import QtQuick.Controls
import Qt.labs.platform as Platform
import Qt.labs.settings

ApplicationWindow {
    id: window

    Material.accent: Material.color(Material.Grey, Material.Shade900)
    Material.background: Material.color(Material.Grey, Material.Shade50)
    Material.foreground: Material.color(Material.Grey, Material.Shade900)
    Material.primary: Material.color(Material.Grey, Material.Shade50)
    Material.theme: Material.Light

    flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

    width: 500
    height: 600

    onActiveChanged: !window.active && window.hide() // hide on click outside

    header: TodoToolBar {
        clearAllEnabled: model.count > 0

        onAdd: model.add()
        onClearAll: clearAllDialog.open()
        onClearCompleted: clearCompletedDialog.open()
        onQuit: Qt.quit()

        function clearCompletedCheck() {
            return model.hasCompleted()
        }
    }

    TodoList {
        anchors.fill: parent

        model: TodoModel {
            id: model

            Component.onCompleted: settings.data && deserialize(settings.data)
            onUpdate: settings.data = serialize()
        }
    }

    Dialog {
        id: clearAllDialog

        anchors.centerIn: Overlay.overlay

        title: qsTr("Are you sure you want to clear all todo items?")
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true

        Component.onCompleted: standardButton(Dialog.Ok).text = qsTr("Clear")
        onAccepted: model.clear()

        Label {
            text: qsTr("You can't undo this action.")
        }
    }

    Dialog {
        id: clearCompletedDialog

        anchors.centerIn: Overlay.overlay

        title: qsTr("Are you sure you want to clear all completed todo items?")
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true

        Component.onCompleted: standardButton(Dialog.Ok).text = qsTr("Clear")
        onAccepted: model.clearCompleted()

        Label {
            text: qsTr("You can't undo this action.")
        }
    }

    Platform.SystemTrayIcon {
        visible: true
        icon.source: "qrc:/icons/todo.png"

        Component.onCompleted: {
            if (Qt.platform.os === "osx") {
                icon.source = "qrc:/icons/checklist.svg"
                icon.mask = true // changes color with dark menu on macOS
            }
        }

        onActivated: {
            if (window.visible) {
                window.hide()
            } else {
                // geometry.x: aligns left of window to left of icon
                // window.width / 2: moves left of window to center
                // geometry.width / 2: moves left of icon to center
                window.x = geometry.x - window.width / 2 + geometry.width / 2

                // geometry.y: aligns top of window to top of icon
                // geometry.height: moves top of icon to bottom
                window.y = geometry.y + geometry.height

                window.show()
                window.raise()
                window.requestActivate()
            }
        }
    }

    Settings {
        id: settings

        property string data: ""
    }
}
