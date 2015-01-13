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

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    gmock       => http://git.chromium.org/external/googlemock.git\
                   cd make && make -s gmock.a && mv gmock.a libgmock.a,\
    gmock/gtest => http://git.chromium.org/external/googletest.git\
                   cd make && make -s gtest.a && mv gtest.a libgtest.a\

# Paths
# =======
CXXLIBS         += -I external/gmock/include/ -I external/gtest/include/
LDLIBS          += -L external/gtest/make/ -L external/gmock/make/

# Flags
# =======
CXXFLAGS        += -pthread
LDFLAGS         += -pthread -lgmock -lgtest
