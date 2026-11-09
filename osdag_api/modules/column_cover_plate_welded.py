"""
Web API for the Column-to-Column Cover Plate Welded Connection module.

Runs the upstream Osdag design (design_type.connection.column_cover_plate_weld)
on the submitted inputs and returns its real outputs and design log.
CAD generation needs pythonOCC and is only attempted when it is installed.
"""
import os
from typing import Any, Dict, List, Tuple

# Import the design module before Common: Common has a circular import with utils.common.
from design_type.connection import column_cover_plate_weld as design_module
from design_type.connection.column_cover_plate_weld import ColumnCoverPlateWeld
from Common import KEY_DISP_COLUMNCOVERPLATEWELD
from osdag_api.errors import InvalidInputTypeError, OsdagApiException
import osdag_api.modules.column_cover_plate_common as ccp

MODULE_NAME = KEY_DISP_COLUMNCOVERPLATEWELD  # 'Column-to-Column Cover Plate Welded Connection'

DEFAULTS = {
    "Connector.Flange_Plate.Preferences": "Outside",
    "Weld.Type": "Fillet Weld",
    "Load.Axial": "",
    "Load.Moment": "",
    "Load.Shear": "",
}

OUTPUT_SECTIONS = [
    "output_values",
    "member_capacityoutput",
    "flangecapacity",
    "webcapacity",
    "flange_weld_details",
    "web_weld_details",
]


def get_required_keys() -> List[str]:
    return [
        "Connector.Flange_Plate.Preferences",
        "Connector.Flange_Plate.Thickness_list",
        "Connector.Material",
        "Connector.Web_Plate.Thickness_List",
        "Design.Design_Method",
        "Detailing.Gap",
        "Material",
        "Member.Designation",
        "Member.Material",
        "Weld.Fab",
        "Weld.Material_Grade_OverWrite",
    ]


def to_design_input(input_values: Dict[str, Any]) -> Dict[str, Any]:
    return ccp.normalise_input(input_values, MODULE_NAME, DEFAULTS)


def validate_input(input_values: Dict[str, Any]) -> None:
    """Raise MissingKeyError / InvalidInputTypeError for unusable input."""
    design = to_design_input(input_values)
    ccp.check_required(design, get_required_keys())
    for key in ("Connector.Flange_Plate.Thickness_list", "Connector.Web_Plate.Thickness_List"):
        if not isinstance(design[key], list):
            raise InvalidInputTypeError(key, "non-empty list of strings")


def create_from_input(input_values: Dict[str, Any]):
    """Run the design and return the design state (a ColumnCoverPlateWeld subclass) and its logs."""
    validate_input(input_values)
    return ccp.run_design(design_module, ColumnCoverPlateWeld, to_design_input(input_values))


def generate_output(input_values: Dict[str, Any]) -> Tuple[Dict[str, Any], List[Dict[str, str]]]:
    """
    Return ({key: {"key", "label", "value"}}, logs) for the given inputs.
    Raises OsdagApiException for invalid input and ccp.DesignError if the design code fails.
    """
    run_cls, logs = create_from_input(input_values)
    output = ccp.collect_output(run_cls, OUTPUT_SECTIONS)
    if not getattr(run_cls, "design_status", False) and not any(log["type"] == "ERROR" for log in logs):
        logs.append({"type": "ERROR", "msg": "Design is unsafe or could not be completed for these inputs."})
    return output, logs


def create_cad_model(input_values: Dict[str, Any], section: str, session: str) -> str:
    """Generate the CAD model as a BREP file and return its path. Requires pythonOCC."""
    from osdag_api import CAD_FUNCTIONALITY_AVAILABLE
    if not CAD_FUNCTIONALITY_AVAILABLE:
        raise OsdagApiException("3D CAD needs pythonOCC, which is not installed on this server.")
    if section not in ("Model", "Column", "Cover Plate"):
        raise InvalidInputTypeError("section", "'Model', 'Column' or 'Cover Plate'")

    from OCC.Core import BRepTools  # imported lazily: optional dependency
    from cad.common_logic import CommonDesignLogic

    run_cls, _ = create_from_input(input_values)
    cld = CommonDesignLogic(None, '', MODULE_NAME, "Moment Connection")
    cld.module_class = run_cls
    cld.CPObj = cld.createCCCoverPlateCAD()
    cld.component = section
    model = cld.create2Dcad()

    folder = os.path.join(os.getcwd(), "file_storage", "cad_models")
    os.makedirs(folder, exist_ok=True)
    file_path = os.path.join("file_storage", "cad_models", f"{session}_{section.replace(' ', '_')}.brep")
    BRepTools.breptools.Write(model, file_path)
    return file_path
