Ultimate Makefile
==================

[![Build Status](https://img.shields.io/travis/umake/make/master.svg)](https://travis-ci.org/umake/make)
[![Build status](https://img.shields.io/appveyor/ci/renatocf/make/master.svg)](https://ci.appveyor.com/project/renatocf/make)
[![Release](https://img.shields.io/github/tag/umake/make.svg)](https://github.com/umake/make/releases/latest)

The Ultimate Makefile to compile all your C, C++, Assembly and Fortran projects.

Tired of installing aditional tools to compile your projects? (Automake,
CMake and Ant). Missing the old days, when all you needed to do was typing
`make`? Here is the solution! A single generalized Makefile which aims to
compile and mix almost everything related to C, C++, Assembly and Fortran
projects - with support to many executables, static and shared libraries,
lexer and parser generators, dependency management,file creation and much
more! Everything just 4 letters away from you.

## TL;DR

```
$ mkdir my_project
$ cd my_project
$ git clone https://github.com/umake/make.git
$ ln -s make/Makefile
$ make init
```

## Starting ##

Good tools are simple. That's why `make` is so successful. And
that's the goal of Ultimate Makefile.

In order to start, just download the Makefile:

    curl -O https://raw.githubusercontent.com/umake/make/master/Makefile

To begin a new project, just type:

    make init

A group of directories and a git repository are now ready for you!

But how about configuring your project settings? `Config.mk` presents a
self-explanatory set of variables used by Ultimate Makefile to perform all
its magic. And the best: everything within the Make language - no 
extra parsers nor extra programs. Just one single Makefile.

In order to make your very first compilation, just create a .c, .cpp,
.asm or .f (or any of the many source extensions available) and *voilà*:
it will compile everything perfectly ( or at least as perfect as your
program is...)

#### Single-directory projects ####

Do you have old single-directory code that is getting out of control? 
We also have a solution! `make standard` checks and separates your
files in our default directory structure. Improve your organization
(and use a great new tool) with almost no work!

#### Git submodule ####

To keep a copy of this project as a submodule, just clone it in your
working directory:

    git clone https://github.com/umake/make.git

Then, create a symbolic link:

    ln -s make/Makefile

`make init` will automatically add it as a submodule.

## Makeballs ##

Using frameworks or libraries may be tricky, even with a easy-to-use
tool as Ultimate Makefile. We need to read documentations and find where
headers and libraries are located in a world of complicated and almost no
standardized projects. So why not reusing these flags? That's where `Makeballs`
come in!


To start using Makeballs, create a `conf` directory and download one
of the `conf/makeball.mk` available. Then add it in the end of your
`Config.mk`:

```make
...
# Makeball list
# ===============
include conf/makeball_1.mk
include conf/makeball_2.mk
```

If you cloned `make` to be used as a git submodule, all Makeballs are 
already available for you! Just create a symbolic link:

    ln -s make/conf/

And include them as above.

#### Didn't find your favorite library? ####

Then just create you own `Makeball`! `conf/makeball.mk` provides the
most complete set of variables that could be used to add functionalities
to Ultimate Makefile. Even better: make a pull request and **contribute**
reducing the work of others (and yourself) in the future.

## Administrative Issues ##

#### Getting the latest version ####

To get the latest version, just type `make upgrade` and the newest 
Makefile will be automatically downloaded. If it is a submodule,
the same procedure will do it.

#### Portability ####

This Makefile is currently being tested under projects developed mainly
in C++ within Ubuntu Linux, Arch Linux, MAC OS X and Windows. Tests have already
been done in purely C and C/C++ projects. To report compatibility
problems, check the session below.

#### Bug report and Contributions ####

Any error or bug can be reported by opening an Issue. In order to 
contribute, make a pull request.

## More info ##

For all available targets, type:

    make projecthelp

And it will print a list with all Ultimate Makefile available options.
