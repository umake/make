/******************************************************************************/
/*  Copyright 2015 RCF                                                        */
/*                                                                            */
/*  Licensed under the Apache License, Version 2.0 (the "License"); you may   */
/*  not use this file except in compliance with the License. You may obtain   */
/*  a copy of the License at                                                  */
/*                                                                            */
/*      http://www.apache.org/licenses/LICENSE-2.0                            */
/*                                                                            */
/*  Unless required by applicable law or agreed to in writing, software       */
/*  distributed under the License is distributed on an "AS IS" BASIS,         */
/*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  */
/*  See the License for the specific language governing permissions and       */
/*  limitations under the License.                                            */
/******************************************************************************/

/* Standard headers */
#include <iostream>

/* Internal headers */
#include "mathlib.hpp"

int calculate(char op, int lhs, int rhs);

int main(int argc, char **argv) {
  int lhs, rhs; char op;

  while (std::cin >> lhs >> op>> rhs)
    std::cout << calculate(op, lhs, rhs) << std::endl;

  return 0;
}

int calculate(char op, int lhs, int rhs) {
  Math calculator;
  switch (op) {
    case '+': return calculator.add(lhs, rhs);
    case '-': return calculator.sub(lhs, rhs);
    case '*': return calculator.mul(lhs, rhs);
    case '/': return calculator.div(lhs, rhs);
    case '%': return calculator.mod(lhs, rhs);
  }
  return 0;
}
