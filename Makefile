#!/usr/bin/make -f
# All-in-One Makefile

########################################################################
# Copyright 2014 RCF                                                   #
#                                                                      #
# Licensed under the Apache License, Version 2.0 (the "License");      #
# you may not use this file except in compliance with the License.     #
# You may obtain a copy of the License at                              #
#                                                                      #
#     http://www.apache.org/licenses/LICENSE-2.0                       #
#                                                                      #
# Unless required by applicable law or agreed to in writing, software  #
# distributed under the License is distributed on an "AS IS" BASIS,    #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or      #
# implied.                                                             #
# See the License for the specific language governing permissions and  #
# limitations under the License.                                       #
########################################################################

# Default target
all:

# Make version
ifneq ($(firstword $(shell $(MAKE) --version)),GNU)
$(error "All-in-One Makefile requires GNU Make. Please install it.")
endif

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                          USER DEFINITIONS                            #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                             PROGRAM                                ##
########################################################################

# Project setting
PROJECT         := Default
VERSION         := 1.0.0

# Package info
AUXFILES        :=
MAINTEINER_NAME := Your Name
MAINTEINER_MAIL := your_mail@mail.com
COPYRIGHT       := $(MAINTEINER_NAME)
SYNOPSIS        := default short synopsis
DESCRIPTION     := default long description

# Debian package
DEB_PROJECT     := default
DEB_PRIORITY    := optional

# Program settings
BIN             :=
SBIN            :=
LIBEXEC         :=
TESTBIN         :=
BENCHBIN        :=
ARLIB           :=
SHRLIB          :=

# Documentation settings
LICENSE         := LICENSE
NOTICE          := NOTICE
CONTRIBUTORS    := CONTRIBUTORS
DOXYFILE        := Doxyfile

# Dependencies
GIT_DEPENDENCY  :=
WEB_DEPENDENCY  :=

# Project namespace (C/C++)
STD_NAMESPACE   :=

########################################################################
##                          COMPILATION FLAGS                         ##
########################################################################

# Preprocessor options
CPPFLAGS    :=

# Assembly/C/C++/Fortran options
ASFLAGS     := -f elf32
CFLAGS      :=
CXXFLAGS    := -std=c++11
FFLAGS      := -ffree-form -cpp

# Library options
ARFLAGS     := -rcv
SHRFLAGS    := -fPIC

# Program options
LEXFLAGS    :=
YACCFLAGS   :=
ESQLFLAGS   :=
COVFLAGS    := -abc
FINDFLAGS   := -type d -print 2> /dev/null
CTAGSFLAGS  :=
ETAGSFLAGS  :=
MAKEFLAGS   := --no-print-directory

# Analysis lint options
CALFLAGS    := --quiet --enable=style
FALFLAGS    :=
CXXALFLAGS  := --quiet --enable=style

# Style l options
CSLFLAGS    :=
FSLFLAGS    :=
CXXSLFLAGS  :=

# Coverage options
CPPCOVFLAGS :=
CCOVFLAGS   := --coverage
FCOVFLAGS   := --coverage
CXXCOVFLAGS := --coverage

########################################################################
##                             LINKER FLAGS                           ##
########################################################################

# Assembly/C/C++/Fortran options
LDFLAGS     :=
LDC         :=
LDF         := -lgfortran
LDCXX       :=

# Library options
LDSHR       := -shared

# Program options
LDLEX       := -lfl
LDYACC      :=
LDESQL      := -lecpg

# Coverage options
LDCOV       := --coverage

########################################################################
##                               PATHS                                ##
########################################################################

# Assembly/C/C++/Fortran paths for include dirs
ASLIBS      :=
CLIBS       :=
CXXLIBS     :=
FLIBS       :=

# Program paths for include dirs
LEXLIBS     :=
YACCLIBS    :=
ESQLLIBS    := $(if $(strip $(shell which pg_config)),\
                   $(shell pg_config --includedir))

# Linker paths for library dirs
LDLIBS      :=

########################################################################
##                            DIRECTORIES                             ##
########################################################################

# Local directories
ifndef SINGLE_DIR
SRCDIR    := src
DEPDIR    := dep
INCDIR    := include
DOCDIR    := doc
DEBDIR    := debian
OBJDIR    := build
COVDIR    := coverage
LIBDIR    := lib
EXTDIR    := external
SRPDIR    := script
BINDIR    := bin
SBINDIR   := sbin
EXECDIR   := libexec
DISTDIR   := dist
CONFDIR   := conf
DATADIR   := data
MAKEDIR   := make
DESTDIR   :=
TESTDIR   := test
BENCHDIR  := benchmark
LOCALEDIR := locale
else
$(foreach var,\
    SRCDIR DEPDIR INCDIR OBJDIR COVDIR LIBDIR EXTDIR SRPDIR \
    BINDIR SBINDIR DISTDIR CONFDIR DATADIR MAKEDIR TESTDIR BENCHDIR \
    LOCALEDIR,\
    $(eval $(var) := .)\
)
endif

# System directories
SYSINCDIR  := /include /usr/include /usr/local/include
SYSLIBDIR  := /lib     /usr/lib     /usr/local/lib      \
              /lib32   /usr/lib32   /usr/local/lib32    \
              /lib64   /usr/lib64   /usr/local/lib64
SYSBINDIR  := /bin     /usr/bin     /usr/local/bin
SYSSBINDIR := /sbin    /usr/sbin    /usr/local/sbin
SYSEXECDIR := /libexec /usr/libexec /usr/local/libexec

## INSTALLATION ########################################################

### PREFIXES
# * prefix:        Default prefix for variables below
# * exec_prefix:   Prefix for machine-specific files (bins and libs)
prefix         := /usr/local
exec_prefix    := $(prefix)

### EXECUTABLES AND LIBRARIES
# * bindir:        Programs that user can run
# * sbindir:       Runnable by shell, useful by sysadmins
# * libexecdir:    Executables for being run only by other programs
# * libdir         Object and libraries of object code
install_dirs   := bindir sbindir libexecdir libdir
bindir         := $(exec_prefix)/bin
sbindir        := $(exec_prefix)/sbin
libexecdir     := $(exec_prefix)/libexec
libdir         := $(exec_prefix)/lib

### DATA PREFIXES
# * datarootdir:   Read-only machine-independent files (docs and data)
# * datadir:       Read-only machine-independent files (data, no docs)
# * sysconfdir:    Read-only single-machine files (as server configs)
# * localstatedir: Exec-modifiable single-machine single-exec files
# * runstatedir:   Exec-modifiable single-machine run-persistent files
install_dirs   += datarootdir datadir sysconfdir
install_dirs   += sharedstatedir localstatedir runstatedir
datarootdir    := $(prefix)/share
datadir        := $(datarootdir)
sysconfdir     := $(prefix)/etc
sharedstatedir := $(prefix)/com
localstatedir  := $(prefix)/var
runstatedir    := $(localstatedir)/run

### HEADER FILES
# * includedir:    Includable (header) files for use by GCC
# * oldincludedir: Includable (header) files for GCC and othe compilers
install_dirs   += includedir oldincludedir
includedir     := $(prefix)/include
oldincludedir  := /usr/include

### DOCUMENTATION FILES
# * infodir:       Doc directory for info files
# * docdir:        Doc directory for files other than info
# * htmldir:       Doc directory for HTML files (with subdir for locale)
# * dvidir:        Doc directory for DVI files (with subdir for locale)
# * pdfdir:        Doc directory for PDF files (with subdir for locale)
# * psdir:         Doc directory for PS files (with subdir for locale)
install_dirs   += docdir infodir htmldir dvidir pdfdir psdir
docdir         := $(datarootdir)/doc/$(PROJECT)/$(VERSION)
infodir        := $(datarootdir)/info
htmldir        := $(docdir)
dvidir         := $(docdir)
pdfdir         := $(docdir)
psdir          := $(docdir)

### MAN FILES
# * mandir:       Manual main directory
# * manXdir:      Manual section X (X from 1 to 7)
install_dirs   += mandir man1dir man2dir man3dir
install_dirs   += man4dir man5dir man6dir man7dir
mandir         := $(datarootdir)/man
man1dir        := $(mandir)/man1
man2dir        := $(mandir)/man2
man3dir        := $(mandir)/man3
man4dir        := $(mandir)/man4
man5dir        := $(mandir)/man5
man6dir        := $(mandir)/man6
man7dir        := $(mandir)/man7

### OTHERS
# * lispdir:      Emacs Lisp files in this package
# * localedir:    Locale-specific message catalogs for the package
install_dirs   += lispdir localedir
lispdir        := $(datarootdir)/emacs/site-lisp
localedir      := $(datarootdir)/locale

########################################################################
##                            EXTENSIONS                              ##
########################################################################

# Assembly extensions
ASMEXT  := .asm .S

# Header extensions
HEXT    := .h
HFEXT   := .mod .MOD
HXXEXT  := .H .hh .hpp .HPP .hxx .h++ .ih

# Source extensions
CEXT    := .c
FEXT    := .f .FOR .for .f77 .f90 .f95 .F .fpp .FPP
CXXEXT  := .C .cc .cpp .CPP .cxx .c++
TLEXT   := .tcc .icc

# Library extensions
LIBEXT  := .a .so .dll .dylib
AREXT   := .a
SHREXT  := .so

# Parser/Lexer extensions
LEXEXT  := .l
LEXXEXT := .ll .lpp
YACCEXT := .y
YAXXEXT := .yy .ypp

# Embedded SQL extensions
ESQLEXT := .pgc .pc

# Dependence extensions
DEPEXT  := .d
EXTEXT  := .dy
SYSEXT  := .dep

# Coverage extensions
COVEXT  := .gcno .gcda
REPEXT  := .info

# Binary extensions
OBJEXT  := .o
BINEXT  :=

# Documentation extensions
TEXIEXT := .texi
INFOEXT := .info
HTMLEXT := .html
DVIEXT  := .dvi
PDFEXT  := .pdf
PSEXT   := .ps

# Script extensions
SRPEXT  := .ahk .applescript .bat .bash .cmd .coffee .erb .hta \
           .itcl .js .lua .m .php .pl .pm .py .pyc .pyo .r .rb \
           .scpt .scptd .sh .tcl .vbs

# Data extensions
DATAEXT := .asc .bak .bin .bk .cfg .conf .cnf .css .csv .dat \
           .diff .dsk .htm .html .json .log .ltsv .raw .sql \
           .temp .tmp .tsv .txt .xml .yaml .yml

# I18n extensions
POTEXT  := .pot
POEXT   := .po
MOEXT   := .mo

# Suffixex
TESTSUF  := Test
BENCHSUF := Bench

########################################################################
##                             PROGRAMS                               ##
########################################################################

# Compilation
AR              := ar
AS              := nasm
CC              := gcc
FC              := gfortran
CXX             := g++
RANLIB          := ranlib

# Include configuration file for compiler if exists
-include .compiler.mk compiler.mk Compiler.mk

# Installation
INSTALL         := install
INSTALL_DATA    := $(INSTALL)
INSTALL_PROGRAM := $(INSTALL) -m 644

# File manipulation
CP              := cp -a
MV              := mv
RM              := rm -f
TAR             := tar -cvf
ZIP             := zip
GZIP            := gzip
BZIP2           := bzip2
MKDIR           := mkdir -p
RMDIR           := rm -rf
FIND            := find

# Parser and Lexer
LEX             := flex
LEXCXX          := flexc++
YACC            := bison
YACCCXX         := bisonc++

# Analysis lint
CALINT          := cppcheck
FALINT          :=
CXXALINT        := cppcheck

# Syntax lint
CSLINT          :=
FSLINT          :=
CXXSLINT        := cpplint.py

# Coverage
COV             := lcov

# Embedded SQL
ESQL            := ecpg

# Tags
CTAGS           := ctags
ETAGS           := etags

# Documentation
DOXYGEN         := doxygen
MAKEINFO        := makeinfo
INSTALL_INFO    := install-info
TEXI2HTML       := makeinfo --no-split --html
TEXI2DVI        := texi2dvi
TEXI2PDF        := texi2pdf
TEXI2PS         := texi2dvi --ps

# Native Language Support
XGETTEXT        := xgettext
MSGINIT         := msginit --no-translator
MSGMERGE        := msgmerge
MSGFMT          := msgfmt -c
NLSREQINC       := libintl.h

# Packages (Debian)
DEBUILD         := debuild -us -uc
DCH              = dch --create -v $(deb_version) \
                       --package $(deb_project)

# Remote
CURL            := curl -o
GIT             := git

# Make
MAKE            += -f $(firstword $(MAKEFILE_LIST)) $(MAKEFLAGS)

########################################################################
##                              SWITCHES                              ##
########################################################################

ifndef COVERAGE
COVERAGE := $(if $(filter %coverage %clean,$(MAKECMDGOALS)),T)
endif

# Include configuration file if exists
-include .version.mk
-include .config.mk config.mk Config.mk

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                     PLATFORM SPECIFIC DEFINITIONS                    #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

# The default definitions presented above area all set to work in a
# standard Linux environment. Here we present changes required to
# the code work in different OSs.

ifdef $(call is-empty,$(shell which uname 2>/dev/null)) # exists 'uname'

$(warning "Platform-specific support unavaiable: 'uname' required")

else # exists 'uname'

# Information extracted by uname
# ================================
# uname_S: Kernel name
# uname_M: Machine hardware name
# uname_O: Operating System
# uname_R: Kernel release
# uname_P: Processor type (or 'unknown')
# uname_V: Kernel version
override uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
override uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
override uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
override uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
override uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
override uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')

PLAT_KERNEL   ?= $(uname_S)
PLAT_ARCH     ?= $(uname_M)
PLAT_OS       ?= $(uname_O)
PLAT_RELEASE  ?= $(uname_R)
PLAT_PROC     ?= $(uname_P)
PLAT_VERSION  ?= $(uname_V)

# Platform specific flags
# =========================

ifeq ($(PLAT_KERNEL),Darwin) # OSX Family
SHREXT   := .dylib
SHRFLAGS := -fno-common
LDSHR    := -dynamiclib -undefined dynamic_lookup
endif

# Include additional platform specific changes
-include $(PLAT_KERNEL).$(PLAT_ARCH).mk
-include $(PLAT_KERNEL).$(PLAT_ARCH).$(PLAT_VERSION).mk

endif # exists 'uname'

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                     FLAG-SPECIFIC POST PROCESSMENT                   #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

# Coverage
# ==========
# Changes needed to deal with coverage compilation.
# 1) Preprocess compilation flags to add coverage compiler options
#    and remove automatic optimizations (flags -On, n > 0)
# 2) Preprocess linker flags to add coverage linker options
#------------------------------------------------------------------[   ]
ifndef DEPLOY
ifdef COVERAGE
#------------------------------------------------------------------[ 1 ]
$(foreach p,CPP AS C F CXX,\
    $(eval override $pFLAGS := $(strip \
        $(patsubst -O%,,$($pFLAGS) $($pCOVFLAGS) ))))
#------------------------------------------------------------------[ 2 ]
override LDFLAGS += $(LDCOV)
#------------------------------------------------------------------[   ]
endif # ifdef COVERAGE
endif # ifndef DEPLOY

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                        DEVELOPER DEFINITIONS                         #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                  MAKEFILE BASIC CONFIGURATIONS                     ##
########################################################################

# Remote path
MAKERAWREMOTE := \
    https://raw.githubusercontent.com/renatocf/make/master/Makefile

# Git remote path
MAKEGITREMOTE := \
    git@github.com:renatocf/make.git

# Make current directory
MAKECURRENTDIR := \
    $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

# Define the shell to be used
SHELL = /bin/sh

########################################################################
##                         USEFUL DEFINITIONS                         ##
########################################################################

T     := 1
comma := ,
empty :=
space := $(empty) $(empty)
tab   := $(empty)	$(empty)
define squote
'
endef
define dquote
"
endef
define newline


endef
lparentheses := (
rparentheses := )

n0 :=
n1 := 1
n2 := 1 1
n3 := 1 1 1
n4 := 1 1 1 1
n5 := 1 1 1 1 1
n6 := 1 1 1 1 1 1
n7 := 1 1 1 1 1 1 1
n8 := 1 1 1 1 1 1 1 1
n9 := 1 1 1 1 1 1 1 1 1

########################################################################
##                             FUNCTIONS                              ##
########################################################################

# Basic variable functions
# ==========================
# 1) is-empty:  Returns not empty if a variable is empty
# 2) not-empty: Returns not empty if a variable is not empty

define is-empty
$(strip $(if $(strip $1),,T))
endef

define not-empty
$(strip $(if $(strip $1),T))
endef

# Logic functions
# =================
# 1) not: Returns empty if arg is not empty, and not empty otherwise
# 2) eq:  Returns not empty if $1 == $2, and empty otherwise
# 3) ne:  Returns not empty if $1 != $2, and empty otherwise
define not
$(strip $(if $1,,T))
endef

define eq
$(strip $(if $(or $(strip $1),$(strip $2)),\
    $(if $(filter $(subst $(space),,$1),$(subst $(space),,$2)),T),T))
endef

define ne
$(strip $(call not,$(call eq,$1,$2)))
endef

# List manipulation functions
# =============================
# 1) car:    Gets first element of a list
# 2) cdr:    Gets all but firs element of a list
# 3) rcar:   Gets last element of a list
# 4) rcdr:   Gets all but last element of a list
# 5) invert: Inverts a list
define car
$(strip $(firstword $(strip $1)))
endef

define cdr
$(strip $(wordlist 2,$(words $(strip $1)),$(strip $1)))
endef

define rcar
$(strip $(lastword $(strip $1)))
endef

define rcdr
$(if $(strip $1),$(strip $(patsubst %.word,%,\
    $(patsubst %.word.last,,$(strip $(addsuffix .word,$1)).last))))
endef

define invert
$(if $(strip $1),\
    $(call invert,$(wordlist 2,$(words $1),$1))) $(firstword $1)
endef

# Numeric classification functions
# ==================================
# 1) is-numeric:  Returns not empty if $1 matches [0-9]*
# 2) is-positive: Returns not empty if $1 matches -[0-9]*
# 3) is-negative: Returns not empty if $1 matches +?[0-9]*
# 4) is-integer:  Returns not empty if $1 matches [+-]?[0-9]*
# 5) is-decimal:  Returns not empty if $1 matches [+-]?[1-9]?[0-9]*

define rm-number
$(strip $(subst 0,,$(subst 1,,$(subst 2,,$(subst 3,,$(subst 4,,\
        $(subst 5,,$(subst 6,,$(subst 7,,$(subst 8,,$(subst 9,,\
        $(strip $1))))))))))))
endef

define is-numeric
$(if $(call rm-number,$1),,T)
endef

define is-negative
$(if $(and $(call is-numeric,$1),$(filter -%,$1)),T)
endef

define is-positive
$(call not,$(call is-negative,$(patsubst +%,%,$1)))
endef

define is-integer
$(if $(and $(call is-numeric,$1),$(strip \
           $(or $(call is-positive,$1),$(call is-negative,$1))\
)),T)
endef

define is-decimal
$(if $(and $(call not,$(filter 0%,$1)),$(call is-integer,$1)),T)
endef

# Numeric comparison functions
# ==============================
# 1) gt: Returns not empty if $1 is greater than $2
# 2) lt: Returns not empty if $1 is less than $2
# 3) ge: Returns not empty if $1 is greater or equal than $2
# 4) le: Returns not empty if $1 is less or equal than $2

define cmp-factory
lt_$(word 1,$(subst -, ,$1))_$(word 2,$(subst -, ,$1)) := T
gt_$(word 2,$(subst -, ,$1))_$(word 1,$(subst -, ,$1)) := T
endef
$(foreach p,\
    0-1 0-2 0-3 0-4 0-5 0-6 0-7 0-8 0-9 1-2 1-3 1-4 1-5 1-6 1-7 1-8   \
    1-9 2-3 2-4 2-5 2-6 2-7 2-8 2-9 3-4 3-5 3-6 3-7 3-8 3-9 4-5 4-6   \
    4-7 4-8 4-9 5-6 5-7 5-8 5-9 6-7 6-8 6-9 7-8 7-9 8-9,              \
    $(eval $(call cmp-factory,$p)))

define expand
$(subst 0,0 ,$(subst 1,1 ,$(subst 2,2 ,$(subst 3,3 ,$(subst 4,4 ,\
    $(subst 5,5 ,$(subst 6,6 ,$(subst 7,7 ,$(subst 8,8 ,$(subst 9,9 ,$1)\
)))))))))
endef

define gt_impl
$(if $(strip $1),$(if $(strip $2),\
    $(if $(gt_$(call car,$1)_$(call car,$2)),T,\
        $(call gt_impl,$(call cdr,$1),$(call cdr,$2))),T))
endef

define gt
$(strip $(if \
    $(call eq,$(words $(call expand,$1)),$(words $(call expand,$2))),\
    $(call gt_impl,\
        $(call invert,$(call expand,$1)),  \
        $(call invert,$(call expand,$2))), \
    $(call gt_impl,\
        $(call invert,$(call expand,$(words $1))), \
        $(call invert,$(call expand,$(words $2)))) \
))
endef

define ge
$(or $(call eq,$1,$2),$(call gt,$1,$2))
endef

define lt
$(if $(call eq,$(call ge,$1,$2),T),,T)
endef

define le
$(or $(call eq,$1,$2),$(call lt,$1,$2))
endef

# Arithmetic functions
# ======================
# 1) oppose:    Returns -$1 if $1 >= 0, or $1 otherwise
# 2) add:       Returns sum of $1 and $2
# 3) increment: Returns sum of $1 with 1

define oppose
$(if $(call is-negative,$1),$(patsubst -%,%,$1),-$1)
endef

define add_impl
$(if $(strip $1 $2 $3),\
    $(foreach n,$(words $(n$(or $(call rcar,$1),0)) \
                        $(n$(or $(call rcar,$2),0)) \
                        $(n$(or $(call rcar,$3),0))),\
        $(if $(call eq,1,$(words $(call expand,$n))),\
            $n $(call add_impl,$(call rcdr,$1),$(call rcdr,$2)),\
            $(lastword $(call expand,$n)) $(call add_impl,\
                $(call rcdr,$1),$(call rcdr,$2),\
                    $(firstword $(call expand,$n)))\
)))
endef

define add
$(strip $(subst $(space),,$(call invert,\
    $(call add_impl,$(call expand,$1),$(call expand,$2)))))
endef

define increment
$(call add,$1,1)
endef

# Lexical functions
# ===================
# 1) lc: Returns $1 with lowecase letters only
# 2) uc: Returns $1 with uppercase letters only

define lc
$(strip $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,\
        $(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,\
        $(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,\
        $(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,\
        $(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,\
        $(subst Z,z,$(strip $1))))))))))))))))))))))))))))
endef

define uc
$(strip $(subst a,A,$(subst b,B,$(subst c,C,$(subst d,D,$(subst e,E,\
        $(subst f,F,$(subst g,G,$(subst h,H,$(subst i,I,$(subst j,J,\
        $(subst k,K,$(subst l,L,$(subst m,M,$(subst n,N,$(subst o,O,\
        $(subst p,P,$(subst q,Q,$(subst r,R,$(subst s,S,$(subst t,T,\
        $(subst u,U,$(subst v,V,$(subst w,W,$(subst x,X,$(subst y,Y,\
        $(subst z,Z,$(strip $1))))))))))))))))))))))))))))
endef

# Lexical comparison functions
# ==============================
# 1) lexical-eq: Returns not empty if $1 is equal to $2
# 2) lexical-ne: Returns not empty if $1 is not equal to $2
# 3) lexical-gt: Returns not empty if $1 is greater than $2
# 4) lexical-lt: Returns not empty if $1 is less than $2
# 5) lexical-ge: Returns not empty if $1 is greater or equal than $2
# 6) lexical-le: Returns not empty if $1 is less or equal than $2

define lexical-eq
$(call eq,$1,$2)
endef

define lexical-ne
$(call ne,$1,$2)
endef

define lexical-gt
$(strip $(if $(strip $1),$(if $(strip $2),\
    $(if $(call lexical-ne,\
             $(firstword $(sort $(call car,$1) $(call car,$2))),\
             $(call car,$1)),\
        T,$(call lexical-gt,$(call cdr,$1),$(call cdr,$2))\
    ),T\
)))
endef

define lexical-ge
$(or $(call lexical-eq,$1,$2),$(call lexical-gt,$1,$2))
endef

define lexical-lt
$(if $(call lexical-eq,$(call lexical-ge,$1,$2),T),,T)
endef

define lexical-le
$(or $(call lexical-eq,$1,$2),$(call lexical-lt,$1,$2))
endef

# Lexical classification functions
# ==================================
# 1) is-lower:        Returns not empty if $1 matches [a-z]*
# 2) is-upper:        Returns not empty if $1 matches [A-Z]*
# 3) is-alpha:        Returns not emtpy if $1 matches [A-Za-z]*
# 4) is-alphanumeric: Returns not empty if $1 matches [A-Za-z0-9]*
# 5) is-identifier:   Returns not empty if $1 matches [A-Za-z0-9_]*

define rm-lower
$(strip $(subst a,,$(subst b,,$(subst c,,$(subst d,,$(subst e,,\
        $(subst f,,$(subst g,,$(subst h,,$(subst i,,$(subst j,,\
        $(subst k,,$(subst l,,$(subst m,,$(subst n,,$(subst o,,\
        $(subst p,,$(subst q,,$(subst r,,$(subst s,,$(subst t,,\
        $(subst u,,$(subst v,,$(subst w,,$(subst x,,$(subst y,,\
        $(subst z,,$(strip $1))))))))))))))))))))))))))))
endef

define rm-upper
$(strip $(subst A,,$(subst B,,$(subst C,,$(subst D,,$(subst E,,\
        $(subst F,,$(subst G,,$(subst H,,$(subst I,,$(subst J,,\
        $(subst K,,$(subst L,,$(subst M,,$(subst N,,$(subst O,,\
        $(subst P,,$(subst Q,,$(subst R,,$(subst S,,$(subst T,,\
        $(subst U,,$(subst V,,$(subst W,,$(subst X,,$(subst Y,,\
        $(subst Z,,$(strip $1))))))))))))))))))))))))))))
endef

define is-lower
$(if $(call is-empty,$(call rm-upper,$1)),T)
endef

define is-upper
$(if $(call is-empty,$(call rm-lower,$1)),T)
endef

define is-alpha
$(if $(call is-empty,$(call rm-upper,$(call rm-lower,$1))),T)
endef

define is-alphanumeric
$(if $(call is-empty,$(strip \
    $(call rm-number,$(call rm-upper,$(call rm-lower,$1))))),T)
endef

define is-identifier
$(call is-alphanumeric,$(subst _,,$1))
endef

# Version comparison functions
# ==============================
# 1) version-eq: Returns not empty if $1 is equal to $2
# 2) version-ne: Returns not empty if $1 is not equal to $2
# 3) version-gt: Returns not empty if $1 is greater than $2
# 4) version-lt: Returns not empty if $1 is less than $2
# 5) version-ge: Returns not empty if $1 is greater or equal than $2
# 6) version-le: Returns not empty if $1 is less or equal than $2

define version-eq
$(call eq,$(firstword $(subst +, ,$1)),$(firstword $(subst +, ,$2)))
endef

define version-ne
$(call ne,$(firstword $(subst +, ,$1)),$(firstword $(subst +, ,$2)))
endef

define version-gt_impl
$(strip $(if $(strip $1),$(if $(strip $2),\
    $(if $(and $(call is-numeric,$1),$(call is-numeric,$2)),\
        $(if $(call gt,$(call car,$1),$(call car,$2)),T,\
            $(if $(call eq,$(call car,$1),$(call car,$2)),\
                $(call version-gt_impl,$(call cdr,$1),$(call cdr,$2)))),\
        $(if $(call lexical-gt,$(call car,$1),$(call car,$2)),T,\
            $(if $(call lexical-eq,$(call car,$1),$(call car,$2)),\
                $(call version-gt_impl,$(call cdr,$1),$(call cdr,$2))))\
    ),T\
)))
endef

define version-gt
$(strip $(if \
    $(strip $(call version-gt_impl,\
        $(subst ., ,$(call car,$(subst -, ,$(word 1,$(subst +, ,$1))))),\
        $(subst ., ,$(call car,$(subst -, ,$(word 1,$(subst +, ,$2)))))\
    )),\
    T,$(strip $(call version-gt_impl,\
        $(subst ., ,$(call cdr,$(subst -, ,$(word 1,$(subst +, ,$1))))),\
        $(subst ., ,$(call cdr,$(subst -, ,$(word 1,$(subst +, ,$2)))))\
    ))\
))
endef

define version-ge
$(or $(call version-eq,$1,$2),$(call version-gt,$1,$2))
endef

define version-lt
$(if $(call version-eq,$(call version-ge,$1,$2),T),,T)
endef

define version-le
$(or $(call version-eq,$1,$2),$(call version-lt,$1,$2))
endef

# Semantic versioning
# =====================
# 1) version-data:        Returns version without metadata
# 2) version-release:     Returns release numbers (X.Y.Z)
# 3) version-major:       Returns major version (X)
# 4) version-minor:       Returns minor version (Y)
# 5) version-patch:       Returns patch version (Z)
# 6) version-pre-release: Returns pre-release strings
# 7) version-metadata:    Returns metadata
# 8) version-check:       Verifies if $1 follows semantic versioning

define version-data
$(strip $(firstword $(subst +, ,$(strip $1))))
endef

define version-release
$(strip $(firstword $(subst -, ,$(call version-data,$1))))
endef

define version-major
$(strip $(word 1,$(subst ., ,$(call version-release,$(strip $1)))))
endef

define version-minor
$(strip $(word 2,$(subst ., ,$(call version-release,$(strip $1)))))
endef

define version-patch
$(strip $(word 3,$(subst ., ,$(call version-release,$(strip $1)))))
endef

define version-pre-release
$(strip $(patsubst -%,%,$(patsubst $(call version-release,$1)%,%,\
    $(call version-data,$1))))
endef

define version-metadata
$(strip $(patsubst +%,%,$(patsubst $(call version-data,$1)%,%,\
    $(strip $1))))
endef

define version-check
$(if $(call is-empty,$(strip $1)),\
    $(error "Version MUST NOT be empty"))\
$(if $(call ne,1,$(words $(strip $1))),\
    $(error "Version MUST NOT have spaces"))\
$(if $(call lt,2,$(words $(subst +, ,$1))),\
    $(error "Version MUST have just one + separating version/metadata"))\
$(if $(call ne,3,$(words $(subst ., ,$(call version-release,$1)))),\
    $(error "Version MUST be on the form X.Y.Z"))\
$(if $(call is-numeric,$(call version-major,$1)),,\
    $(error "Major version (X.y.z) MUST be a non-negative number"))\
$(if $(call is-numeric,$(call version-minor,$1)),,\
    $(error "Minor version (x.Y.z) MUST be a non-negative number"))\
