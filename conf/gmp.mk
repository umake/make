########################################################################
# conf/gmp.mk                                                          #
# =============                                                        #
#                                                                      #
# Dependencies and compilation requirements for GMP.                   #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `GMP` (GNU Multiple Precision Arithmetic Library) #
#                    is a C library for arbitrary precision arithmetic #
#                    on integers, rational and floating-point numbers. #
#                    It can also be compiled by a C++ compiler, and    #
#                    provides a C++ class interface with overloaded    #
#                    functions and operators for a more natural use    #
#                    withing C++ programs.                             #
#                    For further info about GMP library, access:       #
#                    https://gmplib.org/manual/index.html              #
########################################################################

ifndef GMP_MK
override GMP_MK := T

ifdef $(call not,$(call exists-lib,gmp))

# Dependencies
# ==============
WEB_DEPENDENCY  += \
    gmp => https://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2      \
           extract: mv gmp gmp.tar.bz2 && tar -jxf gmp.tar.bz2 \
                    && mv gmp-6.0.0 gmp && rm -f gmp.tar.bz2   \
           build:   ./configure -q --enable-cxx && make -s

# Paths
# =======
ASLIBS          += -I external/gmp/
CLIBS           += -I external/gmp/
FLIBS           += -I external/gmp/
CXXLIBS         += -I external/gmp/
LDLIBS          += -L external/gmp/.libs/

endif # ifdef $(call exists-lib,gmp)

# Linker flags
# ==============
LDFLAGS         += -lgmp
LDCXX           += -lgmpxx

endif # ifndef GMP_MK
