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
echo

echo ".------------------.------------------------------------------.---------."
echo "| PROGRAM          | PATH                                     | VERSION |"


echo "|==================+==========================================+=========|"

printf "| make             | %-40s | %7s |\n" \
    $MAKE  `$MAKE --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                            | sed -n '/[0-9.]\+/{p;q;}'`

echo "|------------------+------------------------------------------+---------|"

printf "| shell            | %-40s | %7s |\n" \
    $SHELL `$SHELL --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                             | sed -n '/[0-9.]\+/{p;q;}'`

echo "|------------------+------------------------------------------+---------|"

printf "| C compiler       | %-40s | %7s |\n" \
    $CC `$CC --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                       | sed -n '/[0-9.]\+/{p;q;}'`

echo "|------------------+------------------------------------------+---------|"

printf "| Fortran compiler | %-40s | %7s |\n" \
    $FC `$FC --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                       | sed -n '/[0-9.]\+/{p;q;}'`

echo "|------------------+------------------------------------------+---------|"

printf "| C++ compiler     | %-40s | %7s |\n" \
    $CXX `$CXX --version | sed -e 's/[^0-9]\+\([0-9.]\+\).*/\1/g' \
                         | sed -n '/[0-9.]\+/{p;q;}'`

echo "'------------------'------------------------------------------'---------'"

echo

################################################################################
##                                    TESTS                                   ##
################################################################################

# Targets
assert_begin "Targets"
echo
. test/targets/test_init.sh
. test/targets/test_standard.sh
echo
assert_end Targets
echo

# Languages
for LANG in ${LANGUAGE:-C C++ Fortran};
do
    lang=`echo $LANG | tr '[:upper:]' '[:lower:]'`

    assert_begin "$LANG"
    echo
    . test/$lang/test_single-file.sh
    . test/$lang/test_multiple-file.sh
    . test/$lang/test_static-lib.sh
    . test/$lang/test_shared-lib.sh
    . test/$lang/test_shared-file.sh
    echo
    assert_end "$LANG"
    echo
done
