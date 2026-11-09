"""
    This file includes the Create Session and Delete Session API.
    Create Session API (class CreateSession(View)):
        Accepts POST requests.
        Accepts content-type/form-data.
        Request body must include module id.
        Creates a session object in db and returns session id as cookie.
    Delete Session API (class CreateSession(View)):
        Accepts POST requests.
        Requires no POST data.
        Requires design_session cookie.
        Deletes session object in db and deletes session id cookie.
"""
from django.shortcuts import render, redirect
from django.utils.html import escape, urlencode
from django.http import HttpResponse, HttpRequest
from django.views import View
from osdag.models import Design
from django.utils.crypto import get_random_string
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
import typing
from django.http import JsonResponse

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

# importing serializers 
from osdag.serializers import Design_Serializer

# Import common definitions
from osdag_api.common_defs import developed_modules
from osdag_api import CAD_FUNCTIONALITY_AVAILABLE

# Author: Aaranyak Ghosh

# Session cookie name for each module.
SESSION_COOKIE_KEYS = {
    "Fin Plate Connection": "fin_plate_connection_session",
    "End Plate Connection": "end_plate_connection_session",
    "Cleat Angle Connection": "cleat_angle_connection_session",
    "Seated Angle Connection": "seated_angle_connection",
    "Column Cover Plate Bolted": "column_cover_plate_bolted_session",
    "Column Cover Plate Welded": "column_cover_plate_welded_session",
}


class CreateSession(APIView):
    """
        Create a session in database and set session cookie.
            Create Session API (class CreateSession(View)):
                Accepts POST requests..
                Accepts content-type/form-data.
                Request body must include module id.
                Creates a session object in db and returns session id as cookie.
    """

    def post(self,request) :
        print("CreateSession view reached")
        module_id = request.data.get('module_id')
        print('module_id in session : ' , module_id)
        if module_id == None or module_id == '': # Error Checking: If module id provided.
            print('module is None or Empty')
            return JsonResponse("Error: Please specify module id", status=400, safe=False) # Returns error response.
        if module_id not in developed_modules: # Error Checking: Does module api exist
            print('module_id not developed')
            return JsonResponse("Error: This module has not been developed yet", status=501, safe=False) # Return error response.

        cookie_key = SESSION_COOKIE_KEYS.get(module_id)
        if cookie_key is None:
            return Response({"error": "Invalid module_id"}, status=status.HTTP_400_BAD_REQUEST)

        # Reuse this module's existing session if it is still in the database.
        existing = request.COOKIES.get(cookie_key)
        if existing and Design.objects.filter(cookie_id=existing).exists():
            return JsonResponse({"status": "set"}, status=200)

        # Show warning if CAD functionality is not available
        if not CAD_FUNCTIONALITY_AVAILABLE:
            print(f"Warning: CAD functionality is limited. Session for {module_id} will be created but some features may not work.")

        cookie_id = get_random_string(length=32) # creting a session from a random string
        print('cookie id in session : ' ,cookie_id)
        tempData = {
            "cookie_id" : cookie_id,
            "module_id" : module_id,
            "input_values" : {}
        }
        print('tempData : ' , tempData)
        print('type of tempData  : ' , type(tempData))
        serializer = Design_Serializer(data = tempData)
        print('serializers : ' , serializer)
        if serializer.is_valid() : 
            print('serializer is valid')
            serializer.save()

            # create HTTPResponse and set the cookie
            response = JsonResponse({"status" : "set"} , status=201)
            
            response.set_cookie(key=cookie_key, value=cookie_id, samesite='None', secure=True)
            print(f"Cookie Set: {cookie_key}")
            return response
        else : 
            print('serializer is invalid')
            print('serializer.errors : ' , serializer.errors)
            return JsonResponse("Inernal Server Error: " , status=500, safe=False) # Return error response.



class DeleteSession(APIView):
    """
        Delete session cookie and session data in db.
            Delete Session API (class CreateSession(View)):
                Accepts POST requests.
                Requires no POST data.
                Requires design_session cookie.
                Deletes session object in db and deletes session id cookie.
    """
    def post(self,request: HttpRequest) -> HttpResponse:
        module_id = request.data.get('module_id')
        print('module_id in session : ' , module_id)
        cookie_key = SESSION_COOKIE_KEYS.get(module_id)
        cookie_id = request.COOKIES.get(cookie_key) if cookie_key else None
        if cookie_id == None or cookie_id == '': # Error Checking: If design session id provided.
            return HttpResponse("Error: Please open module", status=400) # Returns error response.
        if not Design.objects.filter(cookie_id=cookie_id).exists(): # Error Checking: If design session exists.
            return HttpResponse("Error: This design session does not exist", status=404) # Return error response.
        try: # Try deleting session.
            connection_session = Design.objects.get(cookie_id=cookie_id) # Design session object in db.
            connection_session.delete()
        except Exception as e: # Error Checking: While saving design.
            return HttpResponse("Inernal Server Error: " + repr(e), status=500) # Return error response.
        response = HttpResponse(status=200) # Status code 200 - Successfully deleted .
        response.delete_cookie(cookie_key, samesite='None')

        return response