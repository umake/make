########################################################################
# conf/opengl.mk                                                       #
# ================                                                     #
#                                                                      #
# Dependencies and compilation requirements for OpenGL, GLU and GLUT   #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `OpenGL` (Open Graphics Library) is a C language  #
#                    multiplatform API used develop 2D/3D graphics.    #
#                    `GLU` (OpenGL Utility Library) offers functions   #
#                    to create matrixes of visualization/projection.   #
#                    `GLUT` (OpenGL Utility Toolkit) abstracts         #
#                    windowing systems, offering a simple interface    #
#                    to create applications in OpenGL.                 #
#                    For further info about the library, access:       #
#                    https://www.opengl.org/                           #
########################################################################

ifeq ($(PLAT_KERNEL),Linux)

# Flags
# =======
LDFLAGS         += -lGL -lGLU -lglut

endif # ifeq ($(PLAT_KERNEL),Linux)

########################################################################

ifeq ($(PLAT_KERNEL),Darwin)

# Flags
# =======
LDFLAGS         += -framework OpenGL -framework GLUT

endif # ifeq ($(PLAT_KERNEL),Darwin)
