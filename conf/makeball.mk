########################################################################
# conf/makeball.mk                                                     #
# ==================                                                   #
#                                                                      #
# Dependencies and compilation requirements for makeball.              #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Your Name                                         #
# MAINTEINER_MAIL := your_mail@mail.com                                #
# DESCRIPTION     := `makeball.mk` is a model for creating Makeballs   #
#                    - config files similar to `Config.mk` which may   #
#                    be included on it to simplify downloading and     #
#                    header/library configurations of the dependency.  #
#                    To contribute with your own Makeball, modify this #
#                    sample and submit it by a pull request.           #
#                    For further info about the AIO Makefile, access:  #
#                    https://github.com/renatocf/make                  #
########################################################################

# Dependencies
# ==============
# GIT_DEPENDENCY  := # List of git dependencies in the format
#                    # DEP_NAME => dep_path                  
# WEB_DEPENDENCY  := # Same as above, but for URL downloads  
#                    # with 'curl -o' (default) or 'wget -O' 

# Paths
# =======
# ASLIBS          := # Assembly paths
# CLIBS           := # C paths
# CXXLIBS         := # C++ paths
# LDLIBS          := # Linker paths

# Compiler flags
# ================
# CPPFLAGS        := # Precompiler Flags
# ASFLAGS         := # Assembly Flags
# CFLAGS          := # C Flags
# FFLAGS          := # Fortran flags
# CXXFLAGS        := # C++ Flags

# Linker flags
# ==============
# LDFLAGS         := # Linker flags
# LDC             := # C linker flags
# LDF             := # Fortran linker flags
# LDCXX           := # C++ linker flags
# LDLEX           := # Lexer linker flags
# LDYACC          := # Parser linker flags
# LDESQL          := # Embedded SQL linker flags

# Library flags
# ===============
# ARFLAGS         := # Static library flags
# SOFLAGS         := # Shared library flags

