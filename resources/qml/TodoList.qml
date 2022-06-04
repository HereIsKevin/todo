import QtQuick
import QtQuick.Controls

ScrollView {
    property alias model: view.model

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.width: 10 // default scrollbar is too fat

    ListView {
        id: view

        delegate: TodoItem {
            checkState: status
            onCheckStateChanged: status = checkState

            text: contents
            onTextChanged: contents = text

            topPadding: 5 // too much top padding by default
            bottomPadding: 5 // too much bottom padding by default
            width: view.width + 5 // misaligned at right

            onRemove: removeDialog.open()

            Dialog {
                id: removeDialog

                anchors.centerIn: Overlay.overlay

                title: qsTr("Are you sure you want to remove this todo item?")
                standardButtons: Dialog.Ok | Dialog.Cancel
                modal: true

                Component.onCompleted: standardButton(Dialog.Ok).text = qsTr("Remove")
                onAccepted: view.model.remove(index)

                Label {
                    text: qsTr("You can't undo this action.")
                }
            }
        }
    }
}
