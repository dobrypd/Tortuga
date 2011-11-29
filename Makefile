main-native:
	ocamlbuild -I src/ tortuga.native
	@cp `readlink tortuga.native` bin/tortuga.native
	@rm main.native

main:
	ocamlbuild -I src/ tortuga.byte
	@cp `readlink tortuga.byte` bin/tortuga.byte
	@rm main.byte

tests-native:
	ocamlbuild -I src/ -tag pkg_oUnit tests.native
	@cp `readlink tests.native` bin/tests.native
	@rm tests.native
	bin/tests.native
	@echo

tests:
	ocamlbuild -I src/ -tag pkg_oUnit tests.byte
	@cp `readlink tests.byte` bin/tests.byte
	@rm tests.byte
	bin/tests.byte
	@echo

clean:
	-rm -rf _build/ bin/*

.PHONY: main-native main tests-native tests clean