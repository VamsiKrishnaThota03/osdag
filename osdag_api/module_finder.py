from types import ModuleType
import typing
try:
    from typing import Dict, Any, List, _Protocol
except ImportError:
    from typing import Dict, Any, List
    from typing_extensions import Protocol as _Protocol

# Import developed_modules from common_defs instead of osdag_api
from osdag_api.common_defs import developed_modules

# Try to import the modules, but handle the case where OCC is not available
try:
    from osdag_api.modules import fin_plate_connection, end_plate_connection, cleat_angle_connection, seated_angle_connection, column_cover_plate_bolted, column_cover_plate_welded
    modules_imported = True
except ImportError as e:
    import sys
    print(f"Warning: Could not import modules: {e}", file=sys.stderr)
    print("Some functionality will be limited.", file=sys.stderr)
    modules_imported = False
    # Create dummy modules with minimal required interfaces
    class DummyModule:
        def validate_input(self, input_values: Dict[str, Any]) -> None:
            print("Warning: Using dummy module - validation not performed")
            
        def get_required_keys(self) -> List[str]:
            return []
            
        def create_module(self) -> Any:
            print("Warning: Using dummy module - no actual module created")
            return None
            
        def create_from_input(self, input_values: Dict[str, Any]) -> Any:
            print("Warning: Using dummy module - no actual module created")
            return None
            
        def generate_output(self, input_values: Dict[str, Any]) -> Dict[str, Any]:
            print("Warning: Using dummy module - no output generated")
            return {}, []
            
        def create_cad_model(self, input_values: Dict[str, Any], section: str, session: str) -> str:
            print("Warning: Using dummy module - no CAD model created")
            return ""
    
    # Create dummy modules
    fin_plate_connection = DummyModule()
    end_plate_connection = DummyModule()
    cleat_angle_connection = DummyModule()
    seated_angle_connection = DummyModule()
    column_cover_plate_bolted = DummyModule()
    column_cover_plate_welded = DummyModule()

class ModuleApiType(_Protocol):

    def validate_input(self, input_values: Dict[str, Any]) -> None:
        """Validate type for all values in design dict. Raise error when invalid"""
        pass
    def get_required_keys(self) -> List[str]:
        pass
    def create_module(self) -> Any:
        """Create an instance of themodule design class and set it up for use"""
        pass
    def create_from_input(self, input_values: Dict[str, Any]) -> Any:
        """Create an instance of the module design class from input values."""
        pass
    def generate_output(self, input_values: Dict[str, Any]) -> Dict[str, Any]:
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
        pass
    def create_cad_model(self, input_values: Dict[str, Any], section: str, session: str) -> str:
        """Generate the CAD model from input values as a BREP file. Return file path."""
        pass
    
module_dict : Dict[str, ModuleApiType] = {
    'Fin Plate Connection': fin_plate_connection,
    'End Plate Connection': end_plate_connection,
    'Cleat Angle Connection': cleat_angle_connection,
    'Seated Angle Connection': seated_angle_connection,
    'Column Cover Plate Bolted': column_cover_plate_bolted,
    'Column Cover Plate Welded': column_cover_plate_welded
} 

def get_module_api(module_id: str) -> ModuleApiType:
    """Return the api for the specified module"""
    module = module_dict[module_id]
    return module