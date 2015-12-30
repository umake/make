########################################################################
# conf/googletest.mk                                                   #
# ====================                                                 #
#                                                                      #
# Dependencies and compilation requirements for gmock and gtest.       #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `gmock` and `gtest` are part of the Google C++    #
#                    test suite, and can be used to create unit and    #
#                    integration tests. To create the test binary,     #
#                    just set `TESTBIN` with the name of the file      #
#                    that contains the main function for the tests.    #
#                    For further info about the framework, access:     #
#                    https://code.google.com/p/googletest/             #
########################################################################

ifndef GOOGLE_TEST_MK
override GOOGLE_TEST_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    gtest => https://github.com/google/googletest.git \
             mkdir -p build && cd build && cmake .. && make

# Paths
# =======
CXXLIBS         += -I external/gtest/googlemock/include/ \
                   -I external/gtest/googletest/include/
LDLIBS          += -L external/gtest/build/googlemock/ \
                   -L external/gtest/build/googlemock/gtest/

# Flags
# =======
CXXFLAGS        += -pthread
LDFLAGS         += -pthread -lgmock -lgtest

# Runtime
# ========
TEST_ENV        += GTEST_COLOR=yes

endif # ifndef GOOGLE_TEST_MK
