#!/bin/bash

test \
  "make init" \
  should_raise 0

test \
  "make init" \
  "ls" \
  should_output "Config.mk\nMakefile\ndep\ndoc\ninclude\nsrc"

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  should_raise 0

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls" \
  should_output "Config.mk\nMakefile\ndep\ndoc\ninclude\nsrc"

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls src" \
  should_output "hello.cpp"