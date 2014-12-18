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
. test/test_build.sh

echo
assert_end make
