# -*- coding: utf-8 -*-
# stl-to-step.py
# FreeCAD macro to import *.stl and export *.step
# Brian K. White - b.kenyon.w@gmail.com
# Requires:
# * foo.stl file, where "foo" is passed via environment variable MODEL=foo
# * freecad

import Mesh
import Part
import os

MODEL = os.environ['MODEL']

m = Mesh.Mesh(MODEL+'.stl')

s = Part.Shape()
s.makeShapeFromMesh(m.Topology,0.01)

n = s.removeSplitter()

n.exportStep(MODEL+'.step')
