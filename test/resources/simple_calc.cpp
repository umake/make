/* Default libraries */
#include <iostream>

/* Libraries */
#include "mathlib.hpp"

int calculate(char op, int lhs, int rhs);

int main(int argc, char **argv)
{
    int lhs, rhs; char op;
    
    while (std::cin >> lhs >> op>> rhs)
        std::cout << calculate(op, lhs, rhs) << std::endl;
    
    return 0;
}

int calculate(char op, int lhs, int rhs)
{
    Math calculator {};
    switch (op)
    {
        case '+': return calculator.add(lhs, rhs);
        case '-': return calculator.sub(lhs, rhs);
        case '*': return calculator.mul(lhs, rhs);
        case '/': return calculator.div(lhs, rhs);
        case '%': return calculator.mod(lhs, rhs);
    }
    return 0;
}
