import QtQuick
import QtQuick.Controls
import Qt.labs.settings

ApplicationWindow {
    id: window

    property string data: ""

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

            Component.onCompleted: window.data && deserialize(JSON.parse(window.data))
            onUpdate: window.data = JSON.stringify(serialize())
        }
    }

    Settings {
        id: settings

        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
        property alias data: window.data
    }
}
