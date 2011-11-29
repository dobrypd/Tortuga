SRC=src/
BIN=bin/

tortuga: $(SRC)tortuga.ml
	ocamlopt -I $(SRC) $(SRC)tortuga.ml -o $(BIN)tortuga

tests:
	ocamlbuild -I src/ -tag pkg_oUnit tests.byte
	@cp `readlink tests.byte` bin/tests.byte
	@rm tests.byte
	bin/tests.byte
	@echo

clean:
	-rm -rf _build/ bin/*

.PHONY: tortuga tests clean
