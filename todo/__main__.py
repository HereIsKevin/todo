import platform
import sys

from PySide6.QtGui import QFontDatabase, QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuick import QQuickWindow, QSGRendererInterface
from PySide6.QtQuickControls2 import QQuickStyle

import todo.resources as _  # compiled resources

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setOrganizationName("HereIsKevin")
    app.setApplicationName("Todo")
    app.setWindowIcon(QIcon(":/icons/todo.png"))

    if platform.system() == "Windows":  # Direct3D11 has issues on Windows?
        QQuickWindow.setGraphicsApi(QSGRendererInterface.OpenGL)

    QFontDatabase.addApplicationFont(":/fonts/Roboto-Bold.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Medium.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Regular.ttf")
    QQuickStyle.setStyle("Material")

    engine = QQmlApplicationEngine("qrc:/qml/Todo.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
