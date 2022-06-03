#!/usr/bin/env python3

import subprocess
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
RESOURCES = BASE / "resources" / "resources.qrc"
OUTPUT = BASE / "todo" / "resources.py"

if __name__ == "__main__":
    subprocess.run(["pyside6-rcc", str(RESOURCES), "--output", str(OUTPUT)])
