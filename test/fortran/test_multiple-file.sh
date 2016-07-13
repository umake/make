#!/usr/bin/env bash

# Tests
test "the compilation of multiple files" \
  "$MAKE init" \
  "cp ../assets/simple_calc.dat ." \
  "cp ../assets/simple_calc.f ." \
  "cp ../assets/mathlib.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output " 4\n 2\n27\n 2\n 1"
