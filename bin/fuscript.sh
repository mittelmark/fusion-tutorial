#!/bin/bash
########################################################
##
## Copyright (C) 2026 Detlef Groth
##
## Synopsis:    fuscript <FU-File> [ARGS ...]
## Authors:     Detlef Groth, University of Potsdam, Germany
##
########################################################

if [ -z $1 ]; then
    echo "Usage: $0 FU-FILE [ARGUMENTS ...]"
else
    BN=`basename $1 .fu`
    v=`fut $1 -o ${BN}.py 2>&1`
    e=`echo $v | grep ERROR`
    if [[ "$e" == "" ]]; then 
        shift
        python3 ${BN}.py "$@"
    else
        echo "An transpile error occured!"
        echo "$v"
    fi
fi
