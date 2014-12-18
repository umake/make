#!/bin/bash

# Tests if 'make' builds the library
test \
  "make init" \
  "cp ../resources/static_lib.c.mk Config.mk" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.c ." \
  "cp ../resources/mathlib.c ." \
  "cp ../resources/mathlib.h ." \
  "make standard" \
  "make" \
  "./bin/calculator < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
