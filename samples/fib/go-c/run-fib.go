package main
// #include "fib.c"
import "C"

import (
	"fmt"
)

func main() {
    //argv := os.Args
    for i := 0; i < 11; i++   {
	f := int(C.Fib_fib(C.int(i)))
	fmt.Printf("Fib %v = %v\n", i, f)
    }
    fmt.Println("Fibonacchi code program completed by Go!")
}

