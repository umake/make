#!/bin/bash

test "make"\
  "make init" \
  "cp ../resources/hello.c src/hello.c" \
  "make" \
  should_raise 0

test "if \"make\" builds the project" \
  "make init" \
  "cp ../resources/hello.c src/hello.c" \
  "make" \
  "./bin/a.out" \
  should_output "Hello, World!"
