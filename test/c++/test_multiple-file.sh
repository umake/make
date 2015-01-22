#!/usr/bin/env bash

test "$MAKE with multiple files" \
  "$MAKE init" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.cpp ." \
  "cp ../resources/mathlib.cpp ." \
  "cp ../resources/mathlib.hpp ." \
  "$MAKE standard" \
  "$MAKE" \
  should_raise 0

test "if \"$MAKE\" builds the project" \
  "$MAKE init" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.cpp ." \
  "cp ../resources/mathlib.cpp ." \
  "cp ../resources/mathlib.hpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/a.out < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
