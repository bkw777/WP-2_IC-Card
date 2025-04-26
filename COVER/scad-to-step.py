# -*- coding: utf-8 -*-
# scad-to-step.py
# FreeCAD macro to import *.scad and export *.step
# Brian K. White - b.kenyon.w@gmail.com
# Requires:
# * foo.scad file, where "foo" is passed via environment variable MODEL=foo
# * freecad with openscad workbench installed and configured:
#    * path to openscad binary
#    * use view provider in tree view
#    * use multimatrix feature

import Part
import importCSG
import os

MODEL = os.environ['MODEL']

d = importCSG.open(MODEL+'.scad')

s = Part.getShape(d.TopologicalSortedObjects[0])

n = s.removeSplitter()

n.exportStep(MODEL+'.step')
