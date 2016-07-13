#!/usr/bin/env bash

test "the compilation of multiple files" \
  "$MAKE init" \
  "cp ../assets/simple_calc.dat ." \
  "cp ../assets/simple_calc.cpp ." \
  "cp ../assets/mathlib.cpp ." \
  "cp ../assets/mathlib.hpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
