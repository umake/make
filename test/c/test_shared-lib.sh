#!/usr/bin/env bash

test "if \"$MAKE\" builds the shared library" \
  "$MAKE init" \
  "cp ../resources/shared_lib.c.mk Config.mk" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.c ." \
  "cp ../resources/mathlib.c ." \
  "cp ../resources/mathlib.h ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output "4\n2\n27\n2\n1"
