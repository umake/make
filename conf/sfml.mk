########################################################################
# conf/sfml.mk                                                         #
# ==============                                                       #
#                                                                      #
# Dependencies and compilation requirements for SFML.                  #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `SFML` (Simple and Fast Multimedia Library) is a  #
#                    simple multi-platform C++ interface that aims to  #
#                    ease the development of games and multimedia      #
#                    applications. It is composed of five modules:     #
#                    system, window, graphics, audio and network.      #
#                    For further info about SFML, access:              #
#                    http://www.sfml-dev.org/index.php                 #
########################################################################

ifndef SFML_MK
override SFML_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    sfml => https://github.com/SFML/SFML.git \
            mkdir -p build && cd build && cmake .. && make

# Paths
# =======
CXXLIBS         += -I external/sfml/include/
LDLIBS          += -L external/sfml/build/lib/

# Linker flags
# ==============
LDCXX           += -lsfml-system -lsfml-window -lsfml-graphics \
                   -lsfml-network -lsfml-audio

endif # ifndef SFML_MK
