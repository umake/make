Makefile all-in-one
=====================

A single Makefile to compile all your projects: in C, C++ and Fortran.

Tired of installing tools to compile your project? (Automake, CMake
and Ant). Wanting to go back to the old times, when all you needed
to type was `make`? Here is the solution! A single generalized Makefile
which aims to compile and mix almost everything related to C, C++ and
Fortran projects - and supporting many executables, static and shared
library, lexer and parser generators, dependency management and even
more! Everything just 4 letters far from you.

## Wants to start? ##

Good tools are simple. That's why make still has so many success. And
that's what this Makefile wants most. To begin a new project, just type:

    make init

And a set of new directories will be created for you.

And how about configuring the project info? `Config.mk` presents a
self-explanatory set of variables used by this Makefile to do all its
magic. And the best: everything within the own Make language: no extra
parsers, neither extra programs. Just one single Makefile.

In order to make your very first compilation, just create a .c,
.cpp or .f (or any other of the 16 source extensions avaiable) and set
the variable `BIN` whith its name in Config.mk. And *voilà*: it will
compile everything perfectly (at least as perfect as your program...)

## Portability and Issues ##

These Makefile is currently being tested under projects developed mainly
in C++ within Ubuntu Linux and MAC OS X. Any misfunction or bug may be
reported sending an email to me.

## More info ##

For all avaiable targets, type:

    make projecthelp

And it will print a long list of all the avaiable options present in
this complete Makefile.
