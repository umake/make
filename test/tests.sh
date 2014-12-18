#!/bin/bash

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

. test/test_initialization.sh

# C Tests
. test/c/test_single-file.sh

# C++ Tests
. test/c++/test_single-file.sh

echo
assert_end make
