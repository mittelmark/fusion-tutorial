%{
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#include "hello.h"
%}
const char *Hello_GetMessage(void);
