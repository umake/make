########################################################################
# conf/openmpi.mk                                                      #
# =================                                                    #
#                                                                      #
# Dependencies and compilation requirements for Open MPI.              #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `Open MPI` (Open Message Passing Interface) is an #
#                    MPI implementation. MPI defines a set of library  #
#                    routines for building message-passaging programs, #
#                    in C, C++ and Fortran.                            #
#                    For further info about this implementation, see:  #
#                    http://www.open-mpi.org/                          #
########################################################################

# Compiler
# ==========
CC              := mpicc
FC              := mpifort
CXX             := mpicxx
