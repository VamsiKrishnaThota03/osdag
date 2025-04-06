from osdag_api.validation_utils import validate_arr, validate_num, validate_string
from osdag_api.errors import MissingKeyError, InvalidInputTypeError
from osdag_api.utils import contains_keys, custom_list_validation, float_able, int_able, is_yes_or_no, validate_list_type
import osdag_api.modules.shear_connection_common as scc

# Try importing OCC using different approaches
try:
    from OCC.Core import BRepTools
except ImportError:
    try:
        import OCC.BRepTools as BRepTools
    except ImportError:
        print("Warning: OCC module not found. CAD functionality will be limited.")
        class DummyBRepTools:
            class breptools:
                @staticmethod
                def Write(*args, **kwargs):
                    print("CAD export not available - OCC module missing")
                    return "dummy_path.brep"
        BRepTools = DummyBRepTools

from cad.common_logic import CommonDesignLogic
# Will log a lot of unnecessary data.
from design_type.connection.column_cover_plate import ColumnCoverPlate
import sys
import os
import typing
from typing import Dict, Any, List
old_stdout = sys.stdout  # Backup log
sys.stdout = open(os.devnull, "w")  # redirect stdout
sys.stdout = old_stdout  # Reset log


def get_required_keys() -> List[str]:
    return [
        "Bolt.Bolt_Hole_Type",
        "Bolt.Diameter",
        "Bolt.Grade",
        "Bolt.Slip_Factor",
        "Bolt.TensionType",
        "Bolt.Type",
        "Connectivity",
        "Connector.Material",
        "Design.Design_Method",
        "Detailing.Corrosive_Influences",
        "Detailing.Edge_type",
        "Detailing.Gap",
        "Load.Axial",
        "Load.Moment",
        "Load.Shear",
        "Material",
        "Member.Supported_Section.Designation",
        "Member.Supported_Section.Material",
        "Member.Supporting_Section.Designation",
        "Member.Supporting_Section.Material",
        "Module",
        "Weld.Fab",
        "Weld.Material_Grade_OverWrite",
        "Connector.Flange_Plate.Thickness_List",
        "Connector.Web_Plate.Thickness_List",
    ]


