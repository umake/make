#!/bin/bash

test "make with a single file" \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  should_raise 0

test "if \"make\" builds the project with a single file" \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  "./bin/a.out" \
  should_output "Hello, World!"