#!/bin/bash

. test/assert.sh
. test/helper.sh

function setup {
  mkdir test/tmp
  cp Makefile test/tmp/Makefile
  cd test/tmp
  echo "CC  := ${CC}"  >> .compiler.mk
  echo "CXX := ${CXX}" >> .compiler.mk
}

function teardown {
  cd ../..
  rm -rf test/tmp
}

# Targets
. test/targets/test_init.sh
. test/targets/test_standard.sh

# C Tests
. test/c/test_single-file.sh
. test/c/test_multiple-file.sh
. test/c/test_static-lib.sh

# C++ Tests
. test/c++/test_single-file.sh
. test/c++/test_multiple-file.sh
. test/c++/test_static-lib.sh

echo
assert_end make
