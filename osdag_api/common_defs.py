"""
Common definitions and variables used across the osdag_api modules
"""

# List of developed modules
developed_modules = [
    "Fin Plate Connection", "End Plate Connection", "Cleat Angle Connection", 
    "Seated Angle Connection", "Column Cover Plate Bolted", "Column Cover Plate Welded"
]

# Flag to track if CAD functionality is available
CAD_FUNCTIONALITY_AVAILABLE = False

# Dictionary of module information for UI
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
    },
    {
        "key":"Column Cover Plate Welded",
        "image":"/static/images/modules/column_cover_plate_welded.png",
        "name":"Column Cover Plate Welded",
        "path":"Connection/Moment Connection/Column-to-Column Splice"
    }
] 