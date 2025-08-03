# This file is part of Cantera. See License.txt in the top-level directory or
# at https://cantera.org/license.txt for license and copyright information.

# cython: language_level=3
# distutils: language=c++

__all__ = []

import sys
import importlib
import importlib.abc
import importlib.util


# Chooses the right init function
# See https://stackoverflow.com/a/52714500
class CythonPackageMetaPathFinder(importlib.abc.MetaPathFinder):
    def __init__(self, name_filter):
        super().__init__()
        self.name_filter = name_filter

    def find_spec(self, fullname, path, target=None):
        if fullname.startswith(self.name_filter):
            # use this extension-file but PyInit-function of another module:
            loader = importlib.machinery.ExtensionFileLoader(fullname, __file__)
            return importlib.util.spec_from_loader(fullname, loader)


# Inject custom finder/loaders into sys.meta_path:
sys.meta_path.append(CythonPackageMetaPathFinder("cantera."))

# Import the contents of the individual .pyx files
from . import (
    _utils,
    _onedim,
    solutionbase,
    delegator,
    func1,
    kinetics,
    mixture,
    reaction,
    reactionpath,
    reactor,
    speciesthermo,
    thermo,
    transport,
    units,
    yamlwriter,
    constants,
    jacobians,
)
from ._utils import *
from ._onedim import *
from .solutionbase import *
from .delegator import *
from .func1 import *
from .kinetics import *
from .mixture import *
from .reaction import *
from .reactionpath import *
from .reactor import *
from .speciesthermo import *
from .thermo import *
from .transport import *
from .units import *
from .yamlwriter import *
from .constants import *
from .jacobians import *

__all__ += (
    _utils.__all__
    + _onedim.__all__
    + solutionbase.__all__
    + delegator.__all__
    + func1.__all__
    + kinetics.__all__
    + mixture.__all__
    + reaction.__all__
    + reactionpath.__all__
    + reactor.__all__
    + speciesthermo.__all__
    + thermo.__all__
    + transport.__all__
    + units.__all__
    + yamlwriter.__all__
    + constants.__all__
    + jacobians.__all__
)

# Custom finder/loader no longer needed, so remove it
sys.meta_path.pop()
