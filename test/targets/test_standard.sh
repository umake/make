#!/bin/bash

test "\"make standard\"" \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  should_raise 0

test "if \"make standard\" creates the right folders" \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

test "if \"make standard\" moves the source file to \"src\"" \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls src | sort -f" \
  should_output "hello.cpp"
