#!/bin/bash

# Tests 'make'
test \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  should_raise 0

# Tests if 'make' builds the project
test \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  "./bin/a.out" \
  should_output "Hello, World!"