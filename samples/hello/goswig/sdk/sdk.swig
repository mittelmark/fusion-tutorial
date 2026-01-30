%module sdk
%fragment("Swig_escape_always_false", "header") {}
%{
#include "hello.h"
%}
%include "typemaps.i"
%include "hello.h"
