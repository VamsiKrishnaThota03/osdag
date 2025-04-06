'''
Created on 14-Mar-2016

@author: deepa
'''
# Try importing OCC using different approaches
try:
    from OCC.Core.gp import gp_Circ, gp_Ax2, gp_Pnt, gp_Dir, gp_XYZ
    from OCC.Core.Geom import Geom_Circle
    from OCC.Core.GC import GC_MakeArcOfCircle
    from OCC.Core.BRepBuilderAPI import BRepBuilderAPI_MakeEdge, BRepBuilderAPI_MakeWire, BRepBuilderAPI_MakeFace
except ImportError:
    try:
        from OCC.gp import gp_Circ, gp_Ax2, gp_Pnt, gp_Dir, gp_XYZ
        from OCC.Geom import Geom_Circle
        from OCC.GC import GC_MakeArcOfCircle
        from OCC.BRepBuilderAPI import BRepBuilderAPI_MakeEdge, BRepBuilderAPI_MakeWire, BRepBuilderAPI_MakeFace
    except ImportError:
        print("Warning: OCC modules not found. CAD functionality will be limited.")
        # Create dummy classes for basic functionality
        class gp_Circ:
            def __init__(self, *args):
                pass
                
        class gp_Ax2:
            def __init__(self, *args):
                pass
                
        class gp_Pnt:
            def __init__(self, *args):
                pass
                
        class gp_Dir:
            def __init__(self, *args):
                pass
                
        class gp_XYZ:
            def __init__(self, *args):
                pass
                
        class Geom_Circle:
            def __init__(self, *args):
                pass
                
        class GC_MakeArcOfCircle:
            def __init__(self, *args):
                pass
            def Value(self):
                return None
                
        class BRepBuilderAPI_MakeEdge:
            def __init__(self, *args):
                pass
            def Edge(self):
                return None
                
        class BRepBuilderAPI_MakeWire:
            def __init__(self, *args):
                pass
            def Add(self, *args):
                pass
            def Wire(self):
                return None
                
        class BRepBuilderAPI_MakeFace:
            def __init__(self, *args):
                pass
            def Face(self):
                return None

import numpy
from cad.items.ModelUtils import make_edge, getGpPt, getGpDir, makeWireFromEdges, makeFaceFromWire, makePrismFromFace

'''

                                     X-------------------------X
                                  X                         X  |
                               X                         X     |
                            X                         X        |
              ^      a6  X-------------------------X  a1       |
              |          |                         |           |
              |          |                         |           |
              |          |                         |           |
              |          |              a3         |           |
            height   a7  X            +            |  a2       |
              |          XX         X              |           |
              |           XX      X   R1           |           X
              |            XX   X                  |        X
              |              XX                    |     X
              |                 XX                 |  X
              v          X          XX-------------X  
                       a9           a5              a4

                        <---------- width -------->
'''


class Notch(object):
    '''
    '''

    def __init__(self, R1, height, width, length):
        """
        Initialize a Notch

        :param R1: radius
        :param height: height of Notch
        :param width: width of Notch
        :param length: length of Notch
        """
        self.R1 = R1
        self.height = height
        self.width = width
        self.length = length
        self.sec_origin = None
        self.uDir = None
        self.wDir = None
        self.vDir = None
        self.compute_params()

    def place(self, secOrigin, uDir, wDir):
        """
        Place Notch in 3d space

        :param secOrigin: origin of Notch
        :param uDir: u direction of Notch
        :param wDir: w direction of Notch
        :return: None
        """
        self.sec_origin = secOrigin
        self.uDir = uDir
        self.wDir = wDir
        self.compute_params()

    def compute_params(self):
        """
        Compute parameters of Notch

        :return: None
        """
        self.vDir = self.uDir *  self.wDir
        self.vDir.Normalize()

    def createEdges(self):

        edges = []
        # Join points a,b
        edge = make_edge(getGpPt(self.a), getGpPt(self.b))
        edges.append(edge)
        # # Join points b1 and b2
        # cirl = gp_Circ(gp_Ax2(getGpPt(self.o1), getGpDir(self.wDir)), self.R1)
        # edge = make_edge(cirl,getGpPt(self.b2), getGpPt(self.b1))
        # edges.append(edge)
        # Join points b and c2
        edge = make_edge(getGpPt(self.b), getGpPt(self.c2))
        edges.append(edge)
        # join points c2 and c1
        cirl2 = gp_Circ(gp_Ax2(getGpPt(self.o2), getGpDir(self.wDir)), self.R1)
        edge = make_edge(cirl2, getGpPt(self.c1), getGpPt(self.c2))
        edges.append(edge)
        # Join points c1 and d
        edge = make_edge(getGpPt(self.c1), getGpPt(self.d))
        edges.append(edge)
        # Join points d and a
        edge = make_edge(getGpPt(self.d), getGpPt(self.a))
        edges.append(edge)

        return edges

    def create_model(self):
        """
        Create a solid model

        :return: solid model
        """
        # (0,0) at center of the section
        # construct rectangle
        edge_1 = BRepBuilderAPI_MakeEdge(gp_Pnt(0.0, self.height, 0.0), gp_Pnt(self.width, self.height, 0.0)).Edge()
        edge_2 = BRepBuilderAPI_MakeEdge(gp_Pnt(self.width, self.height, 0.0), gp_Pnt(self.width, 0.0, 0.0)).Edge()
        edge_3 = BRepBuilderAPI_MakeEdge(gp_Pnt(self.width, 0.0, 0.0), gp_Pnt(0.0, 0.0, 0.0)).Edge()
        edge_4 = BRepBuilderAPI_MakeEdge(gp_Pnt(0.0, 0.0, 0.0), gp_Pnt(0.0, self.height, 0.0)).Edge()

        # Add round edges
        radius = self.R1
        center = gp_Pnt(self.width - self.R1, self.height - self.R1, 0.0)
        dir_x = gp_Dir(0, 0, 1)
        ax = gp_Ax2(center, dir_x)
        Circle = gp_Circ(ax, radius)
        geomCircle = Geom_Circle(Circle)

        startPnt = gp_Pnt(self.width, self.height - self.R1, 0.0)
        endPnt = gp_Pnt(self.width - self.R1, self.height, 0.0)
        centerPnt = center

        arcofcircle1 = GC_MakeArcOfCircle(geomCircle, startPnt, endPnt, True)
        arcedge1 = BRepBuilderAPI_MakeEdge(arcofcircle1.Value()).Edge()

        #constructing a wire
        wire = BRepBuilderAPI_MakeWire()
        wire.Add(edge_3)
        wire.Add(edge_2)
        wire.Add(arcedge1)
        wire.Add(edge_1)
        wire.Add(edge_4)

        # extrude the wire
        aFace = BRepBuilderAPI_MakeFace(wire.Wire()).Face()
        extrude_dir = self.length *  gp_XYZ(0, 0, 1)
        prism = aFace.Extrude(extrude_dir)

        return prism


if __name__ == '__main__':

    from OCC.Display.SimpleGui import init_display
    display, start_display, add_menu, add_function_to_menu = init_display()

    R1 = 5
    hight = 10
    width = 10
    length = 5

    origin = numpy.array([0.,0.,0.])
    uDir = numpy.array([1.,0.,0.])
    shaftDir = numpy.array([0.,0.,1.])

    notch = Notch(R1, hight, width, length)
    _place = notch.place(origin, uDir, shaftDir)
    point = notch.compute_params()
    prism = notch.create_model()
    display.DisplayShape(prism, update=True)
    display.DisableAntiAliasing()
    start_display()