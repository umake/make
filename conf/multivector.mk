########################################################################
# conf/multivector.mk                                                  #
# =====================                                                #
#                                                                      #
#  Linearized multi-dimensional vectors with a simple syntax           #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `multivector` is a library to create linearized   #
#                    multi-dimensional vector that have a simpele      #
#                    syntax for their manipulation.                    #
#                    For further info about multivector lib, access:   #
#                    https://github.com/renatocf/multivector.git       #
########################################################################

ifndef MULTIVECTOR_MK
override MULTIVECTOR_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    multivector => https://github.com/renatocf/multivector.git

# Paths
# =======
CXXLIBS         += -isystem external/multivector/include

endif # ifndef MULTIVECTOR_MK
