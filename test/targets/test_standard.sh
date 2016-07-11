#!/usr/bin/env bash

test "\"$MAKE standard\"" \
  "cp ../assets/hello.cpp hello.cpp" \
  "$MAKE standard" \
  should_raise 0

test "if \"$MAKE standard\" creates the right folders" \
  "cp ../assets/hello.cpp hello.cpp" \
  "$MAKE standard" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

test "if \"$MAKE standard\" moves the source file to \"src\"" \
  "cp ../assets/hello.cpp hello.cpp" \
  "$MAKE standard" \
  "ls src | sort -f" \
  should_output "hello.cpp"
