import platform
import sys

from PySide6.QtGui import QFontDatabase, QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuick import QQuickWindow, QSGRendererInterface
from PySide6.QtQuickControls2 import QQuickStyle

import todo.resources as _  # compiled resources

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    match platform.system():
        case "Darwin":
            graphics_api = QSGRendererInterface.Metal
        case "Windows":
            graphics_api = QSGRendererInterface.OpenGL  # Direct3D11 has issues
        case _:
            graphics_api = QSGRendererInterface.OpenGL

    QQuickWindow.setSceneGraphBackend("rhi")
    QQuickWindow.setGraphicsApi(graphics_api)

    app.setOrganizationName("HereIsKevin")
    app.setOrganizationDomain("hereiskevin.dev")
    app.setApplicationName("Todo")
    app.setWindowIcon(QIcon(":/icons/todo.png"))

    engine = QQmlApplicationEngine()

    QQuickStyle.setStyle("Material")

    QFontDatabase.addApplicationFont(":/fonts/Roboto-Bold.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Medium.ttf")
    QFontDatabase.addApplicationFont(":/fonts/Roboto-Regular.ttf")

    engine.load("qrc:/qml/Todo.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
