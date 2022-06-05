#!/usr/bin/env python3

import platform
import re
import subprocess
from pathlib import Path

NAME = "Todo"
VERSION = "0.1.0"
BASE = Path(__file__).resolve().parent.parent
SPEC = BASE / "Todo.spec"
MAIN = BASE / "todo" / "__main__.py"
ICONS = BASE / "resources" / "icons" / "app"

if __name__ == "__main__":
    darwin = platform.system() == "Darwin"

    if darwin:
        icon = ICONS / "Todo.icns"
    else:
        icon = ICONS / "Todo.ico"

    spec_command = [
        "pyi-makespec",
        str(MAIN),
        "--windowed",
        "--name",
        NAME,
        "--icon",
        str(icon),
    ]

    subprocess.run(spec_command)

    if darwin:
        pattern = re.compile(r"BUNDLE\((.*)\)", flags=re.DOTALL)
        contents = SPEC.read_text()

        info_plist = {"LSUIElement": True}
        replacement = rf'BUNDLE(\1version="{VERSION}", info_plist={info_plist})'

        SPEC.write_text(pattern.sub(replacement, contents))

    subprocess.run(["pyinstaller", str(SPEC)])
