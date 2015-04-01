#!/usr/bin/env bash

# Tests
test "$MAKE with multiple files" \
  "$MAKE init" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.f ." \
  "cp ../resources/mathlib.f ." \
  "$MAKE standard" \
  "$MAKE" \
  should_raise 0

test "if \"$MAKE\" builds the project with multiple files" \
  "$MAKE init" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.f ." \
  "cp ../resources/mathlib.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output " 4\n 2\n27\n 2\n 1"
