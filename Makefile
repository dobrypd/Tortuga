LIBS=$(WITHGRAPHICS)

SOURCES = src/interface/interface.ml src/tortuga.ml

EXEC = Tortuga

CUSTOM=-custom

########################## Include the template here #####################
include Makefile.ocaml
##########################  Continue  customization  #####################

CAMLC = ocamlc -g -I src/ -I src/interface/
