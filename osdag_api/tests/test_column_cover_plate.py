"""
Checks that the Column Cover Plate web APIs run the real upstream design.

Run from the repository root (no database or pythonOCC needed):

    python -m unittest discover -s osdag_api/tests -t .
"""
import os
import unittest

import yaml

import osdag_api.modules.column_cover_plate_bolted as bolted
import osdag_api.modules.column_cover_plate_welded as welded
from osdag_api.errors import MissingKeyError
from osdag_api.modules.column_cover_plate_common import DesignError

EXAMPLES = os.path.join(os.path.dirname(__file__), "..", "..", "ResourceFiles", "design_example")


def example(name):
    with open(os.path.join(EXAMPLES, name)) as handle:
        return yaml.safe_load(handle)


class ColumnCoverPlateBoltedTest(unittest.TestCase):

    def test_example_design_is_safe_with_real_values(self):
        output, logs = bolted.generate_output(example("column_bolted1.osi"))
        self.assertFalse([log for log in logs if log["type"] == "ERROR"], logs)
        self.assertEqual(output["Bolt.Diameter"]["value"], 14)
        self.assertEqual(output["Section.AxialCapacity"]["value"], 1070.45)
        self.assertIn("flange_bolt_capacity", {item["section"] for item in output.values()})

    def test_accepts_field_names_sent_by_the_web_form(self):
        values = example("column_bolted1.osi")
        values["Member.Supported_Section.Designation"] = values.pop("Member.Designation")
        values["Member.Supported_Section.Material"] = values.pop("Member.Material")
        values["Connector.Flange_Plate.Thickness_List"] = values.pop("Connector.Flange_Plate.Thickness_list")
        output, _ = bolted.generate_output(values)
        self.assertEqual(output["Bolt.Diameter"]["value"], 14)

    def test_overloaded_column_is_reported_unsafe(self):
        values = example("column_bolted1.osi")
        values["Load.Axial"] = "90000"
        _, logs = bolted.generate_output(values)
        self.assertTrue(any(log["type"] == "ERROR" for log in logs))

    def test_missing_key_is_rejected(self):
        with self.assertRaises(MissingKeyError):
            bolted.generate_output({"Bolt.Type": "Bearing Bolt"})

    def test_unknown_section_raises_design_error(self):
        values = example("column_bolted1.osi")
        values["Member.Designation"] = "NOT A SECTION"
        with self.assertRaises(DesignError):
            bolted.generate_output(values)


class ColumnCoverPlateWeldedTest(unittest.TestCase):

    def test_example_design_is_safe(self):
        output, logs = welded.generate_output(example("column_welded1.osi"))
        self.assertFalse([log for log in logs if log["type"] == "ERROR"], logs)
        self.assertEqual(output["Flange_Plate.Width (mm)"]["value"], 270)


if __name__ == "__main__":
    unittest.main()
