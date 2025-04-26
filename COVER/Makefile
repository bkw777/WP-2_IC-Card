# Generate STL and STEP mesh output files from OpenSCAD source
# Brian K. White - b.kenyon.w@gmail.com

# make
# make style=finger
# make style=none
# make SRAM_128K

model = WP-2_IC-Card_Cover

parts = SRAM MRAM ROM
style = slider

openscad = openscad-nightly
freecadcmd = freecadcmd-daily
#openscad = openscad
#freecadcmd = freecadcmd

.PHONY: all
all: $(parts)

.PHONY: $(parts)
$(parts): %: $(model)_%_$(style).stl KICAD_$(model)_%_$(style).stl $(model)_%_$(style).step

# generate .png for readme
#$(model)_%_$(style).png: $(model).scad
#	$(openscad) -D'part="$(*)"' -D'bank_switch_style="$(style)"' --colorscheme DeepOcean --imgsize 1024,768 --viewall -o out/$(@) $(model).scad

# generate .stl for printing
$(model)_%_$(style).stl: $(model).scad
	$(openscad) -D'part="$(*)"' -D'bank_switch_style="$(style)"' -D'PRINT=true' -o out/$(@) $(model).scad

# generate stl for conversion to step for kicad
KICAD_$(model)_%_$(style).stl: $(model).scad
	$(openscad) -D'part="$(*)"' -D'bank_switch_style="$(style)"' -D'PRINT=false' -o out/$(@) $(model).scad

# generate .step for KiCAD
$(model)_%_$(style).step: stl-to-step.py KICAD_$(model)_%_$(style).stl
	MODEL=out/KICAD_$(model)_$(*)_$(style) $(freecadcmd) stl-to-step.py
	rm -f out/KICAD_$(model)_$(*)_$(style).stl
	mv -f out/KICAD_$(model)_$(*)_$(style).step ../PCB/000_LOCAL.pretty/3d/$(model)_$(*)_$(style).step

#########
# old 128k sram has no bank switch

.PHONY: SRAM_128K
SRAM_128K: $(model)_SRAM_128K.stl $(model)_SRAM_128K.step

$(model)_SRAM_128K.stl: $(model).scad
	$(openscad) -D'part="SRAM_128K"' -D'PRINT=true' -o out/$(@) $(model).scad

KICAD_$(model)_SRAM_128K.stl: $(model).scad
	$(openscad) -D'part="SRAM_128K"' -D'PRINT=false' -o out/$(@) $(model).scad

$(model)_SRAM_128K.step: stl-to-step.py KICAD_$(model)_SRAM_128K.stl
	MODEL=out/KICAD_$(model)_SRAM_128K $(freecadcmd) stl-to-step.py
	rm -f out/KICAD_$(model)_SRAM_128K.stl
	mv -f out/KICAD_$(model)_SRAM_128K.step ../PCB/000_LOCAL.pretty/3d/$(model)_SRAM_128K.step

#
#########

.PHONY: help list
help list:
	@echo "Targets: all $(parts) SRAM_128K help list clean"
	@echo
	@echo "  all = generate .stl for printing and and .step for kicad all parts: ($(parts))"
	@echo "  $(parts) SRAM_128K = generate .stl and .step, for the specified part"
	@echo "  optionally add style=slider, =finger, =none for models with bank switch"
	@echo "  help or list: display this text"
	@echo "  clean: delete *.stl *.step"
	@echo
	@echo "$ make style=finger"
	@echo "$ make ROM style=none"
	@echo "$ make SRAM_128K"


.PHONY: clean
clean:
	rm -rf out/*.stl out/*.step out/*.png __pycache__
