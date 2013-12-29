BIN := Main
SRC := Main.cpp Token.cpp
OBJ := $(SRC:.cpp=.o)

CC  := gcc
CXX := g++
RM  := rm -f

CFLAGS   := -Wall
CXXFLAGS := -std=gnu++11
LDFLAGS  := 

$(BIN): $(OBJ)
	$(CXX) $^ -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	$(RM) *.o
