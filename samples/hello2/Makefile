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
FUFILE=Hello2.fu
CBASENAME=$(shell basename $(FUFILE) .fu)
LBASENAME=$(shell basename $(FUFILE) .fu | tr [:upper:] [:lower:])


## default: list existing tasks 
.PHONY: tasks
tasks:  ## list all tasks
	@grep -Eo '^[-a-z0-9]+:.+' $(CURRENT_MAKEFILE) | sed -E 's/:\s+##/\t- /g'
	echo $(LBASENAME)

folders: ## create the output folders
	for folder in bin py c cs cpp d java js py swift ts; do if [ ! -d $$folder ]; then mkdir $$folder ; fi ; done

py-run: ## create and run code translated to python 
	fut -o py/$(LBASENAME).py $(FUFILE)
	python3 py/$(LBASENAME).py 
	python3 py/$(LBASENAME).py "Max Musterman"

c-run:  ## create and run code translated to C
	fut -o c/$(LBASENAME).c $(FUFILE)
	gcc c/$(LBASENAME).c -o bin/$(LBASENAME)-c
	./bin/$(LBASENAME)-c
	./bin/$(LBASENAME)-c "Max Musterman"

cpp-run: ## create and run code translated to C++
	fut -o cpp/$(LBASENAME).cpp $(FUFILE)
	g++ -std=c++20 cpp/$(LBASENAME).cpp -o bin/$(LBASENAME)-cpp
	./bin/$(LBASENAME)-cpp
	./bin/$(LBASENAME)-cpp "Max Musterman"

cs-run: ## create and run code translated to C-Sharp
	fut -o cs/$(LBASENAME).cs $(FUFILE)
	mcs cs/$(LBASENAME).cs -out:bin/$(LBASENAME)-cs
	mono bin/$(LBASENAME)-cs 	 
	mono bin/$(LBASENAME)-cs "Max Musterman"
	 	 
d-run:  ## create and run code translated to D-lang
	fut -o d/$(LBASENAME).d $(FUFILE)
	echo "module $(LBASENAME);" > temp
	cat d/$(LBASENAME).d >> temp
	mv temp d/$(LBASENAME).d
	dmd -of=bin/$(LBASENAME)-d d/$(LBASENAME).d
	./bin/$(LBASENAME)-d
	./bin/$(LBASENAME)-d "Max Musterman"	

java-run: ## create and run code translated to Java
	fut -o java/$(CBASENAME).java $(FUFILE)
	javac java/$(CBASENAME).java
	java -cp java $(CBASENAME)
	java -cp java $(CBASENAME) "Max Musterman"

js-run:  ## create and run code translated to JavaScript
	fut -o js/$(LBASENAME).js $(FUFILE)
	node js/$(LBASENAME).js
	node js/$(LBASENAME).js	 "Max Musterman"

ts-run: ## create and run code translated to Typescript and the Javascript
	## process error fixed with: `npm i --save-dev @types/node`
	fut -o ts/$(LBASENAME).ts $(FUFILE)
	tsc ts/$(LBASENAME).ts
	node ts/$(LBASENAME).js
	node ts/$(LBASENAME).js "Max Musterman"	

swift-run: ## create and run code translated to Swift
	## Download tar.gz: https://www.swift.org/install/linux/debian/12/
	## add /usr/bin folder therein to the PATH
	## swift package init --type executable
	## replace files in Source/swift where sources/swift/swift.swift is the main file
	if [ ! -d "swift/Sources/swift" ]; then mkdir -p swift/Sources/swift ; fi
	fut -o swift/Sources/swift/swift.swift $(FUFILE)
	cd swift && swift build
	cd swift && swift run
	./swift/.build/x86_64-unknown-linux-gnu/debug/swift
	./swift/.build/x86_64-unknown-linux-gnu/debug/swift "Max Musterman"

tcl-run:  ## create and run code translated to C and then wrapped using Swift as a Tcl library
	fut -o tcl/$(LBASENAME).c $(FUFILE)
	cd tcl && swig -tcl8 -module $(LBASENAME) $(LBASENAME).i                ## create the interface
	cd tcl && gcc -fPIC -c $(LBASENAME).c                            ## compile the FU generated code
	cd tcl && gcc -fPIC -c $(LBASENAME)_wrap.c -I/usr/include/tcl8.6 ## compile the SWIG generated code
	cd tcl && gcc -shared $(LBASENAME).o $(LBASENAME)_wrap.o -o $(LBASENAME).so    ## combine both to a Tcl library
	cd tcl && echo "load ./$(LBASENAME).so Hello2; puts [Hello2_GetHello World];" | tclsh     ## execute the code
	cd tcl && echo "load ./$(LBASENAME).so Hello2; puts [Hello2_GetHello {Max Musterman}];" | tclsh     ## execute the code

