########################################################################
# conf/optimus.mk                                                      #
# ====================                                                 #
#                                                                      #
# Dependencies and compilation requirements for Optimus.               #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `Optimus` is a Nonlinear optimization library.    #
#                    For further info about Optimus, access:           #
#                    https://github.com/topsframework/optimus          #
########################################################################

ifndef OPTIMUS_MK
override OPTIMUS_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    optimus => https://github.com/topsframework/optimus.git

# Paths
# =======
CXXLIBS         += -isystem external/optimus/include/
LDLIBS          += -L external/optimus/lib/

# Linker flags
# ==============
LDCXX           += -loptimus

endif # ifndef OPTIMUS_MK
