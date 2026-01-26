#flag -I. -L. -lhello
#include "hello.h" 

fn C.Hello_GetMessage() &char

fn main() {
    s := unsafe { cstring_to_vstring(&char(C.Hello_GetMessage())) }
    println(s)
}
