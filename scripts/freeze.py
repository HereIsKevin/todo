#!/usr/bin/env python3

import os
import platform
import re
import subprocess
from pathlib import Path

NAME = "Todo"
VERSION = "0.1.0"
BASE = Path(__file__).resolve().parent.parent
SPEC = BASE / "Todo.spec"
MAIN = BASE / "todo" / "__main__.py"
RESOURCES = BASE / "resources"
ICONS = RESOURCES / "icons" / "app"
DATA = {
    RESOURCES / "fonts" / "Roboto-Bold.ttf": "./resources/fonts/",
    RESOURCES / "fonts" / "Roboto-Medium.ttf": "./resources/fonts/",
    RESOURCES / "fonts" / "Roboto-Regular.ttf": "./resources/fonts/",
    RESOURCES / "icons" / "add.svg": "./resources/icons/",
    RESOURCES / "icons" / "checklist.svg": "./resources/icons/",
    RESOURCES / "icons" / "delete.svg": "./resources/icons/",
    RESOURCES / "icons" / "more.svg": "./resources/icons/",
    RESOURCES / "icons" / "todo.png": "./resources/icons/",
    RESOURCES / "qml" / "Todo.qml": "./resources/qml/",
    RESOURCES / "qml" / "TodoItem.qml": "./resources/qml/",
    RESOURCES / "qml" / "TodoList.qml": "./resources/qml/",
    RESOURCES / "qml" / "TodoModel.qml": "./resources/qml/",
    RESOURCES / "qml" / "TodoToolBar.qml": "./resources/qml/",
}

if __name__ == "__main__":
    darwin = platform.system() == "Darwin"

    if darwin:
        icon = ICONS / "Todo.icns"
    else:
        icon = ICONS / "Todo.ico"

    data = []

    for path, resource in DATA.items():
        data.append("--add-data")
        data.append(f"{path}{os.pathsep}{resource}")

    spec_command = [
        "pyi-makespec",
        str(MAIN),
        "--windowed",
        "--name",
        NAME,
        "--icon",
        str(icon),
        *data,
    ]

    subprocess.run(spec_command)

    if darwin:
        pattern = re.compile(r"BUNDLE\((.*)\)", flags=re.DOTALL)
        contents = SPEC.read_text()

        info_plist = {"LSUIElement": True}
        replacement = rf'BUNDLE(\1version="{VERSION}", info_plist={info_plist})'

        SPEC.write_text(pattern.sub(replacement, contents))

    subprocess.run(["pyinstaller", str(SPEC)])
