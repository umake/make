#!/usr/bin/env bash

test "the compilation of a single file"\
  "$MAKE init" \
  "cp ../assets/hello.c src/hello.c" \
  "$MAKE" \
  "./bin/hello" \
  should_output "Hello, World!"
