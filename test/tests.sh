#!/usr/bin/env bash

################################################################################
##                                  VARIABLES                                 ##
################################################################################

# Programs
OLD_PATH=$PATH

export MAKE=${MAKE:-$(which make)} NO_COLORS=1;
export SHELL=${SHELL:-$(which sh)};

export CC=${CC:-$(which gcc)}
export FC=${FC:-$(which gfortran)}
export CXX=${CXX:-$(which g++)}

if ! which tput 1>/dev/null 2>/dev/null;
    then export COLUMNS=80
fi

################################################################################
##                                  LIBRARIES                                 ##
################################################################################

# Library options
export STOP=1

# Load libraries
. test/assert.sh
. test/helper.sh

################################################################################
##                                CONFIGURATION                               ##
################################################################################

function setup {
  rm -rf test/tmp
  mkdir test/tmp
  cd test/tmp
  ln -s ../../Makefile .
  PATH=./lib:$PATH
  if ! [ -z "$CC" ];  then echo "CC  := ${CC}"  >> .compiler.mk; fi
  if ! [ -z "$FC"  ]; then echo "FC  := ${FC}"  >> .compiler.mk; fi
  if ! [ -z "$CXX" ]; then echo "CXX := ${CXX}" >> .compiler.mk; fi
}

function teardown {
  PATH=$OLD_PATH
  cd ../..
  rm -rf test/tmp
}

################################################################################
##                                    INFO                                    ##
################################################################################

# Programs
printf "\nUsing make \"$MAKE\" (v%s)\n" \
    `$MAKE --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                     | sed -n '/[0-9.]\+/{p;q;}'`

printf "\nUsing shell \"$SHELL\" (v%s)\n" \
    `$SHELL --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                      | sed -n '/[0-9.]\+/{p;q;}'`

# Compilers
echo
if ! [ -z "$CC" ];  then echo "CC  = \"$CC\" "; fi
if ! [ -z "$FC"  ]; then echo "FC  = \"$FC\" "; fi
if ! [ -z "$CXX" ]; then echo "CXX = \"$CXX\""; fi
echo

################################################################################
##                                    TESTS                                   ##
################################################################################

# Targets
echo -n "Testing Targets "
. test/targets/test_init.sh
. test/targets/test_standard.sh
echo
assert_end Targets
echo

# Languages
for LANG in ${LANGUAGE:-C C++ Fortran};
do
    lang=`echo $LANG | tr '[:upper:]' '[:lower:]'`

    echo -n "Testing $LANG "
    . test/$lang/test_single-file.sh
    . test/$lang/test_multiple-file.sh
    . test/$lang/test_static-lib.sh
    . test/$lang/test_shared-lib.sh
    . test/$lang/test_shared-file.sh
    echo
    assert_end "$LANG"
    echo
done
