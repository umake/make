########################################################################
# conf/soci.mk                                                         #
# ==============                                                       #
#                                                                      #
# Dependencies and compilation requirements for SOCI C++ DB Access.    #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `SOCI` is a C++ database access library that may  #
#                    be used to connect to the most popular DBMS.      #
#                    Here we present the basic access to PostgreSQL    #
#                    backend, which may be easily replaced by others   #
#                    avaiable (Oracle, MySQL, SQLite, DB2, Firebird,   #
#                    ODBC, etc.) Functions and classes may be accessed #
#                    by including the general header "soci.h" and the  #
#                    backend-specific "soci_postgresql.h"              #
#                    For further info about the framework, access:     #
#                    http://soci.sourceforge.net/doc.html              #
########################################################################

ifndef SOCI_MK
override SOCI_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    soci      => git://github.com/SOCI/soci.git\
                 cd build && cmake -G "Unix Makefiles" ../src && make

# Paths
# =======
CXXLIBS         += -I /usr/include/postgresql/ \
                   -I external/soci/src/core/  \
                   -I external/soci/src/backends/postgresql/
LDLIBS          += -L external/soci/build/lib/

# Flags
# =======
LDFLAGS         += -lsoci_core -lsoci_postgresql

endif # ifndef SOCI_MK
