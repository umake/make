########################################################################
# conf/pthread.mk                                                      #
# =================                                                    #
#                                                                      #
# Dependencies and compilation requirements for Pthreads.              #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `Pthreads` (POSIX Threads) is a POSIX standard    #
#                    for threads. It is implemented as a library with  #
#                    C programming language types, functions and       #
#                    constants used to deal with thread management,    #
#                    mutexes, condition variables and synchronization. #
#                    For further info about the standard, access:      #
#                    http://en.wikipedia.org/wiki/POSIX_Threads        #
########################################################################

ifndef PTHREAD_MK
override PTHREAD_MK := T

# Flags
# =======
ASFLAGS         += -pthread
CFLAGS          += -pthread
FFLAGS          += -pthread
CXXFLAGS        += -pthread

# Linker flags
# ==============
LDFLAGS         += -pthread

endif # ifndef PTHREAD_MK
