BIN := Main
SRC := Main.cpp Token.cpp Grammar.cpp Command.cpp Tokenizer.cpp
OBJ := $(SRC:.cpp=.o)

CC  := gcc
CXX := g++
RM  := rm -f

CFLAGS   := -Wall -ansi -pedantic -O2
CXXFLAGS := -std=gnu++11
LDFLAGS  := 

$(BIN): $(OBJ)
	$(CXX) $^ -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CFLAGS) $(CXXFLAGS) -c $< -o $@

clean:
	$(RM) *.o
