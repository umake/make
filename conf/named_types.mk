########################################################################
# conf/named_types.mk                                                  #
# =====================                                                #
#                                                                      #
# Dependencies and compilation requirements for C++14/1z named types.  #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `named_types` is a C++14/1z named types           #
#                    implementation. It interacts well with the        #
#                    standard library. `named_types` is a header-only  #
#                    library. The current implementation offers the    #
#                    `named_tuple` facility and tools to manipulate    #
#                    compile-time strings. `named_variant` and         #
#                    `named_any` are planned.                          #
#                    For further info about ChaiScript, access:        #
#                    https://github.com/duckie/named_types.git         #
########################################################################

ifndef NAMED_TYPES_MK
override NAMED_TYPES_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    named_types => https://github.com/duckie/named_types.git

# Paths
# =======
CXXLIBS         += -I external/named_types/includes

endif # ifndef NAMED_TYPES_MK
