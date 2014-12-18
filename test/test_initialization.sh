#!/bin/bash

test \
  "make init" \
  should_raise 0

test \
  "cp ../resources/hello.cpp hello.cpp" \
  "make standard" \
  should_raise 0