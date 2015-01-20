# Dependencies
# ==============
GIT_DEPENDENCY  += \
    gbenchmark => https://github.com/google/benchmark.git \
                  mkdir -p build && cd build && cmake .. && make

# Paths
# =======
CXXLIBS         += -I external/gbenchmark/include/
LDLIBS          += -L external/gbenchmark/build/src

# Flags
# =======
LDFLAGS         += -lbenchmark
