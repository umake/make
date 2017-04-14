########################################################################
# conf/chaiscript.mk                                                   #
# ====================                                                 #
#                                                                      #
# Dependencies and compilation requirements for ChaiScript.            #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `ChaiScript` is an easy to use embedded scripting #
#                    language for C++. It can be used as header only,  #
#                    depending only on a C++11 compliant compiler.     #
#                    By default, ChaiScript is thread safe (what can   #
#                    be disabled for enhanced performance) and s fully #
#                    tested for 32-bit and 64-bit on g++, clang++ and  #
#                    Windows (MSVC2013).                               #
#                    For further info about ChaiScript, access:        #
#                    http://chaiscript.com/                            #
########################################################################

ifndef CHAISCRIPT_MK
override CHAISCRIPT_MK := T

# Requirements
# ==============
include $(MAKEBALLDIR)/pthread.mk

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    chaiscript => https://github.com/ChaiScript/ChaiScript \
                  build: mkdir -p build && cd build && cmake .. && make

# Paths
# =======
CXXLIBS         += -isystem external/chaiscript/include
LDLIBS          += -L external/chaiscript/build

# Linker flags
# ==============
LDCXX           += -ldl

endif # ifndef CHAISCRIPT_MK