$(if $(call is-numeric,$(call version-patch,$1)),,\
    $(error "Patch version (x.y.Z) MUST be a non-negative number"))\
$(if $(call eq,-,$(subst $(call version-release,$1),,$1)),\
    $(error "Version MUST NOT have an empty pre-release after -"))\
$(foreach p,$(subst ., ,$(call version-pre-release,$1)),\
    $(if $(call is-alphanumeric,$(subst -,,$p)),,\
        $(error "Pre-release '$p' MUST be ASCII alphanumeric and -")))\
$(if $(call eq,+,$(subst $(call version-data,$1),,$1)),\
    $(error "Version MUST NOT have an empty metadata after +"))\
$(if $(call is-alphanumeric,$(subst -,,$(call version-metadata,$1))),,\
    $(error "Metadata MUST be ASCII alphanumeric and hyphen"))
endef

# Semantic versioning update
# ============================
# 1) inc-major:     Increments major version (X)
# 2) inc-minor:     Increments minor version (Y)
# 3) inc-patch:     Increments patch version (Z)
# 4) inc-alpha:     Increments to alpha version pre-release
# 5) inc-beta:      Increments to beta version pre-release
# 6) add-timestamp: Add timestamp as metadata
# 7) inc-version:   Increment version accordingly to arguments

define inc-major
$(subst $(space),,$(call increment,$(call version-major,$1)).0.0)
endef

define inc-minor
$(subst $(space),,$(call version-major,$1)\
                  .$(call increment,$(call version-minor,$1)).0)
endef

define inc-patch
$(subst $(space),,$(call version-major,$1)\
                  .$(call version-minor,$1)\
                  .$(call increment,$(call version-patch,$1)))
endef

define inc-alpha
$(subst $(space),,$(call version-major,$1)\
                  .$(call version-minor,$1)\
                  .$(call version-patch,$1)-alpha)
endef

define inc-beta
$(subst $(space),,$(call version-major,$1)\
                  .$(call version-minor,$1)\
                  .$(call version-patch,$1)-beta)
endef

define add-timestamp
$(subst $(space),,$(call version-major,$1)\
                  .$(call version-minor,$1)\
                  .$(call version-patch,$1)\
                  $(addprefix -,$(call version-pre-release,$1))\
                  +$(shell date +%Y-%m-%d-%H-%M-%S))
endef

define inc-version
$(foreach v,$(firstword \
    $(if $(call eq,$2,major),$(call inc-major,$1)) \
    $(if $(call eq,$2,minor),$(call inc-minor,$1)) \
    $(if $(call eq,$2,patch),$(call inc-patch,$1)) \
    ),$(foreach u,$(firstword \
        $(if $(call eq,$3,alpha),$(call inc-alpha,$v))    \
        $(if $(call eq,$3,beta),$(call inc-beta,$v)) $v), \
            $(if $(call eq,$4,timestamp),$(call add-timestamp,$u),$u)))
endef

# String manipulation functions
# ===============================
# 1) join-strings: Create a single string from separated ones

define quote-factory
define join-$1-strings
$$(foreach w,$$1,$$(strip \
    $$(call join-$1-strings_impl,\
        $$(call rcdr,$$(subst \$$($1),$$(space),$$w))\
    ))$$(strip \
    $$(subst $$($1),,$$(call rcar,$$(subst \$$($1),$$(space),$$w)))))
endef

define join-$1-strings_impl
$$(strip $$(if $$(strip $$1),$$(strip \
    $$(subst $$($1),,$$(call car,$$1))\$$($1))$$(strip \
    $$(call join-$1-strings_impl,$$(call cdr,$$1)))$$(strip \
)))
endef
endef
$(foreach q,squote dquote,$(eval $(call quote-factory,$q)))

define join-strings
$(if $(findstring $(squote),$(subst \$(squote),,$1)),$(strip \
    $(if $(findstring $(dquote),$(subst \$(squote),,$1)),$(strip \
        "$(call join-squote-strings,$(strip \
             $(call join-dquote-strings,$1)))"),$(strip \
        '$(call join-squote-strings,$1)'))),$(strip \
    $(if $(findstring $(dquote),$(subst \$(squote),,$1)),$(strip \
        "$(call join-dquote-strings,$1)"),$(strip \
        $1))))
endef

# Path manipulation functions
# =============================
# 1) root: Gets the root directory (first in the path) of a path or file
# 2) not-root: Given a path or file, take out the root directory of it
# 3) rm-trailing-bar: Removes the last / of a directory-only name
# 4) expand-path: Get path from a partial name

define root
$(strip $(foreach s,$1,$(or $(strip \
    $(lastword $(sort $(foreach d,$(alldir),\
        $(if $(filter $d/%,$1),$d))))),$(strip \
    $(if $(findstring /,$s),\
        $(call root,$(patsubst %/,%,$(dir $s))),$(strip $s)))\
)))
endef

define not-root
$(strip $(foreach s,$1,\
    $(patsubst $(strip $(call root,$s))/%,%,$s)))
endef

define rm-trailing-bar
$(strip $(foreach s,$1,\
    $(patsubst %/,%,$(patsubst %/.,%/,$(subst ./,,$s)))))
endef

# .---.-----.------.-----.--------.---------------------------------.
# | # | dir | base | ext | STATUS |             ACTION              |
# |===|=====|======|=====|========|=================================|
# | 0 |     |      |     | Ok     | None                            |
# | 1 |  X  |      |     | Warn   | Correct to fall in case #4      |
# | 2 |     |  X   |     | Ok     | Match all bases with this dir   |
# | 3 |     |      |  X  | Warn   | Treaded as hidden dir in #4     |
# | 4 |  X  |  X   |     | Ok     | Find base in this dir           |
# | 5 |  X  |      |  X  | Warn   | Treated as hidden dir in #4     |
# | 6 |     |  X   |  X  | Ok     | Find all bases with this ext    |
# | 7 |  X  |  X   |  X  | Ok     | Find the specific file          |
# '---'-----'------'-----'--------'---------------------------------'
# Examples: 1: test1/  2: test2 .c      4: test4/test4       5: test5/.c
#           6: test6.c 7: test7/test7.c 8: src/test8/test8.c
#
# Expand-path steps:
# 1) Case  #1 (correct to fall in case #4)
# 2) Cases #6 (path witout root) and #7 (all path);
# 3) Case  #2 (path without file);
# 4) Case  #4 (path with file without extension);
define expand-path
$(strip $(sort $(foreach p,$(call rm-trailing-bar,$1),$(or \
    $(strip $(foreach s,$2,\
        $(if $(findstring $p,$s),$(filter %$p,$s))\
    )),\
    $(strip $(foreach r,$3,\
        $(firstword $(sort $(foreach s,$(call rsubdir,$r),\
            $(if $(findstring $p,$s),$s)\
    ))))),\
    $(strip $(foreach s,$2,$(if $(findstring $p,$s),$s)))\
))))
endef

# Suffix manipulation functions
# ===============================
# 1) abs-basename: Extracts all but all suffixes from file names in $1
# 2) all-suffix: Extracts all suffixes from file names in $1
# 3) extra-suffix: Extracts all but basename with first suffix
# 4) not-extra-suffix: Extracts basename with first suffix

define abs-basename_impl
$(strip $(if $(call is-empty,$(basename $1)),,\
    $(if $(call eq,$(basename $1),$1),\
        $1,$(call abs-basename_impl,$(basename $1)))))
endef

define abs-basename
$(strip $(foreach w,$1,$(call abs-basename_impl,$w)))
endef

define all-suffix_impl
$(if $(call abs-basename_impl,$1),\
    $(foreach p,$(call abs-basename_impl,$1),$(patsubst $p%,%,$1)),$1)
endef

define all-suffix
$(strip $(foreach w,$1,$(call all-suffix_impl,$1)))
endef

define suffix-list
$(strip $(subst ., ,$(call all-suffix,$1)))
endef

define extra-suffix
$(strip .$(call all-suffix,$(patsubst .%,%,$(call all-suffix,$1))))
endef

define not-extra-suffix
$(strip $(foreach w,$1,\
    $(call abs-basename,$w).$(firstword $(call suffix-list,$w))))
endef

# File identification functions
# ===============================
# 1) has-c: Figures out if there are C files in $1
# 2) has-f: Figures out if there are Fortran files in $1
# 3) has-cxx: Figures out if there are C++ file in $1
# 4) has-c-main: Figures out if there are C 'main' in $1
# 5) has-f-main: Figures out if there are Fortran 'program' in $1
# 6) has-cxx-main: Figures out if there are C++ 'main' in $1

define has-c
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
                 $(if $(filter $s,$(cext)),$s))),T)
endef

define has-f
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
                 $(if $(filter $s,$(fext)),$s))),T)
endef

define has-cxx
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
                 $(if $(filter $s,$(cxxext)),$s))),T)
endef

define has-c-main
$(if $(call has-c,$1),$(strip \
    $(if $(shell cat $1 | sed 's/a/aA/g; s/__/aB/g; s/#/aC/g' \
                        | $(CC) -P -E - \
                        | sed 's/aC/#/g; s/aB/__/g; s/aA/a/g' \
                        | grep "^\ *int \+main *(.*)"),T)))
endef

define has-f-main
$(if $(call has-f,$1),$(strip \
    $(if $(shell cat $1 | grep -i "^program"),T)))
endef

define has-cxx-main
$(if $(call has-cxx,$1),$(strip \
    $(if $(shell cat $1 | sed 's/a/aA/g; s/__/aB/g; s/#/aC/g' \
                        | $(CXX) -P -E - \
                        | sed 's/aC/#/g; s/aB/__/g; s/aA/a/g' \
                        | grep "^\ *int \+main *(.*)"),T)))
endef

define has-main
$(if $(or $(strip \
         $(call has-c-main,$s)),$(strip \
         $(call has-f-main,$s)),$(strip \
         $(call has-cxx-main,$s))),T)
endef

# Language precedence functions
# ===============================
# 1) choose-comment: Choose comment for files in $1
# 2) choose-compiler: Choose compiler for files in $1

define choose-comment
$(strip $(lastword \
    $(if $(call has-c,$1),F)\
    $(if $(call has-f,$1),C)\
    $(if $(call has-cxx,$1),CXX)))
endef

define choose-compiler
$(strip $(lastword \
    $(if $(call has-c,$1),$(CC))\
    $(if $(call has-f,$1),$(FC))\
    $(if $(call has-cxx,$1),$(CXX))))
endef

