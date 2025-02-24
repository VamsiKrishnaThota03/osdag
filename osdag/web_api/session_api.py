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
from osdag_api import developed_modules
import typing
from django.http import JsonResponse

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

# importing serializers 
from osdag.serializers import Design_Serializer

# Author: Aaranyak Ghosh


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
            return JsonResponse("Error: Please specify module id", status=400) # Returns error response.
        if request.COOKIES.get("end_plate_connection_session") is not None: # Error Checking: Already editing design.
            print('end_plate_connection is there')
            return JsonResponse({"status" : "set"}, status=200) # Returns error response. 
        elif request.COOKIES.get("fin_plate_connection_session") is not None:
               print('fin_plate_connection is there')
               return JsonResponse({"status" : "set"}, status=200) # Returns error response. 
        elif request.COOKIES.get("cleat_angle_connection_session") is not None:
               print('cleat_angle_connection_session is there')
               return JsonResponse({"status" : "set"}, status=200) # Returns error response. 
        elif request.COOKIES.get("seated_angle_connection") is not None:
            print("seated angle connection is there ")
            return JsonResponse({"status" : "set"}, status=200)
        if module_id not in developed_modules: # Error Checking: Does module api exist
            print('module_id not developed')
            return JsonResponse("Error: This module has not been developed yet", status=501) # Return error response.

        # Define cookie keys for each module
        cookie_keys = {
            "Fin Plate Connection": "fin_plate_connection_session",
            "End Plate Connection": "end_plate_connection_session",
            "Cleat Angle Connection": "cleat_angle_connection_session",
            "Seated Angle Connection": "seated_angle_connection"
        }

        # Check for existing sessions
        for session_key in cookie_keys.values():
            if request.COOKIES.get(session_key):
                return Response({"status": "set"}, status=status.HTTP_200_OK)


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
            
            cookie_key = cookie_keys.get(module_id)
            if cookie_key:
                response.set_cookie(key=cookie_key, value=cookie_id, samesite='None', secure=True)
                print(f"Cookie Set: {cookie_key}")
            else:
                print(f"Warning: Unknown module_id: {module_id}")
                return Response({"error": "Invalid module_id"}, status=status.HTTP_400_BAD_REQUEST)
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
        if(module_id=='End Plate Connection'):
           cookie_id = request.COOKIES.get("end_plate_connection_session") 
        elif(module_id=='Fin Plate Connection'):# Get design session id.
            cookie_id = request.COOKIES.get("fin_plate_connection_session") 
        elif(module_id=='Cleat Angle Connection'):# Get design session id.
            cookie_id = request.COOKIES.get("cleat_angle_connection_session")
        elif(module_id=='Seated Angle Connection'):
            cookie_id=request.COOKIES.get("seated_angle_connection") 
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

        return response