##-*- makefile -*-############################################################
#
# Copyright (C) 2026 MicroEmacs User.
#
# All rights reserved.
#
# Synopsis:    
# Authors:     MicroEmacs User
#
##############################################################################

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
	if [[ ! -d "swift/Sources/swift" ]]; then mkdir -p swift/Sources/swift ; fi
	fut -o swift/Sources/swift/$(LBASENAME).swift $(FUFILE)
	cp swift/run-$(LBASENAME).swift swift/Sources/swift/swift.swift	
	cd swift && swift build
	cd swift && swift run
	./swift/.build/x86_64-unknown-linux-gnu/debug/swift

tcl-run:  ## create and run code translated to C and then wrapped using Swift as a Tcl library
	fut -o tcl/$(LBASENAME).c $(FUFILE)
	cd tcl && swig -tcl8 -module hello hello.i                ## create the interface
	cd tcl && gcc -fPIC -c hello.c                            ## compile the FU generated code
	cd tcl && gcc -fPIC -c hello_wrap.c -I/usr/include/tcl8.6 ## compile the SWIG generated code
	cd tcl && gcc -shared hello.o hello_wrap.o -o hello.so    ## combine both to a Tcl library
	cd tcl && echo "load ./hello.so; puts [Hello_GetMessage];" | tclsh     ## execute the code