# Auxiliar recursive functions
# ==============================
# 1) rsubdir:     For listing all subdirectories of a given dir
# 2) rwildcard:   For wildcard deep-search in the directory tree
# 3) rfilter:     For filtering a list of text from another list
# 4) rfilter-out: For filtering out a list of text from another list
rsubdir     = $(strip $(foreach d,$1,$(shell $(FIND) $d $(FINDFLAGS))))
rwildcard   = $(strip $(if $(strip $(wildcard $1/*)),\
                  $(foreach d,$(wildcard $1/*),$(call rwildcard,$d,$2)),\
                  $(if $(wildcard $1*),$(filter $(subst *,%,$2),$1))))
rfilter     = $(strip $(if $(strip $1),\
                 $(call rfilter,$(call cdr,$1),$2)\
                 $(filter $(call car,$1),$2)))
rfilter-out = $(strip $(if $(strip $1),\
                 $(call rfilter-out,\
                     $(call cdr,$1),\
                     $(filter-out $(call car,$1),$2)),\
                 $(sort $2)))

########################################################################
##                           DATA STRUCTURES                          ##
########################################################################

# Hash Table
# ============
# 1) hash-table.new:      Creates a hash table with elements accessible
#                         by hash-table.key and a list of keys
#                         hash-table.keys
# 2) hash-table.new_impl: Implements recursion for hash-table.new
# 3) hash-table.keys:     Returns the list of keys of hash-table $1
# 4) hash-table.values:   Returns the list of values of hash-table $1

define hash-table.new
$(call hash-table.new_impl,$(strip $1),$($(strip $1)))
endef

define hash-table.new_impl
$(if $(strip $2),$(or\
  $(if $(strip $(subst =>,,$(strip $(wordlist 2,2,$2)))),\
    $(error "Hash separator must be a => at variable '$1'")\
  ),\
  $(eval $1.__keys += $(firstword $2)),\
  $(eval $1.$(firstword $2) := 0),\
  $(strip $(foreach w,$(wordlist 3,$(words $2),$2),\
    $(if $(strip $(filter 0,$(firstword $($1.$(firstword $2))))),\
      $(if $(call eq,=>,$w),\
        $(eval $1.$(firstword $2) := \
          $(call rcdr,$($1.$(firstword $2))))\
        $(eval $1.$(firstword $2) := \
          $(words $(call cdr,$($1.$(firstword $2))))\
          $(call cdr,$($1.$(firstword $2)))\
        ),\
        $(eval $1.$(firstword $2) += $w)\
        $(if $(strip $(filter %$(comma),$w)),\
          $(eval $1.$(firstword $2) := \
            $(words $(call cdr,$($1.$(firstword $2))))\
            $(call cdr,$($1.$(firstword $2)))\
          )\
        )\
      )\
    )\
  )),\
  $(eval $1.$(firstword $2) := \
    $(call cdr,$($1.$(strip $(firstword $2)))))\
  $(call hash-table.new_impl,$1,\
    $(wordlist $(words a a a $($1.$(firstword $2))),$(words $2),$2)\
    $(eval $1.$(firstword $2) := \
        $(patsubst %$(comma),%,$($1.$(firstword $2))))\
  )\
))
endef

define hash-table.keys
$(strip $($(strip $1).__keys))
endef

define hash-table.values
$(strip $(foreach k,$(call hash-table.keys,$1),$($1.$k)))
endef

########################################################################
##                       USER INPUT VALIDATION                        ##
########################################################################

# Project settings
# ==================
project       := $(strip $(PROJECT))
first_version := $(strip $(VERSION))
version       := $(strip $(or $(version),$(first_version)))
deb_version   := $(subst $(space),,\
                      $(call version-major,$(version))\
                     .$(call version-minor,$(version))\
                     -$(call version-patch,$(version)))

$(call version-check,$(version))
export version

# Package info
# ==================
auxfiles        := $(strip $(AUXFILES))
mainteiner_name := $(strip $(MAINTEINER_NAME))
mainteiner_mail := $(strip $(MAINTEINER_MAIL))
copyright       := $(strip $(COPYRIGHT))
synopsis        := $(strip $(SYNOPSIS))
description     := $(strip $(DESCRIPTION))

# Debian package
# ==================
deb_project     := $(strip $(DEB_PROJECT))
deb_priority    := $(strip $(DEB_PRIORITY))

# Platform info
# ===============
plat_kernel  := $(strip $(PLAT_KERNEL))
plat_arch    := $(strip $(PLAT_ARCH))
plat_os      := $(strip $(PLAT_OS))
plat_release := $(strip $(PLAT_RELEASE))
plat_proc    := $(strip $(PLAT_PROC))
plat_version := $(strip $(PLAT_VERSION))

# Native Language Support
# =========================
ifndef ENABLE_NLS
ENABLE_NLS := $(strip $(and $(foreach s,$(sysincdir),\
                  $(foreach i,$(NLSREQINC),$(wildcard $s$i))),$(strip \
                  $(or $(strip $(filter translation,$(MAKECMDGOALS))),\
                       $(sort $(patsubst %,T,$(strip $(call rwildcard,\
                           $(localedir),$(addprefix *,$(potext))))))\
                  ))\
              ))
endif

# Documentation
# ===============
license      := $(strip $(firstword $(wildcard $(LICENSE))))
notice       := $(strip $(firstword $(wildcard $(NOTICE))))
contributors := $(strip $(firstword $(wildcard $(CONTRIBUTORS))))
doxyfile     := $(strip $(firstword $(DOXYFILE)))

# Compilation flags
# ===================
# Redefine flags to avoid conflict with user's local definitions
cppflags    := $(CPPFLAGS)
asflags     := $(ASFLAGS)
cflags      := $(CFLAGS)
fflags      := $(FFLAGS)
cxxflags    := $(CXXFLAGS)

arflags     := $(ARFLAGS)
shrflags    := $(SHRFLAGS)

lexflags    := $(LEXFLAGS)
yaccflags   := $(YACCFLAGS)
esqlflags   := $(ESQLFLAGS)
covflags    := $(COVFLAGS)
findflags   := $(FINDFLAGS)
ctagsflags  := $(CTAGSFLAGS)
etagsflags  := $(ETAGSFLAGS)
makeflags   := $(MAKEFLAGS)

calflags    := $(CALFLAGS)
falflags    := $(FALFLAGS)
cxxalflags  := $(CXXALFLAGS)

cslflags    := $(CSLFLAGS)
fslflags    := $(FSLFLAGS)
cxxslflags  := $(CXXSLFLAGS)

cppcovflags := $(CPPCOVFLAGS)
ccovflags   := $(CCOVFLAGS)
fcovflags   := $(FCOVFLAGS)
cxxcovflags := $(CXXCOVFLAGS)

# Linker flags
# ==============
# Redefine flags to avoid conflict with user's local definitions
ldflags    := $(LDFLAGS)
ldas       := $(LDAS)
ldc        := $(LDC)
ldf        := $(LDF)
ldcxx      := $(LDCXX)

ldshr      := $(LDSHR)

ldlex      := $(LDLEX)
ldyacc     := $(LDYACC)
ldesql     := $(LDESQL)

ldcov      := $(LDCOV)

# Paths
# =======
# Redefine flags to avoid conflict with user's local definitions
aslibs     := $(ASLIBS)
clibs      := $(CLIBS)
cxxlibs    := $(CXXLIBS)
flibs      := $(FLIBS)

lexlibs    := $(LEXLIBS)
yacclibs   := $(YACCLIBS)
esqllibs   := $(ESQLLIBS)

ldlibs     := $(LDLIBS)

# Installation directories
# ==========================
# Add prefix $(destdir)/ and transforms names in i_
destdir := $(strip $(foreach d,$(DESTDIR),$(patsubst %/,%,$d)))

$(foreach b,$(install_dirs),\
    $(if $(strip $(firstword $($b))),\
        $(eval i_$b := $(destdir)$(strip $(patsubst %/,%,$($b)))),\
        $(error "$b" must not be empty))\
)

# Directories
# =============
# No directories must end with a '/' (slash)
override srcdir    := $(call rm-trailing-bar,$(SRCDIR))
override depdir    := $(call rm-trailing-bar,$(DEPDIR))
override incdir    := $(call rm-trailing-bar,$(INCDIR))
override docdir    := $(call rm-trailing-bar,$(DOCDIR))
override debdir    := $(call rm-trailing-bar,$(DEBDIR))
override objdir    := $(call rm-trailing-bar,$(OBJDIR))
override covdir    := $(call rm-trailing-bar,$(COVDIR))
override libdir    := $(call rm-trailing-bar,$(LIBDIR))
override extdir    := $(call rm-trailing-bar,$(EXTDIR))
override srpdir    := $(call rm-trailing-bar,$(SRPDIR))
override bindir    := $(call rm-trailing-bar,$(BINDIR))
override sbindir   := $(call rm-trailing-bar,$(SBINDIR))
override execdir   := $(call rm-trailing-bar,$(EXECDIR))
override distdir   := $(call rm-trailing-bar,$(DISTDIR))
override confdir   := $(call rm-trailing-bar,$(CONFDIR))
override datadir   := $(call rm-trailing-bar,$(DATADIR))
override makedir   := $(call rm-trailing-bar,$(MAKEDIR))
override testdir   := $(call rm-trailing-bar,$(TESTDIR))
override benchdir  := $(call rm-trailing-bar,$(BENCHDIR))
override localedir := $(call rm-trailing-bar,$(LOCALEDIR))

# All directories
alldir := $(strip\
    $(srcdir) $(depdir) $(incdir) $(docdir) $(debdir) $(objdir)        \
    $(libdir) $(extdir) $(srpdir) $(bindir) $(sbindir) $(execdir)      \
    $(distdir) $(confdir) $(datadir) $(makedir) $(testdir) $(benchdir) \
    $(localedir) \
)

# Check if directory variable is non-empty
$(foreach p,src inc doc deb lib srp bin sbin exec conf data,\
    $(if $(call ge,$(words $($pdir)),1),,\
        $(error There must be at least one dir in '$pdir'.)))

# Check if directory variable has only one directory
$(foreach p,dep obj ext dist make test bench locale,\
    $(if $(call eq,$(words $($pdir)),1),,\
        $(error There must be only one dir in '$pdir'.)))

# System Directories
# ====================
# No directories must end with a '/' (slash)
override sysincdir  := $(call rm-trailing-bar,$(wildcard $(SYSINCDIR)))
override syslibdir  := $(call rm-trailing-bar,$(wildcard $(SYSLIBDIR)))
override sysbindir  := $(call rm-trailing-bar,$(wildcard $(SYSBINDIR)))
override syssbindir := $(call rm-trailing-bar,$(wildcard $(SYSSBINDIR)))
override sysexecdir := $(call rm-trailing-bar,$(wildcard $(SYSEXECDIR)))

# Suffixes
# ==========
testsuf  := $(strip $(sort $(TESTSUF)))
ifneq ($(words $(testsuf)),1)
    $(error Just one suffix allowed for test sources!)
endif
benchsuf := $(strip $(sort $(BENCHSUF)))
ifneq ($(words $(benchsuf)),1)
    $(error Just one suffix allowed for benchmark sources!)
endif

# Extensions
# ============
# Every extension must begin with a '.' (dot)
hext    := $(strip $(sort $(HEXT)))
hfext   := $(strip $(sort $(HFEXT)))
hxxext  := $(strip $(sort $(HXXEXT)))
cext    := $(strip $(sort $(CEXT)))
fext    := $(strip $(sort $(FEXT)))
cxxext  := $(strip $(sort $(CXXEXT)))
tlext   := $(strip $(sort $(TLEXT)))
asmext  := $(strip $(sort $(ASMEXT)))
libext  := $(strip $(sort $(LIBEXT)))
arext   := $(strip $(sort $(AREXT)))
shrext  := $(strip $(sort $(SHREXT)))
lexext  := $(strip $(sort $(LEXEXT)))
lexxext := $(strip $(sort $(LEXXEXT)))
yaccext := $(strip $(sort $(YACCEXT)))
yaxxext := $(strip $(sort $(YAXXEXT)))
esqlext := $(strip $(sort $(ESQLEXT)))
depext  := $(strip $(sort $(DEPEXT)))
extext  := $(strip $(sort $(EXTEXT)))
sysext  := $(strip $(sort $(SYSEXT)))
covext  := $(strip $(sort $(COVEXT)))
repext  := $(strip $(sort $(REPEXT)))
objext  := $(strip $(sort $(OBJEXT)))
binext  := $(strip $(sort $(BINEXT)))

srpext  := $(strip $(sort $(SRPEXT)))
dataext := $(strip $(sort $(DATAEXT)))

potext  := $(strip $(sort $(POTEXT)))
poext   := $(strip $(sort $(POEXT)))
moext   := $(strip $(sort $(MOEXT)))

texiext := $(strip $(sort $(TEXIEXT)))
infoext := $(strip $(sort $(INFOEXT)))
htmlext := $(strip $(sort $(HTMLEXT)))
dviext  := $(strip $(sort $(DVIEXT)))
pdfext  := $(strip $(sort $(PDFEXT)))
psext   := $(strip $(sort $(PSEXT)))

incext := $(hext) $(hxxext) $(tlext) $(hfext)
srcext := $(cext) $(cxxext) $(fext) $(asmext)
docext := $(texiext) $(infoext) $(htmlext) $(dviext) $(pdfext) $(psext)

# Check all extensions
allext := $(strip \
    $(incext) $(srcext) $(asmext) $(libext) $(lexext) $(lexxext)   \
    $(yaccext) $(yaxxext) $(esqlext) $(depext) $(extext) $(sysext) \
    $(covext) $(repext) $(objext) $(binext) $(srpext) $(dataext)   \
    $(potext) $(poext) $(moext) $(docext) \
)
$(foreach e,$(allext),$(if $(filter .%,$e),,\
   $(error "'$e' is not a valid extension (MUST start with dot)")))

define single-extension-test
ifneq ($$(words $$($(strip $1)ext)),1)
    $$(error Just one $(strip $2) extension allowed!)
endif
endef
$(eval $(call single-extension-test,ar,static library))
$(eval $(call single-extension-test,shr,shared library))
$(eval $(call single-extension-test,dep,dependency))
$(eval $(call single-extension-test,ext,external dependency))
$(eval $(call single-extension-test,sys,system dependency))
$(eval $(call single-extension-test,obj,object))

ifneq ($(words $(binext)),1)
    $(if $(binext),$(error Just one or none binary extensions allowed!))
endif

ifdef $(call is-empty,$(findstring $(arext),$(libext)))
    $(error Static library extension must be a valid library extension)
endif

ifdef $(call is-empty,$(findstring $(shrext),$(libext)))
    $(error Shared library extension must be a valid library extension)
endif

# Define extensions as the only valid ones
.SUFFIXES:
.SUFFIXES: $(allext)

# Get all dependency prefixes for targets
targets := \
    build remote upgrade init tags lint coverage \
    translation docs doxy dist dpkg install

# Get all existent programs
programs := \
    AR AS CC FC CXX RANLIB INSTALL INSTALL_DATA INSTALL_PROGRAM CP MV  \
    RM TAR ZIP GZIP BZIP2 MKDIR RMDIR FIND LEX LEXCXX YACC YACCCXX     \
    CALINT FALINT CXXALINT CSLINT FSLINT CXXSLINT COV ESQL CTAGS ETAGS \
    DOXYGEN MAKEINFO INSTALL_INFO TEXI2HTML TEXI2DVI TEXI2PDF TEXI2PS  \
    XGETTEXT MSGINIT MSGMERGE MSGFMT DCH DEBUILD CURL GIT

phony_targets := $(targets) library git web

########################################################################
##                              PATHS                                 ##
########################################################################

# Paths
# ======
$(foreach e,.zip .tar .tgz .tbz2 .tar.gz .tar.bz2,\
    $(eval vpath %.$e $(distdir)))

# Binaries, libraries and source extensions
$(foreach e,$(libext),$(eval vpath lib%$e $(libdir)))
$(foreach s,$(srcdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))
$(foreach s,$(testdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))
$(foreach s,$(benchdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))

########################################################################
##                              FILES                                 ##
########################################################################

# Default variable names
# ========================
# fooall: complete path WITH root directories
# foosrc: complete path WITHOUT root directories
# foopat: incomplete paths WITH root directories
# foolib: library names WITHOUT root directories

# Auxiliar Files
# ================
# 1) Configuration files to store status of executed command
statusfile := $(MAKECURRENTDIR)/.status.mk

# Configuration Files
# =====================
# 1) Configuration files used to change the Makefile behavior
# 2) Dependencies needed to Makefile submodule
#------------------------------------------------------------------[ 1 ]
make_configs := $(auxfiles) $(license) $(notice) $(contributors)
make_configs += $(confdir) $(makedir)
make_configs += Config.mk config.mk Config_os.mk config_os.mk
make_configs := $(sort $(foreach f,$(make_configs),$(wildcard $f)))
#------------------------------------------------------------------[ 2 ]
makedep      := $(addprefix $(depdir)/,$(addsuffix $(sysext),make))

# Ignored Files
# ===============
# 1) Find complete paths for the ignored files
# 2) Define a function for filtering out the ignored files
#------------------------------------------------------------------[ 1 ]
ignore    := $(sort $(IGNORE))
ignore    := $(sort $(foreach f,$(ignore),\
                 $(foreach r,$(alldir) $(bin) $(sbin) $(libexec),\
                     $(foreach d,$(call rsubdir,$r),\
                         $(wildcard $d/$f*)\
             ))))
#------------------------------------------------------------------[ 2 ]
define filter-ignored
$(call rfilter-out,$(ignore),$1)
endef
#------------------------------------------------------------------[ 3 ]
covignore := $(sort $(COV_IGNORE))

# Flag dependency files
# =======================
# 1) Internally defined vars for flags
# 2) Make variable above a hash table
# 3) Add dependency suffix and directory
#------------------------------------------------------------------[ 1 ]
flag_dependency := \
    objall  => CPPFLAGS CPPCOVFLAGS,\
    binall  => LDFLAGS LDCOV LDLIBS,\
    asmobj  => ASFLAGS LDAS ASLIBS,\
    cobj    => CFLAGS CALFLAGS CSLFLAGS CCOVFLAGS LDC CLIBS,\
    fobj    => FFLAGS FALFLAGS FSLFLAGS FCOVFLAGS LDF FLIBS,\
    cxxobj  => CXXFLAGS CXXALFLAGS CXXSLFLAGS CXXCOVFLAGS LDCXX CXXLIBS,\
    arobj   => ARFLAGS,\
    shrobj  => SHRFLAGS LDSHR,\
    lexobj  => LEXFLAGS LDLEX LEXLIBS,\
    yaccobj => YACCFLAGS LDYACC YACCLIBS,\
    esqlobj => ESQLFLAGS LDESQL ESQLLIBS
#------------------------------------------------------------------[ 2 ]
$(call hash-table.new,flag_dependency)
#------------------------------------------------------------------[ 3 ]
flagdep := $(call hash-table.values,flag_dependency)
flagdep := $(addprefix $(depdir)/$(makedir)/,$(flagdep))
flagdep := $(addsuffix $(sysext),$(flagdep))

# External dependency files
# ===========================
# 1) git/web_dependency: Internally defined vars for dependencies
# 2) Make variables above hash tables
# 3) Create variable for all dependencies
# 4) Create variable with complete dependency paths
# 5) Paths (in first extdir) to store new dependencies
#------------------------------------------------------------------[ 1 ]
git_dependency := $(strip $(GIT_DEPENDENCY))
web_dependency := $(strip $(WEB_DEPENDENCY))
#------------------------------------------------------------------[ 2 ]
$(call hash-table.new,git_dependency)
$(call hash-table.new,web_dependency)
#------------------------------------------------------------------[ 3 ]
ext_dependency := $(call hash-table.keys,git_dependency)
ext_dependency += $(call hash-table.keys,web_dependency)
#------------------------------------------------------------------[ 4 ]
externdep := $(addsuffix $(sysext),$(ext_dependency))
externdep := $(addprefix $(depdir)/$(firstword $(extdir))/,$(externdep))
externdep := $(call invert,$(externdep))
#------------------------------------------------------------------[ 5 ]
externreq := $(addprefix $(extdir)/,$(ext_dependency))

# Program dependency files
# ==========================
# 1) Add dependency suffix and directory
#------------------------------------------------------------------[ 1 ]
progdep := $(addprefix $(depdir)/$(bindir)/,$(programs))
progdep := $(addsuffix $(sysext),$(progdep))

# Phony target dependency files (lib + extern + tgt)
# ====================================================
# 1) Add dependency suffix and directory
#------------------------------------------------------------------[ 1 ]
phonydep := $(addprefix $(depdir)/,$(phony_targets))
phonydep := $(addsuffix $(sysext),$(phonydep))

# Library files
# ===============
# 1) Remove the last / if there is a path only
# 2) Throw error If there is only a suffix.
# 3) Store libraries as being shared and static libs.
#------------------------------------------------------------------[ 1 ]
ifndef NO_ARLIBS
ar_in  := $(call rm-trailing-bar,$(ARLIB))
endif

ifndef NO_SHRLIBS
shr_in := $(call rm-trailing-bar,$(SHRLIB))
endif
#------------------------------------------------------------------[ 2 ]
$(foreach s,$(ar_in),\
    $(if $(call eq,$(suffix $s),$s),\
        $(error "Invalid argument $s in library variable ARLIB")))
$(foreach s,$(shr_in),\
    $(if $(call eq,$(suffix $s),$s),\
        $(error "Invalid argument $s in library variable SHRLIB")))
#------------------------------------------------------------------[ 3 ]
lib_in := $(ar_in) $(shr_in)

# Lexical analyzers
# ===================
# 1) Get language-specifid lexical analyzers
# 2) Find in a directory tree all the lex files (with dir names)
# 3) Filter out ignored files from above
# 4) Split C++ and C lexers (to be compiled appropriately)
# 5) Change lex extension to .yy.c or .yy.cc (for C/C++ lexers)
#    and join all the C and C++ lexer source names
# 6) Create lex scanners default directories for headers
# 7) Add default header directories for lexer compilation
#------------------------------------------------------------------[ 1 ]
cxxlexer := $(CXXLEXER)
#------------------------------------------------------------------[ 2 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(lexext) $(lexxext),\
        $(eval alllexer += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 3 ]
alllexer := $(call filter-ignored,$(alllexer))
#------------------------------------------------------------------[ 4 ]
cxxlexer := $(foreach e,$(lexxext),$(filter %$e,$(alllexer)))
clexer   := $(filter-out $(cxxlexer),$(alllexer))
#------------------------------------------------------------------[ 5 ]
lexall   += $(foreach E,$(lexext) $(lexxext),\
                $(patsubst %$E,%.yy.cc,$(filter %$E,$(cxxlexer))))
lexall   += $(foreach E,$(lexext) $(lexxext),\
                $(patsubst %$E,%.yy.c,$(filter %$E,$(clexer))))
lexall   := $(strip $(lexall))
#------------------------------------------------------------------[ 6 ]
lexinc   := $(call not-root,$(basename $(basename $(lexall))))
lexinc   := $(addprefix $(firstword $(incdir))/,$(lexinc))
lexinc   := $(addsuffix -yy/,$(lexinc))
#------------------------------------------------------------------[ 7 ]
lexinc   += $(if $(strip $(lexall)),$(strip $(LEXLIBS)))

# Syntatic analyzers
# ====================
# 1) Get language-specific syntatic analyzers
# 2) Find in a directory tree all the yacc files (with dir names)
# 3) Filter out ignored files from above
# 4) Split C++ and C parsers (to be compiled appropriately)
# 5) Change yacc extension to .tab.c or .tab.cc (for C/C++ parsers)
#    and join all the C and C++ parser source names
# 6) Create yacc parsers default header files
# 7) Add default header directories for parser compilation
#------------------------------------------------------------------[ 1 ]
cxxparser := $(CXXPARSER)
#------------------------------------------------------------------[ 2 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(yaccext) $(yaxxext),\
        $(eval allparser += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 3 ]
allparser := $(call filter-ignored,$(allparser))
#------------------------------------------------------------------[ 4 ]
cxxparser := $(foreach e,$(yaxxext),$(filter %$e,$(allparser)))
cparser   := $(filter-out $(cxxparser),$(allparser))
#------------------------------------------------------------------[ 5 ]
yaccall   += $(foreach E,$(yaccext) $(yaxxext),\
                $(patsubst %$E,%.tab.cc,$(filter %$E,$(cxxparser))))
yaccall   += $(foreach E,$(yaccext) $(yaxxext),\
                $(patsubst %$E,%.tab.c,$(filter %$E,$(cparser))))
yaccall   := $(strip $(yaccall))
#------------------------------------------------------------------[ 6 ]
yaccinc   := $(call not-root,$(basename $(basename $(yaccall))))
yaccinc   := $(addprefix $(firstword $(incdir))/,$(yaccinc))
yaccinc   := $(addsuffix -tab/,$(yaccinc))
#------------------------------------------------------------------[ 7 ]
yaccinc   += $(if $(strip $(yaccall)),$(strip $(YACCLIBS)))

# Embedded SQL preprocessors
# ============================
# 1) Find in a directory tree all the esql files (with dir names)
# 2) Filter out ignored files from above
# 3) Change esql extension to .c
# 4) Add default header directories for embedded SQL compilation
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(esqlext),\
        $(eval cesql += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
cesql     := $(call filter-ignored,$(cesql))
#------------------------------------------------------------------[ 3 ]
esqlall   += $(foreach E,$(esqlext),\
                $(patsubst %$E,%.c,$(filter %$E,$(cesql))))
esqlall   := $(strip $(esqlall))
#------------------------------------------------------------------[ 4 ]
esqlinc   := $(if $(strip $(esqlall)),$(strip $(ESQLLIBS)))

# Source files
# ==============
# 1) userall : Find in the dir trees all source files (with dir names)
# 2) autoall : Join automatically generated source files
# 3) liball  : Save complete paths for libraries
# 4) mainall : Save complete paths for files with 'main'/'program'
# 5) userall : Remove library and main src from user-generated src
# 5) autoall : Remove library and main src from auto-generated src
# 6) srcall  : Join all sources with complete path
# 7) usersrc : Remove root directory names from usersrc
# 7) autosrc : Remove root directory names from autoall
# 7) libsrc  : Remove root directory names from liball
# 7) mainsrc : Remove root directory names from mainall
# 7) src     : Remove root directory names from srcall
# 8) asmall  : Assembly files from srcall
# 8) call    : C files from srcall
# 8) fall    : Fortran files from srcall
# 8) cxxall  : C++ files from srcall
# 9) srcdep  : Dependency files for source files
#------------------------------------------------------------------[ 1 ]
ifneq ($(srcdir),.)
userall := $(sort $(call filter-ignored,\
               $(foreach r,$(srcdir),\
                   $(foreach e,$(srcext),\
                       $(call rwildcard,$r,*$e)\
           ))))
else
$(warning "Source directory is '.'. Deep search for source disabled")
userall := $(sort $(foreach e,$(srcext),$(wildcard *$e)))
endif
#------------------------------------------------------------------[ 2 ]
autoall := $(yaccall) $(lexall) $(esqlall)
#------------------------------------------------------------------[ 3 ]
liball  := $(foreach s,$(userall) $(autoall),\
               $(lastword $(foreach i,$(sort $(lib_in)),\
                   $(if $(findstring $i,$s),$s)\
           )))
# Give error if there is no match with the lib name
$(foreach l,$(lib_in),\
    $(if $(or $(findstring $l,$(liball)),$(call rfilter,\
                init standard nothing config gitignore,\
                $(MAKECMDGOALS))),,\
        $(error "Library file/directory '$l' not found")\
))
#------------------------------------------------------------------[ 4 ]
mainall := $(foreach s,$(userall) $(autoall),$(if $(call has-main,$s),$s))
#------------------------------------------------------------------[ 5 ]
userall := $(call rfilter-out,$(liball) $(mainall),$(userall))
autoall := $(call rfilter-out,$(liball) $(mainall),$(autoall))
#------------------------------------------------------------------[ 6 ]
srcall  := $(userall) $(autoall) $(liball) $(mainall)
#------------------------------------------------------------------[ 7 ]
usersrc := $(call not-root,$(userall))
autosrc := $(call not-root,$(autoall))
libsrc  := $(call not-root,$(liball))
mainsrc := $(call not-root,$(mainall))
src     := $(call not-root,$(srcall))
#------------------------------------------------------------------[ 8 ]
asmall  := $(call rfilter,$(addprefix %,$(asmext)),$(srcall))
call    := $(call rfilter,$(addprefix %,$(cext)),$(srcall))
fall    := $(call rfilter,$(addprefix %,$(fext)),$(srcall))
cxxall  := $(call rfilter,$(addprefix %,$(cxxext)),$(srcall))
#------------------------------------------------------------------[ 9 ]
srcdep  := $(patsubst %,$(depdir)/%$(depext),$(basename $(src)))

# Header files
# ==============
# 1) *libs   : Get headers from external variables
# 2) userinc : Get all directories able to be included
# 3) userinc : Remove empty directories in the leaves of userinc tree
# 4) autoinc : Join automatically generated include files
# 5) incall  : Get all subdirectories of the included dirs
# 6) *libs   : Add subidirectories as paths to be searched for headers
# 7) *head   : Get all language specific headers from include dirs
# 8) headall : Get all headers from include dirs
#------------------------------------------------------------------[ 1 ]
aslibs  := $(call rm-trailing-bar,$(ASLIBS))
clibs   := $(call rm-trailing-bar,$(CLIBS))
flibs   := $(call rm-trailing-bar,$(FLIBS))
cxxlibs := $(call rm-trailing-bar,$(CXXLIBS))
#------------------------------------------------------------------[ 2 ]
userinc := $(call filter-ignored,\
               $(foreach i,$(incdir),$(call rsubdir,$i)))
#------------------------------------------------------------------[ 3 ]
userinc := $(foreach i,$(sort $(userinc)),\
               $(if $(filter $i/%,$(userinc)),$i,\
                   $(if $(call not-empty,$(foreach e,$(incext),\
                            $(call rwildcard,$i,*$e))),$i)))
#------------------------------------------------------------------[ 4 ]
autoinc := $(yaccinc) $(lexinc) $(esqlinc)
#------------------------------------------------------------------[ 5 ]
incall  := $(sort $(call rm-trailing-bar,$(userinc) $(autoinc)))
#------------------------------------------------------------------[ 6 ]
aslibs  += $(patsubst %,-I$(space)%,$(incall))
clibs   += $(patsubst %,-I$(space)%,$(incall))
flibs   += $(patsubst %,-I$(space)%,$(incall))
cxxlibs += $(patsubst %,-I$(space)%,$(incall))
#------------------------------------------------------------------[ 7 ]
chead   := $(foreach d,$(incdir),$(foreach e,$(hext),\
               $(call rwildcard,$d,*$e)))
fhead   := $(foreach d,$(incdir),$(foreach e,$(hfext),\
               $(call rwildcard,$d,*$e)))
cxxhead := $(foreach d,$(incdir),$(foreach e,$(hxxext),\
               $(call rwildcard,$d,*$e)))
#------------------------------------------------------------------[ 8 ]
headall := $(chead) $(fhead) $(cxxhead)

# Type-specific library flags
# =============================
# 1) Add asm, c, f, cxx, lex, yacc and esql only flags in linker flags
$(if $(strip $(asmall)), $(eval ldflags += $(ldas)   ))
$(if $(strip $(call)),   $(eval ldflags += $(ldc)    ))
$(if $(strip $(fall)),   $(eval ldflags += $(ldf)    ))
$(if $(strip $(cxxall)), $(eval ldflags += $(ldcxx)  ))
$(if $(strip $(lexall)), $(eval ldflags += $(ldlex)  ))
$(if $(strip $(yaccall)),$(eval ldflags += $(ldyacc) ))
$(if $(strip $(esqlall)),$(eval ldflags += $(ldesql) ))

# Static libraries
# ==================
# 1) Get all source files that may be compiled to create the static lib
# 2) Get all source files from above without root directory
# 3) Get complete static library paths from all libraries
# 4) Create library simple names, without directories or extension
# 5) Create library flags, to be used with the linker
# 6) Create library names, with directories, from the source
# 7) Create one var with complete path sources for each lib above
# 8) Create one var with objects for each lib above
# 9) Create variables for all static library objects
#------------------------------------------------------------------[   ]
ifndef NO_ARLIBS
#------------------------------------------------------------------[ 1 ]
arall     := $(foreach l,$(liball),\
                 $(lastword $(foreach i,$(sort $(ar_in)),\
                    $(if $(findstring $i,$l),$l)\
             )))
#------------------------------------------------------------------[ 2 ]
arsrc     := $(call not-root,$(arall))
#------------------------------------------------------------------[ 3 ]
arpat     := $(call expand-path,$(ar_in),$(liball),$(srcdir))
#------------------------------------------------------------------[ 4 ]
arname    := $(notdir $(basename $(arpat)))
#------------------------------------------------------------------[ 5 ]
arlink    := $(addprefix -l,$(arname))
#------------------------------------------------------------------[ 6 ]
define arlib-name
$(foreach p,$(call not-root,$(basename $1)),\
    $(patsubst $(subst ./,,$(dir $p))%,\
       $(firstword $(libdir))/$(subst ./,,$(dir $p))lib%$(arext),$p))
endef
arlib     := $(call arlib-name,$(arpat))
#------------------------------------------------------------------[ 7 ]
$(foreach p,$(arpat),\
    $(eval $(call not-root,$(call arlib-name,$p))_all := \
        $(foreach l,$(liball),\
            $(if $(strip $(findstring $p,$l)),$l)\
)))
#------------------------------------------------------------------[ 8 ]
$(foreach p,$(call not-root,$(arlib)),\
    $(eval $p_obj := \
        $(addprefix $(objdir)/,$(addsuffix $(objext),\
            $(call not-root,$(basename $($p_all))))\
)))
#------------------------------------------------------------------[ 9 ]
arobj     := $(sort $(foreach p,$(arlib),$($p_obj)))
#------------------------------------------------------------------[   ]
endif # ifndef NO_ARLIBS

# Dynamic libraries
# ===================
# 1) Get all source files that may be compiled to create the shared lib
# 2) Get all source files from above without root directory
# 3) Get complete dynamic library paths from all libraries
# 4) Create library simple names, without directories or extension
# 5) Create library flags, to be used with the linker
# 6) Create library complete names, with directories, from the source
# 7) Create one var with complete path sources for each lib above
# 8) Create one var with objects for each lib above
# 9) Create variables for all dynamic library objects
#------------------------------------------------------------------[   ]
ifndef NO_SHRLIBS
#------------------------------------------------------------------[ 1 ]
shrall     := $(foreach l,$(liball),\
                  $(lastword $(foreach i,$(sort $(shr_in)),\
                     $(if $(findstring $i,$l),$l)\
              )))
#------------------------------------------------------------------[ 2 ]
shrsrc     := $(call not-root,$(shrall))
#------------------------------------------------------------------[ 3 ]
shrpat     := $(call expand-path,$(shr_in),$(liball),$(srcdir))
#------------------------------------------------------------------[ 4 ]
shrname    := $(notdir $(basename $(shrpat)))
#------------------------------------------------------------------[ 5 ]
shrlink    := $(addprefix -l,$(shrname))
#------------------------------------------------------------------[ 6 ]
define shrlib-name
$(foreach p,$(call not-root,$(basename $1)),\
    $(patsubst $(subst ./,,$(dir $p))%,\
       $(firstword $(libdir))/$(subst ./,,$(dir $p))lib%$(shrext),$p))
endef
shrlib     := $(call shrlib-name,$(shrpat))
#------------------------------------------------------------------[ 7 ]
$(foreach p,$(shrpat),\
    $(eval $(call not-root,$(call shrlib-name,$p))_all := \
        $(foreach l,$(liball),\
            $(if $(strip $(findstring $p,$l)),$l)\
)))
#------------------------------------------------------------------[ 8 ]
$(foreach p,$(call not-root,$(shrlib)),\
    $(eval $p_obj := \
        $(addprefix $(objdir)/,$(addsuffix $(objext),\
            $(call not-root,$(basename $($p_all))))\
)))
#------------------------------------------------------------------[ 9 ]
shrobj     := $(sort $(foreach p,$(shrlib),$($p_obj)))
#------------------------------------------------------------------[   ]
endif # ifndef NO_SHRLIBS

# System libraries
# ==================
# 1) System libraries used by the user
# 2) System library names, deduced from above
# 3) System library flags, to be used with the linker
# 4) System library dependencies, for finding system libraries
#------------------------------------------------------------------[ 1 ]
syslib     := \
$(foreach l,$(filter -l%,$(ldflags)),\
    $(firstword \
        $(foreach d,$(syslibdir) \
                    $(foreach s,$(syslibdir),\
                        $(filter $s%,$(patsubst -L%,%,$(ldlibs)))),\
            $(lastword $(foreach e,$(libext),\
                $(wildcard $d/lib$(patsubst -l%,%,$l)$e)))\
)))
#------------------------------------------------------------------[ 2 ]
sysname    := $(patsubst lib%,%,$(notdir $(basename $(syslib))))
#------------------------------------------------------------------[ 3 ]
syslink    := $(addprefix -l,$(sysname))
#------------------------------------------------------------------[ 4 ]
syslibdep  := $(addprefix $(depdir)/$(firstword $(libdir))/,\
                  $(addsuffix $(sysext),$(sysname)))

# Local libraries
# =================
# 1) Local libraries used by the user
# 2) Local library names, deduced from above
# 3) Local library flags, to be used with the linker
#------------------------------------------------------------------[ 1 ]
loclib     := $(foreach l,$(filter -l%,$(ldflags)),\
                  $(foreach d,$(call rsubdir,$(call cdr,$(libdir))),\
                      $(lastword $(foreach e,$(libext),\
                          $(wildcard $d/lib$(patsubst -l%,%,$l)$e)))))
#------------------------------------------------------------------[ 2 ]
locname    := $(patsubst lib%,%,$(notdir $(basename $(loclib))))
#------------------------------------------------------------------[ 3 ]
loclink    := $(addprefix -l,$(locname))

# Dependency libraries
# ==================
# 1) Dependency library names, deduced from above
# 2) Dependency library flags, to be used with the linker
#------------------------------------------------------------------[ 1 ]
depname    := $(call rfilter-out,$(name) $(sysname) $(locname),\
                  $(patsubst -l%,%,$(filter -l%,$(ldflags))))
#------------------------------------------------------------------[ 3 ]
deplink    := $(addprefix -l,$(depname))

# General libraries
# ===================
# 1) lib     : All complete library names (path/libname.ext)
# 2) libpat  : Save complete paths for libraries (non-wildcard-expanded)
# 3) libname : All library names (name)
# 3) liblink : All library flags (-lname)
# 4) ldlibs  : Get all subdirectories of the library dirs and
#              add them as paths to be searched for libraries
#------------------------------------------------------------------[ 1 ]
lib     := $(arlib) $(shrlib) $(syslib) $(loclib) $(deplib)
#------------------------------------------------------------------[ 2 ]
libpat  := $(arpat) $(shrpat)
#------------------------------------------------------------------[ 3 ]
libname := $(arname) $(shrname) $(sysname) $(locname) $(depname)
#------------------------------------------------------------------[ 4 ]
liblink := $(arlink) $(shrlink)
liblink += $(syslink) $(loclink) $(deplink)
#------------------------------------------------------------------[ 5 ]
libsub   = $(if $(strip $(lib)),\
               $(foreach d,$(libdir),$(call rsubdir,$d)))
ldlibs   = $(call rm-trailing-bar,$(LDLIBS))
ldlibs  += $(patsubst %,-L$(space)%,$(sort $(libsub)))
ldlibs  += $(sort $(patsubst -L%,-Wl$(comma)-rpath$(comma)%,\
               $(subst -L$(space),-L,\
                   $(call rm-trailing-bar,$(LDLIBS)))\
               $(addprefix -L,$(libsub))\
           ))

# Object files
# ==============
# 1) Create object file from each common source file
# 2) Create object file from each auto-generated source file
# 3) Create object file from each library source file
# 4) Create object file from each main file
# 5) Join all object files from above
define all-to-obj 
$1 := $$(addsuffix $$(firstword $$(objext)),$$(basename $2))
$1 := $$(addprefix $$(objdir)/,$$(call not-root,$$($1)))
endef
$(foreach p,asm c f cxx ar shr lex yacc esql,\
    $(eval $(call all-to-obj,$pobj,$($pall))))
#------------------------------------------------------------------[ 1 ]
userobj := $(addsuffix $(firstword $(objext)),$(basename $(usersrc)))
userobj := $(addprefix $(objdir)/,$(userobj))
#------------------------------------------------------------------[ 2 ]
autoobj := $(addsuffix $(firstword $(objext)),$(basename $(autosrc)))
autoobj := $(addprefix $(objdir)/,$(autoobj))
#------------------------------------------------------------------[ 3 ]
libobj  := $(addsuffix $(firstword $(objext)),$(basename $(libsrc)))
libobj  := $(addprefix $(objdir)/,$(libobj))
#------------------------------------------------------------------[ 4 ]
mainobj := $(addsuffix $(firstword $(objext)),$(basename $(mainsrc)))
mainobj := $(addprefix $(objdir)/,$(mainobj))
#------------------------------------------------------------------[ 5 ]
srcobj  := $(userobj) $(autoobj) $(libobj) $(mainobj)

# Internationalization
# ======================
# 1) intlall: Get all portable object files (based on their locale)
# 2) intlall: Filter out ignored files from above
# 3) intlobj: Names of corresponding machine object files
ifdef ENABLE_NLS
#------------------------------------------------------------------[ 1 ]
ifneq ($(srcdir),.)
intlall := $(sort\
    $(foreach E,$(poext),\
        $(call rwildcard,$(localedir),*$E)\
))
else
$(warning Locale directory is '.'. Deep search for translations disabled.)
intlall := $(sort\
    $(foreach E,$(poext),\
        $(wildcard *$E)\
))
endif
#------------------------------------------------------------------[ 2 ]
intlall := $(strip $(call filter-ignored,$(intlall)))
#------------------------------------------------------------------[ 3 ]
intlobj := \
$(foreach p,$(intlall),\
    $(dir $p)LC_MESSAGES/$(notdir $(basename $p))$(firstword $(moext)))
intlobj := $(strip $(intlobj))
endif

# Binaries
# ==========
# 1) Define all binary names (with extensions if avaiable)
# 2) Store binary-specific files from source, objects and libs
# 3) Store common source, objects and libs filtering the above ones
# 4) Create variables:
#    4.1) binary-name_src, for not-root binary's specific sources;
#    4.2) binary-name_all, for complete path binary's specific sources;
#    4.3) binary-name_obj, for binary's specific objects;
#    4.4) binary-name_lib, for binary's specific libraries;
#    4.5) binary-name_link, for binary's specific linker flags;
#    4.6) binary-name_has_c, to test if the binary has C files;
#    4.7) binary-name_has_f, to test if the binary has Fortran files;
#    4.8) binary-name_has_cxx, to test if the binary has C++ files;
#------------------------------------------------------------------[ 1 ]
define binary-name
$1 := $$(call rm-trailing-bar,$$(basename $2))
$1 := $$(call expand-path,$$($1),$$(basename $$(src)),$$(srcdir))
$1 := $$(addprefix $$(strip $3)/,$$($1))
$1 := $$(if $$(strip $$(binext)),$$(addsuffix $$(binext),$$($1)),$$($1))
$1 := $$(call filter-ignored,$$($1))
endef
$(eval $(call binary-name,bin,$(BIN),$(bindir)))
$(eval $(call binary-name,sbin,$(SBIN),$(sbindir)))
$(eval $(call binary-name,libexec,$(LIBEXEC),$(execdir)))

$(if $(strip $(bin) $(sbin) $(libexec)),\
    $(eval binall := $(bin) $(sbin) $(libexec)),\
    $(if $(strip $(mainall)),$(eval binall := $(bindir)/a.out))\
)
#------------------------------------------------------------------[ 2 ]
$(foreach sep,/ .,$(foreach b,$(call not-root,$(binall)),$(or\
    $(eval $b_src  += $(filter $b$(sep)%,\
                          $(usersrc) $(autosrc) $(mainsrc))),\
    $(eval $b_all  += $(sort $(call rfilter,$(addprefix %,$($b_src)),\
                          $(userall) $(autoall) $(mainall)))),\
    $(eval $b_obj  += $(filter $(objdir)/$b$(sep)%,\
                          $(userobj) $(autoobj) $(mainobj))),\
    $(eval $b_lib  += $(foreach d,$(libdir),\
                          $(filter $d/$b$(sep)%,$(lib)))),\
    $(eval $b_link += $(foreach l,$(arlink) $(shrlink),\
                          $(if $(strip $(filter %$(subst -l,,$l),\
                              $(filter $b$(sep)%,$(call not-root,\
                                  $(basename $($b_lib)))))),$l))),\
)))
#------------------------------------------------------------------[ 3 ]
define common-factory
$(call rfilter-out,$(foreach b,$(call not-root,$(binall)),$($b_$1)),$2)
endef
comsrc  := $(call common-factory,src,$(usersrc) $(autosrc) $(mainsrc))
comall  := $(call common-factory,all,$(userall) $(autoall) $(mainall))
comobj  := $(call common-factory,obj,$(userobj) $(autoobj) $(mainobj))
comlib  := $(call common-factory,lib,$(lib))
comlink := $(call common-factory,link,$(liblink))
#------------------------------------------------------------------[ 4 ]
$(foreach b,$(call not-root,$(binall)),$(or\
    $(eval $b_src     := $(comsrc)  $($b_src)  ),\
    $(eval $b_all     := $(comall)  $($b_all)  ),\
    $(eval $b_obj     := $(comobj)  $($b_obj)  ),\
    $(eval $b_lib     := $(comlib)  $($b_lib)  ),\
    $(eval $b_link    := $($b_link) $(comlink) ),\
    $(eval $b_has_c   := $(strip $(call has-c,$($b_src)))),\
    $(eval $b_has_f   := $(strip $(call has-f,$($b_src)))),\
    $(eval $b_has_cxx := $(strip $(call has-cxx,$($b_src)))),\
))

# Binary installation
# =====================
i_lib     := $(addprefix $(i_libdir)/,$(call not-root,$(lib)))
i_bin     := $(addprefix $(i_bindir)/,$(call not-root,$(bin)))
i_sbin    := $(addprefix $(i_sbindir)/,$(call not-root,$(sbin)))
i_libexec := $(addprefix $(i_libexecdir)/,$(call not-root,$(libexec)))

# Internationalization templates
# ================================
# 1) intltl:   Template files for executables
# 2) cppflags: Add definitions for internationalization
ifdef ENABLE_NLS
#------------------------------------------------------------------[ 1 ]
intltl    := \
$(foreach b,$(binall),\
    $(localedir)/$(call not-root,$b)$(firstword $(potext)))
intltl    := $(strip $(intltl))
#------------------------------------------------------------------[ 2 ]
cppflags  += -D ENABLE_NLS -D PACKAGE=\"$(PROJECT)\" \
             -D LOCALEDIR=\"$(i_localedir)\"
endif

# Automated tests
# =================
#  1) testall : Get all source files in the test directory
#  2) testall : Filter out ignored files from above
#  3) testsrc : Remove root directory names from dir paths
#  4) testobj : Create object file from each complete source
#  5) testbin : Define all binary names (with extensions if avaiable)
#  6) Store test binary-specific files from source and objects
#  7) Store common source and objects filtering the above ones
#  8) Create variables:
#     8.1) binary-name_src, for not-root test binary's sources;
#     8.2) binary-name_all, for complete path binary's sources;
#     8.3) binary-name_obj, for test binary's specific objects;
#  9) Check if test sources have test suffixes and a matching file
# 10) testdep : Dependency files for tests
# 11) testrun : Alias to execute tests, prefixing run_ and
#               substituting / for _ in $(testbin)
#------------------------------------------------------------------[ 1 ]
$(foreach e,$(srcext),\
    $(eval testall += $(call rwildcard,$(testdir),*$e)))
#------------------------------------------------------------------[ 2 ]
testall := $(call filter-ignored,$(testall))
#------------------------------------------------------------------[ 3 ]
testsrc := $(call not-root,$(testall))
#------------------------------------------------------------------[ 4 ]
testobj := $(addsuffix $(firstword $(objext)),$(basename $(testsrc)))
testobj := $(addprefix $(objdir)/$(testdir)/,$(testobj))
#------------------------------------------------------------------[ 5 ]
testbin := $(call rm-trailing-bar,$(TESTBIN))
testbin := $(foreach b,$(testbin),$(or $(strip \
               $(foreach d,$(testdir),$(wildcard $d/$b/*))),$b))
testbin := $(call not-root,$(basename $(testbin)))
testbin := $(addprefix $(strip $(bindir)/$(testdir))/,$(testbin))
testbin := $(if $(strip $(binext)),\
               $(addsuffix $(binext),$(testbin)),$(testbin))
testbin := $(call filter-ignored,$(testbin))
#------------------------------------------------------------------[ 6 ]
$(foreach t,$(call not-root,$(testbin)),$(or\
    $(eval $t_src := $(filter $(call not-root,$t)%,\
                         $(testsrc)) $(usersrc) $(autosrc)),\
    $(eval $t_all += $(sort $(call rfilter,$(addprefix %,$($t_src)),\
                         $(testall) $(userall) $(autoall)))),\
    $(eval $t_obj := $(filter $(objdir)/$(testdir)/$t%,\
                         $(testobj) $(userobj) $(autoobj)))\
))
#------------------------------------------------------------------[ 7 ]
define common-test-factory
$(call rfilter-out,$(foreach t,$(call not-root,$(testbin)),$($t_$1)),$2)
endef
comtestsrc := $(call common-test-factory,src,\
                  $(testsrc) $(usersrc) $(autosrc))
comtestall := $(call common-test-factory,all,\
                  $(testall) $(userall) $(autoall))
comtestobj := $(call common-test-factory,obj,\
                  $(testobj) $(userobj) $(autoobj))
#------------------------------------------------------------------[ 8 ]
$(foreach t,$(call not-root,$(testbin)),$(or\
    $(eval $t_src := $(comtestsrc) $($t_src)),\
    $(eval $t_src := $(comtestall) $($t_all)),\
    $(eval $t_obj := $(comtestobj) $($t_obj)),\
))
#------------------------------------------------------------------[ 9 ]
ifneq (,$(comtestsrc))
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,check test)))
$(foreach s,$(comtestsrc),\
    $(if $(filter-out %$(testsuf),$(basename $s)),\
        $(error "Test $(testdir)/$s have no suffix $(testsuf)")))
$(foreach s,$(comtestsrc),\
    $(if $(filter $(subst $(testsuf).,.,$s)%,$(src)),,\
        $(error "Test $(testdir)/$s has no matching source file")))
endif
endif
#------------------------------------------------------------------[ 10 ]
testdep := $(addprefix $(depdir)/$(testdir)/,\
               $(addsuffix $(depext),$(basename $(testsrc))))
#------------------------------------------------------------------[ 11 ]
testrun := $(addprefix run_,$(subst /,_,$(testbin)))

# Automated Benchmarks
# ======================
#  1) benchall : Get all source files in the benchmark directory
#  2) benchall : Filter out ignored files from above
#  3) benchsrc : Remove root directory names from dir paths
#  4) benchobj : Create object file from each complete source
#  5) benchbin : Define all binary names (with extensions if avaiable)
#  6) Store bench binary-specific files from source and objects
#  7) Store common source and objects filtering the above ones
#  8) Create variables:
#     8.1) binary-name_src, for bench not-root test binary's sources;
#     8.2) binary-name_all, for bench complete path binary's sources;
#     8.3) binary-name_obj, for bench binary's specific objects;
#  9) Check if bench sources have benchmark suffixes and a matching file
# 10) benchdep : Dependency files for benchmarks
# 11) benchrun : Alias to execute benchmarks, prefixing run_ and
#                substituting / for _ in $(benchdep)
#------------------------------------------------------------------[ 1 ]
$(foreach e,$(srcext),\
    $(eval benchall += $(call rwildcard,$(benchdir),*$e)))
#------------------------------------------------------------------[ 2 ]
benchall := $(call filter-ignored,$(benchall))
#------------------------------------------------------------------[ 3 ]
benchsrc := $(call not-root,$(benchall))
#------------------------------------------------------------------[ 4 ]
benchobj := $(addsuffix $(firstword $(objext)),$(basename $(benchsrc)))
benchobj := $(addprefix $(objdir)/$(benchdir)/,$(benchobj))
#------------------------------------------------------------------[ 5 ]
benchbin := $(call rm-trailing-bar,$(BENCHBIN))
benchbin := $(foreach b,$(benchbin),$(or $(strip \
               $(foreach d,$(benchdir),$(wildcard $d/$b/*))),$b))
benchbin := $(call not-root,$(basename $(benchbin)))
benchbin := $(addprefix $(strip $(bindir)/$(benchdir))/,$(benchbin))
benchbin := $(if $(strip $(binext)),\
               $(addsuffix $(binext),$(benchbin)),$(benchbin))
benchbin := $(call filter-ignored,$(benchbin))
#------------------------------------------------------------------[ 6 ]
$(foreach t,$(call not-root,$(benchbin)),$(or\
    $(eval $t_src := $(filter $(call not-root,$t)%,\
                         $(benchsrc)) $(usersrc) $(autosrc)),\
    $(eval $t_all += $(sort $(call rfilter,$(addprefix %,$($t_src)),\
                         $(benchall) $(userall) $(autoall)))),\
    $(eval $t_obj := $(filter $(objdir)/$(benchdir)/$t%,\
                         $(benchobj) $(userobj) $(autoobj)))\
))
#------------------------------------------------------------------[ 7 ]
define common-bench-factory
$(call rfilter-out,$(foreach t,$(call not-root,$(benchbin)),$($t_$1)),$2)
endef
combenchsrc := $(call common-bench-factory,src,\
                  $(benchsrc) $(usersrc) $(autosrc))
combenchall := $(call common-bench-factory,all,\
                  $(benchall) $(userall) $(autoall))
combenchobj := $(call common-bench-factory,obj,\
                  $(benchobj) $(userobj) $(autoobj))
#------------------------------------------------------------------[ 8 ]
$(foreach t,$(call not-root,$(benchbin)),$(or\
    $(eval $t_src := $(combenchsrc) $($t_src)),\
    $(eval $t_all := $(combenchsrc) $($t_all)),\
    $(eval $t_obj := $(combenchobj) $($t_obj)),\
))
#------------------------------------------------------------------[ 9 ]
ifneq (,$(combenchsrc))
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,eval benchmark)))
$(foreach s,$(combenchsrc),\
    $(if $(filter-out %$(benchsuf),$(basename $s)),\
        $(error "Benchmark $(benchdir)/$s have no suffix $(benchsuf)")))
$(foreach s,$(combenchsrc),\
    $(if $(filter $(subst $(benchsuf).,.,$s)%,$(src)),,\
        $(error "Benchmark $(benchdir)/$s has no matching source file")))
endif
endif
#------------------------------------------------------------------[ 10 ]
benchdep := $(addprefix $(depdir)/$(benchdir)/,\
                $(addsuffix $(depext),$(basename $(benchsrc))))
#------------------------------------------------------------------[ 11 ]
benchrun := $(addprefix run_,$(subst /,_,$(benchbin)))

# Lint style check
# ==================
# 1) alintrun : Alias to execute analysis lint, prefixing analysis_lint_
#               and substituting / for _ in $(benchdep)
# 2) slintrun : Alias to execute style lint, prefixing style_lint_
#               and substituting / for _ in $(benchdep)
#------------------------------------------------------------------[ 1 ]
alintrun := $(addprefix analysis_lint_,$(subst /,_,$(binall)))
alintrun += $(addprefix analysis_lint_,$(subst /,_,$(testbin)))
alintrun += $(addprefix analysis_lint_,$(subst /,_,$(benchbin)))
alintrun += $(addprefix analysis_lint_,$(subst /,_,$(arlib)))
alintrun += $(addprefix analysis_lint_,$(subst /,_,$(shrlib)))
#------------------------------------------------------------------[ 2 ]
slintrun := $(addprefix style_lint_,$(subst /,_,$(binall)))
slintrun += $(addprefix style_lint_,$(subst /,_,$(testbin)))
slintrun += $(addprefix style_lint_,$(subst /,_,$(benchbin)))
slintrun += $(addprefix style_lint_,$(subst /,_,$(arlib)))
slintrun += $(addprefix style_lint_,$(subst /,_,$(shrlib)))

# Source dependency files
# =========================
# 1) Get flag, source, test and benchmark dependencies
# 2) Get program, external and system library dependencies
# 3) Get phony target and submodule makefile dependencies
depall := $(flagdep) $(srcdep) $(testdep) $(benchdep) 
depall += $(progdep) $(externdep) $(syslibdep)
depall += $(phonydep) $(makedep)

# Coverage analysis
# ===================
# 1) Data files used to generate coverage information
# 2) Report files with coverage information
# 3) Alias to show reports, prefixing show_ and replacing / for _ above
#------------------------------------------------------------------[   ]
ifndef DEPLOY
ifdef COVERAGE
#------------------------------------------------------------------[ 1 ]
covdata      := $(foreach e,$(covext),$(addsuffix $e,\
                    $(basename $(srcobj))))
covtestdata  := $(foreach e,$(covext),$(addsuffix $e,\
                    $(basename $(testobj))))
covbenchdata := $(foreach e,$(covext),$(addsuffix $e,\
                    $(basename $(benchobj))))
#------------------------------------------------------------------[ 2 ]
covrep       := $(addprefix $(covdir)/,\
                    $(addsuffix $(firstword $(repext)),\
                        $(call not-root,$(basename $(binall)))))
covtestrep   := $(addprefix $(covdir)/,\
                    $(addsuffix $(firstword $(repext)),\
                        $(call not-root,$(basename $(testbin)))))
covbenchrep  := $(addprefix $(covdir)/,\
                    $(addsuffix $(firstword $(repext)),\
                        $(call not-root,$(basename $(benchbin)))))
#------------------------------------------------------------------[ 3 ]
covshow      := $(addprefix show_,$(subst /,_,$(covrep)))
covtestshow  := $(addprefix show_,$(subst /,_,$(covtestrep)))
covbenchshow := $(addprefix show_,$(subst /,_,$(covbenchrep)))
#------------------------------------------------------------------[   ]
endif # ifdef COVERAGE
endif # ifndef DEPLOY

# Texinfo files
# ===============
# 1) texiall: All TexInfo files with complete path
# 2) texiall: Filter out ignored files from above
# 3) texisrc: Take out root dir reference from above
# 4) Create variables:
#    4.1) texiinfo, for INFO's to be generated from TexInfo files
#    4.1) texihtml, for HTML's to be generated from TexInfo files
#    4.2) texidvi, for DVI's to be generated from TexInfo files
#    4.3) texipdf, for PDF's to be generated from TexInfo files
#    4.4) texips, for PS's to be generated from TexInfo files
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(docdir),\
    $(foreach E,$(texiext),\
        $(eval texiall += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
texiall := $(call filter-ignored,$(texiall))
#------------------------------------------------------------------[ 3 ]
texisrc := $(call not-root,$(texiall))
#------------------------------------------------------------------[ 4 ]
$(foreach doc,info html dvi pdf ps,\
    $(eval texi$(doc) := \
        $(addprefix $(firstword $(docdir))/$(doc)/,\
            $(addsuffix $(firstword $($(doc)ext)),\
                $(basename $(texisrc))\
))))

# Debian package files
# ======================
# 1) deball: debian packaging files in the default debian directory
deball := changelog compat control copyright
deball += rules source/format $(deb_project).dirs
deball := $(sort $(strip $(addprefix $(debdir)/,$(deball))))

########################################################################
##                            VERSION                                 ##
########################################################################

# Version check
# ===============
# 1) program/library_version: Internally defined vars for versions
# 2) Make variables above hash tables
# 3) Check validity of keys
# 4) Remove parentheses around version
#------------------------------------------------------------------[ 1 ]
program_version := $(strip $(PROGRAM_VERSION))
library_version := $(strip $(LIBRARY_VERSION))
#------------------------------------------------------------------[ 2 ]
$(call hash-table.new,program_version)
$(call hash-table.new,library_version)
#------------------------------------------------------------------[ 3 ]
$(foreach p,$(call hash-table.keys,program_version),\
    $(if $(call not,$(findstring $p,$(programs))),\
        $(error "$p key of PROGRAM_VERSION is not a program var name")))
#------------------------------------------------------------------[ 4 ]
$(foreach n,program library,\
    $(foreach p,$(call hash-table.keys,$n_version),\
        $(eval $n_version.$p := \
            $(patsubst $(lparentheses)%,%,\
                $(call car,$($n_version.$p)))\
            $(call cdr,$($n_version.$p)))\
        $(eval $n_version.$p := \
            $(call rcdr,$($n_version.$p))\
            $(patsubst %$(rparentheses),%,\
                $(call rcar,$($n_version.$p))))\
))

########################################################################
##                              BUILD                                 ##
########################################################################

build_dependency := \
    AR       => $(arlib),\
    AS       => $(asmall),\
    CC       => $(call),\
    FC       => $(fall),\
    CXX      => $(cxxall),\
    RANLIB   => $(arlib),\
    LEX      => $(clexer),\
    LEXCXX   => $(cxxlexer),\
    YACC     => $(cparser),\
    YACCCXX  => $(cxxparser),\
    ESQL     => $(cesql)

.PHONY: all
all: depend $(binall) $(lib)

.PHONY: depend
depend: builddep librarydep gitdep webdep

.PHONY: nothing
nothing:

########################################################################
##                                RUN                                 ##
########################################################################

.PHONY: run
run: $(filter $(addprefix %,$(EXEC)),$(binall))
	
	$(if $(call is-empty,$(EXEC)),\
		$(error EXEC not defined. Type 'make projecthelp' for info))
	
	$(if $(call is-empty,$<),\
	    $(call phony-error,$(MSG_RUN_BAD_EXEC)))
	
	$(call phony-status,$(MSG_RUN))
	$(quiet) $(call store-status,./$<) $(ERROR)
	$(call phony-ok,$(MSG_RUN))

########################################################################
##                        REMOTE REPOSITORIES                         ##
########################################################################

remote_dependency := \
    GIT      => $(and $(call not-empty,$(GIT_REMOTE_PATH)),$(strip \
                      $(call is-empty,$(NO_GIT))))

.PHONY: sync
sync: remotedep
	$(call git-pull,$(REMOTE),$(BRANCH))

.PHONY: deploy
deploy: remotedep
	$(call git-push,$(REMOTE),$(BRANCH))

########################################################################
##                             UPGRADE                                ##
########################################################################

upgrade_dependency := \
    CURL     => $(firstword $(MAKEFILE_LIST)),\
    GIT      => $(or $(filter-out undefined,$(origin NO_GIT)),T)

.PHONY: upgrade
upgrade: upgradedep
ifdef $(call not-empty,$(wildcard $(makedir)/*))
	$(call git-pull,origin,master,$(makedir))
	$(call git-add-commit,$(makedir),"Upgrade submodule $(makedir)")
else
	$(call web-clone,$(MAKERAWREMOTE),$(firstword $(MAKEFILE_LIST)))
	$(call git-add-commit,$(firstword $(MAKEFILE_LIST)),\
                          "Upgrade $(firstword $(MAKEFILE_LIST))")
endif

########################################################################
##                          INITIALIZATION                            ##
########################################################################

init_dependency := \
    GIT      => $(or $(filter-out undefined,$(origin NO_GIT)),T)

.PHONY: init
init: initdep
	$(call git-init)
	$(call git-remote-add,origin,$(GIT_REMOTE_PATH))
	
	$(if $(wildcard $(makedir)/*),\
	    $(if $(wildcard $(makedep)),,\
	        $(call touch,$(makedep))$(newline)\
	        $(call git-submodule-add,$(MAKEGITREMOTE),$(makedir))))
	
	$(call mkdir,$(srcdir))
	$(call mkdir,$(incdir))
	$(call mkdir,$(docdir))
	
	$(call make-create,config,Config.mk)
	$(call make-create,version,.version.mk)
	$(call make-create,gitignore,.gitignore)
	
	$(call git-tag,"v$(strip $(version))")
	
	$(call git-add-commit,Makefile Config.mk,\
	       "Add Makefile and Config.mk")
	$(call git-add-commit,.git[a-z]*,\
	       "Add git configuration files")
	$(call git-add-commit,.version.mk,\
	       "Add versioning control file .version.mk")

.PHONY: standard
standard: init
	$(call mv,$(objext), $(objdir),   "object")
	$(call mv,$(libext), $(libdir),   "library")
	$(call mv,$(docext), $(docdir),   "document")
	$(call mv,$(srpext), $(srpdir),   "script")
	$(call mv,$(dataext),$(datadir),  "data")
	$(call mv,$(potext), $(localedir),"portable object template")
	$(call mv,$(poext),  $(localedir),"portable object")
	$(call mv,$(moext),  $(localedir),"machine object")
	$(call mv,$(incext), $(incdir),   "header")
	$(call mv,$(srcext), $(srcdir),   "source")
	$(call mv,$(esqlext),$(srcdir),   "embedded SQL")
	$(call mv,$(lexext)  $(lexxext),$(srcdir),"lexer")
	$(call mv,$(yaccext) $(yaxxext),$(srcdir),"parser")

########################################################################
##                               TAGS                                 ##
########################################################################

tags_dependency := \
    CTAGS => ctags,\
    ETAGS => etags

.PHONY: TAGS
TAGS: tagsdep ctags etags

ctags: $(incall) $(srcall)
	$(call phony-status,$(MSG_CTAGS))
	$(quiet) $(CTAGS) $(ctagsflags) $^ -o $@ $(ERROR)
	$(call phony-ok,$(MSG_CTAGS))

etags: $(incall) $(srcall)
	$(call phony-status,$(MSG_ETAGS))
	$(quiet) $(ETAGS) $(etagsflags) $^ -o $@ $(ERROR)
	$(call phony-ok,$(MSG_ETAGS))

########################################################################
##                               TESTS                                ##
########################################################################

.PHONY: check test
check test: all $(testrun)
	$(if $(filter-out $<,$^),$(call phony-ok,$(MSG_TEST_SUCCESS)))

.PHONY: eval benchmark
eval benchmark: all $(benchrun)
	$(if $(filter-out $<,$^),$(call phony-ok,$(MSG_BENCH_SUCCESS)))

########################################################################
##                                LINT                                ##
########################################################################

ifneq (,$(call rfilter,analysis-lint lint,$(MAKECMDGOALS)))
lint_dependency += \
    CALINT   => $(call),\
    FALINT   => $(fall),\
    CXXALINT => $(cxxall)
endif

ifneq (,$(call rfilter,style-lint lint,$(MAKECMDGOALS)))
lint_dependency += \
    CSLINT   => $(call),\
    FSLINT   => $(fall),\
    CXXSLINT => $(cxxall)
endif

.PHONY: analysis-lint
analysis-lint: lintdep $(alintrun)
	$(if $(filter-out $<,$^),$(call phony-ok,$(MSG_ALINT_SUCCESS)))

.PHONY: style-lint
style-lint: lintdep $(slintrun)
	$(if $(filter-out $<,$^),$(call phony-ok,$(MSG_SLINT_SUCCESS)))

.PHONY: lint
lint: analysis-lint style-lint

########################################################################
##                              COVERAGE                              ##
########################################################################

coverage_dependency := \
    COV => $(binall) $(testbin) $(benchbin)

.PHONY: coverage
coverage: coveragedep $(covshow)

.PHONY: check-coverage test-coverage
check-coverage test-coverage: coveragedep $(covtestshow)

.PHONY: eval-coverage benchmark-coverage
eval-coverage benchmark-coverage: coveragedep $(covbenchshow)

########################################################################
##                             STATISTICS                             ##
########################################################################

define statistic-count
$(words $1) $(if $(call ne,$(words $1),0),$(strip \
    $(foreach n,$(call rcar,$(call rcdr,$(shell wc -l $1))),$(strip \
        $(if $(call eq,1,$n),($n line),($n lines))\
))))
endef

.PHONY: statistics
statistics:
	@echo "                                                            "
	@echo "$(project)-$(version)                                       "
	@echo "=============================                               "
	@echo "                                                            "
	@echo "C            : $(call statistic-count,$(call))              "
	@echo "C++          : $(call statistic-count,$(cxxall))            "
	@echo "Fortran      : $(call statistic-count,$(fall))              "
	@echo "Assembly     : $(call statistic-count,$(asmall))            "
	@echo "Libraries    : $(call statistic-count,$(liball))            "
	@echo "Headers      : $(call statistic-count,$(userinc))           "
	@echo "Lexers       : $(call statistic-count,$(alllexer))          "
	@echo "Parsers      : $(call statistic-count,$(allparser))         "
	@echo "Embedded SQL : $(call statistic-count,$(cesql))             "
	@echo "Tests        : $(call statistic-count,$(testall))           "
	@echo "-----------------------------------                         "
	@echo "Total        :"\
          "$(call statistic-count,$(userall) $(liball) $(mainall)      \
           $(userinc) $(alllexer) $(allparser) $(cesql) $(testall))    "
	@echo "                                                            "

########################################################################
##                        INTERNATIONALIZATION                        ##
########################################################################

translation_dependency := \
    XGETTEXT => $(intltl),\
    MSGINIT  => $(intlall),\
    MSGMERGE => $(intlall),\
    MSGFMT   => $(intlobj)

.PHONY: translation
translation: translationdep $(intltl) $(intlobj)

########################################################################
##                          DOCUMENTATION                             ##
########################################################################

docs_dependency := \
    DOXYGEN   => $(doxyfile),\
    MAKEINFO  => $(texiinfo),\
    TEXI2HTML => $(texihtml),\
    TEXI2DVI  => $(texidvi),\
    TEXI2PDF  => $(texipdf),\
    TEXI2PS   => $(texips)

.PHONY: docs
docs: docsdep $(if $(strip $(doxyfile)),doxy)
docs: $(if $(strip $(texiall)),info html dvi pdf ps)

ifdef $(call not-empty,$(doxyfile))

.PHONY: doxy
doxy: docsdep $(docdir)/$(doxyfile).mk
	$(call phony-status,$(MSG_DOXY_DOCS))
	$(quiet) $(DOXYGEN) $(word 2,2,$^) $(NO_OUTPUT) $(NO_ERROR)
	$(call phony-ok,$(MSG_DOXY_DOCS))

$(docdir)/$(doxyfile).mk: | $(firstword $(docdir))/./ $(docdir)/doxygen
$(docdir)/$(doxyfile).mk: $(doxyfile)
	$(call status,$(MSG_DOXY_MAKE))
	$(quiet) $(CP) $< $@
	
	@echo "                                                      " >> $@
	@echo "######################################################" >> $@
	@echo "##                 MAKEFILE CONFIGS                 ##" >> $@
	@echo "######################################################" >> $@
	@echo "                                                      " >> $@
	@echo "# Project info                                        " >> $@
	@echo "PROJECT_NAME     = $(project)                         " >> $@
	@echo "PROJECT_NUMBER   = $(version)                         " >> $@
	@echo "PROJECT_BRIEF    = $(synopsis)                        " >> $@
	@echo "                                                      " >> $@
	@echo "# Source info                                         " >> $@
	@echo "INPUT            = $(call rsubdir,$(srcdir) $(incdir))" >> $@
	@echo "FILE_PATTERNS    = $(addprefix *,$(srcext) $(incext)) " >> $@
	@echo "                                                      " >> $@
	@echo "OUTPUT_DIRECTORY = $(firstword $(docdir)/doxygen)     " >> $@
	
	$(call ok,$(MSG_DOXY_MAKE),$@)

$(doxyfile):
	$(call status,$(MSG_DOXY_FILE))
	$(quiet) $(DOXYGEN) -g $@ $(NO_OUTPUT)
	$(call ok,$(MSG_DOXY_FILE),$@)

$(docdir)/doxygen:
	$(call mkdir,$(docdir)/doxygen)

endif # ifdef $(not-empty,$(doxyfile))

########################################################################
##                            DISTRIBUTION                            ##
########################################################################

dist_dependency := \
    ZIP   => $(call rfilter,%-zip,$(MAKECMDGOALS)),\
    TAR   => $(call rfilter,package dist tar,$(MAKECMDGOALS))\
             $(call rfilter,dist-tar% package-tar%,$(MAKECMDGOALS)),\
    GZIP  => $(call rfilter,dist-%gz package-tar%gz, $(MAKECMDGOALS)),\
    BZIP2 => $(call rfilter,dist-%bz2 package-tar%bz2, $(MAKECMDGOALS))

.PHONY: package
package: package-tar.gz

.PHONY: dist
dist: dist-tar.gz

.PHONY: tar
tar: dist-tar

########################################################################
##                          DEBIAN PACKAGE                            ##
########################################################################

dpkg_dependency := \
    DEBUILD => $(deball),\
    DCH     => $(debdir)/changelog,

.PHONY: dpkg
dpkg: dpkgdep package-tar.gz $(deball)
	
	@# Step 1: Rename the upstream tarball
	$(call phony-status,$(MSG_DEB_STEP1))
	$(quiet) $(MV) $(distdir)/$(project)-$(version)_src.tar.gz \
	               $(distdir)/$(deb_project)_$(deb_version).orig.tar.gz \
	               $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP1))
	
	@# Step 2: Unpack the upstream tarball
	$(call phony-status,$(MSG_DEB_STEP2))
	$(quiet) cd $(distdir) \
	         && tar xf $(deb_project)_$(deb_version).orig.tar.gz $(ERROR)
	$(call srmdir,$(distdir)/$(deb_project)-$(version))
	$(quiet) $(MV) $(distdir)/$(project)-$(version)_src \
	               $(distdir)/$(deb_project)-$(version) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP2))
	
	@# Step 3: Add the Debian packaging files
	$(call phony-status,$(MSG_DEB_STEP3))
	$(quiet) $(CP) $(debdir) \
	         $(distdir)/$(deb_project)-$(version) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP3))
	
	@# Step 4: Install the package
	$(call phony-status,$(MSG_DEB_STEP4))
	$(quiet) cd $(distdir)/$(deb_project)-$(version) \
	         && $(DEBUILD) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP4))

# Executes iff one of the make goals is 'dpkg'
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,dpkg)))

$(debdir)/changelog: | $(firstword $(debdir))/./
	$(quiet) $(DCH)

$(debdir)/compat: | $(firstword $(debdir))/./
	$(call touch,$@)
	$(quiet) echo 9 >> $@

$(debdir)/control: | $(firstword $(debdir))/./
	$(call touch,$@)
	$(call select,$@)
	@echo " "                                                 >> $@
	@echo "Source: $(deb_project)"                            >> $@
	@echo "Maintainer: $(mainteiner_name) $(mainteiner_mail)" >> $@
	@echo "Section: misc"                                     >> $@
	@echo "Priority: $(deb_priority)"                         >> $@
	@echo "Standards-Version: $(version)"                     >> $@
	@echo "Build-Depends: debhelper (>= 9)"                   >> $@
	@echo " "                                                 >> $@
	@echo "Package: $(deb_project)"                           >> $@
	@echo "Architecture: any"                                 >> $@
	@echo "Depends: "$$"{shlibs:Depends}, "$$"{misc:Depends}" >> $@
	@echo "Description: $(synopsis)"                          >> $@
	@echo " $(description)"                                   >> $@
	$(call select,stdout)

$(debdir)/copyright: | $(firstword $(debdir))/./
	$(call touch,$@,$(notice))

$(debdir)/rules: | $(firstword $(debdir))/./
	$(call touch,$@)
	$(call select,$@)
	$(call cat,"#!/usr/bin/make -f                                    ")
	$(call cat,"                                                      ")
	$(call cat,"%:                                                    ")
	$(call cat,"\tdh "$$"@                                            ")
	$(call cat,"                                                      ")
	$(call cat,"override_dh_auto_install:                             ")
	$(call cat,"\t"$$"(MAKE) \\"                                       )
	$(call cat,"    DESTDIR="$$""$$"(pwd)/debian/$(deb_project) \\"    )
	$(call cat,"    prefix=/usr install"                               )
	$(call select,stdout)

$(debdir)/source/format: | $(firstword $(debdir))/./
	$(call mksubdir,$(debdir),$@)
	$(call touch,$@)
	$(quiet) echo "3.0 (quilt)" >> $@

$(debdir)/$(deb_project).dirs: | $(firstword $(debdir))/./
	$(call touch,$@)
	$(call select,$@)
	$(if $(strip $(bin)),     $(call cat,'$(i_bindir)                '))
	$(if $(strip $(sbin)),    $(call cat,'$(i_sbindir)               '))
	$(if $(strip $(libexec)), $(call cat,'$(i_libexecdir)            '))
	$(if $(strip $(lib)),     $(call cat,'$(i_libdir)                '))
	$(if $(strip $(texiinfo)),$(call cat,'$(i_docdir)/info           '))
	$(call select,stdout)
endif

########################################################################
##                           INSTALLATION                             ##
########################################################################

install_dependency := \
    INSTALL         => $(i_lib) $(i_bin) $(i_sbin) $(i_libexec),\
    INSTALL_DATA    => $(i_lib),\
    INSTALL_PROGRAM => $(i_bin) $(i_sbin) $(i_libexec)

.PHONY: install-strip
install-strip: installdep
	$(MAKE) INSTALL_PROGRAM='$(INSTALL_PROGRAM) -s' install

.PHONY: install
install: installdep $(i_lib) $(i_bin) $(i_sbin) $(i_libexec) \
         install-docs

.PHONY: install-docs
install-docs: installdep install-info install-html install-dvi
install-docs: install-pdf install-ps

.PHONY: install-info
install-info:
	$(if $(strip $(texiinfo)),$(foreach f,$(texiinfo),\
        $(INSTALL_DATA) $f $(i_infodir)/$(notdir $f);\
        if $(SHELL) -c '$(INSTALL_INFO) --version' $(NO_OUTPUT) 2>&1; \
        then \
            $(INSTALL_INFO) --dir-file="$(i_infodir)/dir" \
            "$(i_infodir)/$(notdir $f)"; \
        else true; fi;\
    ))

.PHONY: installcheck
installcheck:
	$(call phony-ok,"No installation test avaiable")

########################################################################
##                          UNINSTALLATION                            ##
########################################################################

# Remove subdirectories of this directory
# Remove files if no subdir was identified
define uninstall
$(if $(strip $(i_$1)),\
    $(if $(sort $(foreach d,\
        $(call root,$(call not-root,$($1))),\
        $(call rsubdir,$(i_$1dir)/$d)\
    )),
        $(call rm-if-empty,\
            $(call invert,$(sort $(foreach d,\
                $(call root,$(call not-root,$($1))),\
                $(call rsubdir,$(i_$1dir)/$d)\
            ))),\
            $(i_$1)\
        ),\
        $(if $(strip $(foreach f,$(i_$1),$(wildcard $f))),\
            $(call rm,$(i_$1)))\
))
endef

.PHONY: mainteiner-uninstall
mainteiner-uninstall:
	@$(MAKE) uninstall DESTDIR=$(destdir) MAINTEINER_CLEAN=1

.PHONY: uninstall
uninstall:
	$(call uninstall,lib)
	$(call uninstall,bin)
	$(call uninstall,sbin)
	$(call uninstall,libexec)

.PHONY: uninstall-docs
uninstall-docs: uninstall-info uninstall-html uninstall-dvi
uninstall-docs: uninstall-pdf uninstall-ps

.PHONY: uninstall-info
uninstall-info:
	$(if $(strip $(texiinfo)),$(call rm-if-empty,$(i_infodir),\
	    $(addprefix $(i_infodir)/,$(notdir $(texiinfo)))\
	))

########################################################################
##                              RULES                                 ##
########################################################################

# Include dependencies for each src extension, unless cleaning files
ifneq ($(patsubst %clean,clean,$(MAKECMDGOALS)),clean)
-include $(wildcard $(depall))
endif

#======================================================================#
# Function: root-factory                                               #
# @param  $1 Root directory                                            #
# @return Target to create a root directory (used in '| $(root)')      #
#======================================================================#
define root-factory
$1/./:
	$$(call mkdir,$$@)
endef
$(foreach d,$(alldir),$(eval $(call root-factory,$d)))

#======================================================================#
# Function: flag-dependency                                            #
# @param  $1 Source file (which has the dependency)                    #
# @param  $2 Flag name (for targets)                                   #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define flag-dependency
$1: \
    $$(if $$(call ne,$$(strip $$(OLD_$2)),$$(strip $$($2))),\
        $$(shell $$(RM) $$(depdir)/$$(makedir)/$2$$(sysext)))\
    $$(depdir)/$$(makedir)/$2$$(sysext)

$$(depdir)/$$(makedir)/$2$$(sysext): $$(depdir)/./
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(call select,$$@)
	$$(call cat,'override OLD_$2 := $$(strip $$($2))')
endef
$(foreach k,$(call hash-table.keys,flag_dependency),\
    $(foreach f,$(flag_dependency.$k),\
        $(if $(call not-empty,$($k)),\
            $(eval $(call flag-dependency,$($k),$f))\
)))

#======================================================================#
# Function: program-dependency-target                                  #
# @param  $1 Dependency name (for targets)                             #
# @param  $2 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define program-dependency-target
# Creates hash from hash-key
$$(call hash-table.new,$2)

# Verifies if programs of $1dep are the same. If they changed, deletes 
# old program dependency file and checks if the new is avaiable.
.PHONY: $1dep
$1dep: \
    $$(foreach k,$$(call hash-table.keys,$2),$$(if \
        $$(and $$(strip $$(OLD_$$k)),$$(call ne,$$(OLD_$$k),$$($$k))),\
            $$(shell $$(RM) \
                $$(addprefix $$(depdir)/$$(firstword $$(bindir))/,\
                    $$(addsuffix $$(sysext),$$k) \
            )) \
    )) \
    $$(if $$(strip $$(call hash-table.values,$2)),\
        $$(depdir)/$1$$(sysext))
endef
$(foreach t,$(targets),\
    $(eval $(call program-dependency-target,$t,$t_dependency)))

#======================================================================#
# Function: program-dependency                                         #
# @param  $1 Complete library path                                     #
# @param  $2 Library name                                              #
# @return Target to check if program exists                            #
#======================================================================#
define program-dependency
$$(depdir)/$$(firstword $$(bindir))/$1$$(sysext): d=$1
$$(depdir)/$$(firstword $$(bindir))/$1$$(sysext): | $$(depdir)/./
	$$(if $$(strip $$($1)),,$$(call phony-error,$$(MSG_PRG_UNDEFINED)))
	$$(call phony-status,$$(MSG_PRG_SEARCH))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) which $$(firstword $$($1)) $$(NO_OUTPUT) $$(NO_ERROR) \
	          || $$(call model-error,$$(MSG_PRG_NOT_FOUND))
	
	$$(if $$(strip $$(program_version.$1)),\
	    $$(if $$(call version-ge,\
	             $$(lastword $$(shell $$(firstword $$($1)) --version \
	                 | grep "\([0-9a-zA-Z]\+[-.]\)\+[0-9a-zA-Z]$$$$")),\
	             $$(lastword $$(program_version.$1))\
	        ),,\
	        $$(call phony-error,$$(MSG_PRG_BAD_VER))\
	))
	
	$$(call select,$$@)
	$$(call cat,'override OLD_$1 := $$($1)')
	
	$$(call phony-ok,$$(MSG_PRG_SEARCH))
endef
$(foreach p,$(programs),$(eval $(call program-dependency,$p)))

#======================================================================#
# Function: library-dependency-target                                  #
# @param  $1 Dependency name (for targets)                             #
# @param  $3 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define library-dependency-target
.PHONY: $1dep
$1dep: \
    $$(foreach l,$$(old_syslib),\
        $$(if $$(findstring $$l,$$(syslib)),,\
            $$(shell $$(RM) \
                $$(addprefix $$(depdir)/$$(firstword $$(libdir))/,\
                    $$(addsuffix $$(sysext),\
                        $$(patsubst lib%,%,$$(notdir $$(basename $$l)))\
            ))) \
    )) \
    $$(if $$(strip $$(call hash-table.values,$2)),\
        $$(depdir)/$1$$(sysext))
endef
$(foreach d,library,\
    $(eval $(call library-dependency-target,$d,$d_version)))

#======================================================================#
# Function: library-dependency                                         #
# @param  $1 Program name                                              #
# @return Target to check if program exists                            #
#======================================================================#
define library-dependency
$$(depdir)/$$(firstword $$(libdir))/$1$$(sysext): d=$1
$$(depdir)/$$(firstword $$(libdir))/$1$$(sysext): | $$(depdir)/./
	$$(call phony-status,$$(MSG_LIB_SEARCH))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) ls $2* $$(NO_OUTPUT) $$(NO_ERROR) \
	          || $$(call model-error,$$(MSG_LIB_NOT_FOUND))
	
	$$(if $$(strip $$(library_version.$1)),\
	    $$(if $$(lastword $$(shell ls $2* \
	              | sed 's/[^ ]\+$$(suffix $2).//')),,\
	        $$(call prony-error,$$(MSG_LIB_NO_VERSION))\
	))
	
	$$(if $$(strip $$(library_version.$1)),\
	    $$(if $$(call version-ge,\
	             $$(lastword $$(shell ls $2* \
	                 | sed 's/[^ ]\+$$(suffix $3).//')),\
	             $$(lastword $$(library_version.$1))\
	        ),,\
	        $$(call phony-error,$$(MSG_LIB_BAD_VER))\
	))
	
	$$(call select,$$@)
	$$(call cat,'override old_syslib := $$(syslib)')
	
	$$(call phony-ok,$$(MSG_LIB_SEARCH))
endef
$(foreach p,$(syslib),$(strip \
    $(eval $(call library-dependency,$(patsubst lib%,%,\
               $(notdir $(basename $(call not-extra-suffix,$p)))),$p,\
               $(call not-extra-suffix,$p)))))

#======================================================================#
# Function: extern-dependency-target                                   #
# @param  $1 Dependency name (for targets)                             #
# @param  $3 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define extern-dependency-target
.PHONY: $1dep
$1dep: \
    $$(foreach d,$$(old_externdep),\
        $$(if $$(findstring $$l,$$(externdep)),,\
            $$(shell $$(RM) \
                $$(addprefix $$(depdir)/$$(firstword $$(extdir))/,\
                    $$(addsuffix $$(extext),$$l)\
            ))\
    )) \
    $$(if $$(strip $$(call hash-table.values,$2)),\
        $$(depdir)/$1$$(sysext))
endef
$(foreach d,git web,\
    $(eval $(call extern-dependency-target,$d,$d_dependency)))

#======================================================================#
# Function: extern-dependency                                          #
# @param  $1 Dependency nick (hash key)                                #
# @param  $2 Dependency path (hash value)                              #
# @return Target to download git dependencies for building             #
#======================================================================#
define extern-dependency
$$(extdir)/$1: | $$(extdir)/./
	$$(call $2,$$(call car,$3),$$@)

$$(depdir)/$$(firstword $$(extdir))/$1$$(sysext): d=$$(extdir)/$1
$$(depdir)/$$(firstword $$(extdir))/$1$$(sysext): $$(externreq)
	$$(call status,$$(MSG_EXT_BUILD))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(if $$(call cdr,$3),$$(strip \
	              $$(call store-status,cd $$d && $$(call cdr,$3)) \
	              $$(ERROR)                                       \
	              && $$(call model-error,$$(MSG_EXT_BUILD_ERR))   \
	          ),$$(strip \
	              if [ -f $$d/[Mm]akefile ]; \
	              then \
	                  cd $$d \
	                  && $$(call store-status,$$(MAKE) -f [Mm]akefile)  \
	                     $$(ERROR)                                      \
	                  && $$(call model-error,$$(MSG_EXT_BUILD_ERR));    \
	              elif [ -f $$d/$$(makedir)/[Mm]akefile ]; \
	              then \
	                  cd $$d/$$(makedir)                                \
	                  && $$(call store-status,$$(MAKE) -f [Mm]akefile)  \
	                     $$(ERROR)                                      \
	                  && $$(call model-error,$$(MSG_EXT_BUILD_ERR));    \
	              else \
	                  $$(call println,"$$(MSG_EXT_NO_MAKE)",$$(ERROR)); \
	              fi \
	          ))
	
	$$(call select,$$@)
	$$(call cat,'override old_externdep := $$(externdep)')
	
	$$(call ok,$$(MSG_EXT_BUILD))
endef
$(foreach d,$(call hash-table.keys,git_dependency),$(eval\
    $(call extern-dependency,$d,git-submodule-add,$(git_dependency.$d))))
$(foreach d,$(call hash-table.keys,web_dependency),$(eval\
    $(call extern-dependency,$d,web-clone,$(web_dependency.$d))))

#======================================================================#
# Function: phony-target-dependency                                    #
# @param  $1 Dependency name (for targets)                             #
# @param  $2 Dependency nick (hash key)                                #
# @return Target to check a set of dependencies defined in $2          #
#======================================================================#
define phony-target-dependency
$$(depdir)/$$(strip $1)$$(sysext): n=$1
$$(depdir)/$$(strip $1)$$(sysext): \
    $$(foreach k,$3,$$(if $$(strip $$($2.$$k)),$4/$$k$$(sysext))) \
    | $$(depdir)/./
	
	$$(quiet) touch $$@
	$$(call phony-ok,$$(MSG_PRG_ALL))
endef
$(foreach d,$(targets),\
    $(eval $(call phony-target-dependency,$d,$d_dependency,\
               $(call hash-table.keys,$d_dependency),\
               $(depdir)/$(firstword $(bindir)))))
$(foreach d,library,\
    $(eval $(call phony-target-dependency,$d,$d_version,\
               $(call hash-table.keys,$d_version),\
               $(depdir)/$(firstword $(libdir)))))
$(foreach d,git web,\
    $(eval $(call phony-target-dependency,$d,$d_dependency,\
               $(call invert,$(call hash-table.keys,$d_dependency)),\
               $(depdir)/$(firstword $(extdir)))))

#======================================================================#
# Function: scanner-factory                                            #
# @param  $1 Basename of the lex file                                  #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define scanner-factory
# Recompile target iff the include directory not exists
$$(firstword $$(srcdir))/$1.yy.$2: \
    $$(if $$(wildcard $$(firstword $$(incdir))/$1-yy),,\
    $$(firstword $$(incdir))/$1-yy)

$$(firstword $$(srcdir))/$1.yy.$2: $3
	$$(call status,$$(MSG_LEX))
	
	$$(quiet) $$(MV) $$< $$(firstword $$(incdir))/$1-yy/
	$$(quiet) cd $$(firstword $$(incdir))/$1-yy/ \
	          && $4 $$(lexflags) $$(notdir $$<) $$(ERROR)
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-yy/$$(notdir $$<) $$<
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-yy/*.$2 $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_LEX),$$@)

ifdef $$(is-empty,$$(wildcard $$(firstword $$(incdir))/$1-yy))
$$(firstword $$(incdir))/$1-yy/:
	$$(call mkdir,$$@)
endif
endef
$(foreach s,$(clexer),$(eval\
    $(call scanner-factory,$(call not-root,$(basename $s)),c,$s,\
    $(LEX))\
))
$(foreach s,$(cxxlexer),$(eval\
    $(call scanner-factory,$(call not-root,$(basename $s)),cc,$s,\
    $(LEXCXX))\
))

#======================================================================#
# Function: parser-factory                                             #
# @param  $1 Basename of the yacc file                                 #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files accordingly to their types   #
#======================================================================#
define parser-factory
$$(firstword $$(srcdir))/$1.tab.$2: \
    $$(if $$(wildcard $$(firstword $$(incdir))/$1-tab),,\
    $$(firstword $$(incdir))/$1-tab)

$$(firstword $$(srcdir))/$1.tab.$2: $3 $$(lexall)
	$$(call status,$$(MSG_YACC))
	
	$$(quiet) $$(MV) $$< $$(firstword $$(incdir))/$1-tab/
	$$(quiet) cd $$(firstword $$(incdir))/$1-tab/ \
	          && $4 $$(yaccflags) $$(notdir $$<) $$(ERROR)
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-tab/$$(notdir $$<) $$<
	$$(quiet) $$(MV) $$(firstword $$(incdir))/$1-tab/*.$2 $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_YACC),$$@)

ifdef $$(call is-empty,$$(wildcard $$(firstword $$(incdir))/$1-tab))
$$(firstword $$(incdir))/$1-tab/:
	$$(call mkdir,$$@)
endif
endef
$(foreach s,$(cparser),$(eval\
    $(call parser-factory,$(call not-root,$(basename $s)),c,$s,\
    $(YACC))\
))
$(foreach s,$(cxxparser),$(eval\
    $(call parser-factory,$(call not-root,$(basename $s)),cc,$s,\
    $(YACCCXX))\
))

#======================================================================#
# Function: esql-factory                                               #
# @param  $1 Basename of the esql file                                 #
# @return Target to generate source files from embeddes SQL            #
#======================================================================#
define esql-factory
$$(firstword $$(srcdir))/$1.$2: $3
	$$(call status,$$(MSG_ESQL))
	$$(quiet) $$(ESQL) $$(esqlflags) -c $$< -o $$@ $$(ERROR)
	$$(call ok,$$(MSG_ESQL),$$@)
endef
$(foreach s,$(cesql),$(eval\
    $(call esql-factory,$(call not-root,$(basename $s)),c,$s)\
))

#======================================================================#
# Function: compile-asm                                                #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 Assembly extension                                        #
# @return Target to compile all Assembly files with the given          #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-asm
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)/./
	$$(call status,$$(MSG_ASM_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$$(call not-root,$1/$$*))
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(AS) $$(cppflags) $$(asflags) $$(aslibs) \
	                 $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_ASM_COMPILE),$$@)
endef
$(foreach r,$(srcdir),\
    $(foreach e,$(asmext),\
        $(eval $(call compile-asm,$(objdir),$r,$e))))

#======================================================================#
# Function: compile-c                                                  #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 C extension                                               #
# @return Target to compile all C files with the given extension,      #
#         looking in the right root directory                          #
#======================================================================#
define compile-c
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)/./
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$$(call not-root,$1/$$*))
	
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) $$(cppflags) $$(cflags) $$(clibs) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_C_COMPILE),$$@)
endef
$(foreach r,$(srcdir),$(foreach e,$(cext),\
    $(eval $(call compile-c,$(objdir),$r,$e))))
$(foreach p,test bench,$(foreach e,$(cext),\
    $(eval $(call compile-c,$(objdir)/$($pdir),$($pdir),$e))))

#======================================================================#
# Function: compile-f                                                  #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 Fortran extension                                         #
# @return Target to compile all Fortran files with the given           #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-f
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)/./
	$$(call status,$$(MSG_F_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call mksubdir,$$(incdir),$$@)
	$$(quiet) $$(call fortran-depend,$$<,$$@,$$(call not-root,$3/$$*))
	
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(FC) $$(cppflags) $$(fflags) $$(flibs) \
	                 -J $$(firstword $$(incdir))/$$(dir $$*) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_F_COMPILE),$$@)
endef
$(foreach r,$(srcdir),$(foreach e,$(fext),\
    $(eval $(call compile-f,$(objdir),$r,$e))))
$(foreach p,test bench,$(foreach e,$(fext),\
    $(eval $(call compile-f,$(objdir)/$($pdir),$($pdir),$e))))

#======================================================================#
# Function: compile-cpp                                                #
# @param  $1 Directory for object files                                #
# @param  $2 Root source directory                                     #
# @param  $3 C++ extension                                             #
# @return Target to compile all C++ files with the given extension     #
#         looking in the right root directory                          #
#======================================================================#
define compile-cpp
$1/%$$(firstword $$(objext)): $2/%$3 | $$(depdir)/./
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call cpp-depend,$$<,$$@,$$(call not-root,$1/$$*))
	
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) $$(cppflags) $$(cxxlibs) $$(cxxflags) \
	                  -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_CXX_COMPILE),$$@)
endef
$(foreach r,$(srcdir),$(foreach e,$(cxxext),\
    $(eval $(call compile-cpp,$(objdir),$r,$e))))
$(foreach p,test bench,$(foreach e,$(cxxext),\
    $(eval $(call compile-cpp,$(objdir)/$($pdir),$($pdir),$e))))

#======================================================================#
# Function: compile-shrlib-c                                           #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the C library file                         #
#======================================================================#
define compile-shrlib-c
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)/./
	$$(call status,$$(MSG_C_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$2)
	
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) $$(cppflags) $$(clibs) $$(shrflags) $$(cflags) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_C_LIBCOMP),$$@)
endef
$(foreach s,$(foreach e,$(cext),$(filter %$e,$(shrall))),\
    $(eval $(call compile-shrlib-c,$(strip \
        $(call root,$s)/),$(call not-root,$(basename $s)),$(suffix $s))\
))

#======================================================================#
# Function: compile-shrlib-f                                           #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the Fortran library file                   #
#======================================================================#
define compile-shrlib-f
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)/./
	$$(call status,$$(MSG_F_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call mksubdir,$$(incdir),$$@)
	$$(quiet) $$(call fortran-depend,$$<,$$@,$2)
	
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(FC) $$(cppflags) $$(flibs) $$(shrflags) $$(fflags) \
	                 -J $$(firstword $$(incdir))/$$(dir $2) \
	                 -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_F_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(fext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-shrlib-f,$(strip \
        $(call root,$s)/),$(call not-root,$(basename $s)),$(suffix $s))\
))

#======================================================================#
# Function: compile-shrlib-cpp                                         #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the C++ library file                       #
#======================================================================#
define compile-shrlib-cpp
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)/./
	$$(call status,$$(MSG_CXX_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call cpp-depend,$$<,$$@,$2)
	
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) $$(cppflags) $$(cxxlibs) \
	                  $$(shrflags) $$(cxxflags) -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_CXX_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(cxxext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-shrlib-cpp,$(strip \
        $(call root,$s)/),$(call not-root,$(basename $s)),$(suffix $s))\
))

#======================================================================#
# Function: link-shrlib                                                #
# @param  $1 Directory in which the lib may be put                     #
# @param  $2 Subdirectories in which the lib may be put                #
# @param  $3 File/dir basename that makes the name of the dir          #
# @param  $4 Object dependencies of this static library                #
# @return Target to create a shared library from objects               #
#======================================================================#
define link-shrlib
$1/$2: $$($2_obj) | $1/./
	$$(call status,$$(MSG_$3_SHRLIB))
	
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $4 $$^ -o $$@ $$(ldflags) $$(ldshr) $$(ldlibs) $$(ERROR)
	
	$$(call ok,$$(MSG_$3_SHRLIB))
endef
$(foreach l,$(shrlib),\
    $(eval $(call link-shrlib,$(strip \
        $(call root,$l)),$(call not-root,$l),$(strip \
        $(call choose-comment,$($(call not-root,$l)_all))),$(strip \
        $(call choose-compiler,$($(call not-root,$l)_all)))\
)))

#======================================================================#
# Function: link-arlib                                                 #
# @param  $1 Directory in which the lib may be put                     #
# @param  $2 Subdirectories in which the lib may be put                #
# @param  $3 File/dir basename that makes the name of the dir          #
# @param  $4 Object dependencies of this static library                #
# @return Target to create a static library from objects               #
#======================================================================#
define link-arlib
$1/$2: $$($2_obj) | $1/./
	$$(call status,$$(MSG_ARLIB))
	
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(AR) $$(arflags) $$@ $$^ $$(NO_OUTPUT) $$(NO_ERROR)
	$$(quiet) $$(RANLIB) $$@
	
	$$(call ok,$$(MSG_ARLIB),$$@)
endef
$(foreach l,$(arlib),\
    $(eval $(call link-arlib,$(call root,$l),$(call not-root,$l))))

#======================================================================#
# Function: test-factory                                               #
# @param  $1 Unit test binary's directory name                         #
# @param  $2 Unit test binary's name without root directory            #
# @param  $3 Alias to execute tests, prefixing run_ and                #
#            substituting / for _ in $(testbin)                        #
# @return Target to generate binary file for the unit test             #
#======================================================================#
ifneq (,$(call rfilter,check test %-coverage,$(MAKECMDGOALS)))
define test-factory
$1/$2: $$($2_obj) | $1/./
	$$(call status,$$(MSG_TEST_COMPILE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(CXX) $$^ -o $$@ \
	                  $$(ldflags) $$(arlink) $$(shrlink) $$(ldlibs)
	$$(call ok,$$(MSG_TEST_COMPILE),$$@)

.PHONY: $3
$3: $1/$2
	$$(call phony-vstatus,$$(MSG_TEST))
	@./$$< || $$(call model-test-error,$$(MSG_TEST_FAILURE))
	$$(call ok,$$(MSG_TEST))
endef
$(foreach t,$(testbin),$(eval\
    $(call test-factory,$(call root,$t),$(call not-root,$t),\
    run_$(subst /,_,$t)\
)))
endif

#======================================================================#
# Function: benchmark-factory                                          #
# @param  $1 Benchmark binary's directory name                         #
# @param  $2 Benchmark binary's name without root directory            #
# @param  $3 Alias to execute benchmarks, prefixing run_ and           #
#            substituting / for _ in $(benchdep)                       #
# @return Target to generate binary file for the benchmark             #
#======================================================================#
ifneq (,$(call rfilter,eval benchmark %-coverage,$(MAKECMDGOALS)))
define bench-factory
$1/$2: $$($2_obj) | $1/./
	$$(call status,$$(MSG_BENCH_COMPILE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(CXX) $$^ -o $$@ \
	                  $$(ldflags) $$(arlink) $$(shrlink) $$(ldlibs)
	$$(call ok,$$(MSG_BENCH_COMPILE),$$@)

.PHONY: $3
$3: $1/$2
	$$(call phony-vstatus,$$(MSG_BENCH))
	@./$$<
	$$(call ok,$$(MSG_BENCH))
endef
$(foreach t,$(benchbin),$(eval\
    $(call bench-factory,$(call root,$t),$(call not-root,$t),\
    run_$(subst /,_,$t)\
)))
endif

#======================================================================#
# Function: binary-factory                                             #
# @param  $1 Binary root directory                                     #
# @param  $2 Binary name witout root dir                               #
# @param  $3 Comments to be used (C's, Fortran's or C++'s)             #
# @param  $4 Compiler to be used (C's, Fortran's or C++'s)             #
# @return Target to generate binaries and dependencies of its object   #
#         files (to create objdir and automatic source)                #
#======================================================================#
define binary-factory
$1/$2: $$($2_lib) $$($2_obj) | $1/./
	$$(call status,$$(MSG_$3_LINKAGE))
	
	$$(if $$(strip $$($2_all)),,\
	    $$(call phony-error,$$(MSG_$3_NO_FILE)))
	
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $4 $$($2_obj) -o $$@ \
	             $$(ldflags) $$($2_link) $$(ldlibs) $$(ERROR)
	
	$$(call ok,$$(MSG_$3_LINKAGE),$$@)

$$($2_obj): $$($2_all) | $$(objdir)/./
endef
$(foreach b,$(binall),\
    $(eval $(call binary-factory,$(strip \
        $(call root,$b)),$(call not-root,$b),$(strip \
        $(call choose-comment,$($(call not-root,$b)_all))),$(strip \
        $(call choose-compiler,$($(call not-root,$b)_all)))\
)))

#======================================================================#
# Function: analysis-lint-factory                                      #
# @param  $1 Alias to execute analysis lint, prefixing analysis_lint_  #
#            and replacing / for _ in $(binall)/$(testbin)/$(benchbin) #
# @param  $2 Analysis lint binary's name without root directory        #
# @param  $3 Lint tool to be used (C's, Fortran's or C++'s)            #
# @return Target to generate binary file for the analysis lint         #
#======================================================================#
define analysis-lint-factory
$1: f=$2
$1: $$($$(call not-root,$2)_all)
	$$(call phony-status,$$(MSG_ALINT))
	$$(quiet) $$($3ALINT) $$($$(call lc,$3)libs) \
	                      $$($$(call lc,$3)alflags) $$^ $$(ERROR)
	$$(call phony-ok,$$(MSG_ALINT))
endef
$(foreach b,$(binall) $(testbin) $(benchbin) $(arlib) $(shrlib),\
    $(eval $(call analysis-lint-factory,$(strip \
        $(addprefix analysis_lint_,$(subst /,_,$b))),$b,$(strip \
        $(call choose-comment,$($(call not-root,$b)_all))\
))))

#======================================================================#
# Function: style-lint-factory                                         #
# @param  $1 Alias to execute style lint, prefixing style_lint_ and    #
#            replacing / for _ in $(binall)/$(testbin)/$(benchbin)     #
# @param  $2 Style lint binary's name without root directory           #
# @param  $3 Lint tool to be used (C's, Fortran's or C++'s)            #
# @return Target to generate binary file for the style lint            #
#======================================================================#
define style-lint-factory
$1: f=$2
$1: $$($$(call not-root,$2)_all)
	$$(call phony-status,$$(MSG_SLINT))
	$$(quiet) $$($3SLINT) $$($$(call lc,$3)slflags) $$^ $$(ERROR)
	$$(call phony-ok,$$(MSG_SLINT))
endef
$(foreach b,$(binall) $(testbin) $(benchbin) $(arlib) $(shrlib),\
    $(eval $(call style-lint-factory,$(strip \
        $(addprefix style_lint_,$(subst /,_,$b))),$b,$(strip \
        $(call choose-comment,$($(call not-root,$b)_all))\
))))

#======================================================================#
# Function: coverage-factory                                           #
# @param  $1 Report file                                               #
# @param  $1 Binary file                                               #
# @param  $3 Phony target to show coverage statistics for $2           #
# @return Target to generate coverage and show coverage statistics     #
#======================================================================#
ifndef DEPLOY
ifdef COVERAGE
define coverage-factory
$1: $2 $$(call rwildcard,$$(addprefix *,$$(covext)),$$(objdir))
	$$(call status,$$(MSG_COV_COMPILE))
	
	$$(call mksubdir,$$(covdir),$$@)
	$$(quiet) $$(COV) -q -b $$(covdir) --capture -o $$@ \
	                  -d $$(objdir) -d $$(firstword $$(libdir)) $$(ERROR)
	$$(quiet) if [ -s $$@ ]; \
	          then \
	              $$(COV) -q -o $$@                               \
	                      -r $$@ '$$(extdir)/*' '/usr/*'          \
	                             '$$(testdir)/*' '$$(benchdir)/*' \
	                             $$(patsubst %,'%',$$(covignore)) \
	                      $$(ERROR);                              \
	          fi
	
	$$(call ok,$$(MSG_COV_COMPILE))

.PHONY: show_$$(subst /,_,$1)
show_$$(subst /,_,$1): f=$1
show_$$(subst /,_,$1): $3 $1
	$$(call phony-status,$$(MSG_COV))
	$$(quiet) if [ -s $1 ]; \
	          then \
	              $$(COV) -l $1 $$(ERROR); \
	              $$(call model-ok,$$(MSG_COV)); \
	          else \
	              $$(call model-ok,$$(MSG_COV_NONE)); \
	          fi
endef
$(foreach b,$(binall),\
    $(eval $(call coverage-factory,$(strip \
        $(covdir)/$(call not-root,$(basename $b))$(repext)),$b)))
$(foreach b,$(testbin),\
    $(eval $(call coverage-factory,$(strip \
        $(covdir)/$(call not-root,$(basename $b))$(repext)),$b,check)))
$(foreach b,$(benchbin),\
    $(eval $(call coverage-factory,$(strip \
        $(covdir)/$(call not-root,$(basename $b))$(repext)),$b,eval)))
endif # ifdef COVERAGE
endif # ifndef DEPLOY

#======================================================================#
# Function: intl-template-factory                                      #
# @param  $1 Locale root directory                                     #
# @param  $1 Binary name witout root dir                               #
# @return Target to generate template translations for translators     #
#======================================================================#
ifdef ENABLE_NLS
define intl-template-factory
$1/$2$$(firstword $$(potext)): $$($2_all) | $1/./
	$$(call status,$$(MSG_INTL_TEMPLATE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(XGETTEXT)\
	          --copyright-holder=$$(call shstring,$$(copyright))\
	          --msgid-bugs-address=$$(call shstring,$$(mainteiner_mail))\
	          --package-name=$$(call shstring,$$(project))\
	          --package-version=$$(version)\
	          -d $2 -k_ -kN_ -s $$^ -o $$@
	$$(call ok,$$(MSG_INTL_TEMPLATE),$$@)
endef
$(foreach b,$(binall),$(eval\
    $(call intl-template-factory,$(strip\
        $(localedir)),$(call not-root,$(basename $b)))))
endif

#======================================================================#
# Function: intl-translate-factory                                     #
# @param  $1 Locale root directory                                     #
# @param  $1 Binary name witout root dir                               #
# @return Target to generate machine objects to be used by binaries    #
#======================================================================#
ifdef ENABLE_NLS
define intl-translate-factory
$1/%/$2$$(firstword $$(poext)): $1/$2$$(firstword $$(potext))
	$$(call phony-status,$$(MSG_INTL_PORTABLE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(if $$(strip $$(wildcard $$@)),\
	              $$(MSGMERGE) $$@ $$< -o $$@ $$(ERROR),\
	              $$(MSGINIT)  -l $$* -i $$< -o $$@ $$(ERROR))
	$$(call phony-ok,$$(MSG_INTL_PORTABLE),$$@)

$1/%/LC_MESSAGES/$2$$(firstword $$(moext)): $1/%/$2$$(firstword $$(poext))
	$$(call status,$$(MSG_INTL_MACHINE))
	$$(quiet) $$(call mksubdir,$1,$$@)
	$$(quiet) $$(MSGFMT) $$< -o $$@ $$(ERROR)
	$$(call ok,$$(MSG_INTL_MACHINE),$$@)
endef
$(foreach t,$(intltl),$(eval\
    $(call intl-translate-factory,$(strip \
        $(localedir)),$(call not-root,$(basename $t)))))
endif

#======================================================================#
# Function: texinfo-factory                                            #
# @param  $1 Type of doc to be generated                               #
# @param  $2 Extension that should be used for the doc file type       #
# @param  $3 Command to generate the doc file                          #
# @return Three targets: one to generate all files of a doc type; one  #
#         general target to create the files of this doc type; and a   #
#         target to generate the dir where the files should be put     #
#======================================================================#
define texinfo-factory
.PHONY: $1
$1: docsdep $$(texi$1)
	$$(call phony-ok,$$(MSG_TEXI_DOCS))

$$(docdir)/$1/%$2: $$(filter $$(docdir)/$$*%,$$(texiall)) \
                   | $$(docdir)/$1/
	$$(call status,$$(MSG_TEXI_FILE))
	$$(call mksubdir,$$(docdir)/$1,$$<)
	$$(quiet) $3 $$< -o $$@ $$(ERROR)
	$$(call srm,$$(notdir $$(basename $$@)).*)
	$$(call ok,$$(MSG_TEXI_FILE),$$@)

$$(docdir)/$1/:
	$$(quiet) $$(call mkdir,$$@)
endef
$(eval $(call texinfo-factory,info,$(firstword $(infoext)),$(MAKEINFO)))
$(eval $(call texinfo-factory,html,$(firstword $(htmlext)),$(TEXI2HTML)))
$(eval $(call texinfo-factory,dvi,$(firstword $(dviext)),$(TEXI2DVI)))
$(eval $(call texinfo-factory,pdf,$(firstword $(pdfext)),$(TEXI2PDF)))
$(eval $(call texinfo-factory,ps,$(firstword $(psext)),$(TEXI2PS)))

#======================================================================#
# Function: install-texinfo-factory                                    #
# @param  $1 Type of doc to be generated                               #
# @return Two targets: one to install the files of the specified doc   #
#         type (creating the directory as needed); and another one to  #
#         uninstall these files and delete the dir (if empty).         #
#======================================================================#
define install-texinfo-factory
.PHONY: install-$1
install-$1:
	$$(if $$(strip $$(texi$1)),$$(call mkdir,$$(i_$1dir)))
	$$(if $$(strip $$(texi$1)),$$(foreach f,$$(texi$1),\
	    $$(call phony-status,$$(MSG_INSTALL_DOC));\
	    $$(INSTALL_DATA) $$f $$(i_$1dir)/$$(notdir $$f);\
	    $$(call phony-ok,$$(MSG_INSTALL_DOC));\
	))

.PHONY: uninstall-$1
uninstall-$1:
	$$(if $$(strip $$(texi$1)),$$(call rm-if-empty,$$(i_$1dir),\
	    $$(addprefix $$(i_$1dir)/,$$(notdir $$(texi$1)))\
	))
endef
$(foreach type,html dvi pdf ps,\
    $(eval $(call install-texinfo-factory,$(type))))

#======================================================================#
# Function: installdirs                                                #
# @param  $1 Directory to be created for installation                  #
# @return Target to create directory for some installation             #
#======================================================================#
define installdirs
$1:
	$$(call mkdir,$$@)
endef
$(foreach d,$(i_libdir) $(i_bindir) $(i_sbindir) $(i_libexecdir),\
    $(eval $(call installdirs,$d)))

#======================================================================#
# Function: install-data                                               #
# @param  $1 Directory where the installation should be made           #
# @param  $2 Name of the data file to be installed                     #
# @return Target to install some data file                             #
#======================================================================#
define install-data
$1/$$(call not-root,$2): | $1/./
	$$(call phony-status,$$(MSG_INSTALL_DAT))
	$$(call mksubdir,$1,$2)
	$$(quiet) $$(INSTALL_DATA) $2 $$@
	$$(call phony-ok,$$(MSG_INSTALL_DAT))
endef
$(foreach t,lib,$(foreach b,$($t),\
    $(eval $(call install-data,$(i_$tdir),$b))))

#======================================================================#
# Function: install-program                                            #
# @param  $1 Directory where the installation should be made           #
# @param  $2 Name of the binary program to be installed                #
# @return Target to install some program                               #
#======================================================================#
define install-program
$1/$$(call not-root,$2): | $1/./
	$$(call phony-status,$$(MSG_INSTALL_BIN))
	$$(call mksubdir,$1,$2)
	$$(quiet) $$(INSTALL_PROGRAM) $2 $$@
	$$(call phony-ok,$$(MSG_INSTALL_BIN))
endef
$(foreach t,bin sbin libexec,$(foreach b,$($t),\
    $(eval $(call install-program,$(i_$tdir),$b))))

#======================================================================#
# Function: packsyst-factory                                           #
# @param  $1 Extension of the file package system                      #
# @param  $2 Part of the name of the var with text to be outputed      #
# @param  $3 Program to be used to generate the package                #
# @return Target to create a package with dirs specified by 'dirs' var #
#======================================================================#
define packsyst-factory
%.$1: clndirs = $$(foreach d,$$(dirs),$$(if $$(wildcard $$d*),$$d))
%.$1: packdir = $$(notdir $$*)
%.$1: packdep = $$(addprefix $$(packdir)/,\
        $$(strip $$(foreach f,$$(dirs),$$(or \
            $$(strip $$(call rwildcard,$$f,*)),\
            $$(strip $$(wildcard $$f*))) )))
%.$1: distdep $$(binall)
	$$(call mkdir,$$(dir $$@))
	$$(quiet) $$(MKDIR) $$(packdir)
	$$(quiet) $$(CP) $$(clndirs) $$(packdir)
	
	$$(call vstatus,$$(MSG_MAKE$2))
	$$(quiet) $3 $$@ $$(packdep)
	$$(call ok,$$(MSG_MAKE$2),$$@)
	
	$$(quiet) $$(RMDIR) $$(packdir)
endef
$(eval $(call packsyst-factory,tar,TAR,$(TAR)))
$(eval $(call packsyst-factory,zip,ZIP,$(ZIP)))

#======================================================================#
# Function: compression-factory                                        #
# @param  $1 Extension to be added in the compressed file              #
# @param  $2 Extension of the uncompressed file (for dependency)       #
# @param  $3 Part of the name of the var with text to be outputed      #
# @param  $4 Program to be used to generate the compressed package     #
# @return Target to create a compressed package from uncompressed one  #
#======================================================================#
define compression-factory
%.$1: %.$2
	$$(call status,$$(MSG_MAKE$3))
	$$(quiet) $4 $$< $$(ERROR)
	$$(call ok,$$(MSG_MAKE$3),$$@)
endef
$(eval $(call compression-factory,tar.gz,tar,TGZ,$(GZIP)))
$(eval $(call compression-factory,tar.bz2,tar,TBZ2,$(BZIP2)))

#======================================================================#
# Function: compression-shortcut                                       #
# @param  $1 Default extension generated by a compression tool         #
# @param  $2 Shortcut extension to be put in the file above            #
# @param  $3 Part of the name of the var with text to be outputed      #
# @return Target to create a compressed extension from another one     #
#======================================================================#
define compression-shortcut
%.$1: %.$2
	$$(call status,$$(MSG_MAKE$3))
	$$(quiet) $$(CP) $$< $$@ $$(ERROR)
	$$(call ok,$$(MSG_MAKE$3),$$@)
endef
$(eval $(call compression-shortcut,tgz,tar.gz,TGZ))
$(eval $(call compression-shortcut,tbz2,tar.bz2,TBZ2))

#======================================================================#
# Function: dist-factory                                               #
# @param  $1 Extension of the file package system                      #
# @return Phony targets to create a binary distribution and a source   #
#         distribution of the project                                  #
#======================================================================#
define dist-factory
.PHONY: package-$1
package-$1: dirs := Makefile $$(make_configs) $$(wildcard .git*)
package-$1: dirs += $$(srcdir) $$(incdir) $$(datadir) $$(docdir)
package-$1: dirs += $$(if $$(strip $$(lib)),$$(libdir)) $$(bindir)
package-$1: distdep $$(distdir)/$$(project)-$$(version)_src.$1

.PHONY: dist-$1
dist-$1: dirs := Makefile $$(make_configs)
dist-$1: dirs += $$(if $$(strip $$(lib)),$$(libdir)) $$(bindir)
dist-$1: distdep $$(distdir)/$$(project)-$$(version).$1
endef
$(foreach e,tar.gz tar.bz2 tar zip tgz tbz2,\
    $(eval $(call dist-factory,$e)))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: mostlyclean
mostlyclean:
	$(call rm-if-empty,$(objdir),\
	    $(srcobj) $(testobj) $(benchobj)\
	    $(covdata) $(covtestdata) $(covbenchdata))
	$(foreach d,$(call invert,$(sort $(dir $(fhead)))),\
	    $(call rm-if-empty,$d,$(filter $d%,$(fhead)))$(newline))

.PHONY: clean
clean: mostlyclean
	$(call rm-if-empty,$(bindir),$(bin) $(testbin) $(benchbin))
	$(call rm-if-empty,$(sbindir),$(sbin))
	$(call rm-if-empty,$(execdir),$(libexec))

.PHONY: distclean
distclean: clean
	$(call rm-if-empty,$(depdir),$(depall))
	$(call rm-if-empty,$(distdir))
	$(call rm-if-empty,$(firstword $(libdir)),\
	    $(filter $(firstword $(libdir))/%,$(lib)))
	$(call rm-if-empty,$(covdir),$(covrep) $(covtestrep) $(covbenchrep))

ifdef ENABLE_NLS
.PHONY: translationclean
translationclean:
	$(call rm-if-exists,$(intltl),$(MSG_INTLTL_NONE))
	$(call rm-if-exists,$(intlall),$(MSG_INTLALL_NONE))
	$(call rm-if-exists,$(intlobj),$(MSG_INTLOBJ_NONE))
	$(call rm-if-empty,$(localedir))
endif

.PHONY: docclean
docclean:
	$(call rm-if-empty,$(docdir)/doxygen)
	$(call rm-if-exists,$(docdir)/Doxyfile.mk,$(MSG_DOXY_NONE))
	$(call rm-if-empty,$(docdir)/info,$(texiinfo))
	$(call rm-if-empty,$(docdir)/html,$(texihtml))
	$(call rm-if-empty,$(docdir)/dvi,$(texidvi))
	$(call rm-if-empty,$(docdir)/pdf,$(texipdf))
	$(call rm-if-empty,$(docdir)/ps,$(texips))
	$(call rm-if-empty,$(docdir))

.PHONY: packageclean
packageclean:
	$(call rm-if-empty,$(distdir)/$(deb_project)-$(version))
	$(call rm-if-empty,$(debdir),$(deball))

.PHONY: externalclean
externalclean:
	$(foreach d,$(call invert,$(call hash-table.keys,git_dependency)),\
	    $(if $(wildcard $(extdir)/$d),\
	        $(call git-submodule-rm,$(extdir)/$d)$(newline)))
	$(foreach d,$(call invert,$(call hash-table.keys,web_dependency)),\
	    $(if $(wildcard $(extdir)/$d),\
	        $(call rmdir,$(extdir)/$d)$(newline)))
	$(call rm-if-empty,$(extdir),$(call rwildcard,*,$(externreq)))

.PHONY: realclean
ifndef D
realclean:
	@$(call println,$(MSG_WARNCLEAN_BEG))
	@$(call println,$(MSG_WARNCLEAN_END))
	@$(call println,$(MSG_WARNCLEAN_ALT))
else
realclean: distclean docclean packageclean externalclean \
           $(if $(ENABLE_NLS),translationclean)
	$(call rm-if-exists,$(lexall),$(MSG_LEX_NONE))
	$(foreach d,$(lexinc),$(call rm-if-empty,$d)$(newline))
	$(call rm-if-exists,$(yaccall),$(MSG_YACC_NONE))
	$(foreach d,$(yaccinc),$(call rm-if-empty,$d)$(newline))
	$(call rm-if-exists,$(esqlall),$(MSG_ESQL_NONE))
	$(call rm-if-exists,ctags,$(MSG_CTAGS_NONE))
	$(call rm-if-exists,etags,$(MSG_ETAGS_NONE))
endif

.PHONY: mainteiner-clean
ifndef D
mainteiner-clean:
	@$(call println,$(MSG_WARNCLEAN_BEG))
	@$(call println,$(MSG_WARNCLEAN_END))
	@$(call println,$(MSG_WARNCLEAN_ALT))
else
mainteiner-clean:
	@$(MAKE) realclean MAINTEINER_CLEAN=1 D=1
endif

.PHONY: uninitialize
ifndef U
uninitialize:
	@$(call println,$(MSG_UNINIT_WARN))
	@$(call println,$(MSG_UNINIT_ALT))
else
uninitialize:
	@$(MAKE) mainteiner-clean D=1
	$(call rm-if-empty,$(srcdir),$(srcall))
	$(call rm-if-empty,$(incdir),$(incall))
	$(call rm-if-empty,$(docdir),$(texiall))
	$(call rm-if-exists,Config.mk)
	$(call rm-if-exists,config.mk)
	$(call rm-if-exists,.config.mk)
	$(call rm-if-exists,Config_os.mk)
	$(call rm-if-exists,config_os.mk)
	$(call rm-if-exists,.config_os.mk)
	$(call rm-if-exists,.version.mk)
	$(call rm-if-exists,.gitignore)
	$(call rm-if-exists,.gitmodules)
	$(call rm-if-empty,.git)
endif

########################################################################
##                              OUTPUT                                ##
########################################################################

# Hide command execution details
V   ?= 0
Q_0 := @
quiet := $(Q_$V)

O_0 := 1> /dev/null
E_0 := 2> /dev/null
NO_OUTPUT    := $(O_$V)
NO_ERROR     := $(E_$V)
NO_OPERATION := :

# ANSII Escape Colors
ifndef NO_COLORS
DEF     := \033[0;38m
RED     := \033[1;31m
GREEN   := \033[1;32m
YELLOW  := \033[1;33m
BLUE    := \033[1;34m
PURPLE  := \033[1;35m
CYAN    := \033[1;36m
WHITE   := \033[1;37m
RES     := \033[0m
ERR     := \033[0;37m
endif

MSG_UNINIT_WARN   = "${RED}Are you sure you want to delete all"\
                    "sources, headers and configuration files?"
MSG_UNINIT_ALT    = "${DEF}Run ${BLUE}'make uninitialize U=1'${RES}"

MSG_MOVE          = "${YELLOW}Populating ${BLUE}$(firstword $2)"\
                    "${YELLOW}with $(strip $3) files${RES}"
MSG_NO_MOVE       = "${PURPLE}No $(strip $3) files to put in"\
                    "$(firstword $2)${RES}"

MSG_WEB_CLONE     = "${YELLOW}Downloading web dependency ${DEF}$2${RES}"

MSG_GIT_INIT      = "${YELLOW}[$(GIT)]"\
                    "${BLUE}Initializing empty repository${RES}"
MSG_GIT_TAG       = "${YELLOW}[$(GIT)]"\
                    "${BLUE}Creating new tag ${DEF}$(strip $1)${RES}"
MSG_GIT_CLONE     = "${YELLOW}[$(GIT)]"\
                    "${BLUE}Cloning repository ${DEF}$2${RES}"
MSG_GIT_ADD       = "${YELLOW}[$(GIT)]${BLUE} Adding"\
                    "$(if $(wordlist 2,2,$1),files,file)${DEF}"\
                    "$(subst $(space),$(comma)$(space),$(strip $1))"\
                    "${RES}"
MSG_GIT_COMMIT    = "${YELLOW}[$(GIT)]${BLUE}"\
                    "Commiting message ${DEF}\"$(strip $2)\"${RES}"
MSG_GIT_REM_ADD   = "${YELLOW}[$(GIT)]${BLUE} Setting ${DEF}$(strip $1)"\
                    "${BLUE}to remote ${DEF}$(strip $2)${RES}"
MSG_GIT_PULL      = "${YELLOW}[$(GIT)]${BLUE} Receiveing in${DEF}"\
                    "$(or $(strip $1),origin)${BLUE} from remote"\
                    "repository ${DEF}$(or $(strip $2),master)${RES}"
MSG_GIT_PUSH      = "${YELLOW}[$(GIT)]${BLUE} Sending from${DEF}"\
                    "$(or $(strip $1),origin)${BLUE} to remote"\
                    "repository ${DEF}$(or $(strip $2),master)${RES}"
MSG_GIT_SUB_ADD   = "${YELLOW}[$(GIT)]${BLUE} Adding git dependency"\
                    "${DEF}$(strip $2)${RES}"
MSG_GIT_SUB_RM    = "${YELLOW}[$(GIT)]${BLUE} Removing git dependency"\
                    "${DEF}$(strip $1)${RES}"

MSG_MAKE_CREATE   = "${PURPLE}Creating file ${DEF}$2"\
                    "${PURPLE}from target ${DEF}$(firstword $1)${RES}"

MSG_PRG_SEARCH    = "${DEF}Searching for $d dependency"\
                    "${GREEN}$($d)${RES}"
MSG_PRG_ALL       = "${YELLOW}All $n dependencies avaiable${RES}"
MSG_PRG_UNDEFINED = "${DEF}Undefined variable ${GREEN}$d${RES}"
MSG_PRG_NOT_FOUND = "${DEF}Dependency ${GREEN}$($d)${DEF}"\
                    "not found${RES}"
MSG_PRG_BAD_VER   = "${DEF}$d dependency ${GREEN}$($d)${DEF}"\
                    "has not the required version"\
                    "($(program_version.$d))${RES}"

MSG_LIB_SEARCH    = "${DEF}Searching for system library"\
                    "${GREEN}$d${RES}"
MSG_LIB_NOT_FOUND = "${DEF}System library ${GREEN}$d${DEF}"\
                    "not found${RES}"
MSG_LIB_BAD_VER   = "${DEF}System library ${RED}$d${DEF}"\
                    "has not the required version"\
                    "($(library_version.$d))${RES}"

MSG_EXT_BUILD     = "${YELLOW}Building dependency ${DEF}$d${RES}"
MSG_EXT_NO_MAKE   = "${DEF}No Makefile found for compilation${RES}"
MSG_EXT_BUILD_ERR = "${DEF}Failed compiling ${DEF}$@${RES}"

MSG_TOUCH         = "${PURPLE}Creating new file ${DEF}$1${RES}"
MSG_UPDATE_NMSH   = "${YELLOW}Updating namespace${DEF}"\
                    "$(subst /,::,${NMS_HEADER})"
MSG_UPDATE_LIBH   = "${YELLOW}Updating library${DEF}"\
                    "$(subst /,::,${LIB_HEADER})"
MSG_NEW_EXT       = "${RED}Extension '$1' invalid${RES}"
MSG_DELETE_WARN   = "${RED}Are you sure you want to do deletes?${RES}"
MSG_DELETE_ALT    = "${DEF}Run ${BLUE}'make delete FLAGS D=1'${RES}"

MSG_WARNCLEAN_BEG = "${RED}This command is intended for maintainers"\
                    "to use; it${RES}"
MSG_WARNCLEAN_END = "${RED}deletes files that may need special tools"\
                    "to rebuild.${RES}"
MSG_WARNCLEAN_ALT = "${RED}Run ${BLUE}'make $@ D=1'${RED} to confirm."\
                    "${RES}"

MSG_MKDIR         = "${CYAN}Creating directory"\
                    "$(call rm-trailing-bar,$1)${RES}"
MSG_RM            = "${BLUE}Removing ${RES}$1${RES}"
MSG_RMDIR         = "${BLUE}Removing directory ${CYAN}$1${RES}"
MSG_RM_NOT_EMPTY  = "${PURPLE}Directory ${WHITE}$d${RES} not empty"
MSG_RM_EMPTY      = "${PURPLE}Nothing to remove in $d${RES}"

MSG_CTAGS         = "${BLUE}Creating tags for ${YELLOW}Vi${RES}"
MSG_CTAGS_NONE    = "${PURPLE}No auto-generated tags for Vi${RES}"
MSG_ETAGS         = "${BLUE}Creating tags for ${YELLOW}Emacs${RES}"
MSG_ETAGS_NONE    = "${PURPLE}No auto-generated tags for Emacs${RES}"

MSG_INTL_TEMPLATE = "${DEF}Generating template ${GREEN}$@${RES}"
MSG_INTL_PORTABLE = "${DEF}Generating file for ${BLUE}$*${DEF}"\
                    "translation from ${GREEN}$<${RES}"
MSG_INTL_MACHINE  = "${DEF}Generating machine translation for"\
                    "${GREEN}$(notdir $(basename $@))${RES}"
MSG_INTLTL_NONE   = "${PURPLE}No translation templates${RES}"
MSG_INTLALL_NONE  = "${PURPLE}No translation portable objects${RES}"
MSG_INTLOBJ_NONE  = "${PURPLE}No translation machine objects${RES}"

MSG_TEXI_FILE     = "${DEF}Generating $1 file ${WHITE}$@${RES}"
MSG_TEXI_DOCS     = "${BLUE}Generating docs in ${WHITE}$@${RES}"

MSG_DOXY_DOCS     = "${YELLOW}Generating Doxygen docs${RES}"
MSG_DOXY_FILE     = "${BLUE}Generating Doxygen file ${WHITE}$@${RES}"
MSG_DOXY_MAKE     = "${BLUE}Generating Doxygen config ${WHITE}$@${RES}"
MSG_DOXY_NONE     = "${PURPLE}No auto-generated Doxyfile.mk${RES}"

MSG_INSTALL_BIN   = "${DEF}Installing binary file ${GREEN}$@${RES}"
MSG_UNINSTALL_BIN = "${DEF}Uninstalling binary file ${GREEN}$@${RES}"
MSG_INSTALL_DAT   = "${DEF}Installing data file ${GREEN}$@${RES}"
MSG_UNINSTALL_DAT = "${DEF}Uninstalling data file ${GREEN}$@${RES}"
MSG_INSTALL_DOC   = "${DEF}Installing document file ${BLUE}$f${RES}"
MSG_UNINSTALL_DOC = "${DEF}Uninstalling document file ${BLUE}$f${RES}"

MSG_DEB_STEP1     = "${YELLOW}[STEP_1]${DEF} Rename upstream tarball to"\
                    "${BLUE}${deb_project}_${version}.orig.tar.gz${RES}"
MSG_DEB_STEP2     = "${YELLOW}[STEP_2]${DEF} Unpacking upstream tarball"\
                    "and renaming directory${RES}"
MSG_DEB_STEP3     = "${YELLOW}[STEP_3]${DEF} Adding directory${CYAN}"\
                    "${debdir}${DEF} with Debian packaging files${RES}"
MSG_DEB_STEP4     = "${YELLOW}[STEP_4]${DEF} Building the Debian"\
                    "package${RES}"

MSG_LEX           = "${PURPLE}Generating scanner ${BLUE}$@${RES}"
MSG_LEX_NONE      = "${PURPLE}No auto-generated lexers${RES}"
MSG_YACC          = "${PURPLE}Generating parser ${BLUE}$@${RES}"
MSG_YACC_NONE     = "${PURPLE}No auto-generated parsers${RES}"
MSG_ESQL          = "${PURPLE}Generating embedded SQL ${BLUE}$@${RES}"
MSG_ESQL_NONE     = "${PURPLE}No auto-generated embedded SQL${RES}"

MSG_TEST          = "${BLUE}Testing ${WHITE}$(notdir $<)${RES}"
MSG_TEST_COMPILE  = "${DEF}Generating test executable"\
                    "${GREEN}$(notdir $(strip $@))${RES}"
MSG_TEST_FAILURE  = "${CYAN}Test '$(notdir $<)' did not passed${RES}"
MSG_TEST_SUCCESS  = "${YELLOW}All tests passed successfully${RES}"

MSG_BENCH         = "${BLUE}Running benchmark ${WHITE}$(notdir $<)${RES}"
MSG_BENCH_COMPILE = "${DEF}Generating benchmark executable"\
                    "${GREEN}$(notdir $(strip $@))${RES}"
MSG_BENCH_SUCCESS = "${YELLOW}All benchmarks runned successfully${RES}"

MSG_ALINT         = "${BLUE}Running analysis lint for ${GREEN}$f${RES}"
MSG_ALINT_SUCCESS = "${YELLOW}All analysis lints runned successfully${RES}"

MSG_SLINT         = "${BLUE}Running style lint for ${GREEN}$f${RES}"
MSG_SLINT_SUCCESS = "${YELLOW}All style lints runned successfully${RES}"

MSG_COV           = "${BLUE}Showing coverage analysis ${DEF}$f${RES}"
MSG_COV_NONE      = "${PURPLE}No coverage analysis reported in $f${RES}"
MSG_COV_COMPILE   = "${DEF}Generating coverage analysis ${WHITE}$@${RES}"

MSG_MAKETAR       = "${RED}Generating tar file ${BLUE}$@${RES}"
MSG_MAKEZIP       = "${RED}Generating zip file ${BLUE}$@${RES}"
MSG_MAKETGZ       = "${YELLOW}Compressing file ${BLUE}$@"\
                    "${YELLOW}(gzip)${RES}"
MSG_MAKETBZ2      = "${YELLOW}Compressing file ${BLUE}$@"\
                    "${YELLOW}(bzip2)${RES}"

MSG_ASM_COMPILE   = "${DEF}Generating Assembly artifact ${WHITE}$@${RES}"
MSG_ARLIB         = "${RED}Generating static library $@${RES}"

MSG_C_COMPILE     = "${DEF}Generating C artifact ${WHITE}$@${RES}"
MSG_C_LINKAGE     = "${YELLOW}Generating C executable ${GREEN}$@${RES}"
MSG_C_SHRLIB      = "${RED}Generating C shared library $@${RES}"
MSG_C_NO_FILE     = "${DEF}No files for C executable ${GREEN}$@${RES}"
MSG_C_LIBCOMP     = "${DEF}Generating C library artifact"\
                    "${YELLOW}$@${RES}"

MSG_F_COMPILE     = "${DEF}Generating Fortran artifact ${WHITE}$@${RES}"
MSG_F_LINKAGE     = "${YELLOW}Generating Fortran executable"\
                    "${GREEN}$@${RES}"
MSG_F_SHRLIB      = "${RED}Generating Fortran shared library $@${RES}"
MSG_F_NO_FILE     = "${DEF}No files for Fortran executable"\
                    "${GREEN}$@${RES}"
MSG_F_LIBCOMP     = "${DEF}Generating Fortran library artifact"\
                    "${YELLOW}$@${RES}"

MSG_CXX_COMPILE   = "${DEF}Generating C++ artifact ${WHITE}$@${RES}"
MSG_CXX_LINKAGE   = "${YELLOW}Generating C++ executable ${GREEN}$@${RES}"
MSG_CXX_SHRLIB    = "${RED}Generating C++ shared library $@${RES}"
MSG_CXX_NO_FILE   = "${DEF}No files for C++ executable ${GREEN}$@${RES}"
MSG_CXX_LIBCOMP   = "${DEF}Generating C++ library artifact"\
                    "${YELLOW}$@${RES}"

MSG_RUN           = "${YELLOW}Running executable ${GREEN}$<${RES}"
MSG_RUN_BAD_EXEC  = "${DEF}Executable ${GREEN}$(EXEC)${DEF}"\
                    "is not produced by this Makefile${RES}"
MSG_RUN_ERROR     = "${DEF}Failed running ${GREEN}$<${RES}"

########################################################################
##                            FUNCTIONS                               ##
########################################################################

## TARGET FILES ########################################################
define make-create
$(if $(and $(call is-empty,$3),$(wildcard $2)),,\
	$(call phony-status,$(MSG_MAKE_CREATE))$(newline)\
	$(quiet) $(MAKE) $1 $(if $(filter -k,$(MAKE)),,> $2)$(newline)\
	$(call phony-ok,$(MSG_MAKE_CREATE)))$(newline)
endef

## DEPENDENCIES ########################################################
# Functions: *-depend
# @param $1 Source name (with path)
# @param $2 Main target to be analised
# @param $3 Dependency file name

define c-depend
$(CC) -MM -MF $(depdir)/$3$(depext) -MP -MT $2 $(cppflags) \
      $(clibs) $(filter-out $(ccovflags),$(cflags)) $1
endef

define cpp-depend
$(CXX) -MM -MF $(depdir)/$3$(depext) -MP -MT $2 $(cppflags) \
       $(cxxlibs) $(filter-out $(cxxcovflags),$(cxxflags)) $1
endef

define fortran-depend
$(FC) -MM -MF $(depdir)/$3$(depext) -MP -MT $2 \
      -J $(firstword $(incdir))/$(dir $3) $(cppflags) \
      $(flibs) $(filter-out $(fcovflags),$(fflags)) $1
endef

## DIRECTORIES #########################################################
define mkdir
$(if $(shell if ! [ -d $(strip $(patsubst .,,$1)) ]; then echo 1; fi),\
	$(if $(strip $(patsubst .,,$1)), $(call phony-status,$(MSG_MKDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(MKDIR) $1              )
	$(if $(strip $(patsubst .,,$1)), $(call phony-ok,$(MSG_MKDIR))     )
)
endef

# Create a subdirectory tree in the first element of a list of roots
define mksubdir
$(if $(strip $(patsubst .,,$1)),\
	$(quiet) $(MKDIR) $(firstword $1)/$(strip $(call not-root,$(dir $2))))
endef

define mv
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(if $(strip $(wildcard $(firstword $2/*))),,\
        $(call mkdir,$(firstword $2))\
))
$(call phony-status,$(MSG_MOVE))
$(strip $(foreach e,$(strip $1),\
    $(if $(strip $(wildcard *$e)),\
        $(quiet) $(MV) $(wildcard *$e) $(firstword $2);\
    )\
))
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(call phony-ok,$(MSG_MOVE)),\
    $(call phony-ok,$(MSG_NO_MOVE))\
)
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(call git-add-commit,\
        $(addprefix $(firstword $2)/,\
            $(foreach e,$(strip $1),$(wildcard *$e))),\
        "Move $(subst $(dquote),,$3) files to $(firstword $2)/")\
)
endef

## REMOTION ############################################################
define srm
	$(quiet) $(RM) $1 $(NO_ERROR);
endef

define srmdir
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(RMDIR) $1;)
endef

define rm
$(if $(strip $(patsubst .,,$1)),\
	$(call phony-status,$(MSG_RM))
	$(quiet) $(RM) $1;
	$(call phony-ok,$(MSG_RM))
)
endef

define rmdir
	$(if $(strip $(patsubst .,,$1)), $(call phony-status,$(MSG_RMDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(RMDIR) $1;             )
	$(if $(strip $(patsubst .,,$1)), $(call phony-ok,$(MSG_RMDIR))     )
endef

#======================================================================#
# Function: rm-if-empty                                                #
# If MAINTEINER_CLEAN is setted, or there is no $2 arg, the function   #
# does not test for extra files in the directory (see below)           #
# @param $1 Directory name                                             #
# @param $2 Files in $1 that should be removed from within $1          #
# .---------.-----.-------.-------.------------.                       #
# | Dir not | 2nd | Extra |  Dir  | Result     |                       #
# |  empty  | arg | files | exist |            |                       #
# |=========|=====|=======|=======|============|                       #
# |         |     |       |       | nothing    | }                     #
# |         |     |   X   |       | nothing    | } When dir is         #
# |         |  X  |       |       | nothing    | } empty               #
# |         |  X  |   X   |       | nothing    | }                     #
# |         |     |       |   X   | remove     | }                     #
# |    X    |     |       |   X   | remove     | - With or without     #
# |    X    |     |   X   |   X   | remove     | - rest., remove.      #
# |    X    |  X  |       |   X   | remove     | - ok? Remove!         #
# |    X    |  X  |   X   |   X   | not_remove | } Not remove,         #
# '---------'-----'-------'-------'------------'   otherwise           #
#======================================================================#
define rm-if-empty
	$(if $(strip $2),$(call srmdir,$2))
	$(foreach d,$(strip $(call rm-trailing-bar,$1)),\
	    $(if $(strip $(call rwildcard,$d,*)),\
	        $(if $(strip $2),
	            $(if $(strip $(MAINTEINER_CLEAN)),\
	                $(call rmdir,$d),\
	                $(if $(strip \
	                  $(call rfilter-out,$(call rsubdir,$d),\
	                  $(call rfilter-out,$2,$(call rwildcard,$d,*)))),\
	                    $(call phony-ok,$(MSG_RM_NOT_EMPTY)),\
	                    $(call rmdir,$d)\
	            )),\
	            $(call rmdir,$d)\
	        ),\
	        $(if $(wildcard $d),\
	            $(call rmdir,$d),\
	            $(call phony-ok,$(MSG_RM_EMPTY))\
	        )\
	))
endef

#======================================================================#
# Function: rm-if-exists                                               #
# @param $1 File to be removed                                         #
# @param $1 Message to be outputed if the file was not found           #
#======================================================================#
define rm-if-exists
$(if $(wildcard $1),\
    $(call rm,$1),$(if $(strip $2),$(call phony-ok,$(strip $2))))
endef

## PRINT FUNCTIONS #####################################################
ifndef SILENT

define printf
printf $1 $2 $(strip $3)
endef

define print
$(call printf,"%b",$(call join-strings,$1),$2)
endef

define println
$(call print,$1"\n",$2)
endef

else # ifndef SILENT

define print
$(NO_OPERATION)
endef

define println
$(NO_OPERATION)
endef

endif # ifndef SILENT

## ERROR SHELL #########################################################
ifndef SILENT
ifndef MORE

define ERROR_SEPARATOR
$(shell printf '%*s\n' "$${COLUMNS:-$$(tput cols)}" '' | tr ' ' '#')
endef

define ERROR
2>&1 | sed -e '1 s/^/\'$$'\n''$(ERROR_SEPARATOR)\'$$'\n/' \
           -e '1 s/^\$$//g' -e '1 s/#\$$/#/' \
           -e '$$ s/$$/\'$$'\n''$(ERROR_SEPARATOR)/' \
           -e '$$ s/\$$\(.*\)#/\1#/g'
endef
#| sed '1 s/^/> stderr:\n/'                 # '> stderr:' in 1st line
#| sed 's/^/> /'                            # Put '> ' before each line
#| sed ''/"> error"/s//`printf "${ERR}"`/'' # Gray color with above

else # ifndef MORE

define ERROR
2>&1 | more
endef

endif # ifndef MORE
endif # ifndef SILENT

## ERROR MAKEFILE ######################################################
ifndef SILENT

define model-error
if [ ! -f $(statusfile) ] || [ -z $$(cat $(statusfile) 2>/dev/null) ];\
then\
    $(RM) $(statusfile);\
    ($(call println,"\r${RED}[ERROR]${RES}" $1 \
                    "${RED}(STATUS: $$?)${RES}") && exit 42);\
fi
endef

define model-test-error
($(call println,"\r${RED}[FAILURE]${RES}" $1"." \
                "${RED}Aborting status: $$?${RES}") &&  exit 42)
endef

define phony-error
@$(call model-error,$1)
endef

else # ifndef SILENT

define model-error
$(NO_OPERATION)
endef

define model-test-error
$(NO_OPERATION)
endef

endif # ifndef SILENT

## STATUS PERSISTENCE ##################################################
ifndef SILENT

define store-status
($1; echo $$? > $(statusfile))
endef

else # ifndef SILENT

define store-status
$1
endef

endif # ifndef SILENT

## STATUS ##############################################################
ifdef $(and $(call is-empty,$(SILENT)),$(call not-empty,$(quiet)))

define model-status
$(call print,$1 "... ")
endef

define model-vstatus
$(call println,$1 "... ")
endef

define phony-status
	@$(call model-status,$1)
endef

define phony-vstatus
	@$(call model-vstatus,$1)
endef

define status
	@$(RM) $@ && $(call model-status,$1)
endef

define vstatus
	@$(RM) $@ && $(call model-vstatus,$1)
endef

else # if empty $(SILENT) and not empty $(quiet)

define model-status
$(NO_OPERATION)
endef

define model-vstatus
$(NO_OPERATION)
endef

endif # if empty $(SILENT) and not empty $(quiet)

## ACKNOWLEDGMENT ######################################################
ifndef SILENT

define model-ok
$(RM) $(statusfile); $(call println,"\r${GREEN}[OK]${RES}" $1 "     ")
endef

define phony-ok
@if [ -n $$? ] && [ -n $$(cat $(statusfile) 2>/dev/null) ];\
    then $(call model-ok,$1);\
    else $(call model-error,$1);\
fi;
endef

define ok
@if [ -f $2 ] && [ -n $$(cat $(statusfile) 2>/dev/null) ];\
    then $(call model-ok,$1);\
    else $(call model-error,$1);\
fi;
endef

else # ifndef SILENT

define model-ok
$(NO_OPERATION)
endef

endif # ifndef SILENT

## TEXT ################################################################

# Function: shstring
# Transforms a text valid inside make in a valid for shell
define shstring
$(strip $(subst $(space),\$(space),$(strip $1)))
endef

# Function: select
# Define which ostream should be used
define select
$(eval ostream = $(strip $(if $(call not-empty,$1),$1)))
endef

# Function: cat
# Add a text in the end of a ostream
define cat
$(if $(or $(call is-empty,$(ostream)),\
          $(call not,$(wildcard $(ostream)*))),\
    $(quiet) $(call printf,"%b\n",$1,\
                           $(if $(strip $(ostream)),>> $(ostream))))
endef

# Function: touch
# Create a new file based on a model
# @param $1 File to be created
# @param $2 Model to be used in the creation (optional)
# @param $3 Command to postprocess $1 content (with pipe)
define touch
$(if $(wildcard $1*),,\
    $(call phony-status,$(MSG_TOUCH)))
$(if $(wildcard $1*),,\
    $(if $(strip $2),\
        $(quiet) cat $2 $(strip $3) > $1,\
        $(quiet) touch $1))
$(if $(wildcard $1*),,\
    $(call phony-ok,$(MSG_TOUCH)))
endef

## VERSIONMENT #########################################################
ifndef NO_GIT

git_version          := $(subst git version,,$(shell git --version))

GIT_ADD              := $(GIT) add -f
GIT_CLONE            := $(GIT) clone -q --recursive
GIT_COMMIT           := $(GIT) commit -q -m
GIT_DIFF             := $(GIT) diff --quiet
GIT_INIT             := $(GIT) init -q  
GIT_LS_FILES         := $(GIT) ls-files --error-unmatch 2>/dev/null 1>&2
GIT_PULL             := $(GIT) pull -q  
GIT_PUSH             := $(GIT) push -q  
GIT_REMOTE           := $(GIT) remote
GIT_REMOTE_ADD       := $(GIT_REMOTE) add
GIT_RM               := $(GIT) rm -q
GIT_SUBMODULE        := $(GIT) submodule -q
GIT_SUBMODULE_ADD    := $(GIT_SUBMODULE) add -f
GIT_SUBMODULE_INIT   := $(GIT_SUBMODULE) init
GIT_TAG              := $(GIT) tag

ifdef $(call version-gt,$(git_version),1.8.3)
GIT_SUBMODULE_DEINIT := $(GIT_SUBMODULE) deinit -f
else
GIT_SUBMODULE_DEINIT := $(NO_OPERATION)
endif

define git-cmd-factory
model-git-$1 = \
    $$(call store-status,$(GIT_$2) $$1) $$(ERROR) \
    && $$(call model-error,"Error on $1")
phony-git-$1 = \
    $$(quiet) $$(call model-git-$1,$$1)
endef
$(foreach c,\
    ADD CLONE COMMIT DIFF INIT LS_FILES PULL PUSH REMOTE REMOTE_ADD \
    RM SUBMODULE SUBMODULE_ADD SUBMODULE_INIT SUBMODULE_DEINIT TAG, \
    $(eval $(call git-cmd-factory,$(subst _,-,$(call lc,$c)),$c)))

define git-clone
	$(call phony-status,$(MSG_GIT_CLONE))
	$(call phony-git-clone,$1 $2)
	$(call phony-ok,$(MSG_GIT_CLONE))
endef

define git-init
	$(quiet) if ! [ -d .git ]; \
	         then \
	             $(call model-status,$(MSG_GIT_INIT)); \
	             $(call model-git-init);               \
	             $(call model-ok,$(MSG_GIT_INIT));     \
	         fi
endef

define git-tag
	$(quiet) if ! $(GIT_TAG) | grep -q $1; \
	         then \
	             $(call model-status,$(MSG_GIT_TAG)); \
	             $(call model-git-tag,$1);            \
	             $(call model-ok,$(MSG_GIT_TAG));     \
	         fi
endef

define git-add
	$(quiet) if ! $(GIT_LS_FILES) $1 || ! $(GIT_DIFF) $1; \
	         then \
	             $(call model-status,$(MSG_GIT_ADD)); \
	             $(call model-git-add,$1);            \
	             $(call model-ok,$(MSG_GIT_ADD));     \
	         fi
endef

define git-commit
	$(quiet) if ! $(GIT_DIFF) --cached $1; \
             then \
                 $(call model-status,$(MSG_GIT_COMMIT)); \
                 $(call model-git-commit,$(strip $2));   \
                 $(call model-ok,$(MSG_GIT_COMMIT));     \
             fi
endef

define git-add-commit
	$(quiet) if ! $(GIT_LS_FILES) $1 || ! $(GIT_DIFF) $1; \
	         then \
	             $(call model-status,$(MSG_GIT_COMMIT)); \
	             $(call model-git-add,$1);               \
	             $(call model-git-commit,$(strip $2));   \
	             $(call model-ok,$(MSG_GIT_COMMIT));     \
	         fi
endef

define git-submodule-add
	$(call phony-status,$(MSG_GIT_SUB_ADD))
	$(quiet) if [ -f $(call rm-trailing-bar,$(dir $2))/.git ]; \
	         then \
	             cd $(dir $2);                                     \
	             $(call model-git-submodule-add,$1 $(notdir $2));  \
	             $(call model-git-submodule-init,$(notdir $2));    \
	             $(call model-git-commit,"Add $(notdir $2)");      \
	             cd $(MAKECURRENTDIR);                             \
	             $(call model-git-add,$(dir $2));                  \
	             $(call model-git-commit,"Add sub-submodule $2");  \
	         else \
	             $(call model-git-submodule-add,$1 $2);            \
	             $(call model-git-submodule-init,$2);              \
	             $(call model-git-commit,"Add submodule $2");      \
	         fi
	$(call phony-ok,$(MSG_GIT_SUB_ADD))
endef

define git-submodule-rm
	$(call phony-status,$(MSG_GIT_SUB_RM))
	$(quiet) if [ -f $(call rm-trailing-bar,$(dir $1))/.git ]; \
	         then \
	             cd $(dir $1);                                       \
	             $(call model-git-submodule-deinit,$(notdir $1));    \
	             $(call model-git-rm,--cached $(notdir $1));         \
	             $(call model-git-commit,"Remove $(notdir $1)");     \
	             $(RMDIR) $1 $(ERROR);                               \
	             cd $(MAKECURRENTDIR);                               \
	             $(call model-git-add,$(dir $1));                    \
	             $(call model-git-commit,"Remove sub-submodule $1"); \
	             $(RMDIR) .git/modules/$(notdir $1) $(ERROR);        \
	         else \
	             $(call model-git-submodule-deinit,$1);              \
	             $(call model-git-rm,--cached $1);                   \
	             $(call model-git-commit,"Remove submodule $1");     \
	             $(RMDIR) $1 $(ERROR);                               \
	             $(RMDIR) .git/modules/$1 $(ERROR);                  \
	         fi 
	$(call phony-ok,$(MSG_GIT_SUB_RM))
endef

ifneq (,$(or $(strip $(GIT_REMOTE_PATH)),$(strip \
             $(findstring upgrade,$(MAKECMDGOALS)))))

define git-remote-add
	$(quiet) if ! $(GIT_REMOTE) | grep "^$1$$" $(NO_OUTPUT); \
	         then \
	             $(call model-status,$(MSG_GIT_REM_ADD)); \
	             $(call model-git-remote-add,$1 $2);      \
	             $(call model-ok,$(MSG_GIT_REM_ADD));     \
	         fi
endef

define git-pull
	$(call phony-status,$(MSG_GIT_PULL))
	$(quiet) $(if $(strip $3),cd $3 && ) \
	         $(call model-git-pull,$(or $(strip $1),origin) \
	                               $(or $(strip $2),master))
	$(call phony-ok,$(MSG_GIT_PULL))
endef

define git-push
	$(call phony-status,$(MSG_GIT_PUSH))
	$(quiet) $(if $(strip $3),cd $3 && ) \
	         $(call model-git-push,$(or $(strip $1),origin) \
	                               $(or $(strip $2),master))
	$(call phony-ok,$(MSG_GIT_PUSH))
endef

endif # not empty GIT_REMOTE_PATH

endif # ifndef NO_GIT

## WEB DEPENDENCIES ####################################################
define web-clone
	$(call phony-status,$(MSG_WEB_CLONE))
	$(quiet) $(CURL) $2 $1 $(NO_OUTPUT) $(NO_ERROR)
	$(quiet) $(call model-git-add,$2)
	$(quiet) $(call model-git-commit,"Add web dependency $2")
	$(call phony-ok,$(MSG_WEB_CLONE))
endef

########################################################################
##                           MANAGEMENT                               ##
########################################################################

# Executes iff one of the make goals is 'new' or 'delete'
ifneq (,$(foreach g,$(MAKECMDGOALS),$(filter $g,new delete update)))

# File path
# ===========
# 1) Remove trailing bars if it is a directory-only name
# 2) Substitute C++ namespace style (::) by path style (/)
# 3) If the name includes a root src/inc directory, remove-it.
ifdef IN
#------------------------------------------------------------------[ 1 ]
override IN := $(strip $(call rm-trailing-bar,$(IN)))
#------------------------------------------------------------------[ 2 ]
override IN := $(subst ::,/,$(IN))
#------------------------------------------------------------------[ 3 ]
override IN := $(strip $(or $(strip $(foreach d,$(srcdir) $(incdir),\
                   $(if $(strip $(patsubst $d%,%,$(call root,$(IN)))),,\
                       $(call not-root,$(IN))\
               ))),$(IN)))
endif

# File properties
# =================
# 1) Get standard namespace
# 2) Check if standard namespace number of words and style
# 4) Create default #ifndef to be used in C/C++ preproc directive
# 5) Create default namespace structure to be used with C++
# 6) Create namespace name to 'using namespace' in C++ source file
# 7) Define identation accordingly to namespace depth
#------------------------------------------------------------------[ 4 ]
std_namespace := $(strip $(STD_NAMESPACE))
#------------------------------------------------------------------[ 4 ]
$(if $(call gt,$(words $(std_namespace)),1),\
    $(error "Standard namespace MUST have only one word"))
$(if $(call not,$(call is-identifier,$(std_namespace))),\
    $(error "Standard namespace MUST have match [A-Za-z0-9_]*"))
#------------------------------------------------------------------[ 4 ]
indef         := $(strip $(addsuffix _,$(call uc,$(std_namespace))))
indef         := $(indef)$(addsuffix _,$(call uc,$(subst /,_,$(IN))))
#------------------------------------------------------------------[ 5 ]
innms         := $(strip $(call lc,$(subst _,$(space),$(indef))))
#------------------------------------------------------------------[ 6 ]
inusing       := $(strip $(subst $(space),::,$(innms)))
#------------------------------------------------------------------[ 7 ]
idnt          := $(if $(strip $(IN)),    )

# Extension variables
# =====================
override SRC_EXT := $(strip $(if $(strip $(SRC_EXT)),\
    $(or $(filter .%,$(SRC_EXT)),.$(SRC_EXT))))
override INC_EXT := $(strip $(if $(strip $(INC_EXT)),\
    $(or $(filter .%,$(INC_EXT)),.$(INC_EXT))))

# Function: sfmt
# Format to make a preprocessor symbol
# $1 File name
define sfmt
$(call uc,$1)
endef

# Function: invalid-ext
# $1 File extension
# $2 List of extensions to validate as correct $1, if it is not empty
define invalid-ext
$(if $(strip $1),$(if $(findstring $(strip $1),$2),,\
    $(call phony-error,$(MSG_NEW_EXT))\
))
endef

# Function: start-namespace
# Create new namespaces from the IN variable
# If there are 'n' namespaces, put the first 'n-1' with open
# curly-braces in the same line, and the last one in the last line
define start-namespace
$(if $(innms),\
    $(call cat,"$(strip $(subst \\n$(space),\\n,\
        $(patsubst %,namespace % {\\n,$(call rcdr,$(innms)))\
        $(patsubst %,namespace % \\n{,$(call rcar,$(innms)))\
))"))
endef

# Function: end-namespace
# End the namespaces using the IN variable for namespace depth
define end-namespace
$(if $(innms),\
    $(call cat,"$(subst } ,},$(foreach n,$(innms),}))"))
endef

# Function: include-files
# Create include directives (#include) for all files in $1
define include-files
$(call cat,$(subst \\n ,\\n,\
    $(patsubst %,'#include "%"'\\n,$(sort $1))))
endef

# Path variables
# ================
# Auxiliar variables to the default place to create/remove
# files created by this makefile (usually the first inc/src dirs)
override incbase := $(strip $(firstword $(incdir)))$(if $(IN),/$(IN))
override srcbase := $(strip $(firstword $(srcdir)))$(if $(IN),/$(IN))

# Check if directory exists
ifdef $(call not-empty,$(IN))
$(if $(findstring $(IN),$(call rsubdir,$(incbase) $(srcbase))),,\
    $(error Namespace "$(IN)" does not exist))
endif

# Artifacts
# ===========
# C/C++ Artifacts that may be created by this Makefile
override NAMESPACE     := $(strip $(notdir $(NAMESPACE)))
override NMS_HEADER    := $(strip $(basename $(notdir $(NMS_HEADER))))
override LIBRARY       := $(strip $(notdir $(LIBRARY)))
override LIB_HEADER    := $(strip $(basename $(notdir $(LIB_HEADER))))
override C_FILE        := $(strip $(basename $(notdir $(C_FILE))))
override F_FILE        := $(strip $(basename $(notdir $(F_FILE))))
override CXX_FILE      := $(strip $(basename $(notdir $(CXX_FILE))))
override C_MODULE      := $(strip $(basename $(notdir $(C_MODULE))))
override F_MODULE      := $(strip $(basename $(notdir $(F_MODULE))))
override CXX_MODULE    := $(strip $(basename $(notdir $(CXX_MODULE))))
override C_MAIN        := $(strip $(basename $(notdir $(C_MAIN))))
override F_MAIN        := $(strip $(basename $(notdir $(F_MAIN))))
override CXX_MAIN      := $(strip $(basename $(notdir $(CXX_MAIN))))
override CLASS         := $(strip $(basename $(notdir $(CLASS))))
override TEMPLATE      := $(strip $(basename $(notdir $(TEMPLATE))))
override TRANSLATION   := $(strip $(basename $(notdir $(TRANSLATION))))
override NLS_HEADER    := $(strip $(basename $(notdir $(NLS_HEADER))))
override MAJOR_RELEASE := $(strip $(basename $(notdir $(MAJOR_RELEASE))))
override MINOR_RELEASE := $(strip $(basename $(notdir $(MINOR_RELEASE))))
override PATCH_RELEASE := $(strip $(basename $(notdir $(PATCH_RELEASE))))

$(foreach f,ALPHA BETA TIMESTAMP,\
    $(if $($f),$(eval $f := $(call lc,$f))))

# Check if there is at least one artifact to be created/deleted
$(if $(strip \
    $(or $(NAMESPACE),$(NMS_HEADER),\
         $(LIBRARY),$(LIB_HEADER),\
         $(C_FILE),$(F_FILE),$(CXX_FILE),\
         $(C_MODULE),$(F_MODULE),$(CXX_MODULE),\
         $(C_MAIN),$(F_MAIN),$(CXX_MAIN),\
         $(CLASS),$(TEMPLATE),\
         $(TRANSLATION),$(NLS_HEADER),\
         $(MAJOR_RELEASE),$(MINOR_RELEASE),$(PATCH_RELEASE),\
     )),,\
     $(error No filetype defined. Type 'make projecthelp' for info))

.PHONY: new
new: | $(call root,$(incbase))/./ $(call root,$(srcbase))/./
ifdef NAMESPACE
	$(call mkdir,$(incbase)/$(subst ::,/,$(NAMESPACE)))
	$(call mkdir,$(srcbase)/$(subst ::,/,$(NAMESPACE)))
endif
ifdef NMS_HEADER
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	
	@# NMSH: Namespace directory
	$(eval NMSH       := $(subst ::,/,$(NMS_HEADER)))
	$(eval NMSH       := $(if $(strip $(IN)),$(IN)/)$(NMSH))
	$(eval NMSH       := $(firstword $(filter %$(NMSH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval NMSH       := $(call rm-trailing-bar,$(NMSH)))
	
	@# NMSH_NAME: File name for the Namespace header
	$(eval NMSH_NAME  := $(notdir $(basename $(NMSH))))
	
	@# NMSH_FILES: Files to be put in the Namespace Header
	$(eval NMSH_FILES := $(filter $(NMSH)/%,$(incall)))
	$(eval NMSH_FILES := $(call not-root,\
	    $(filter-out $(NMSH)/$(NMSH_NAME).%,\
	        $(foreach f,$(NMSH_FILES),\
	            $(firstword $(filter %$f,$(incall)))\
	))))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(NMSH)/$(NMSH_NAME)$(INC_EXT),$(notice))
	$(call select,$(NMSH)/$(NMSH_NAME)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef NMS_$(indef)$(call sfmt,$(NMSH_NAME))_DEFINED' )
	$(call cat,'#define NMS_$(indef)$(call sfmt,$(NMSH_NAME))_DEFINED' )
	$(call cat,''                                                      )
	$(call cat,'// Libraries'                                          )
	$(call include-files,$(NMSH_FILES)                                 )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef LIBRARY
	$(call mkdir,$(incbase)/$(subst ::,/,$(LIBRARY)))
endif
ifdef LIB_HEADER
	$(if $(INC_EXT),,$(eval override INC_EXT := .tcc))
	
	@# LIBH: Library directory
	$(eval LIBH       := $(subst ::,/,$(LIB_HEADER)))
	$(eval LIBH       := $(if $(strip $(IN)),$(IN)/)$(LIBH))
	$(eval LIBH       := $(firstword $(filter %$(LIBH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval LIBH       := $(call rm-trailing-bar,$(LIBH)))
	
	@# LIBH_NAME: File name for the Library header
	$(eval LIBH_NAME  := $(notdir $(basename $(LIBH))))
	
	@# LIBH_FILES: Files to be put in the Library header
	$(eval LIBH_FILES := $(filter $(LIBH)/%,$(incall)))
	$(eval LIBH_FILES := $(call not-root,\
	    $(filter-out $(LIBH)/$(LIBH_NAME).%,\
	        $(foreach f,$(LIBH_FILES),\
	            $(firstword $(filter %$f,$(incall)))\
	))))
	
	$(call invalid-ext,$(INC_EXT),$(tlext))
	$(call touch,$(LIBH)/$(LIBH_NAME)$(INC_EXT),$(notice))
	$(call select,$(LIBH)/$(LIBH_NAME)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef LIB_$(indef)$(call sfmt,$(LIBH_NAME))_DEFINED' )
	$(call cat,'#define LIB_$(indef)$(call sfmt,$(LIBH_NAME))_DEFINED' )
	$(call cat,''                                                      )
	$(call cat,'// Libraries'                                          )
	$(call include-files,$(LIBH_FILES)                                 )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef C_FILE
	$(if $(INC_EXT),,$(eval override INC_EXT := .h))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .c))
	
	$(call invalid-ext,$(INC_EXT),$(hext))
	$(call touch,$(incbase)/$(C_FILE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(C_FILE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef H_$(indef)$(call sfmt,$(C_FILE))_DEFINED'      )
	$(call cat,'#define H_$(indef)$(call sfmt,$(C_FILE))_DEFINED'      )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cext))
	$(call touch,$(srcbase)/$(C_FILE)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(C_FILE)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'/* Libraries */'                                       )
	$(call cat,'#include "$(C_FILE)$(INC_EXT)"'                        )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef F_FILE
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .f))
	
	$(call invalid-ext,$(SRC_EXT),$(fext))
	$(call touch,$(srcbase)/$(F_FILE)$(SRC_EXT),$(notice),\
                 | sed 's/\//!/g')
	$(call select,$(srcbase)/$(F_FILE)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,''                                                      )
	$(call cat,'$(idnt)'                                               )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef CXX_FILE
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CXX_FILE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(CXX_FILE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(CXX_FILE))_DEFINED'  )
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(CXX_FILE))_DEFINED'  )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CXX_FILE)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(CXX_FILE)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'// Libraries'                                          )
	$(call cat,'#include "$(CXX_FILE)$(INC_EXT)"'                      )
	$(call cat,$(if $(inusing),'using namespace $(inusing);')          )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef C_MODULE
	$(if $(INC_EXT),,$(eval override INC_EXT := .h))
	
	$(call invalid-ext,$(INC_EXT),$(hext))
	$(call touch,$(incbase)/$(C_MODULE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(C_MODULE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef H_$(indef)$(call sfmt,$(C_MODULE))_DEFINED'    )
	$(call cat,'#define H_$(indef)$(call sfmt,$(C_MODULE))_DEFINED'    )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call mkdir,$(srcbase)/$(C_MODULE))
	
	$(call select,stdout)
endif
ifdef F_MODULE
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .f))
	
	$(call invalid-ext,$(SRC_EXT),$(fext))
	$(call touch,$(srcbase)/$(F_MODULE)$(SRC_EXT),$(notice),\
                 | sed 's/\//!/g')
	$(call select,$(srcbase)/$(F_MODULE)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'module $(F_MODULE)'                                    )
	$(call cat,''                                                      )
	$(call cat,'    implicit none'                                     )
	$(call cat,''                                                      )
	$(call cat,'    private'                                           )
	$(call cat,'    public'                                            )
	$(call cat,''                                                      )
	$(call cat,'contains'                                              )
	$(call cat,''                                                      )
	$(call cat,'end module $(F_MODULE)'                                )
	
	$(call select,stdout)
endif
ifdef CXX_MODULE
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CXX_MODULE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(CXX_MODULE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(CXX_MODULE))_DEFINED')
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(CXX_MODULE))_DEFINED')
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call mkdir,$(srcbase)/$(CXX_MODULE))
	
	$(call select,stdout)
