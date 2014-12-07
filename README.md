Makefile All-in-One
=====================

A single Makefile to compile all your projects: in C, C++ and Fortran.

Tired of installing tools to compile your project? (Automake, CMake
and Ant). Want to go back to old times, when all you needed was typing 
`make`? Here is the solution! A single generalized Makefile which aims 
to compile and mix almost everything related to C, C++, Assembly and 
Fortran projects - with support to many executables, static and shared 
libraries, lexer and parser generators, dependency management and much 
more! Everything just 4 letters far from you.

## Want to start? ##

Good tools are simple. That's why make still has so many success. And
that's what this Makefile primarily wants.

In order to start, download the Makefile:

    curl -O https://raw.githubusercontent.com/renatocf/make/master/Makefile

To begin a new project, just type:

    make init

And a group of new directories will be created for you!

And how about configuring the project info? `Config.mk` presents a
self-explanatory set of variables used by this Makefile to do all its
magic. And the best: everything within the own Make language - no 
extra parsers, neither extra programs. Just one single Makefile.

In order to make your very first compilation, just create a .c, .cpp
.asm or .f (or any other source extensions avaiable) and set the 
variable `BIN` whith its name in Config.mk. Then  *voilà*: it will
compile everything perfectly (at least as perfect as your program...)

#### Git submodule ####

If you want to keep a copy of this project as a submodule, you may
add it within your working directory:

    git submodule add git@github.com:renatocf/make.git make

And then create a symbolic link:

    ln -s make/Makefile Makefile

## Getting the lastest version ##

To get the latest version, just type `make upgrade` and the newest 
Makefile will be automatically downloaded. If it is a submodule,
`cd make && git pull origin master` will solve it.

## Portability and Issues ##

These Makefile is currently being tested under projects developed mainly
in C++ within Ubuntu Linux and MAC OS X. Tests have already been done
to purely C and C/C++ projects. Any misfunction or bug may be reported 
sending an email to me. In order to contribute, make a pull request.

## More info ##

For all avaiable targets, type:

    make projecthelp

And it will print the list of all avaiable options.