def validate_input(input_values: Dict[str, Any]) -> None:
    """Validate type for all values in design dict. Raise error when invalid"""

    # Check if all required keys exist
    required_keys = get_required_keys()
    # Check if input_values contains all required keys.
    missing_keys = contains_keys(input_values, required_keys)
    if missing_keys != None:  # If keys are missing.
        # Raise error for the first missing key.
        raise MissingKeyError(missing_keys[0])

    # Validate key types one by one:

    # Validate Bolt.Bolt_Hole_Type.
    # Check if Bolt.Bolt_Hole_Type is a string.
    if not isinstance(input_values["Bolt.Bolt_Hole_Type"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Bolt.Bolt_Hole_Type", "str")

     # Validate Bolt.Diameter.
    bolt_diameter = input_values["Bolt.Diameter"]
    if (not isinstance(bolt_diameter, list)  # Check if Bolt.Diameter is a list.
            # Check if all items in Bolt.Diameter are str.
            or not validate_list_type(bolt_diameter, str)
            or not custom_list_validation(bolt_diameter, int_able)):  # Check if all items in Bolt.Diameter can be converted to int.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Bolt.Diameter", "non empty List[str] where all items can be converted to int")

    # Validate Bolt.Grade
    bolt_grade = input_values["Bolt.Grade"]
    if (not isinstance(bolt_grade, list)  # Check if Bolt.Grade is a list.
            # Check if all items in Bolt.Grade are str.
            or not validate_list_type(bolt_grade, str)
            or not custom_list_validation(bolt_grade, float_able)):  # Check if all items in Bolt.Grade can be converted to float.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Bolt.Grade", "non empty List[str] where all items can be converted to float")

    # Validate Bolt.Slip_Factor
    bolt_slipfactor = input_values["Bolt.Slip_Factor"]
    if (not isinstance(bolt_slipfactor, str)  # Check if Bolt.Slip_Factor is a string.
            or not float_able(bolt_slipfactor)):  # Check if Bolt.Slip_Factor can be converted to float.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Bolt.Slip_Factor", "str where str can be converted to float")

    # Validate Bolt.TensionType
    # Check if Bolt.TensionType is a string.
    if not isinstance(input_values["Bolt.TensionType"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Bolt.TensionType", "str")

    # Validate Bolt.Type
    # Check if Bolt.Type is a string.
    if not isinstance(input_values["Bolt.Type"], str):
        raise InvalidInputTypeError("Bolt.Type", "str")  # If not, raise error.

    # Validate Connectivity
    # Check if Connectivity is a string.
    if not isinstance(input_values["Connectivity"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Connectivity", "str")

    # Validate Connector.Material
    # Check if Connector.Material is a string.
    if not isinstance(input_values["Connector.Material"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Connector.Material", "str")

    # Validate Design.Design_Method
    # Check if Design.Design_Method is a string.
    if not isinstance(input_values["Design.Design_Method"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Design.Design_Method", "str")

    # Validate Detailing.Corrosive_Influences
    # Check if Detailing.Corrosive_Influences is 'Yes' or 'No'.
    if not is_yes_or_no(input_values["Detailing.Corrosive_Influences"]):
        # If not, raise error.
        raise InvalidInputTypeError(
            "Detailing.Corrosive_Influences", "'Yes' or 'No'")

    # Validate Detailing.Edge_type
    # Check if Detailing.Edge_type is a string.
    if not isinstance(input_values["Detailing.Edge_type"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Detailing.Edge_type", "str")

    # Validate Detailing.Gap
    detailing_gap = input_values["Detailing.Gap"]
    if (not isinstance(detailing_gap, str)  # Check if Detailing.Gap is a string.
            or not int_able(detailing_gap)):  # Check if Detailing.Gap can be converted to int.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Detailing.Gap", "str where str can be converted to int")

    # Validate Load.Axial
    load_axial = input_values["Load.Axial"]
    if (not isinstance(load_axial, str)  # Check if Load.Axial is a string.
            or not int_able(load_axial)):  # Check if Load.Axial can be converted to int.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Load.Axial", "str where str can be converted to int")

    # Validate Load.Moment
    load_moment = input_values["Load.Moment"]
    if (not isinstance(load_moment, str)  # Check if Load.Moment is a string.
            or not int_able(load_moment)):  # Check if Load.Moment can be converted to int.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Load.Moment", "str where str can be converted to int")

    # Validate Load.Shear
    load_shear = input_values["Load.Shear"]
    if (not isinstance(load_shear, str)  # Check if Load.Shear is a string.
            or not int_able(load_shear)):  # Check if Load.Shear can be converted to int.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Load.Shear", "str where str can be converted to int")

    # Validate Material
    # Check if Material is a string.
    if not isinstance(input_values["Material"], str):
        raise InvalidInputTypeError("Material", "str")  # If not, raise error.

    # Validate Member.Supported_Section.Designation
    # Check if Member.Supported_Section.Designation is a string.
    if not isinstance(input_values["Member.Supported_Section.Designation"], str):
        # If not, raise error.
        raise InvalidInputTypeError(
            "Member.Supported_Section.Designation", "str")

    # Validate Member.Supported_Section.Material
    # Check if Member.Supported_Section.Material is a string.
    if not isinstance(input_values["Member.Supported_Section.Material"], str):
        # If not, raise error.
        raise InvalidInputTypeError("Member.Supported_Section.Material", "str")

    # Validate Member.Supporting_Section.Designation
    # Check if Member.Supporting_Section.Designation is a string.
    if not isinstance(input_values["Member.Supporting_Section.Designation"], str):
        # If not, raise error.
        raise InvalidInputTypeError(
            "Member.Supporting_Section.Designation", "str")

    # Validate Member.Supporting_Section.Material
    # Check if Member.Supporting_Section.Material is a string.
    if not isinstance(input_values["Member.Supporting_Section.Material"], str):
        # If not, raise error.
        raise InvalidInputTypeError(
            "Member.Supporting_Section.Material", "str")

    # Validate Module
    # Check if Module is a string.
    if not isinstance(input_values["Module"], str):
        raise InvalidInputTypeError("Module", "str")  # If not, raise error.

    # Validate Weld.Fab
    # Check if Weld.Fab is a string.
    if not isinstance(input_values["Weld.Fab"], str):
        raise InvalidInputTypeError("Weld.Fab", "str")  # If not, raise error.

    # Validate Weld.Material_Grade_OverWrite
    weld_materialgradeoverwrite = input_values["Weld.Material_Grade_OverWrite"]
    if (not isinstance(weld_materialgradeoverwrite, str)  # Check if Weld.Material_Grade_OverwWite is a string.
            or not int_able(weld_materialgradeoverwrite)):  # Check if Weld.Material_Grade_OverWrite can be converted to int.
        # If any of these conditions fail, raise error.
        raise InvalidInputTypeError(
            "Weld.Material_Grade_OverWrite", "str where str can be converted to int.")

    # Validate Connector.Flange_Plate.Thickness_List
    flange_plate_thicknesslist = input_values["Connector.Flange_Plate.Thickness_List"]
    if (not isinstance(flange_plate_thicknesslist, list)  # Check if list.
            # Check if all items are str.
            or not validate_list_type(flange_plate_thicknesslist, str)
            or not custom_list_validation(flange_plate_thicknesslist, int_able)):  # Check if all items can be converted to int.
        raise InvalidInputTypeError(
            "Connector.Flange_Plate.Thickness_List", "List[str] where all items can be converted to int")

    # Validate Connector.Web_Plate.Thickness_List
    web_plate_thicknesslist = input_values["Connector.Web_Plate.Thickness_List"]
    if (not isinstance(web_plate_thicknesslist, list)  # Check if list.
            # Check if all items are str.
            or not validate_list_type(web_plate_thicknesslist, str)
            or not custom_list_validation(web_plate_thicknesslist, int_able)):  # Check if all items can be converted to int.
        raise InvalidInputTypeError(
            "Connector.Web_Plate.Thickness_List", "List[str] where all items can be converted to int")


def create_module() -> ColumnCoverPlate:
    """Create an instance of the Column Cover Plate connection module design class and set it up for use"""
    module = ColumnCoverPlate()  # Create an instance of the ColumnCoverPlate
    module.set_osdaglogger(None)
    return module


def create_from_input(input_values: Dict[str, Any]) -> ColumnCoverPlate:
    """Create an instance of the Column Cover Plate connection module design class from input values."""
    validate_input(input_values)
    try:
        module = create_module()  # Create module instance.
    except Exception as e:
        print('e in create_module : ', e)
        print('error in creating module')
    
    # Set the input values on the module instance.
    try:
        module.set_input_values(input_values)
    except Exception as e:
        print('e in set_input_values : ', e)
        print('error in setting the input values')

    return module


def generate_output(input_values: Dict[str, Any]) -> Dict[str, Any]:
    """
    Generate, format and return the input values from the given output values.
    Output format (json): {
        "Bolt.Pitch": 
            "key": "Bolt.Pitch",
            "label": "Pitch Distance (mm)"
            "value": 40
        }
    }
    """
    output = {}  # Dictionary for formatted values
    module = create_from_input(input_values)  # Create module from input.
    
    # Generate output values in unformatted form.
    raw_output_text = module.output_values(True)
    raw_output_spacing = module.spacing(True)  # Generate output val
    raw_output_capacities = module.capacities(True)
    raw_output_bolt_capacity = module.bolt_capacity_details(True)
    logs = module.logs
    
    raw_output = raw_output_capacities + raw_output_spacing + raw_output_text + raw_output_bolt_capacity
    
    # Loop over all the text values and add them to output dict.
    for param in raw_output:
        if param[2] == "TextBox":  # If the parameter is a text output,
            key = param[0]  # id/key
            label = param[1]  # label text.
            value = param[3]  # Value as string.
            output[key] = {
                "key": key,
                "label": label,
                "value": value
            }  # Set label, key and value in output
    return output, logs


def create_cad_model(input_values: Dict[str, Any], section: str, session: str) -> str:
    """Generate the CAD model from input values as a BREP file. Return file path."""
    # Check if we have CAD functionality available
    from osdag_api import CAD_FUNCTIONALITY_AVAILABLE
    if not CAD_FUNCTIONALITY_AVAILABLE:
        print("CAD functionality is disabled. Cannot generate CAD model.")
        return "CAD functionality unavailable"
        
    if section not in ("Model", "Beam", "Column", "Plate"):  # Error checking: If section is valid.
        raise InvalidInputTypeError(
            "section", "'Model', 'Beam', 'Column' or 'Plate'")
    
    try:
        module = create_from_input(input_values)  # Create module from input.
    except Exception as e:
        print(f"Error creating module: {e}")
        return "Error creating module"
    
    # Object that will create the CAD model.
    try:
        cld = CommonDesignLogic(None, '', module.module, module.mainmodule)
    except Exception as e:
        print(f'Error in creating CommonDesignLogic: {e}')
        return "Error in CAD model creation"
    
    try:
        # Setup the calculations object for generating CAD model.
        scc.setup_for_cad(cld, module)
    except Exception as e:
        print(f'Error in setting up CAD: {e}')
        return "Error in CAD setup"

    # The section of the module that will be generated.
    cld.component = section
    
    try:
        model = cld.create2Dcad()  # Generate CAD Model.
    except Exception as e:
        print(f'Error in creating 2D CAD: {e}')
        return "Error generating CAD model"

    # check if the cad_models folder exists or not 
    # if no, then create one 
    if not os.path.exists(os.path.join(os.getcwd(), "file_storage/cad_models/")):
        print('path does not exist for cad_models, creating one')
        try:
            os.makedirs(os.path.join(os.getcwd(), "file_storage/cad_models/"), exist_ok=True)
        except Exception as e:
            print(f'Error creating directory: {e}')
            return "Error creating directory for CAD model"
      
    file_name = session + "_" + section + ".brep"
    file_path = "file_storage/cad_models/" + file_name
    
    try:
        BRepTools.breptools.Write(model, file_path) # Generate CAD Model
        return file_path
    except Exception as e:
        print(f'Writing to BREP file failed: {e}')
        return "Error writing CAD model to file" 