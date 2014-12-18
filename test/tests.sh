#!/bin/bash

set -e

. test/assert.sh
. test/helper.sh

function setup {
  mkdir test/tmp
  cp Makefile test/tmp/Makefile
  cd test/tmp
}

function teardown {
  cd ../..
  rm -rf test/tmp
}

test \
  "make init" \
  should_raise 0

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
  should_be "Hello, World!"

echo
assert_end make
