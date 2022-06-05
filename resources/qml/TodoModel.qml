import QtQuick
import QtQml.Models

ListModel {
    signal update

    function add() {
        if (count === 0 || get(count - 1).contents) {
            append({ status: Qt.Unchecked, contents: "" })
        }
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

        return JSON.stringify(items)
    }

    function deserialize(items) {
        clear()

        for (const { status, contents } of JSON.parse(items)) {
            append({ status, contents })
        }
    }

    onDataChanged: update()
    onCountChanged: update()
}
