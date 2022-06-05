import QtQuick
import QtQuick.Controls
import Qt.labs.settings

ApplicationWindow {
    id: window

    Material.accent: Material.color(Material.Grey, Material.Shade900)
    Material.background: Material.color(Material.Grey, Material.Shade50)
    Material.foreground: Material.color(Material.Grey, Material.Shade900)
    Material.primary: Material.color(Material.Grey, Material.Shade50)
    Material.theme: Material.Light

    title: qsTr("Todo")
    visible: true

    width: 450
    height: 600

    minimumWidth: 300
    minimumHeight: 300

    header: TodoToolBar {
        clearAllEnabled: model.count > 0
        clearCompletedCheck: model.hasCompleted

        onAdd: model.add()
        onClearAll: clearAllDialog.open()
        onClearCompleted: clearCompletedDialog.open()
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

    Settings {
        id: settings

        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height

        property string data: ""
    }
}
