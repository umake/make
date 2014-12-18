#!/bin/bash

test \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  should_raise 0


test \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make" \
  "./bin/a.out" \
  should_output "Hello, World!"