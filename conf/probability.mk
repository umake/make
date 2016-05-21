########################################################################
# conf/probability.mk                                                  #
# =====================                                                #
#                                                                      #
# A fast implementation of probabilities, using log-probabilities      #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `probability` is a library to use probabilities   #
#                    with operations optimized to make calculus in     #
#                    log-space.                                        #
#                    For further info about probability lib, access:   #
#                    https://github.com/renatocf/probability.git       #
########################################################################

ifndef PROBABILITY_MK
override PROBABILITY_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    probability => https://github.com/renatocf/probability.git

# Paths
# =======
CXXLIBS         += -I probability/include

endif # ifndef PROBABILITY_MK
