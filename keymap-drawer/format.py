#!/usr/bin/env python3
"""Apply presentation-only ordering and filtering to parsed keymap YAML."""

from pathlib import Path
import sys

import yaml


path = Path(sys.argv[1])
keymap = yaml.safe_load(path.read_text(encoding="utf-8"))

layers = keymap.get("layers", {})
layers.pop("CAD", None)

ordered_layers = {}
for name in ("Base", "Symbols"):
    if name in layers:
        ordered_layers[name] = layers.pop(name)
ordered_layers.update(layers)
keymap["layers"] = ordered_layers

keymap["combos"] = [
    combo for combo in keymap.get("combos", []) if "CAD" not in combo.get("l", [])
]

# The ODK activator is sticky, so its key is not physically held while typing.
accents = keymap["layers"].get("Accents")
if accents and isinstance(accents[8], dict) and accents[8].get("t") == "¨":
    accents[8] = "¨"

path.write_text(
    yaml.safe_dump(keymap, sort_keys=False, allow_unicode=True),
    encoding="utf-8",
)
