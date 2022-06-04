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
        onAdd: model.add()
        onClear: model.clear()
    }

    TodoList {
        anchors.fill: parent

        model: TodoModel {
            id: model

            Component.onCompleted: {
                if (settings.data) {
                    deserialize(JSON.parse(settings.data))
                }
            }

            onUpdate: settings.data = JSON.stringify(serialize())
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
