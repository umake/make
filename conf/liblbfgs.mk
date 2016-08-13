##########################################################################
# conf/liblbfgs.mk                                                       #
# ====================                                                   #
#                                                                        #
# Implementation of Limited-memory Broyden-Fletcher-Goldfarb-Shanno      #
# (L-BFGS) method                                                        #
# ---------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                            #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                        #
# DESCRIPTION     := This library is a C port of the implementation of   #
#                    Limited-memory Broyden-Fletcher-Goldfarb-Shanno     #
#                    (L-BFGS) method written by Jorge Nocedal.           #
#                    The original FORTRAN source code is available at:   #
#                    http://www.ece.northwestern.edu/~nocedal/lbfgs.html #
##########################################################################

ifndef LIBLBFGS_MK
override LIBLBFGS_MK := T

# Dependencies
# ==============
CURL = curl -sLo

LIBTOOLIZE := libtoolize

ifeq ($(PLAT_KERNEL),Darwin)

LIBTOOLIZE := glibtoolize

endif # ifeq ($(PLAT_KERNEL),Darwin)

GIT_DEPENDENCY  += \
    liblbfgs => https://github.com/chokkan/liblbfgs.git \
                build: mkdir -p build && $(LIBTOOLIZE) && sh autogen.sh \
                && ./configure --disable-debug --disable-dependency-tracking \
                --prefix=$(PWD)/external/liblbfgs/build && make && make install

# Paths
# =======
CXXLIBS         += -I external/liblbfgs/build/include
LDLIBS          += -L external/liblbfgs/build/lib
LDFLAGS         += -llbfgs

endif # ifndef LIBLBFGS_MK
