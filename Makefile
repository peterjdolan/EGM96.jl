all: test

test: install
	julia -e 'Pkg.test("EGM96")'

install:
	julia -e 'Pkg.rm("EGM96"); Pkg.init(); Pkg.clone(pwd()); Pkg.build("EGM96");'

clean:
	rm -rf deps/usr
	(cd deps/src/f477; make clean)

.PHONY: src test
