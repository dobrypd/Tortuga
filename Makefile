LIBS=$(WITHGRAPHICS)

SRC=src/

SOURCES = \
$(SRC)logic/SomeTranslations.ml \
$(SRC)logic/IterativeFunction.ml \
$(SRC)interface/iooperations.ml \
$(SRC)interface/interface.ml \
$(SRC)tortuga.ml

EXEC = Tortuga

CUSTOM = -custom

########################## Include the template here #####################
include Makefile.ocaml
##########################  Continue  customization  #####################

CAMLC = ocamlc -g -I $(SRC) -I $(SRC)interface/ -I $(SRC)logic/
