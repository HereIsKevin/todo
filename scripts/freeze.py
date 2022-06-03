#!/usr/bin/env python3

from pathlib import Path

import PyInstaller.__main__

NAME = "Todo"
BASE = Path(__file__).resolve().parent.parent
MAIN = BASE / "todo" / "__main__.py"

if __name__ == "__main__":
    PyInstaller.__main__.run([str(MAIN), "--windowed", "--name", NAME])
