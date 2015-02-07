#!/usr/bin/env bash

. test/assert.sh
. test/helper.sh

if which gmake 1>/dev/null 2>/dev/null;
    then export MAKE=gmake;
    else export MAKE=make;
fi

function setup {
  rm -rf test/tmp
  mkdir test/tmp
  cp Makefile test/tmp/Makefile
  cd test/tmp
  if ! [ -z "$CC" ];  then echo "CC  := ${CC}"  >> .compiler.mk; fi
  if ! [ -z "$CXX" ]; then echo "CXX := ${CXX}" >> .compiler.mk; fi
}

function teardown {
  cd ../..
  rm -rf test/tmp
}

echo "Using program \"$MAKE\""
echo

# Targets
echo -n "Testing Targets "
. test/targets/test_init.sh
. test/targets/test_standard.sh
echo
assert_end Targets
echo

# C Tests
echo -n "Testing C "
. test/c/test_single-file.sh
. test/c/test_multiple-file.sh
. test/c/test_static-lib.sh
. test/c/test_shared-lib.sh
echo
assert_end "C Tests"
echo

# C++ Tests
echo -n "Testing C++ "
. test/c++/test_single-file.sh
. test/c++/test_multiple-file.sh
. test/c++/test_static-lib.sh
. test/c++/test_shared-lib.sh
echo
assert_end "C++ Tests"
echo

# Fortran Tests
echo -n "Testing Fortran "
. test/fortran/test_single-file.sh
. test/fortran/test_multiple-file.sh
echo
assert_end "Fortran Tests"
echo
