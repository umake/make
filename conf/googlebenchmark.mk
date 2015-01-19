# Dependencies
# ==============
GIT_DEPENDENCY  += \
    gbenchmark => https://github.com/google/benchmark.git \
                  mkdir build && cd build && cmake .. && make

# Paths
# =======
CXXLIBS         += -I external/benchmark/include/
LDLIBS          += -L external/benchmark/build/src

# Flags
# =======
LDFLAGS         += -lbenchmark
