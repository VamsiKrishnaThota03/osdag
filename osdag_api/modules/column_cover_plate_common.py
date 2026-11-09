"""
Shared helpers for the Column-to-Column Cover Plate (bolted and welded) web APIs.

The design itself is done by the upstream Osdag design classes
(design_type.connection.column_cover_plate.ColumnCoverPlate and
design_type.connection.column_cover_plate_weld.ColumnCoverPlateWeld).
These classes come from the desktop application and keep their state on the
class rather than on an instance (methods are called as Cls.method(Cls, ...)).
To keep concurrent web requests independent, every design run uses a fresh
throw-away subclass, and runs are serialised because the design modules share
a module-level `logger`.

Only the design calculation is needed for outputs; it does not require
pythonOCC. CAD generation is handled separately and needs pythonOCC.
"""
import contextlib
import io
import logging
import threading
from typing import Any, Dict, List, Tuple

from osdag_api.errors import InvalidInputTypeError, MissingKeyError

_DESIGN_LOCK = threading.Lock()

# Keys the upstream design classes read, with accepted aliases sent by older
# versions of the web form (which reused the shear-connection field names).
_ALIASES = {
    "Member.Designation": ["Member.Supported_Section.Designation", "Member.Supporting_Section.Designation"],
    "Member.Material": ["Member.Supported_Section.Material", "Member.Supporting_Section.Material", "Material"],
    "Connector.Flange_Plate.Thickness_list": ["Connector.Flange_Plate.Thickness_List"],
}

_LOG_TYPES = {
    logging.DEBUG: "DEBUG",
    logging.INFO: "INFO",
    logging.WARNING: "WARNING",
    logging.ERROR: "ERROR",
    logging.CRITICAL: "ERROR",
}


class DesignError(Exception):
    """Raised when the upstream design code fails for the given inputs."""


def normalise_input(input_values: Dict[str, Any], module_name: str, defaults: Dict[str, Any]) -> Dict[str, Any]:
    """Return a copy of the input in the shape the upstream design class expects."""
    if not isinstance(input_values, dict):
        raise InvalidInputTypeError("input", "JSON object")
    design = dict(input_values)
    for key, aliases in _ALIASES.items():
        if not design.get(key):
            for alias in aliases:
                if design.get(alias):
                    design[key] = design[alias]
                    break
    for key, value in defaults.items():
        design.setdefault(key, value)
    # The design classes compare against their own display name.
    design["Module"] = module_name
    return design


def check_required(design: Dict[str, Any], required: List[str]) -> None:
    for key in required:
        if key not in design or design[key] in (None, [], {}):
            raise MissingKeyError(key)
    for key in ("Load.Axial", "Load.Moment", "Load.Shear"):
        value = design.get(key, "")
        if value not in ("", None):
            try:
                float(value)
            except (TypeError, ValueError):
                raise InvalidInputTypeError(key, "number (or empty)")


class _CaptureHandler(logging.Handler):
    def __init__(self):
        super().__init__(level=logging.INFO)
        self.records: List[Dict[str, str]] = []

    def emit(self, record):
        # Upstream messages are formatted as " : <text>"; drop that prefix.
        message = record.getMessage().strip()
        if message.startswith(":"):
            message = message[1:].strip()
        entry = {"type": _LOG_TYPES.get(record.levelno, "INFO"), "msg": message}
        if entry not in self.records:
            self.records.append(entry)


def run_design(design_module, design_class, design: Dict[str, Any]) -> Tuple[type, List[Dict[str, str]]]:
    """
    Run the upstream design for `design` and return (design_state, logs).

    design_module is the Python module that defines design_class; its global
    `logger` is pointed at a capturing logger for the duration of the run.
    """
    run_cls = type(design_class.__name__ + "Run", (design_class,), {})
    capture = _CaptureHandler()
    run_logger = logging.getLogger("osdag_api.column_cover_plate")
    run_logger.propagate = False
    run_logger.setLevel(logging.DEBUG)

    with _DESIGN_LOCK:
        previous = getattr(design_module, "logger", None)
        run_logger.addHandler(capture)
        design_module.logger = run_logger
        try:
            # The desktop code prints a lot of debugging output; keep it out of the server log.
            with contextlib.redirect_stdout(io.StringIO()):
                run_cls.set_input_values(run_cls, design)
        except Exception as exc:  # upstream code raises many different errors for bad input
            logging.getLogger(__name__).exception("Column cover plate design failed")
            raise DesignError(f"{type(exc).__name__}: {exc}") from exc
        finally:
            run_logger.removeHandler(capture)
            if previous is not None:
                design_module.logger = previous
    return run_cls, capture.records


def collect_output(run_cls, sections: List[str]) -> Dict[str, Dict[str, Any]]:
    """Format the TextBox outputs of the given output functions as {key: {key, label, value}}."""
    output: Dict[str, Dict[str, Any]] = {}
    with contextlib.redirect_stdout(io.StringIO()):
        for name in sections:
            func = getattr(run_cls, name, None)
            if func is None:
                continue
            try:
                rows = func(run_cls, True)
            except Exception:
                logging.getLogger(__name__).exception("Could not read %s from the design", name)
                continue
            for row in rows or []:
                if len(row) > 3 and row[2] == "TextBox" and row[0]:
                    key = row[0] if row[0] not in output else f"{name}.{row[0]}"
                    output[key] = {"key": key, "label": row[1], "value": row[3], "section": name}
    return output
