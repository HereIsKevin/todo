import os
import sys

import PySide6.QtQuick as _  # needed for PyInstaller
from PySide6.QtGui import QFontDatabase, QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle

import todo.resources as _  # compiled resources

if __name__ == "__main__":
    os.environ["QT_QUICK_BACKEND"] = "software"

    app = QGuiApplication(sys.argv)

    app.setOrganizationName("HereIsKevin")
    app.setOrganizationDomain("hereiskevin.dev")
    app.setApplicationName("Todo")

    engine = QQmlApplicationEngine()

    QQuickStyle.setStyle("Material")

    QFontDatabase.addApplicationFont(":/fonts/Roboto-Regular.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Medium.ttf")

    engine.load("qrc:/qml/Todo.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
