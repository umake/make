#!/usr/bin/env bash

# Tests
test "$MAKE with multiple files" \
  "$MAKE init" \
  "cp ../assets/simple_calc.dat ." \
  "cp ../assets/simple_calc.c ." \
  "cp ../assets/mathlib.c ." \
  "cp ../assets/mathlib.h ." \
  "$MAKE standard" \
  "$MAKE" \
  should_raise 0

test "if \"$MAKE\" builds the project with multiple files" \
  "$MAKE init" \
  "cp ../assets/simple_calc.dat ." \
  "cp ../assets/simple_calc.c ." \
  "cp ../assets/mathlib.c ." \
  "cp ../assets/mathlib.h ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
