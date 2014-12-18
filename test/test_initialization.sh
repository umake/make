#!/bin/bash

test \
  "make init" \
  should_raise 0

test \
  "make init" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  should_raise 0

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  "ls src | sort -f" \
  should_output "hello.cpp"