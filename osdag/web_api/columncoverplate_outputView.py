"""
Output API for the Column-to-Column Cover Plate modules.

POST /calculate-output/Column-Cover-Plate-Bolted
POST /calculate-output/Column-Cover-Plate-Welded

Body: the module's input values (JSON). Requires the module's session cookie
(created by POST /sessions/create with the module_id).

Response: {"data": {key: {key, label, value}}, "logs": [{type, msg}],
           "success": <design is safe>, "cad_available": <pythonOCC installed>}
"""
import logging

from django.http import JsonResponse
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView

from osdag.models import Design
from osdag_api import CAD_FUNCTIONALITY_AVAILABLE, get_module_api
from osdag_api.errors import OsdagApiException
from osdag_api.modules.column_cover_plate_common import DesignError

logger = logging.getLogger(__name__)


def _logs_to_text(logs):
    return "".join(f"{log['type'].upper()} : {log['msg']}\n" for log in logs)


@method_decorator(csrf_exempt, name='dispatch')
class ColumnCoverPlateOutputBase(APIView):
    module_id = None
    cookie_key = None

    def post(self, request):
        cookie_id = request.COOKIES.get(self.cookie_key)
        design = Design.objects.filter(cookie_id=cookie_id).first() if cookie_id else None
        if design is None:
            return self._error(400, "No design session found. Reopen the module to start a new session.")

        input_values = request.data
        if not isinstance(input_values, dict):
            return self._error(400, "Input values must be a JSON object.")

        try:
            output, logs = get_module_api(self.module_id).generate_output(input_values)
        except OsdagApiException as exc:
            return self._error(400, str(exc))
        except DesignError as exc:
            logger.warning("%s design failed: %s", self.module_id, exc)
            return self._error(422, "The design could not be completed for these inputs. Check that the "
                                    "section designation and materials exist in the Osdag database. (" + str(exc) + ")")

        design_status = bool(output) and not any(log["type"] == "ERROR" for log in logs)
        design.input_values = input_values
        design.output_values = output
        design.logs = _logs_to_text(logs)
        design.design_status = design_status
        design.save()

        if not CAD_FUNCTIONALITY_AVAILABLE:
            logs = logs + [{"type": "INFO",
                            "msg": "3D model not generated: pythonOCC is not installed on this server."}]

        return JsonResponse({
            "data": output,
            "logs": logs,
            "success": design_status,
            "cad_available": CAD_FUNCTIONALITY_AVAILABLE,
        }, status=200)

    @staticmethod
    def _error(status, message):
        return JsonResponse({"data": {}, "logs": [{"type": "ERROR", "msg": message}],
                             "success": False, "cad_available": CAD_FUNCTIONALITY_AVAILABLE},
                            status=status)


class ColumnCoverPlateBoltedOutputData(ColumnCoverPlateOutputBase):
    module_id = 'Column Cover Plate Bolted'
    cookie_key = 'column_cover_plate_bolted_session'
