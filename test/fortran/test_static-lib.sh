#!/usr/bin/env bash

test "if \"$MAKE\" builds the static library" \
  "$MAKE init" \
  "cp ../resources/static_lib.f.mk Config.mk" \
  "cp ../resources/simple_calc.dat ." \
  "cp ../resources/simple_calc.f ." \
  "cp ../resources/mathlib.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "./bin/simple_calc < ./data/simple_calc.dat" \
  should_output " 4\n 2\n27\n 2\n 1"
