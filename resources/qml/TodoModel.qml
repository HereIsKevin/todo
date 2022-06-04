import QtQuick
import QtQml.Models

ListModel {
    signal update

    function add() {
        append({ status: Qt.Unchecked, contents: "" })
    }

    function clearCompleted() {
        for (let index = 0; index < count; index++) {
            if (get(index).status === Qt.Checked) {
                remove(index)
                index--
            }
        }
    }

    function hasCompleted() {
        for (let index = 0; index < count; index++) {
            if (get(index).status === Qt.Checked) {
                return true
            }
        }

        return false
    }

    function serialize() {
        const items = []

        for (let index = 0; index < count; index++) {
            items.push(get(index))
        }

        return items
    }

    function deserialize(items) {
        clear()

        for (const { status, contents } of items) {
            append({ status, contents })
        }
    }

    onDataChanged: update()
    onCountChanged: update()
}
