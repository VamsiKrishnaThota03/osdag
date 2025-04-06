from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import JSONParser
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.http import JsonResponse
from osdag_api import get_module_api, CAD_FUNCTIONALITY_AVAILABLE
from django.http import HttpResponse, HttpRequest

# importing from DRF
from rest_framework.response import Response
from rest_framework import status

# importing models
from osdag.models import Columns, Beams, Bolt, Bolt_fy_fu, Material
from osdag.models import Design

# importing serializers
from osdag.serializers import Design_Serializer

@method_decorator(csrf_exempt, name='dispatch')
class ColumnCoverPlateBoltedOutputData(APIView):

    def post(self, request):
        print("Inside post method of ColumnCoverPlateBolted OutputData")

        # Check if CAD functionality is available
        if not CAD_FUNCTIONALITY_AVAILABLE:
            print("Warning: CAD functionality is disabled. Proceeding with limited functionality.")
            # We'll continue with limited functionality instead of stopping completely
            # This allows users to at least see the interface and input data
            # Add a warning to the logs that will be displayed to the user
            warning_logs = [
                {"type": "WARNING", "msg": "The OCC module is missing. 3D model generation and some calculation features will be limited."},
                {"type": "INFO", "msg": "You can continue using the application with limited functionality."}
            ]
            # We'll set an empty output dictionary and continue
            # This is better than returning an error immediately
            return JsonResponse({
                "data": {},
                "logs": warning_logs,
                "success": True  # Changed to True so the interface still loads
            }, safe=False, status=200)  # Changed to 200 OK

        # obtaining the session, module_id, input_values
        cookie_id = request.COOKIES.get('column_cover_plate_bolted_session')
        module_api = get_module_api('Column Cover Plate Bolted')
        input_values = request.data
        tempData = {
            'cookie_id': cookie_id,
            'module_id': 'Column Cover Plate Bolted',
            'input_values': input_values
        }
        print('tempData : ', tempData)
        print('type of input_values : ', type(input_values))
        # obtaining the record from the Design model
        designRecord = Design.objects.get(cookie_id=cookie_id)
        serailizer = Design_Serializer(designRecord, data=tempData)

        # checking the validtity of the serializer
        if serailizer.is_valid():
            print('serializer is valid')
            try:  # try saving the serializer
                serailizer.save()
                print('serializer saved')
            except Exception as e:
                print('Error in saving the serializer:', e)
                return Response('Error in saving the serializer', status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        else:
            print('serializer is invalid')
            return Response('Serializer is invalid', status=status.HTTP_400_BAD_REQUEST)

        output = {}
        logs = []
        new_logs = []
        try:
            try:
                output, logs = module_api.generate_output(input_values)
            except Exception as e: 
                print('e : ', e)
                print('Error in generating the output and logs')
            
            for log in logs:
                # removing duplicates
                if log not in new_logs:
                    new_logs.append(log)

        except Exception as e:
            print('Exception raised : ', e)
            return JsonResponse({"data": {}, "logs": new_logs,
                                "success": False}, safe=False, status=400)
        
        print('new_logs : ', new_logs)
        print('type of new_logs : ', type(new_logs))
        finalLogsString = self.combine_logs(new_logs)

        try: 
            # save the logs, output, design_status in the Design table for that specific cookie_id
            designObject = Design.objects.get(cookie_id=cookie_id)
            designObject.logs = finalLogsString
            designObject.output_values = output
            print('output outside the condition  : ', output)
            output_result = self.check_non_zero_output(output)
            print('output_result : ', output_result)

            if output == "" or output == 0 or output_result is False:
                print('output is empty string or output_result is False')
                print('output : ', output)
                designObject.design_status = False
            else: 
                print('output is true')
                # if the output is successfully generated, then set the design_status to True 
                designObject.design_status = True

            designObject.save()
        except Exception as e: 
            print('Error in saving the logs in Design table : ', e)
            return JsonResponse({"data": {}, "logs": new_logs,
                               "success": False}, safe=False, status=500)

        return JsonResponse({"data": output, "logs": new_logs, "success": True}, safe=False, status=201)
    
    
    def combine_logs(self, logs): 
        # the logs here is an array of objects 
        # this function extracts the objects to string and combines them into a single string 
        # also converting the type key value to upper case 
        finalLogsString = ""

        for item in logs: 
            print('item : ', item)
            print('item.keys : ', item.keys())
            if 'type' in item:
                item['type'] = item['type'].upper()
                msg = item['msg']
                finalLogsString = finalLogsString + item['type'] + " : " + msg + '\n'
            else:
                msg = item['msg']
                finalLogsString = finalLogsString + msg + '\n'

        print('finalLogsString : ', finalLogsString)
        return finalLogsString 

    def check_non_zero_output(self, output): 
        flag = False
        for item in output: 
            # comparing the float values 
            try:
                if(abs(float(output[item]['value']) - 0.0) > 1e-9): 
                    flag = True
                    break
            except (ValueError, TypeError):
                continue
        
        return flag 