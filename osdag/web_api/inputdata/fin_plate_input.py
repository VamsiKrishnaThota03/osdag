from .input_data_base import InputDataBase
from rest_framework import status
from rest_framework.response import Response
from osdag.models import Columns, Beams, Bolt, Bolt_fy_fu, Material, CustomMaterials

class FinPlateInputData(InputDataBase):
    def process(self, **kwargs):
        connectivity, boltDiameter = kwargs["connectivity"], kwargs["boltDiameter"]
        propertyClass, thickness, email  = kwargs["propertyClass"], kwargs["thickness"], kwargs["email"]
        
        if (connectivity is None and boltDiameter is None and propertyClass is None and thickness is None):
            # fetch the list of all the connectivity options for Fin-Plate-Connection
            print("\n\n")
            print('inside connectivtityList handling ')
            print("\n\n")
            connectivityList = ['Column Flange-Beam-Web' , 'Column Web-Beam-Web', 'Beam-Beam']
            response = {
                'connectivityList': connectivityList
            }
            return Response(response, status=status.HTTP_200_OK)
        if(connectivity == 'Column-Flange-Beam-Web' or connectivity == 'Column-Web-Beam-Web'):
            # print('connectivity : ', connectivity)

            try:
                # fetch all records from Column table
                # fetch all records from Beam table
                # fetch all records from Material table

                columnList = list(Columns.objects.values_list(
                    'Designation', flat=True))
                beamList = list(Beams.objects.values_list(
                    'Designation', flat=True))
                
                materialList = list(Material.objects.filter().values())
                if email: 
                    custom_material = list(CustomMaterials.objects.filter(email=email).values())
                materialList = materialList + custom_material

                materialList.append({"id": -1, "Grade": 'Custom'})
                response = {
                    'columnList': columnList,
                    'beamList': beamList,
                    'materialList': materialList 
                }

                return Response(response, status=status.HTTP_200_OK)

            except Exception as err:
                print(err)
                return Response({"error": "Bad request"}, status=status.HTTP_400_BAD_REQUEST)

        elif (connectivity == 'Beam-Beam'):
            # print('connectivity : ', connectivity)

            # fetch all records from Beams table
            # fetch all recorsd from the Material Table
            try:
                beamList = list(Beams.objects.values_list(
                    'Designation', flat=True))
                materialList = list(Material.objects.all().values())
                materialList.append({"id": -1, "Grade": 'Custom'})
                response = {
                    'beamList': beamList,
                    'materialList': materialList
                }

                return Response(response, status=200)

            except:
                return Response({"error": "Bad request"}, status=status.HTTP_400_BAD_REQUEST)

        elif (boltDiameter == 'Customized'):
            # print('boltDiameter : ', boltDiameter)

            # fetch the data from Bolt table
            try:
                # print('fetching')
                boltList = list(Bolt.objects.values_list(
                    'Bolt_diameter', flat=True))
                boltList.sort()
                print('boltList : ' , boltList)
                response = {
                    'boltList': boltList
                }

                return Response(response, status=status.HTTP_200_OK)

            except:
                return Response({"error": "Something went wrong"}, status=status.HTTP_400_BAD_REQUEST)

        elif (propertyClass == 'Customized'):
            print('propertyClass : ', propertyClass)

            # fetch the data from Bolt_fy_fu table
            try:
                #boltFyFuList = list(Bolt_fy_fu.objects.values_list(
                #    'Property_Class', flat=True))
                boltFyFuList = ['3.6', '4.6', '4.8', '5.6', '5.8', '6.8', '8.8', '9.8', '10.9', '12.9']
                # boltFyFuList.sort()

                response = {
                    'propertyClassList': boltFyFuList
                }
                print('propertyFyFuList : ', boltFyFuList)

                return Response(response, status=status.HTTP_200_OK)

            except:
                return Response({"error": "Something went wrong"}, status=status.HTTP_400_BAD_REQUEST)

        elif (thickness == 'Customized'):
            # print('thickness : ', thickness)

            try:
                # standard as per SAIL's product brochure
                PLATE_THICKNESS_SAIL = ['8', '10', '12', '14', '16', '18', '20', '22', '25', '28', '32', '36', '40', '45', '50', '56', '63', '75', '80', '90', '100',
                                        '110', '120']

                response = {
                    'thicknessList': PLATE_THICKNESS_SAIL
                }

                return Response(response, status=status.HTTP_200_OK)

            except:
                return Response({'error': 'Something went wrong'}, status=status.HTTP_400_BAD_REQUEST)
        return super().process(kwargs)