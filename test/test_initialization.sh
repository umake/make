#!/bin/bash

# Tests initialization
test \
  "make init" \
  should_raise 0

# Tests if 'make init' creates the right folders
test \
  "make init" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

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