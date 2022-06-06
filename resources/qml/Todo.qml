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
        icon.source: "../icons/todo.png"

        Component.onCompleted: {
            if (Qt.platform.os === "osx") {
                icon.source = "../icons/checklist.svg"
                icon.mask = true // changes color with dark menu on macOS
            }
        }

        onActivated: {
            if (window.visible) {
                window.hide()
            } else {
                let geometryX = geometry.x
                let geometryY = geometry.y
                let geometryWidth = geometry.width
                let geometryHeight = geometry.height

                // only macOS seems to automatically scale geometry by DPI
                if (Qt.platform.os !== "osx") {
                    geometryX /= Screen.devicePixelRatio
                    geometryY /= Screen.devicePixelRatio
                    geometryWidth /= Screen.devicePixelRatio
                    geometryHeight /= Screen.devicePixelRatio
                }

                // geometry.x: aligns left of window to left of icon
                // window.width / 2: moves left of window to center
                // geometry.width / 2: moves left of icon to center
                const windowX = geometryX - window.width / 2 + geometryWidth / 2

                // rightmost position for window still within screen
                const maxX = Screen.width - window.width

                // use maxX only if windowX goes offscreen
                if (windowX > maxX) {
                    window.x = maxX
                } else {
                    window.x = windowX
                }

                // geometry.y: aligns top of window to top of icon
                // geometry.height: moves top of icon to bottom
                // window.height: moves top of window to bottom
                if (geometryY === 0) {
                    // when icon is at the top of the screen
                    window.y = geometryY + geometryHeight
                } else {
                    // when icon is at the bottom of the screen
                    window.y = geometryY - window.height
                }

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
