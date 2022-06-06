import platform
import sys
from pathlib import Path

from PyQt6.QtGui import QFontDatabase, QGuiApplication, QIcon
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtQuick import QQuickWindow, QSGRendererInterface

if getattr(sys, "frozen", False) and hasattr(sys, "_MEIPASS"):
    DATA = Path(sys._MEIPASS).resolve() / "resources"  # type: ignore
else:
    DATA = Path(__file__).resolve().parent.parent / "resources"

if __name__ == "__main__":
    app = QGuiApplication([*sys.argv, "--style", "Material"])
    app.setOrganizationName("HereIsKevin")
    app.setApplicationName("Todo")
    app.setWindowIcon(QIcon(str(DATA / "icons" / "todo.png")))

    if platform.system() == "Windows":  # Direct3D11 has issues on Windows?
        QQuickWindow.setGraphicsApi(QSGRendererInterface.GraphicsApi.OpenGL)

    QFontDatabase.addApplicationFont(str(DATA / "fonts" / "Roboto-Bold.ttf"))
    QFontDatabase.addApplicationFont(str(DATA / "fonts" / "Roboto-Medium.ttf"))
    QFontDatabase.addApplicationFont(str(DATA / "fonts" / "Roboto-Regular.ttf"))

    engine = QQmlApplicationEngine(str(DATA / "qml" / "Todo.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
