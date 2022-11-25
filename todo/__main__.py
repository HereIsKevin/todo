import sys

import PySide6.QtQuick as _
from PySide6.QtGui import QFontDatabase, QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle

import todo.resources as _  # compiled resources

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setOrganizationName("HereIsKevin")
    app.setApplicationName("Todo")
    app.setWindowIcon(QIcon(":/icons/todo.png"))

    QFontDatabase.addApplicationFont(":/fonts/Roboto-Bold.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Medium.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Regular.ttf")
    QQuickStyle.setStyle("Material")

    engine = QQmlApplicationEngine("qrc:/qml/Todo.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
