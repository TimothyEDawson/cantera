# This file is part of Cantera. See License.txt in the top-level directory or
# at https://cantera.org/license.txt for license and copyright information.

__all__ = []

from . import _cantera, composite, liquidvapor, onedim, utils, data
from ._cantera import *
from .composite import *
from .liquidvapor import *
from .onedim import *
from .utils import *
from .data import *
import cantera.interrupts  # Helps with standalone packaging (PyInstaller etc.)

import os
import sys
from pathlib import Path
import warnings

__all__ += (
    _cantera.__all__
    + composite.__all__
    + liquidvapor.__all__
    + onedim.__all__
    + utils.__all__
    + data.__all__
)

warnings.filterwarnings("default", module="cantera")
add_directory(Path(__file__).parent / "data")
add_directory(".")  # Move current working directory to the front of the path

# Python interpreter used for converting mechanisms
if "PYTHON_CMD" not in os.environ:
    os.environ["PYTHON_CMD"] = sys.executable
