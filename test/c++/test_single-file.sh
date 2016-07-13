#!/usr/bin/env bash

test "the compilation of a single file"\
  "$MAKE init" \
  "cp ../assets/hello.cpp src/hello.cpp" \
  "$MAKE" \
  "./bin/hello" \
  should_output "Hello, World!"
