########################################################################
# conf/mpfr.mk                                                         #
# ==============                                                       #
#                                                                      #
# Dependencies and compilation requirements for MPFR.                  #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `MPFR` (GNU Multiple Precision Floating-Point     #
#                    Arithmetic with Correct Rounding) is a C library  #
#                    for arbitrary precision arithmetic on floating-   #
#                    point numbers. As its main characteristics, it    #
#                    provides portable code, exact precision in bits   #
#                    and four different round modes.                   #
#                    For further info about MPFR library, access:      #
#                    http://www.mpfr.org/mpfr-current/#doc             #
########################################################################

ifndef MPFR_MK
override MPFR_MK := T

# Requirements
# ==============
include $(MAKEBALLDIR)/gmp.mk

ifdef $(call not,$(call exists-lib,mpfr))

# Dependencies
# ==============
WEB_DEPENDENCY  += \
    mpfr => http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.bz2    \
            extract: mv mpfr mpfr.tar.bz2 && tar -jxf mpfr.tar.bz2 \
                     && mv mpfr-3.1.2 mpfr && rm -f mpfr.tar.bz2   \
            build:   ./configure -q && make -s

# Paths
# =======
ASLIBS          += -I external/mpfr/
CLIBS           += -I external/mpfr/
FLIBS           += -I external/mpfr/
CXXLIBS         += -I external/mpfr/
LDLIBS          += -L external/mpfr/.libs/

endif # ifdef $(call exists-lib,mpfr)

# Linker flags
# ==============
LDFLAGS         += -lmpfr

endif # ifndef MPFR_MK
