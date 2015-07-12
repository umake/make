#!/usr/bin/env bash

test "$MAKE with a single file"\
  "$MAKE init" \
  "cp ../resources/hello.c src/hello.c" \
  "$MAKE" \
  should_raise 0

test "if \"$MAKE\" builds the project with a single file" \
  "$MAKE init" \
  "cp ../resources/hello.c src/hello.c" \
  "$MAKE V=1" \
  "./bin/hello" \
  should_output "Hello, World!"
