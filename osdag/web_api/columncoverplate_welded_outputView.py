"""Output API for the Column-to-Column Cover Plate Welded module (see columncoverplate_outputView)."""
from osdag.web_api.columncoverplate_outputView import ColumnCoverPlateOutputBase


class ColumnCoverPlateWeldedOutputData(ColumnCoverPlateOutputBase):
    module_id = 'Column Cover Plate Welded'
    cookie_key = 'column_cover_plate_welded_session'