endif
ifdef C_MAIN
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .c))
	
	$(call invalid-ext,$(SRC_EXT),$(cext))
	$(call touch,$(srcbase)/$(C_MAIN)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(C_MAIN)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'int main(int argc, char **argv)'                       )
	$(call cat,'{'                                                     )
	$(call cat,'    return 0;'                                         )
	$(call cat,'}'                                                     )
	
	$(call select,stdout)
endif
ifdef F_MAIN
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .f))
	
	$(call invalid-ext,$(SRC_EXT),$(fext))
	$(call touch,$(srcbase)/$(F_MAIN)$(SRC_EXT),$(notice),\
                 | sed 's/\//!/g')
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call select,$(srcbase)/$(F_MAIN)$(SRC_EXT))
	$(call cat,'program $(F_MAIN)'                                     )
	$(call cat,'end program $(F_MAIN)'                                 )
	
	$(call select,stdout)
endif
ifdef CXX_MAIN
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CXX_MAIN)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(CXX_MAIN)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'// Default libraries'                                  )
	$(call cat,'using namespace std;'                                  )
	$(call cat,''                                                      )
	$(call cat,'int main(int argc, char **argv)'                       )
	$(call cat,'{'                                                     )
	$(call cat,'    return 0;'                                         )
	$(call cat,'}'                                                     )
	
	$(call select,stdout)
