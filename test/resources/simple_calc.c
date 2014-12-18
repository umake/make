/* Default libraries */
#include <stdio.h>

/* Libraries */
#include "mathlib.h"

int calculate(char op, int lhs, int rhs);

int main(int argc, char **argv)
{
    int lhs, rhs; char op;
    
    while (1)
    {
        if(scanf("%d %c %d", &lhs, &op, &rhs) == EOF) break;
        printf("%d\n", calculate(op, lhs, rhs));
    }
    
    return 0;
}

int calculate(char op, int lhs, int rhs)
{
    switch (op)
    {
        case '+': return add(lhs, rhs);
        case '-': return sub(lhs, rhs);
        case '*': return mul(lhs, rhs);
        case '/': return div(lhs, rhs);
        case '%': return mod(lhs, rhs);
    }
    return 0;
}
