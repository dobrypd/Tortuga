LIBS=$(WITHGRAPHICS)

SRC=src/

SOURCES = \
$(SRC)logic/iterativeFunction.ml \
$(SRC)logic/translations.ml \
$(SRC)interface/iooperations.ml \
$(SRC)interface/interface.ml \
$(SRC)tortuga.ml

EXEC = Tortuga

CUSTOM = -custom

########################## Include the template here #####################
include Makefile.ocaml
##########################  Continue  customization  #####################

CAMLC = ocamlc -g -I $(SRC) -I $(SRC)interface/ -I $(SRC)logic/
