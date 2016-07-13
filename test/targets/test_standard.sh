#!/usr/bin/env bash

test "if 'standard' works" \
  "cp ../assets/hello.cpp hello.cpp" \
  "$MAKE standard" \
  should_raise 0

test "if 'standard' creates the right folders" \
  "cp ../assets/hello.cpp hello.cpp" \
  "$MAKE standard" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

test "if 'standard' moves the source file to 'src'" \
  "cp ../assets/hello.cpp hello.cpp" \
  "$MAKE standard" \
  "ls src | sort -f" \
  should_output "hello.cpp"
