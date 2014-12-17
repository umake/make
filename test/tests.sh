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

test assert_raises "make init" 0
test assert_raises "make" 0
test assert "./bin/a.out" "Hello, World!" \
  "make init" \
  "cp ../resources/hello.cpp src/hello.cpp" \
  "make"

echo
assert_end make
