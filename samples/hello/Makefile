##-*- makefile -*-############################################################
# Synopsis:    make 
#              make tasks
#              make c-run
#
# Authors:     Detlef Groth, University of Potsdam, Germany
#
###############################################################################

CURRENT_MAKEFILE := $(lastword $(MAKEFILE_LIST))

## argument delegation
ARGS=
FUFILE=Hello.fu
CBASENAME=$(shell basename $(FUFILE) .fu)
LBASENAME=$(shell basename $(FUFILE) .fu | tr [:upper:] [:lower:])


## default: list existing tasks 
.PHONY: tasks
tasks:  ## list all tasks
	@grep -Eo '^[-a-z0-9]+:.+' $(CURRENT_MAKEFILE) | sed -E 's/:\s+##/\t- /g'
	echo $(LBASENAME)
py-run: ## create and run code translated to python 
	fut -o py/$(LBASENAME).py $(FUFILE)
	python3 py/run-$(LBASENAME).py

c-run:  ## create and run code translated to C
	fut -o c/$(LBASENAME).c $(FUFILE)
	gcc c/$(LBASENAME).c c/run-$(LBASENAME).c -o bin/$(LBASENAME)-c
	./bin/$(LBASENAME)-c

cpp-run: ## create and run code translated to C++
	fut -o cpp/$(LBASENAME).cpp $(FUFILE)
	g++ cpp/$(LBASENAME).cpp cpp/run-$(LBASENAME).cpp -o bin/$(LBASENAME)-cpp
	./bin/$(LBASENAME)-cpp

cs-run: ## create and run code translated to C-Sharp
	fut -o cs/$(LBASENAME).cs $(FUFILE)
	mcs cs/$(LBASENAME).cs cs/run-$(LBASENAME).cs -out:bin/$(LBASENAME)-cs
	mono bin/$(LBASENAME)-cs 	 

d-run:  ## create and run code translated to D-lang
	fut -o d/$(LBASENAME).d $(FUFILE)
	echo "module $(LBASENAME);" > temp
	cat d/$(LBASENAME).d >> temp
	mv temp d/$(LBASENAME).d
	dmd -of=bin/$(LBASENAME)-d d/run-$(LBASENAME).d d/$(LBASENAME).d
	./bin/$(LBASENAME)-d

java-run: ## create and run code translated to Java
	fut -o java/$(CBASENAME).java $(FUFILE)
	javac java/Run$(CBASENAME).java java/$(CBASENAME).java
	java -cp java Run$(CBASENAME)

js-run:  ## create and run code translated to JavaScript
	fut -o js/$(LBASENAME).js $(FUFILE)
	node js/run-$(LBASENAME).js

ts-run: ## create and run code translated to Typescript and the Javascript
	fut -o ts/$(LBASENAME).ts $(FUFILE)
	tsc ts/$(LBASENAME).ts
	node ts/run-$(LBASENAME).js

swift-run: ## create and run code translated to Swift
	## Download tar.gz: https://www.swift.org/install/linux/debian/12/
	## add /usr/bin folder therein to the PATH
	## swift package init --type executable
	## replace files in Source/swift where sources/swift/swift.swift is the main file
	## we just need the file Package.swift in the root folder of the project
	if [ ! -d "swift/Sources/swift" ]; then mkdir -p swift/Sources/swift ; fi
	fut -o swift/Sources/swift/$(LBASENAME).swift $(FUFILE)
	cp swift/run-$(LBASENAME).swift swift/Sources/swift/swift.swift	
	cd swift && swift build
	cd swift && swift run
	./swift/.build/x86_64-unknown-linux-gnu/debug/swift

tcl-run:  ## create and run code translated to C and then wrapped with Swig as a Tcl library
	fut -o tcl/$(LBASENAME).c $(FUFILE)
	cd tcl && swig -tcl8 -module $(LBASENAME) $(LBASENAME).i                ## create the interface
	cd tcl && gcc -fPIC -c $(LBASENAME).c                            ## compile the FU generated code
	cd tcl && gcc -fPIC -c $(LBASENAME)_wrap.c -I/usr/include/tcl8.6 ## compile the SWIG generated code
	cd tcl && gcc -shared $(LBASENAME).o $(LBASENAME)_wrap.o -o $(LBASENAME).so    ## combine both to a Tcl library
	cd tcl && echo "load ./$(LBASENAME).so; puts [Hello_GetMessage];" | tclsh     ## execute the code

r-run:
	fut -o R/$(LBASENAME).c $(FUFILE)
	cd R && swig -r -module $(LBASENAME) $(LBASENAME).i
	cd R && R CMD SHLIB hello_wrap.c hello.c -o hello.so
	cd R && Rscript run-hello.R
v-run:
	## example: https://github.com/vlang/v/blob/master/examples/c_interop_wkhtmltopdf.v
	fut -o v/$(LBASENAME).c $(FUFILE)
	cd v && gcc -shared hello.c -o libhello.so
	cd v && LD_LIBRARY_PATH=. v run hello.v
	cd v && LD_LIBRARY_PATH=. v .
	./v/v
	
lua-run:
	fut -o lua/$(LBASENAME).ts $(FUFILE)
	cd lua && npx tstl $(LBASENAME).ts
	cd lua && lua run-$(LBASENAME).lua
lua-swig: ## library creation using swig
	fut -o lua-run-swig/$(LBASENAME).c $(FUFILE)
	cd lua-run-swig && swig -lua -module $(LBASENAME) -o $(LBASENAME)_wrap.c $(LBASENAME).i
	cd lua-run-swig && gcc -fPIC -I/usr/include/lua5.1 -c  $(LBASENAME)_wrap.c -o $(LBASENAME)_wrap.o
	cd lua-run-swig && gcc -fPIC -I/usr/include/lua5.1 -c  $(LBASENAME).c -o $(LBASENAME).o
	cd lua-run-swig && gcc -shared -I/usr/include/lua5.1 -L/usr/lib/x86_64-linux-gnu/  $(LBASENAME)_wrap.o $(LBASENAME).o -o $(LBASENAME).so
	cd lua-run-swig && nm $(LBASENAME).so | grep GetMessage
	cd lua-run-swig && lua run-$(LBASENAME).lua
octave-run:
	## sudo apt install octave-dev
	fut -o octave/$(LBASENAME).c $(FUFILE)
	cd octave && swig -octave -module $(LBASENAME) -o $(LBASENAME)_wrap.cpp $(LBASENAME).i
	cd octave && mkoctfile $(LBASENAME)_wrap.cpp $(LBASENAME).c -o $(LBASENAME)
	cd octave && octave run-hello.m

go-cgo-run:
	fut -o go/$(LBASENAME).c $(FUFILE)
	cd go && go run run-$(LBASENAME).go $(LBASENAME)

go-swig-run:
	fut -o goswig/sdk/$(LBASENAME).c $(FUFILE)
	cd goswig && make build
	cd goswig && make run
