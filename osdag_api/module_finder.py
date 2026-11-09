import importlib
import logging
from types import ModuleType
from typing import Any, Dict, List

try:
    from typing import Protocol as _Protocol
except ImportError:  # Python < 3.8
    from typing_extensions import Protocol as _Protocol

from osdag_api.common_defs import developed_modules  # noqa: F401  (re-exported)
from osdag_api.errors import OsdagApiException

logger = logging.getLogger(__name__)


class ModuleApiType(_Protocol):

    def validate_input(self, input_values: Dict[str, Any]) -> None:
        """Validate type for all values in design dict. Raise error when invalid"""

    def get_required_keys(self) -> List[str]:
        """Return all required keys for the design."""

    def generate_output(self, input_values: Dict[str, Any]) -> Dict[str, Any]:
        """Generate, format and return the output values for the given input values."""

    def create_cad_model(self, input_values: Dict[str, Any], section: str, session: str) -> str:
        """Generate the CAD model from input values as a BREP file. Return file path."""


class UnavailableModule:
    """
    Stand-in for a module whose API could not be imported (for example the shear
    connection modules, which need pythonOCC). Every call raises a clear error
    instead of silently returning empty results.
    """

    def __init__(self, module_id: str, reason: str):
        self.module_id = module_id
        self.reason = reason

    def _fail(self, *args, **kwargs):
        raise OsdagApiException(f"{self.module_id} is not available on this server: {self.reason}")

    validate_input = get_required_keys = create_module = create_from_input = _fail
    generate_output = create_cad_model = _fail


_MODULE_PATHS = {
    'Fin Plate Connection': 'osdag_api.modules.fin_plate_connection',
    'End Plate Connection': 'osdag_api.modules.end_plate_connection',
    'Cleat Angle Connection': 'osdag_api.modules.cleat_angle_connection',
    'Seated Angle Connection': 'osdag_api.modules.seated_angle_connection',
    'Column Cover Plate Bolted': 'osdag_api.modules.column_cover_plate_bolted',
    'Column Cover Plate Welded': 'osdag_api.modules.column_cover_plate_welded',
}


def _load(module_id: str, path: str):
    # Import each module separately so one missing optional dependency
    # (pythonOCC for the shear connections) does not disable the others.
    try:
        return importlib.import_module(path)
    except ImportError as exc:
        logger.warning("Module %s is unavailable: %s", module_id, exc)
        return UnavailableModule(module_id, f"missing dependency ({exc})")


module_dict: Dict[str, ModuleApiType] = {
    module_id: _load(module_id, path) for module_id, path in _MODULE_PATHS.items()
}


def get_module_api(module_id: str) -> ModuleApiType:
    """Return the api for the specified module"""
    return module_dict[module_id]


def is_module_available(module_id: str) -> bool:
    return isinstance(module_dict.get(module_id), ModuleType)
