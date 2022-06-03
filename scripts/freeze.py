#!/usr/bin/env python3

import platform
from pathlib import Path

from PyInstaller.__main__ import run

NAME = "Todo"
BASE = Path(__file__).resolve().parent.parent
MAIN = BASE / "todo" / "__main__.py"
ICONS = BASE / "resources" / "icons" / "app"

if __name__ == "__main__":
    if platform.system() == "Darwin":
        icon = ICONS / "Todo.icns"
    else:
        icon = ICONS / "Todo.ico"

    run([str(MAIN), "--windowed", "--name", NAME, "--icon", str(icon)])
