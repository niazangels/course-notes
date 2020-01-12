from pathlib import Path
from regression_model.config import config

with open(config.PACKAGE_ROOT / "VERSION") as f:
    __version__ = f.read().strip()