endif
ifdef CLASS
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CLASS)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(CLASS)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(CLASS))_DEFINED'     )
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(CLASS))_DEFINED'     )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)class $(CLASS)'                                 )
	$(call cat,'$(idnt){'                                              )
	$(call cat,'$(idnt)$(idnt)'                                        )
	$(call cat,'$(idnt)};'                                             )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CLASS)$(SRC_EXT),$(notice))
	$(call select,$(srcbase)/$(CLASS)$(SRC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'// Libraries'                                          )
	$(call cat,'#include "$(CLASS)$(INC_EXT)"'                         )
	$(call cat,$(if $(inusing),'using namespace $(inusing);')          )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef TEMPLATE
	$(if $(INC_EXT),,$(eval override INC_EXT := .tcc))
	
	$(call invalid-ext,$(INC_EXT),$(tlext))
	$(call touch,$(incbase)/$(TEMPLATE)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(TEMPLATE)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef TCC_$(indef)$(call sfmt,$(TEMPLATE))_DEFINED'  )
	$(call cat,'#define TCC_$(indef)$(call sfmt,$(TEMPLATE))_DEFINED'  )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef ENABLE_NLS
ifdef TRANSLATION
new: $(foreach t,$(intltl),$(foreach e,$(firstword $(poext)),\
        $(localedir)/$(TRANSLATION)$d/$(call not-root,$(basename $t))$e))
endif
ifdef NLS_HEADER
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(call not-empty,$(call)),\
	    $(if $(INC_EXT),,$(eval override INC_EXT := .h)))
	$(if $(call not-empty,$(cxxall)),\
	    $(if $(INC_EXT),,$(eval override INC_EXT := .hpp)))
	
	$(call invalid-ext,$(INC_EXT),$(hext) $(hxxext))
	$(call touch,$(incbase)/$(NLS_HEADER)$(INC_EXT),$(notice))
	$(call select,$(incbase)/$(NLS_HEADER)$(INC_EXT))
	$(if $(wildcard $(notice)),$(call cat,''))
	$(call cat,'#ifndef HPP_$(indef)$(call sfmt,$(NLS_HEADER))_DEFINED')
	$(call cat,'#define HPP_$(indef)$(call sfmt,$(NLS_HEADER))_DEFINED')
	$(call cat,''                                                      )
	$(call cat,'#ifdef ENABLE_NLS'                                     )
	$(call cat,''                                                      )
	$(call cat,'/* I18n libraries */'                                  )
	$(foreach l,$(NLSREQINC),$(call cat,'#include <$l>')$(newline))
	$(call cat,''                                                      )
	$(call cat,'/* I18n macros */'                                     )
	$(call cat,'#define _(String) gettext (String)'                    )
	$(call cat,'#define gettext_noop(String) String'                   )
	$(call cat,'#define N_(String) gettext_noop (String)'              )
	$(call cat,''                                                      )
	$(call cat,'#else'                                                 )
	$(call cat,''                                                      )
	$(call cat,'/* I18n macros */'                                     )
	$(call cat,'#define _(String) String'                              )
	$(call cat,'#define gettext_noop(String) String'                   )
	$(call cat,'#define N_(String) gettext_noop (String)'              )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
endif
ifdef MAJOR_RELEASE
	$(eval override version := \
	$(call inc-version,$(version),major,$(ALPHA) $(BETA),$(TIMESTAMP)))
	
	$(call make-create,version version=$(version),.version.mk,T)
	$(call git-add-commit,.version.mk,"Update to version v$(version)")
	$(call git-tag,"v$(version)")
endif
ifdef MINOR_RELEASE
	$(eval override version := \
	$(call inc-version,$(version),minor,$(ALPHA) $(BETA),$(TIMESTAMP)))
	
	$(call make-create,version version=$(version),.version.mk,T)
	$(call git-add-commit,.version.mk,"Update to version v$(version)")
	$(call git-tag,"v$(version)")
endif
ifdef PATCH_RELEASE
	$(eval override version := \
	$(call inc-version,$(version),patch,$(ALPHA) $(BETA),$(TIMESTAMP)))
	
	$(call make-create,version version=$(version),.version.mk,T)
	$(call git-add-commit,.version.mk,"Update to version v$(version)")
	$(call git-tag,"v$(version)")
endif

.PHONY: update
update:
ifdef NMS_HEADER
	$(call phony-status,$(MSG_UPDATE_NMSH))
	@$(MAKE) delete new NMS_HEADER=$(NMS_HEADER) D=1 SILENT=1
	$(call phony-ok,$(MSG_UPDATE_NMSH))
endif
ifdef LIB_HEADER
	$(call phony-status,$(MSG_UPDATE_LIBH))
	@$(MAKE) delete new LIB_HEADER=$(LIB_HEADER) D=1 SILENT=1
	$(call phony-ok,$(MSG_UPDATE_LIBH))
endif

# Function: delete-file
# $1 File basename to be deleted
# $2 Extensions allowed for the basename above
define delete-file
$(if $(strip $(firstword $(foreach e,$2,$(wildcard $1$e)))),\
    $(call rm,$(firstword $(foreach e,$2,$(wildcard $1$e)))))
endef

.PHONY: delete
delete:
ifndef D
	@$(call println,$(MSG_DELETE_WARN))
	@$(call println,$(MSG_DELETE_ALT))
else
ifdef NAMESPACE
	$(call rm-if-empty,$(incbase)/$(subst ::,/,$(NAMESPACE)))
	$(call rm-if-empty,$(srcbase)/$(subst ::,/,$(NAMESPACE)))
endif
ifdef NMS_HEADER
	@# NMSH: Namespace directory
	$(eval NMSH       := $(subst ::,/,$(NMS_HEADER)))
	$(eval NMSH       := $(if $(strip $(IN)),$(IN)/)$(NMSH))
	$(eval NMSH       := $(firstword $(filter %$(NMSH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval NMSH       := $(call rm-trailing-bar,$(NMSH)))
	
	@# NMSH_NAME: Namespace include files
	$(eval NMSH_NAME  := $(notdir $(basename $(NMSH))))
	
	$(call delete-file,$(NMSH)/$(NMSH_NAME),$(INC_EXT) $(hxxext))
endif
ifdef LIBRARY
	$(call rm-if-empty,$(incbase)/$(subst ::,/,$(LIBRARY)))
endif
ifdef LIB_HEADER
	@# LIBH: Namespace directory
	$(eval LIBH       := $(subst ::,/,$(LIB_HEADER)))
	$(eval LIBH       := $(if $(strip $(IN)),$(IN)/)$(LIBH))
	$(eval LIBH       := $(firstword $(filter %$(LIBH)/,\
	                         $(sort $(dir $(incall))))))
	$(eval LIBH       := $(call rm-trailing-bar,$(LIBH)))
	
	@# LIBH_NAME: Namespace include files
	$(eval LIBH_NAME  := $(notdir $(basename $(LIBH))))
	
	$(call delete-file,$(LIBH)/$(LIBH_NAME),$(INC_EXT) $(tlext))
endif
ifdef C_FILE
	$(call delete-file,$(incbase)/$(C_FILE),$(INC_EXT) $(hext))
	$(call delete-file,$(srcbase)/$(C_FILE),$(SRC_EXT) $(cext))
endif
ifdef F_FILE
	$(call delete-file,$(srcbase)/$(F_FILE),$(SRC_EXT) $(fext))
endif
ifdef CXX_FILE
	$(call delete-file,$(incbase)/$(CXX_FILE),$(INC_EXT) $(hxxext))
	$(call delete-file,$(srcbase)/$(CXX_FILE),$(SRC_EXT) $(cxxext))
endif
ifdef C_MODULE
	$(call delete-file,$(incbase)/$(C_MODULE),$(INC_EXT) $(hext))
	$(call rm-if-empty,$(srcbase)/$(C_MODULE))
endif
ifdef F_MODULE
	$(call delete-file,$(srcbase)/$(F_MODULE),$(SRC_EXT) $(fext))
endif
ifdef CXX_MODULE
	$(call delete-file,$(incbase)/$(CXX_MODULE),$(INC_EXT) $(hxxext))
	$(call rm-if-empty,$(srcbase)/$(CXX_MODULE))
endif
ifdef C_MAIN
	$(call delete-file,$(srcbase)/$(C_MAIN),$(SRC_EXT) $(cext))
endif
ifdef F_MAIN
	$(call delete-file,$(srcbase)/$(F_MAIN),$(SRC_EXT) $(fext))
endif
ifdef CXX_MAIN
	$(call delete-file,$(srcbase)/$(CXX_MAIN),$(SRC_EXT) $(cxxext))
endif
ifdef CLASS
	$(call delete-file,$(incbase)/$(CLASS),$(INC_EXT) $(hxxext))
	$(call delete-file,$(srcbase)/$(CLASS),$(SRC_EXT) $(cxxext))
endif
ifdef TEMPLATE
	$(call delete-file,$(incbase)/$(TEMPLATE),$(INC_EXT) $(tlext))
endif
ifdef ENABLE_NLS
ifdef TRANSLATION
delete: r := $(localedir)
delete: d := $(TRANSLATION)
delete:
	$(foreach t,$(intltl),$(call delete-file,\
	    $r/$d/$(call not-root,$(basename $b)),$(poext)))
	$(foreach t,$(intltl),$(call delete-file,\
	    $r/$d/LC_MESSAGES/$(call not-root,$b),$(moext)))
	$(call rm-if-empty,$r/$d/LC_MESSAGES)
	$(call rm-if-empty,$r/$d)
endif
ifdef NLS_HEADER
	$(call delete-file,$(incbase)/$(NLS_HEADER),\
	                   $(INC_EXT) $(hext) $(hxxext))
endif
endif
endif # Check if D was defined

endif # Check if one goal is 'new', 'delete' or 'update'

########################################################################
##                         CONFIGURATION FILES                        ##
########################################################################

.PHONY: config
config:
	@echo ""
	@echo "############################################################"
	@echo "##     UNCOMMENT ANY TARGET TO OVERWRITE THE DEFAULT!     ##"
	@echo "############################################################"
	@echo ""
	@echo "# Project info"
	@echo "# ==============="
	@echo "# PROJECT         := # Project name (def: Default)"
	@echo "# VERSION         := # Version (def: 1.0.0)"
	@echo "# STD_NAMESPACE   := # Project namespace for C/C++"
	@echo "# GIT_REMOTE_PATH := # Remote path for git repository"
	@echo "# MAINTEINER_NAME := # Your name"
	@echo "# MAINTEINER_MAIL := # your_name@mail.com"
	@echo "# COPYRIGHT       := # Copyright Holder"
	@echo "# SYNOPSIS        := # One-line description of the program"
	@echo "# DESCRIPTION     := # Longer description of the program"
	@echo ""
	@echo "# Program settings"
	@echo "# =================="
	@echo "# BIN             := # Binaries' names. If a subdir of any"
	@echo "                     # src dir has the same name of this bin"
	@echo "                     # it and all its subdir will be compiled"
	@echo "                     # only for this specific binary"
	@echo "# ARLIB           := # Static/Shared libraries' names. If"
	@echo "# SHRLIB          := # one is a dir, all srcs within will"
	@echo "                     # make the lib"
	@echo ""
	@echo "# Dependencies"
	@echo "# =============="
	@echo "# GIT_DEPENDENCY  := # List of git dependencies in the form: "
	@echo "#                    # DEP_NAME => dep_path build_cmd        "
	@echo "# WEB_DEPENDENCY  := # Same as above, but for URL downloads  "
	@echo "#                    # with 'curl -o' (default) or 'wget -O' "
	@echo ""
	@echo "# Paths"
	@echo "# ======="
	@echo "# ASLIBS          := # Assembly paths"
	@echo "# CLIBS           := # C paths"
	@echo "# CXXLIBS         := # C++ paths"
	@echo "# LDLIBS          := # Linker paths"
	@echo ""
	@echo "# Flags"
	@echo "# ======="
	@echo "# CPPFLAGS        := # Precompiler Flags"
	@echo "# ASFLAGS         := # Assembly Flags"
	@echo "# CFLAGS          := # C Flags"
	@echo "# CXXFLAGS        := # C++ Flags"
	@echo "# LDFLAGS         := # Linker flags"
	@echo ""
	@echo "# Documentation"
	@echo "# ==============="
	@echo "# LICENSE         := # File with a License (def: LICENSE)"
	@echo "# NOTICE          := # Notice of the License, to be put in "
	@echo "#                    # the top of any file (def: NOTICE)."
	@echo "# DOXYFILE        := # Dxygen config file (def: Doxyfile)"
	@echo ""
	@echo "# Makeball list"
	@echo "# ==============="
	@echo "# 'include conf/makeball.mk' for pre-configured options"
	@echo "# to use the library 'makeball'"
	@echo ""

.PHONY: version
version:
	@echo "override version := $(version)"

.PHONY: compiler
compiler:
	@echo ""
	@echo "############################################################"
	@echo "##     UNCOMMENT ANY TARGET TO OVERWRITE THE DEFAULT!     ##"
	@echo "############################################################"
	@echo ""
	@echo "# AR     := # Create static libraries (default: ar)"
	@echo "# AS     := # Compile assembly        (default: nasm)"
	@echo "# CC     := # Compile C               (default: gcc)"
	@echo "# FC     := # Compile C++             (default: gfortran)"
	@echo "# CXX    := # Compile Fortran         (default: g++)"
	@echo "# RANLIB := # Update static libraries (default: ranlib)"

.PHONY: gitignore
gitignore:
	@echo ""
	@echo "# Automatically generated directories"
	@echo "#======================================"
	@$(foreach d,$(depdir),echo $d/; )
	@$(foreach d,$(objdir),echo $d/; )
	@$(foreach d,$(covdir),echo $d/; )
	@$(foreach d,$(bindir),echo $d/; )
	@$(foreach d,$(sbindir),echo $d/; )
	@$(foreach d,$(execdir),echo $d/; )
	@$(foreach d,$(distdir),echo $d/; )
	@echo $(firstword $(libdir))
	@echo ""
	@echo "# Objects, Libraries and Binaries"
	@echo "#=================================="
	@$(foreach e,$(moext),echo *$e; )
	@$(foreach e,$(objext),echo *$e; )
	@$(foreach e,$(libext),echo *$e; )
	@$(foreach e,$(binext),echo *$e; )
	@echo ""
	@echo "# Make auxiliars"
	@echo "#================="
	@echo "make.debug"
	@$(if $(strip $(doxyfile)),echo $(docdir)/doxygen/)
	@$(if $(strip $(doxyfile)),echo $(docdir)/$(doxyfile).mk)
	@$(foreach e,$(depext) $(sysext),echo *$e; )
	@echo ""

.PHONY: help
help:
	@echo "                                                            "
	@echo "AIO Makefile for C/C++/Fortran by Renato Cordeiro Ferreira. "
	@echo "Type 'make projecthelp' for additional info.                "
	@echo "                                                            "

.PHONY: projecthelp
projecthelp:
	@echo "                                                            "
	@echo "All-in-One Makefile                                         "
	@echo "=====================                                       "
	@echo "                                                            "
	@echo "Default targets:                                            "
	@echo "-----------------                                           "
	@echo " * all:              Generates all executables              "
	@echo " * analysis-lint:    Runs analysis lint on binary sources   "
	@echo " * benchmark:        Compiles and runs Benchmarks           "
	@echo " * check:            Compiles and runs Unit Tests           "
	@echo " * compiler:         Outputs Compiler.mk to define compilers"
	@echo " * config:           Outputs Config.mk for user's options   "
	@echo " * coverage:         Creates coverage analysis information  "
	@echo " * *-coverage:       As 'coverage' for tests and benchmarks "
	@echo " * depend:           Checks all dependencies needed to build"
	@echo " * deploy:           Deploys changes in BRANCH to REMOTE    "
	@echo " * dist-*:           As 'dist', with many compressions      "
	@echo " * dist:             Creates .tar.gz with bins and libs     "
	@echo " * docs:             Generates docs in all formats avaiable "
	@echo " * doxy:             Creates Doxygen docs                   "
	@echo " * dpkg:             Creates the project's debian package   "
	@echo " * eval:             Same as 'benchmark'                    "
	@echo " * gitignore:        Outputs .gitignore model for user      "
	@echo " * init:             Creates dirs for beggining projects    "
	@echo " * install-*:        Installs one info/html/dvi/pdf/ps docs "
	@echo " * install-docs:     Installs documentation in all formats  "
	@echo " * install:          Installs executables and libraries     "
	@echo " * installcheck:     Runs installation tests (if avaiable)  "
	@echo " * lint:             Runs analysis and style lints          "
	@echo " * package-*:        As 'package', with many compressions   "
	@echo " * package:          As 'dist', but also with src and data  "
	@echo " * run:              Run EXEC executable from BIN           "
	@echo " * standard:         Moves files to standard directories    "
	@echo " * statistics:       Outputs file countage and LOC          "
	@echo " * style-lint:       Runs style lint on binary sources      "
	@echo " * sync:             Synchronizes from REMOTE to BRANCH     "
	@echo " * tar:              Creates .tar with bins and libs        "
	@echo " * test:             Same as 'check'                        "
	@echo " * translation:      Creates files for internationalization "
	@echo " * uninstall-*:      Uninstalls info/html/dvi/pdf/ps docs   "
	@echo " * uninstall:        Uninstalls anything created by installs"
	@echo " * upgrade:          Upgrades Makefile from remote repo     "
	@echo " * version:          Outputs current version in .version.mk "
	@echo "                                                            "
	@echo "Management targets:                                         "
	@echo "--------------------                                        "
	@echo " * new:              Creates C/C++/Fortran artifact         "
	@echo " * delete:           Removes C/C++/Fortran artifact         "
	@echo " * update:           Updates C/C++/Fortran artifact         "
	@echo "                                                            "
	@echo "Tags targets:                                               "
	@echo "--------------                                              "
	@echo " * ctags:            Creates tags for VI/Vim editor         "
	@echo " * etags:            Creates tags for Emacs editor          "
	@echo " * TAGS:             Creates tags for both VI/Vim and Emacs "
	@echo "                                                            "
	@echo "Debug targets:                                              "
	@echo "---------------                                             "
	@echo " * debug:            Output 'dump' content in 'make.debug'  "
	@echo " * dump:             Output main variables of this Makefile "
	@echo " * nothing:          Self-explicative, huh?                 "
	@echo "                                                            "
	@echo "Cleaning targets:                                           "
	@echo "------------------                                          "
	@echo " * mostlyclean:      Cleans all object files                "
	@echo " * clean:            Above and all types of binaries        "
	@echo " * distclean:        Above and libraries, .tar and .tar.gz  "
	@echo " * docclean:         Removes all documentation files        "
	@echo " * packageclean:     Removes all debian and RPM packages    "
	@echo " * coverageclean:    Removes all coverage analysis info     "
	@echo " * translationclean: Removes all debian and RPM packages    "
	@echo " * realclean:        Above, auto-generated source and docs  "
	@echo " * uninitialize:     Above and source/include directories   "
	@echo "                                                            "
	@echo "Help targets:                                               "
	@echo "--------------                                              "
	@echo " * help:             Info about this Makefile               "
	@echo " * projecthelp:      Perharps you kwnow if you are here...  "
	@echo "                                                            "
	@echo "Compilation options:                                        "
	@echo "---------------------                                       "
	@echo " * COVERAGE:         Enable compilation with coverage       "
	@echo "                                                            "
	@echo "Special flags:                                              "
	@echo "---------------                                             "
	@echo " * D:                Allows deletion of a C/C++ artifact    "
	@echo " * U:                Allows uninitilization of the project  "
	@echo " * V:                Allows printing the command line rules "
	@echo " * EXEC:             Binary to be run, profiled or covered  "
	@echo " * MORE:             With errors, use 'more' to read stderr "
	@echo " * SILENT:           Outputs no messages in execution       "
	@echo " * NO_GIT:           Disables git commands executed by make "
	@echo " * NO_COLORS:        Outputs are made without any color     "
	@echo " * ENABLE_NLS:       Allows internationalization            "
	@echo "                                                            "
	@echo "Management auxiliars:                                       "
	@echo "----------------------                                      "
	@echo " * IN:               Directory for 'new' files              "
	@echo " * INC_EXT:          Include extension for 'new' files      "
	@echo " * SRC_EXT:          Source extension for 'new' files       "
	@echo " * ALPHA:            Make 'new' release an alpha release    "
	@echo " * BETA:             Make 'new' release a beta release      "
	@echo " * TIMESTAMP:        Add timestamp metadata in 'new' release"
	@echo "                                                            "
	@echo "Management flags:                                           "
	@echo "------------------                                          "
	@echo " * NAMESPACE:        Directories for namespace (src/inc)    "
	@echo " * NMS_HEADER:       Header with all includes in a namespace"
	@echo " * LIBRARY:          Directory for library (of templates)   "
	@echo " * LIB_HEADER:       Header with all includes in a library  "
	@echo " * C_FILE:           Ordinary C source and header           "
	@echo " * F_FILE:           Ordinary C file                        "
	@echo " * CXX_FILE:         Ordinary C++ source and header         "
	@echo " * C_MODULE:         C header and dir for its sources       "
	@echo " * F_MODULE:         Fortran module                         "
	@echo " * CXX_MODULE:       C++ header and dif for its sources     "
	@echo " * C_MAIN:           Ordinary C main                        "
	@echo " * F_MAIN:           Ordinary Fortran program               "
	@echo " * CXX_MAIN:         Ordinary C++ main                      "
	@echo " * CLASS:            New file for a C++ class               "
	@echo " * TEMPLATE:         C++ template file                      "
	@echo " * TRANSLATION:      Portable object translation            "
	@echo " * NLS_HEADER:       Header with i18n headers and macros    "
	@echo " * MAJOR_RELEASE:    Projetc major release                  "
	@echo " * MINOR_RELEASE:    Project minor release                  "
	@echo " * PATCH_RELEASE:    Project patch release                  "
	@echo "                                                            "

########################################################################
##                            DEBUGGING                               ##
########################################################################

define echo
@$(call println,$1)
endef

define prompt
@$(call printf,"%b%b\n","${YELLOW}"$1"${RES}" \
                        "$(or $(strip $2),${RED}Empty${RES})")
endef

.PHONY: debug
debug:
	$(call make-create,dump NO_COLORS=1,make.debug)

.PHONY: dump
dump:
ifdef VAR ####
	@$(call println,\
	    "${YELLOW}$(VAR):${RES}"\
	    $(if $(strip $(filter undefined,$(origin $(VAR)))),\
	        "${RED}Undefined${RES}",\
	        "$(or $(strip $($(VAR))),${RED}Empty${RES})"))
else
	$(call echo,"${WHITE}\nPLATFORM INFO           ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"plat_kernel:  ",$(plat_kernel)         )
	$(call prompt,"plat_arch:    ",$(plat_arch)           )
	$(call prompt,"plat_os:      ",$(plat_os)             )
	$(call prompt,"plat_release: ",$(plat_release)        )
	$(call prompt,"plat_proc:    ",$(plat_proc)           )
	$(call prompt,"plat_version: ",$(plat_version)        )
	
	$(call echo,"${WHITE}\nCONFIGURATION           ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"license:      ",$(license)             )
	$(call prompt,"notice:       ",$(notice)              )
	$(call prompt,"contributors: ",$(contributors)        )
	$(call prompt,"doxyfile:     ",$(doxyfile)            )
	
	$(call echo,"${WHITE}\nIGNORED FILES           ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"ignore:       ",$(ignored)             )
	$(call prompt,"covignore:    ",$(covignore)           )
	
	$(call echo,"${WHITE}\nACCEPTED EXTENSIONS     ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"asmext:       ",$(asmext)              )
	$(call prompt,"cext:         ",$(cext)                )
	$(call prompt,"fext:         ",$(fext)                )
	$(call prompt,"cxxext:       ",$(cxxext)              )
	$(call prompt,"hext:         ",$(hext)                )
	$(call prompt,"hfext:        ",$(hfext)               )
	$(call prompt,"hxxext:       ",$(hxxext)              )
	$(call prompt,"tlext:        ",$(tlext)               )
	$(call prompt,"libext:       ",$(libext)              )
	$(call prompt,"arext:        ",$(arext)               )
	$(call prompt,"shrext:       ",$(shrext)              )
	$(call prompt,"lexext:       ",$(lexext)              )
	$(call prompt,"lexxext:      ",$(lexxext)             )
	$(call prompt,"yaccext:      ",$(yaccext)             )
	$(call prompt,"yaxxext:      ",$(yaxxext)             )
	$(call prompt,"esqlext:      ",$(esqlext)             )
	$(call prompt,"objext:       ",$(objext)              )
	$(call prompt,"binext:       ",$(binext)              )
	$(call prompt,"covext:       ",$(covext)              )
	$(call prompt,"repext:       ",$(repext)              )
	$(call prompt,"potext:       ",$(potext)              )
	$(call prompt,"poext:        ",$(poext)               )
	$(call prompt,"moext:        ",$(moext)               )
	$(call prompt,"depext:       ",$(depext)              )
	$(call prompt,"extext:       ",$(extext)              )
	$(call prompt,"sysext:       ",$(sysext)              )
	$(call prompt,"docext:       ",$(docext)              )
	$(call prompt,"srpext:       ",$(srpext)              )
	$(call prompt,"dataext:      ",$(dataext)             )
	
	$(call echo,"${WHITE}\nLEXER                   ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"alllexer:     ",$(alllexer)            )
	$(call prompt,"clexer:       ",$(clexer)              )
	$(call prompt,"cxxlexer:     ",$(cxxlexer)            )
	$(call prompt,"lexall:       ",$(lexall)              )
	$(call prompt,"lexinc:       ",$(lexinc)              )
	
	$(call echo,"${WHITE}\nPARSER                  ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"allparser:    ",$(allparser)           )
	$(call prompt,"cparser:      ",$(cparser)             )
	$(call prompt,"cxxparser:    ",$(cxxparser)           )
	$(call prompt,"yaccall:      ",$(yaccall)             )
	$(call prompt,"yaccinc:      ",$(yaccinc)             )
	
	$(call echo,"${WHITE}\nEMBEDDED SQL PREPROC    ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"cesql:        ",$(cesql)               )
	$(call prompt,"esqlall:      ",$(esqlall)             )
	
	$(call echo,"${WHITE}\nSOURCE                  ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"asmall:       ",$(asmall)              )
	$(call prompt,"call:         ",$(call)                )
	$(call prompt,"fall:         ",$(fall)                )
	$(call prompt,"cxxall:       ",$(cxxall)              )
	$(call prompt,"userall:      ",$(userall)             )
	$(call prompt,"usersrc:      ",$(usersrc)             )
	$(call prompt,"autoall:      ",$(autoall)             )
	$(call prompt,"autosrc:      ",$(autosrc)             )
	$(call prompt,"liball:       ",$(liball)              )
	$(call prompt,"libsrc:       ",$(libsrc)              )
	$(call prompt,"mainall:      ",$(mainall)             )
	$(call prompt,"mainsrc:      ",$(mainsrc)             )
	$(call prompt,"srcall:       ",$(srcall)              )
	$(call prompt,"src:          ",$(src)                 )
	
	$(call echo,"${WHITE}\nHEADERS                 ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"userinc:      ",$(userinc)             )
	$(call prompt,"autoinc:      ",$(autoinc)             )
	$(call prompt,"incall:       ",$(incall)              )
	$(call prompt,"chead:        ",$(chead)               )
	$(call prompt,"fhead:        ",$(fhead)               )
	$(call prompt,"cxxhead:      ",$(cxxhead)             )
	$(call prompt,"headall:      ",$(headall)             )
	
	$(call echo,"${WHITE}\nSTATIC LIBRARY          ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"ar_in:        ",$(ar_in)               )
	$(call prompt,"arall:        ",$(arall)               )
	$(call prompt,"arsrc:        ",$(arsrc)               )
	$(call prompt,"arpat:        ",$(arpat)               )
	$(call prompt,"arname:       ",$(arname)              )
	$(call prompt,"arlink:       ",$(arlink)              )
	$(call prompt,"arlib:        ",$(arlib)               )
	
	$(call echo,"${WHITE}\nDYNAMIC LIBRARY         ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"shr_in:       ",$(shr_in)              )
	$(call prompt,"shrall:       ",$(shrall)              )
	$(call prompt,"shrsrc:       ",$(shrsrc)              )
	$(call prompt,"shrpat:       ",$(shrpat)              )
	$(call prompt,"shrname:      ",$(shrname)             )
	$(call prompt,"shrlink:      ",$(shrlink)             )
	$(call prompt,"shrlib:       ",$(shrlib)              )
	
	$(call echo,"${WHITE}\nSYSTEM LIBRARY          ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"syslib:       ",$(syslib)              )
	$(call prompt,"sysname:      ",$(sysname)             )
	$(call prompt,"syslink:      ",$(syslink)             )
	
	$(call echo,"${WHITE}\nLOCAL LIBRARY           ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"loclib:       ",$(loclib)              )
	$(call prompt,"locname:      ",$(locname)             )
	$(call prompt,"loclink:      ",$(loclink)             )
	
	$(call echo,"${WHITE}\nDEPENDENCY LIBRARY      ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"deplib:       ",$(deplib)              )
	$(call prompt,"depname:      ",$(depname)             )
	$(call prompt,"deplink:      ",$(deplink)             )
	
	$(call echo,"${WHITE}\nLIBRARY                 ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"lib_in:       ",$(lib_in)              )
	$(call prompt,"libpat:       ",$(libpat)              )
	$(call prompt,"libname:      ",$(libname)             )
	$(call prompt,"liblink:      ",$(liblink)             )
	$(call prompt,"lib:          ",$(lib)                 )
	
	$(call echo,"${WHITE}\nTEST                    ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"testall:      ",$(testall)             )
	$(call prompt,"testsrc:      ",$(testsrc)             )
	$(call prompt,"testobj:      ",$(testobj)             )
	$(call prompt,"testbin:      ",$(testbin)             )
	$(call prompt,"testrun:      ",$(testrun)             )
	
	$(call echo,"${WHITE}\nBENCHMARK               ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"benchall:     ",$(benchall)            )
	$(call prompt,"benchsrc:     ",$(benchsrc)            )
	$(call prompt,"benchobj:     ",$(benchobj)            )
	$(call prompt,"benchbin:     ",$(benchbin)            )
	$(call prompt,"benchrun:     ",$(benchrun)            )
	
	$(call echo,"${WHITE}\nCOVERAGE                ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"covdata:      ",$(covdata)             )
	$(call prompt,"covrep:       ",$(covrep)              )
	$(call prompt,"covtestdata:  ",$(covtestdata)         )
	$(call prompt,"covtestrep:   ",$(covtestrep)          )
	$(call prompt,"covbenchdata: ",$(covbenchdata)        )
	$(call prompt,"covbenchrep:  ",$(covbenchrep)         )
	
	$(call echo,"${WHITE}\nOBJECT                  ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"arobj:        ",$(arobj)               )
	$(call prompt,"shrobj:       ",$(shrobj)              )
	$(call prompt,"userobj:      ",$(userobj)             )
	$(call prompt,"autoobj:      ",$(autoobj)             )
	$(call prompt,"libobj:       ",$(libobj)              )
	$(call prompt,"mainobj:      ",$(mainobj)             )
	$(call prompt,"srcobj:       ",$(srcobj)              )
	
	$(call echo,"${WHITE}\nDEPENDENCY              ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"srcdep:       ",$(srcdep)              )
	$(call prompt,"testdep:      ",$(testdep)             )
	$(call prompt,"benchdep:     ",$(benchdep)            )
	$(call prompt,"progdep:      ",$(progdep)             )
	$(call prompt,"externdep:    ",$(externdep)           )
	$(call prompt,"syslibdep:    ",$(syslibdep)           )
	$(call prompt,"phonydep:     ",$(phonydep)            )
	$(call prompt,"depall:       ",$(depall)              )
	
	$(call echo,"${WHITE}\nBINARY                  ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"bin:          ",$(bin)                 )
	$(call prompt,"sbin:         ",$(sbin)                )
	$(call prompt,"libexec:      ",$(libexec)             )
	$(call prompt,"binall:       ",$(binall)              )
	
	$(call echo,"${WHITE}\nINSTALLATION            ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"destdir:      ",$(destdir)             )
	$(call prompt,"prefix:       ",$(prefix)              )
	$(call prompt,"exec_prefix:  ",$(exec_prefix)         )
	$(call prompt,"i_bindir:     ",$(i_bindir)            )
	$(call prompt,"i_sbindir:    ",$(i_sbindir)           )
	$(call prompt,"i_libexecdir: ",$(i_libexecdir)        )
	$(call prompt,"i_docdir:     ",$(i_docdir)            )
	
	$(call echo,"${WHITE}\nDOCUMENTATION           ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"texiall:      ",$(texiall)             )
	$(call prompt,"texisrc:      ",$(texiall)             )
	$(call prompt,"texiinfo:     ",$(texiinfo)            )
	$(call prompt,"texihtml:     ",$(texihtml)            )
	$(call prompt,"texidvi:      ",$(texidvi)             )
	$(call prompt,"texipdf:      ",$(texipdf)             )
	$(call prompt,"texips:       ",$(texips)              )
	
	$(call echo,"${WHITE}\nCOMPILER FLAGS          ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"asflags:      ",$(asflags)             )
	$(call prompt,"cflags:       ",$(cflags)              )
	$(call prompt,"fflags:       ",$(fflags)              )
	$(call prompt,"cxxflags:     ",$(cxxflags)            )
	$(call prompt,"lexflags:     ",$(lexflags)            )
	$(call prompt,"yaccflags:    ",$(yaccflags)           )
	$(call prompt,"esqlflags:    ",$(esqlflags)           )
	$(call prompt,"covflags:     ",$(covflags)            )
	$(call prompt,"findflags:    ",$(findflags)           )
	$(call prompt,"ctagsflags:   ",$(ctagsflags)          )
	$(call prompt,"etagsflags:   ",$(etagsflags)          )
	$(call prompt,"makeflags:    ",$(makeflags)           )
	$(call prompt,"ccovflags:    ",$(ccovflags)           )
	$(call prompt,"fcovflags:    ",$(fcovflags)           )
	$(call prompt,"cxxcovflags:  ",$(cxxcovflags)         )
	$(call prompt,"cppcovflags:  ",$(cppcovflags)         )
	
	$(call echo,"${WHITE}\nLINKER FLAGS            ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"ldflags:      ",$(ldflags)             )
	$(call prompt,"ldc:          ",$(ldc)                 )
	$(call prompt,"ldf:          ",$(ldf)                 )
	$(call prompt,"ldcxx:        ",$(ldcxx)               )
	$(call prompt,"ldshr:        ",$(ldshr)               )
	$(call prompt,"ldlex:        ",$(ldlex)               )
	$(call prompt,"ldyacc:       ",$(ldyacc)              )
	$(call prompt,"ldesql:       ",$(ldesql)              )
	$(call prompt,"ldcov:        ",$(ldcov)               )
	
	$(call echo,"${WHITE}\nPATHS                   ${RES}")
	$(call echo,"----------------------------------------")
	$(call prompt,"aslibs:       ",$(aslibs)              )
	$(call prompt,"clibs:        ",$(clibs)               )
	$(call prompt,"flibs:        ",$(flibs)               )
	$(call prompt,"cxxlibs:      ",$(cxxlibs)             )
	$(call prompt,"lexlibs:      ",$(lexlibs)             )
	$(call prompt,"yacclibs:     ",$(yacclibs)            )
	$(call prompt,"esqllibs:     ",$(esqllibs)            )
	$(call prompt,"ldlibs:       ",$(ldlibs)              )

endif #### ifdef VAR
