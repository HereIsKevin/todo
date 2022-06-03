import QtQuick
import QtQuick.Controls

ScrollView {
    property alias model: view.model

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.width: 10 // material scrollbar is too fat

    ListView {
        id: view

        delegate: TodoItem {
            checkState: status
            onCheckStateChanged: status = checkState

            text: contents
            onTextChanged: contents = text

            topPadding: 5 // too much top padding by default
            bottomPadding: 5 // too much bottom padding by default
            width: view.width + 5 // misaligned at right (use rightPadding?)

            onRemove: view.model.remove(index)
        }
    }
}
