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

## default: list existing tasks 
.PHONY: tasks
tasks:  ## list all tasks
	@grep -Eo '^[a-z0-9]+:.+' $(CURRENT_MAKEFILE) | sed -E 's/:\s+##/\t- /g'

tutorial: ## compile the tutorial
	[ -f Main.fu ] && fut Main.fu -o out/main.d && dmd out/main.d -of:out/main-d
	tmdoc tutorial.Rmd - --toc true | mndoc - tutorial.html --css tmdoc.css

