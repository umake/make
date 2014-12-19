#!/bin/bash

test "make" \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  should_raise 0

test "if \"make\" builds the project" \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  "./bin/a.out" \
  should_output "Hello, World!"