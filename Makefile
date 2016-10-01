all: test

test:
	julia -e 'Pkg.rm("EGM96"); Pkg.init(); Pkg.clone(pwd()); Pkg.build("EGM96"); Pkg.test("EGM96")'

clean:
	rm -rf deps/usr
	(cd deps/src/f477; make clean)

.PHONY: src test
