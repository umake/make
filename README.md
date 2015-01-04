Makefile All-in-One
=====================

[![Build Status](https://travis-ci.org/renatocf/make.svg?branch=master)]
                (https://travis-ci.org/renatocf/make)

A single Makefile to compile all your projects: in C, C++, Assembly
and Fortran.

Tired of installing tools to compile your project? (Automake, CMake
and Ant). Want to go back to the old days, when all you needed was typing 
`make`? Here is the solution! A single generalized Makefile which aims 
to compile and mix almost everything related to C, C++, Assembly and 
Fortran projects - with support to many executables, static and shared 
libraries, lexer and parser generators, dependency management, file
creation and much more! Everything just 4 letters far from you.

## Starting ##

Good tools are simple. That's why `make` is still so successful. And
that's what this Makefile wants more.

To start, first download the Makefile:

    curl -O https://raw.githubusercontent.com/renatocf/make/master/Makefile

To begin a new project, just type:

    make init

And a group of new directories will be created for you!

And how about configuring the project settings? `Config.mk` presents a
self-explanatory set of variables used by this Makefile to do all its
magic. And the best: everything within the own Make language - no 
extra parsers, neither extra programs. Just one single Makefile.

In order to make your very first compilation, just create a .c, .cpp
.asm or .f (or any of the many source extensions avaiable) and set the 
variable `BIN` whith its name in Config.mk. Then  *voilà*: it will
compile everything perfectly (at least as perfect as your program...)

##### Git submodule #####

To keep a copy of this project as a submodule, first clone it in your
working directory:

    git clone git@github.com:renatocf/make.git

Then, create a symbolic link:

    ln -s make/Makefile .

`make init` will automatically add it as a submodule.

##### Single-directory projects #####

Do you have old single-directory code that started getting out of
control? We also have a solution! `make standard` checks and separates 
your files in our default directory structure. Improve your organization
with almost no work!

## Makeballs ##

Using frameworks or libraries may be tricky, even with a simple-of-use
tool as this Makefile. We need to read documentations and explore where
headers and static/shared libraries are located, in a world of 
complicated and no standardized projects. So, why not to reuse these 
flags? `Makeballs` are meant for that! 

To start using Makeballs, create a `conf` directory and download one
of the `conf/makeball.mk` that you want to use. Then, add it in the end
of `Config.mk`:

    ...
    Makeball list
    ===============
    include conf/makeball_1.mk
    include conf/makeball_2.mk

If you cloned `make` to be used as a git submodule, all Makeballs are 
already avaiable for you! Just create a symbolic link:

    ln -s make/conf/ .

And include them as above.

## Getting the lastest version ##

To get the latest version, just type `make upgrade` and the newest 
Makefile will be automatically downloaded. If it is a submodule,
the same procedure will do it.

## Portability and Issues ##

This Makefile is currently being tested under projects developed mainly
in C++ within Ubuntu Linux and MAC OS X. Tests have already been done
to purely C and C/C++ projects. Any misfunction or bug may be reported 
opening an issue. In order to contribute, make a pull request.

## More info ##

For all avaiable targets, type:

    make projecthelp

And it will print a list with all avaiable options.
