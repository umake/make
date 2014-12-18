#!/bin/bash

# Tests 'make standard'
test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  should_raise 0

# Tests if 'make standard' creates the right folders
test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

# Tests if 'make standard' moves the source file to 'src'
test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls src | sort -f" \
  should_output "hello.cpp"
