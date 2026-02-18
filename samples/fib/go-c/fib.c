// Generated automatically with "fut". Do not edit.
#include <stdio.h>
#include <stdlib.h>
#include "fib.h"

int Fib_fib(int n)
{
	return n < 2 ? n : Fib_fib(n - 1) + Fib_fib(n - 2);
}
/*
int main(void)
{
	for (int i = 0; i < 5; i++) {
		int f = Fib_fib(i);
		printf("Fib %d is: %d\n", i, f);
	}
}
*/
