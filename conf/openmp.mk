########################################################################
# conf/openmp.mk                                                       #
# ================                                                     #
#                                                                      #
# Dependencies and compilation requirements for OpenMP.                #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `OpenMP` (Open Multi-Processing) is an API for    #
#                    shared memory multiproces programming for C, C++  #
#                    and Fortran. It consists of compiler directives,  #
#                    library routines and environment variables that   #
#                    influence runtime behavior.                       #
#                    For further info about the API, access:           #
#                    http://openmp.org/wp/                             #
########################################################################

ifndef OPENMP_MK
override OPENMP_MK := T

# Flags
# =======
CFLAGS          += -fopenmp
CXXFLAGS        += -fopenmp
LDFLAGS         += -fopenmp

endif # ifndef OPENMP_MK
