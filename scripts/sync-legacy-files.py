#!/usr/bin/env python3
"""Keep downloads available at their pre-migration GitHub Pages URLs."""

from pathlib import Path
import shutil


def sync_files(root):
    source = root / "files"
    destination = root / "yanbo_pan.github.io" / "files"
    copied = 0
    for path in sorted(source.rglob("*")):
        relative = path.relative_to(source)
        if not path.is_file() or any(part.startswith(".") for part in relative.parts):
            continue
        target = destination / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
        copied += 1
    return copied


if __name__ == "__main__":
    count = sync_files(Path(__file__).resolve().parents[1])
    print(f"Synced {count} downloads to yanbo_pan.github.io/files/.")
