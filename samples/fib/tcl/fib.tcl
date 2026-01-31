#!/usr/bin/env tclsh
##############################################################################
#
# Copyright (C) 2026 MicroEmacs User.
#
# All rights reserved.
#
# Synopsis:    
# Authors:     MicroEmacs User
#
##############################################################################

load ./fib.so Fib; 
foreach x [list 1 2 3 4 5] { 
    puts "fin of $x is: [Fib_fib $x]"
}

