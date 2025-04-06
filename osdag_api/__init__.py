# Import common definitions
from osdag_api.common_defs import developed_modules, module_dict

# Track if CAD functionality is available
CAD_FUNCTIONALITY_AVAILABLE = False

# First check if OCC module is available
try:
    try:
        from OCC.Core import BRepTools
        print("OCC Core module is available - Full CAD functionality enabled")
        CAD_FUNCTIONALITY_AVAILABLE = True
    except ImportError:
        try:
            import OCC.BRepTools as BRepTools
            print("Legacy OCC module is available - Full CAD functionality enabled")
            CAD_FUNCTIONALITY_AVAILABLE = True
        except ImportError:
            print("Warning: OCC module not found. CAD functionality will be limited.")
            CAD_FUNCTIONALITY_AVAILABLE = False
except Exception as e:
    print(f"Error checking CAD functionality: {e}")
    CAD_FUNCTIONALITY_AVAILABLE = False

# Try to import the module_finder for CAD functionality
try:
    from osdag_api.module_finder import get_module_api
    print("Successfully imported module_finder")
except ImportError as e:
    print(f"Warning: {e}")
    print("Module finder import failed. Some features may not work properly.")
    # Define empty or mock functions that might be needed
    def get_module_api(module_id):
        print(f"Warning: Module finder is not available. Cannot access module: {module_id}")
        return None
else:
    # This code runs if the import was successful
    # developed_modules is already defined in the imported module
    pass

# Keep the module_dict definition which provides UI information
module_dict = [
    {
        "key": "Fin Plate Connection",
        "image": "/static/images/modules/fin_plate_connection.png",
        "name": "Fin Plate",
        "path": "Connection/Shear Connection"
    },
    {
        "key": "End Plate Connection",
        "image": "/static/images/modules/end_plate_connection.png",
        "name": "End Plate",
        "path": "Connection/Shear Connection"
    },
    {
        "key": "Cleat Angle Connection",
        "image":"/static/images/modules/cleat_angle_connection.png",
        "name":"Cleat Angle",
        "path":"Connection/Shear Connection"
    },
    {
        "key":"Seated Angle Connection",
        "image":"/static/images/modules/seated_angle_connection.png",
        "name":"Seated Angle",
        "path":"Connection/Shear Connection"
    },
    {
        "key":"Column Cover Plate Bolted",
        "image":"/static/images/modules/column_cover_plate_bolted.png",
        "name":"Column Cover Plate Bolted",
        "path":"Connection/Moment Connection/Column-to-Column Splice"
    }
]