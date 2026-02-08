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

FUFILE=Fib.fu
CBASENAME=$(shell basename $(FUFILE) .fu)
LBASENAME=$(shell basename $(FUFILE) .fu | tr [:upper:] [:lower:])
# Check the operating system
ifeq ($(OS),Windows_NT)
    # Windows
    LIB_EXT = dll
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        # Linux
        LIB_EXT = so
    else ifeq ($(UNAME_S),Darwin)
        # macOS
        LIB_EXT = dylib
    else
        $(error Unsupported OS)
    endif
endif
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

c-run:  ## create and run code translated to C
	fut -o c/$(LBASENAME).c $(FUFILE)
	gcc c/$(LBASENAME).c -o bin/$(LBASENAME)-c
	./bin/$(LBASENAME)-c

cpp-run: ## create and run code translated to C++
	fut -o cpp/$(LBASENAME).cpp $(FUFILE)
	g++ -std=c++20 cpp/$(LBASENAME).cpp -o bin/$(LBASENAME)-cpp
	./bin/$(LBASENAME)-cpp

cs-run: ## create and run code translated to C-Sharp
	fut -o cs/$(LBASENAME).cs $(FUFILE)
	mcs cs/$(LBASENAME).cs -out:bin/$(LBASENAME)-cs
	mono bin/$(LBASENAME)-cs 	 
	 	 
d-run:  ## create and run code translated to D-lang
	fut -o d/$(LBASENAME).d $(FUFILE)
	echo "module $(LBASENAME);" > temp
	cat d/$(LBASENAME).d >> temp
	mv temp d/$(LBASENAME).d
	dmd -of=bin/$(LBASENAME)-d d/$(LBASENAME).d
	./bin/$(LBASENAME)-d

java-run: ## create and run code translated to Java
	fut -o java/$(CBASENAME).java $(FUFILE)
	javac java/$(CBASENAME).java
	java -cp java $(CBASENAME)

js-run:  ## create and run code translated to JavaScript
	fut -o js/$(LBASENAME).js $(FUFILE)
	node js/$(LBASENAME).js

ts-run: ## create and run code translated to Typescript and the Javascript
	## process error fixed with: `npm i --save-dev @types/node`
	fut -o ts/$(LBASENAME).ts $(FUFILE)
	tsc ts/$(LBASENAME).ts
	node ts/$(LBASENAME).js

tcl-swig-run:  ## create and run code translated to C and then wrapped using Swift as a Tcl library
	fut -o tcl-swig/$(LBASENAME).c $(FUFILE)
	cd tcl-swig && swig -tcl8 -module $(LBASENAME) $(LBASENAME).i                ## create the interface
	cd tcl-swig && gcc -fPIC -c $(LBASENAME).c                            ## compile the FU generated code
	cd tcl-swig && gcc -fPIC -c $(LBASENAME)_wrap.c -I/usr/include/tcl8.6 ## compile the SWIG generated code
	cd tcl-swig && gcc -shared $(LBASENAME).o $(LBASENAME)_wrap.o -o $(LBASENAME).$(LIB_EXT)    ## combine both to a Tcl library
	cd tcl-swig && tclsh run-fib.tcl    ## execute the code

lua-swig-run:
	fut -o lua-swig/$(LBASENAME).c $(FUFILE)
	cd lua-swig && swig -lua -module $(LBASENAME) -o $(LBASENAME)_wrap.c $(LBASENAME).i
	cd lua-swig && gcc -fPIC -I/usr/include/lua5.1 -c  $(LBASENAME)_wrap.c -o $(LBASENAME)_wrap.o
	cd lua-swig && gcc -fPIC -I/usr/include/lua5.1 -c  $(LBASENAME).c -o $(LBASENAME).o
	cd lua-swig && gcc -shared -I/usr/include/lua5.1 -L/usr/lib/x86_64-linux-gnu/  $(LBASENAME)_wrap.o $(LBASENAME).o -o $(LBASENAME).$(LIB_EXT)
	cd lua-swig && nm $(LBASENAME).$(LIB_EXT) | grep Fib
	cd lua-swig && lua run-$(LBASENAME).lua

lua-tstl-run:
	fut -o lua-tstl/$(LBASENAME).ts $(FUFILE)
	cd lua-tstl && npx tstl $(LBASENAME).ts
	cd lua-tstl && lua run-$(LBASENAME).lua

octave-run:
	## sudo apt install octave-dev
	fut -o octave/$(LBASENAME).c $(FUFILE)
	cd octave && swig -octave -module $(LBASENAME) -o $(LBASENAME)_wrap.cpp $(LBASENAME).i
	cd octave && mkoctfile $(LBASENAME)_wrap.cpp $(LBASENAME).c -o $(LBASENAME)
	cd octave && octave run-$(LBASENAME).m
