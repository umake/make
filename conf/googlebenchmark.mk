########################################################################
# conf/googlebenchmark.mk                                              #
# =========================                                            #
#                                                                      #
# Dependencies and compilation requirements for gbenchmark.            #
# -------------------------------------------------------------------- #
# MAINTEINER_NAME := Renato Cordeiro Ferreira                          #
# MAINTEINER_MAIL := renato.cferreira@hotmail.com                      #
# DESCRIPTION     := `gbenchmark` is a microbenchmark support library, #
#                    which support unit-tests alike benchmarking. To   #
#                    create the benchmark binary, just set `BENCHBIN`  #
#                    with the name of the file that contains the main  #
#                    function for the benchmarks.                      #
#                    For further info about the library, access:       #
#                    https://code.google.com/p/googletest/             #
########################################################################

ifndef GOOGLE_BENCHMARK_MK
override GOOGLE_BENCHMARK_MK := T

# Dependencies
# ==============
GIT_DEPENDENCY  += \
    gbenchmark => https://github.com/google/benchmark.git \
                  mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make

# Paths
# =======
CXXLIBS         += -I external/gbenchmark/include/
LDLIBS          += -L external/gbenchmark/build/src

# Flags
# =======
LDBENCH         += -lbenchmark

endif # ifndef GOOGLE_BENCHMARK_MK
