#!/usr/bin/env bash

# Tests
test "the compilation of multiple files" \
  "$MAKE init" \
  "cp ../assets/simple_calc.dat ." \
  "cp ../assets/simple_calc.c ." \
  "cp ../assets/mathlib.c ." \
  "cp ../assets/mathlib.h ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
