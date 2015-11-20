########################################################################
# conf/sitmo_prng_engine.mk                                            #
# ===========================                                          #
#                                                                      #
# Dependencies and compilation requirements for Sitmo PRNG Engine      #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := Sitmo Parallel Random Number Generator Engine is  #
#                    a fast and high quality random number generator   #
#                    used for large scale parallel processing. The     #
#                    implementation is based on a paper by John Salmon #
#                    and Mark Moraes and described in their paper      #
#                    "Parallel Random Numbers: As Easy as 1, 2, 3".    #
#                    (Proceedings of 2011 International Conference for #
#                    High Performance Computing, Networking, Storage   #
#                    and Analysis). The algorithm is based on the      #
#                    Threefish cryptographic cipher.                   #
#                    For further info about Sitmo PRNG engine, access: #
#                    http://www.sitmo.com/article/                     #
########################################################################

ifndef SISTMO_PRNG_ENGINE_MK
override SISTMO_PRNG_ENGINE_MK := T

# Dependencies
# ==============
WEB_DEPENDENCY  += \
    sitmo_prng_engine => \
        http://www.sitmo.com/wp-content/uploads/2013/12/prng_engine.hpp\
        extract: mv sitmo_prng_engine prng_engine.hpp \
                 && mkdir sitmo_prng_engine/ \
                 && mv prng_engine.hpp sitmo_prng_engine/ \
        build:   echo "Sitmo PRGN engine installed"

# Paths
# =======
CXXLIBS         += -I external/sitmo_prng_engine

endif # ifndef SISTMO_PRNG_ENGINE_MK
