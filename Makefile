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

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                          USER DEFINITIONS                            #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                             PROGRAM                                ##
########################################################################

# Project setting 
PROJECT     := Default
VERSION     := 1.0

# Package info
AUXFILES        :=
MAINTEINER_NAME := Your Name
MAINTEINER_MAIL := your_mail@mail.com
SYNOPSIS        := default short synopsis
DESCRIPTION     := default long description

# Debian package
DEB_VERSION     := 1
DEB_PROJECT     := Default
DEB_PRIORITY    := optional

# Program settings
BIN      :=
SBIN     :=
LIBEXEC  :=
ARLIB    :=
SHRLIB   :=

# Documentation settings
LICENSE  := LICENSE
NOTICE   := NOTICE
DOXYFILE := Doxyfile

########################################################################
##                              FLAGS                                 ##
########################################################################

# Assembler flags
ASFLAGS   := -f elf32

# C Options
CFLAGS    := -Wall -ansi -pedantic -O2 -g

# C++ Options
CXXFLAGS  := $(CFLAGS) -std=c++11

# Fortran Options
FFLAGS    := -cpp

# Linker flags
LDFLAGS   := 
LDC       := 
LDF       := -lgfortran
LDCXX     := 
LDLEX     := -lfl
LDYACC    := 

# Library flags
ARFLAGS   := -rcv
SOFLAGS   := -shared 

# Include configuration file if exists
-include config.mk
-include Config.mk

########################################################################
##                            DIRECTORIES                             ##
########################################################################
ifndef SINGLE_DIR
SRCDIR  := src
DEPDIR  := dep
INCDIR  := include
DOCDIR  := doc
DEBDIR  := debian
OBJDIR  := build
LIBDIR  := lib
BINDIR  := bin
SBINDIR := sbin
EXECDIR := libexec
DISTDIR := dist
TESTDIR := test
DATADIR := 
DESTDIR :=
else
$(foreach var,\
    SRCDIR BINDIR DEPDIR OBJDIR INCDIR LIBDIR \
    SBINDIR DISTDIR TESTDIR DATADIR,\
    $(eval $(var) := .)\
)
endif

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
# * ondincludedir: Includable (header) files for GCC and othe compilers
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
HEXT    := .h .ih
HFEXT   := .mod .MOD
HXXEXT  := .H .hh .hpp .hxx .h++

# Source extensions
CEXT    := .c
FEXT    := .f .FOR .for .f77 .f90 .f95 .F .fpp .FPP
CXXEXT  := .C .cc .cpp .cxx .c++
TLEXT   := .tcc .icc

# Library extensions
LIBEXT  := .a .so .dll

# Parser/Lexer extensions
LEXEXT  := .l
LEXXEXT := .ll .lpp
YACCEXT := .y
YAXXEXT := .yy .ypp

# Dependence extensions
DEPEXT  := .d

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

# Test suffix
TESTSUF := _tests

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                           OS DEFINITIONS                             #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

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

# Installation
INSTALL         := install
INSTALL_DATA    := $(INSTALL)
INSTALL_PROGRAM := $(INSTALL) -m 644

# File manipulation
CP              := cp -rap
MV              := mv
RM              := rm -f
TAR             := tar -cvf
ZIP             := zip
GZIP            := gzip
BZIP2           := bzip2
MKDIR           := mkdir -p
RMDIR           := rm -rf
FIND            := find
FIND_FLAGS      := -type d -print 2> /dev/null

# Documentations
DOXYGEN         := doxygen

# Parser and Lexer
LEX             := flex
LEX_CXX         := flexc++
LEXFLAGS        := 
YACC            := bison
YACC_CXX        := bisonc++
YACCFLAGS       := 

# Documentation
MAKEINFO        := makeinfo
INSTALL_INFO    := install-info
TEXI2HTML       := makeinfo --no-split --html
TEXI2DVI        := texi2dvi
TEXI2PDF        := texi2pdf
TEXI2PS         := texi2dvi --ps

# Packages (Debian)
DEBUILD         := debuild -us -uc
DCH             := dch --create -v $(VERSION)-$(DEB_VERSION) \
                       --package $(DEB_PROJECT)

# Make
MAKE            += --no-print-directory

# Include configuration file if exists
-include config_os.mk
-include Config_os.mk

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                        DEVELOPER DEFINITIONS                         #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                       USER INPUT VALIDATION                        ##
########################################################################

# Documentation:
doxyfile  := $(strip $(firstword $(DOXYFILE)))

# Flags:
# Redefine flags to avoid conflict with user's local definitions
asflags   := $(ASFLAGS)
cflags    := $(CFLAGS)
fflags    := $(FFLAGS)
cxxflags  := $(CXXFLAGS)
cxxlexer  := $(CXXLEXER)
cxxparser := $(CXXPARSER)
ldflags   := $(LDFLAGS)
arflags   := $(ARFLAGS)
soflags   := $(SOFLAGS)
lexflags  := $(LEXFLAG)
yaccflags := $(YACCFLAGS)

# Installation directories
destdir := $(strip $(foreach d,$(DESTDIR),$(patsubst %/,%,$d)))

$(foreach b,$(install_dirs),\
    $(if $(strip $(firstword $($b))),\
        $(eval i_$b := $(destdir)$(strip $(patsubst %/,%,$($b)))),\
        $(error "$b" must not be empty))\
)

# Directories:
# No directories must end with a '/' (slash)
override srcdir  := $(strip $(foreach d,$(SRCDIR),$(patsubst %/,%,$d)))
override depdir  := $(strip $(foreach d,$(DEPDIR),$(patsubst %/,%,$d)))
override incdir  := $(strip $(foreach d,$(INCDIR),$(patsubst %/,%,$d)))
override docdir  := $(strip $(foreach d,$(DOCDIR),$(patsubst %/,%,$d)))
override debdir  := $(strip $(foreach d,$(DEBDIR),$(patsubst %/,%,$d)))
override objdir  := $(strip $(foreach d,$(OBJDIR),$(patsubst %/,%,$d)))
override libdir  := $(strip $(foreach d,$(LIBDIR),$(patsubst %/,%,$d)))
override bindir  := $(strip $(foreach d,$(BINDIR),$(patsubst %/,%,$d)))
override sbindir := $(strip $(foreach d,$(SBINDIR),$(patsubst %/,%,$d)))
override execdir := $(strip $(foreach d,$(EXECDIR),$(patsubst %/,%,$d)))
override distdir := $(strip $(foreach d,$(DISTDIR),$(patsubst %/,%,$d)))
override testdir := $(strip $(foreach d,$(TESTDIR),$(patsubst %/,%,$d)))
override datadir := $(strip $(foreach d,$(DATADIR),$(patsubst %/,%,$d)))

# All directories
alldir := $(strip\
    $(srcdir) $(depdir) $(incdir) $(docdir) $(debdir) $(objdir)     \
    $(libdir) $(bindir) $(sbindir) $(execdir) $(distdir) $(testdir) \
    $(datadir)                                                      \
)

# Check if every directory variable is non-empty
ifeq ($(and $(srcdir),$(bindir),$(depdir),$(objdir),\
            $(incdir),$(libdir),$(distdir),$(testdir)),)
$(error There must be at least one directory of each type, or '.'.)
endif

ifneq ($(words $(depdir) $(objdir) $(distdir) $(debdir)),4)
$(error There must be one dependency, obj, dist and debian dir.)
endif

# Extensions:
testsuf := $(strip $(sort $(TESTSUF)))
ifneq ($(words $(testsuf)),1)
    $(error Just one suffix allowed for test sources!)
endif

# Extensions:
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
lexext  := $(strip $(sort $(LEXEXT)))
lexxext := $(strip $(sort $(LEXXEXT)))
yaccext := $(strip $(sort $(YACCEXT)))
yaxxext := $(strip $(sort $(YAXXEXT)))
depext  := $(strip $(sort $(DEPEXT)))
objext  := $(strip $(sort $(OBJEXT)))
binext  := $(strip $(sort $(BINEXT)))

texiext := $(strip $(sort $(TEXIEXT)))
infoext := $(strip $(sort $(INFOEXT)))
htmlext := $(strip $(sort $(HTMLEXT)))
dviext  := $(strip $(sort $(DVIEXT)))
pdfext  := $(strip $(sort $(PDFEXT)))
psext   := $(strip $(sort $(PSEXT)))

incext := $(hext) $(hxxext) $(tlext) $(hfext)
srcext := $(cext) $(cxxext) $(fext)
docext := $(texiext) $(infoext) $(htmlext) $(dviext) $(pdfext) $(psext)

# Check all extensions
allext := $(incext) $(srcext) $(asmext) $(libext) 
allext += $(lexext) $(lexxext) $(yaccext) $(yaxxext) 
allext += $(depext) $(objext) $(binext)
allext := $(strip $(allext))
$(foreach ext,$(allext),\
    $(if $(filter .%,$(ext)),,\
        $(error "$(ext)" is not a valid extension)))

ifneq ($(words $(objext)),1)
    $(error Just one object extension allowed!)
endif

ifneq ($(words $(depext)),1)
    $(error Just one dependency extension allowed!)
endif

ifneq ($(words $(binext)),1)
    $(if $(binext),\
        $(error Just one or none binary extensions allowed!))
endif

########################################################################
##                              PATHS                                 ##
########################################################################

# Define the shell to be used
SHELL = /bin/sh

# Define extensions as the only valid ones
.SUFFIXES:
.SUFFIXES: $(allext)

# Paths
# ======
vpath %.tar    $(distdir) # All tar files in distdir
vpath %.tar.gz $(distdir) # All tar.gz files in distdir

# Binaries, libraries and source extensions
$(foreach e,$(libext),$(eval vpath lib%$e $(libdir)))
$(foreach s,$(srcdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))
$(foreach s,$(testdir),$(foreach e,$(srcext),$(eval vpath %$e $s)))

########################################################################
##                              FILES                                 ##
########################################################################

# Auxiliar functions
# ===================
# 1) root: Gets the root directory (first in the path) of a path or file
# 2) not-root: Given a path or file, take out the root directory of it
# 3) invert: Invert a list of elements
# 4) not: Returns empty if its argument was defined, or T otherwise
# 5) remove-trailing-bar: Removes the last / of a directory-only name
# 6) is-cxx: find out if there is a C++ file in its single argument
define root
$(foreach s,$1,\
    $(if $(findstring /,$s),\
        $(call root,$(patsubst %/,%,$(dir $s))),$(strip $s)))
endef

define not-root
$(foreach s,$1,$(strip $(patsubst $(strip $(call root,$s))/%,%,$s)))
endef

define invert
$(if $(strip $1),$(call invert,$(wordlist 2,$(words $1),$1))) $(firstword $1) 
endef

define not
$(strip $(if $1,,T))
endef

define remove-trailing-bar
$(foreach s,$1,$(if $(or $(call not,$(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))
endef

define has_c
$(if $(strip $(sort $(foreach s,$(sort $(suffix $1)),\
    $(findstring $s,$(cext))))),has_c)
endef

define is_c
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
    $(if $(strip $(findstring $s,$(cext))),,$s))),,is_c)
endef

define has_f
$(if $(strip $(sort $(foreach s,$(sort $(suffix $1)),\
    $(findstring $s,$(fext))))),has_f)
endef

define is_f
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
    $(if $(strip $(findstring $s,$(fext))),,$s))),,is_f)
endef

define has_cxx
$(if $(strip $(sort $(foreach s,$(sort $(suffix $1)),\
    $(findstring $s,$(cxxext))))),has_cxx)
endef

define is_cxx
$(if $(strip $(foreach s,$(sort $(suffix $1)),\
    $(if $(strip $(findstring $s,$(cxxext))),,$s))),,is_cxx)
endef

# Auxiliar recursive functions
# ==============================
# 1) rsubdir: For listing all subdirectories of a given dir
# 2) rwildcard: For wildcard deep-search in the directory tree
# 3) rfilter-out: For filtering a list of text from another list
rsubdir   = $(foreach d,$1,$(shell $(FIND) $d $(FIND_FLAGS)))
rwildcard = $(foreach d,$(wildcard $1/*),\
                $(call rwildcard,$d,$2)$(filter $(subst *,%,$2),$d)) 
rfilter-out = \
  $(eval rfilter-out_aux = $2)\
  $(foreach d,$1,\
      $(eval rfilter-out_aux = $(filter-out $d,$(rfilter-out_aux))))\
  $(sort $(rfilter-out_aux))

# Configuration Files
# =====================
make_configs := $(AUXFILES) $(LICENSE) $(NOTICE)
make_configs += Config.mk config.mk Config_os.mk config_os.mk
make_configs := $(sort $(foreach f,$(make_configs),$(wildcard $f)))

# Ignored Files
# ===============
# 1) Find complete paths for the ignored files
# 2) Define a function for filtering out the ignored files
#------------------------------------------------------------------[ 1 ]
ignored := $(sort $(IGNORED))
ignored := $(sort $(foreach f,$(ignored),\
               $(foreach r,$(alldir) $(bin) $(sbin) $(libexec),\
                   $(foreach d,$(call rsubdir,$r),\
                       $(wildcard $d/$f*)\
           ))))
#------------------------------------------------------------------[ 2 ]
define filter-ignored
$(call rfilter-out,$(ignored),$1)
endef

# Default variable names 
# ======================
# fooall: complete path WITH root directories
# foosrc: complete path WITHOUT root directories
# foopat: incomplete paths WITH root directories
# foolib: library names WITHOUT root directories

# Library files
# ==============
# .---.-----.------.-----.--------.---------------------------------.
# | # | dir | base | ext | STATUS |             ACTION              |
# |===|=====|======|=====|========|=================================|
# | 0 |     |      |     | Ok     | None                            |
# | 1 |  X  |      |     | Warn   | Correct to fall in case #4      |
# | 2 |     |  X   |     | Ok     | Matches all bases with this dir |
# | 3 |     |      |  X  | Error  | Extension only not allowed      |
# | 4 |  X  |  X   |     | Ok     | Find base in this dir           |
# | 5 |  X  |      |  X  | Error  | Extension only not allowed      |
# | 6 |     |  X   |  X  | Ok     | Find all bases with this ext    |
# | 7 |  X  |  X   |  X  | Ok     | Find the specific file          |
# '---'-----'------'-----'--------'---------------------------------'
# Examples: 1: test1/  2: test2 .c      4: test4/test4       5: test5/.c 
#           6: test6.c 7: test7/test7.c 8: src/test8/test8.c
# 1) ar_in/shr_in: Remove the last / if there is a path only
# 2) lib_in      : Store libraries as being shared and static libs.
#                  If there is only a suffix, throw an error. 
#------------------------------------------------------------------[ 1 ]
ar_in     := $(call remove-trailing-bar,$(ARLIB))
shr_in    := $(call remove-trailing-bar,$(SHRLIB))
#------------------------------------------------------------------[ 2 ]
lib_in    := $(ar_in) $(shr_in)
lib_in    := \
$(foreach s,$(lib_in),                                                 \
  $(if $(and                                                           \
      $(strip $(suffix $s)),$(if $(strip $(notdir $(basename $s))),,T) \
  ),                                                                   \
  $(error "Invalid argument $s in library variable"),$s)               \
)

# Assembly files
# ==============
# 1) Find all assembly files in the source directory
# 2) Filter out ignored files from above
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(asmext),\
        $(eval asmall += $(call rwildcard,$(root),*$E))))
#------------------------------------------------------------------[ 2 ]
asmall := $(call filter-ignored,$(asmall))

# Lexical analyzer
# =================
# 1) Find in a directory tree all the lex files (with dir names)
# 2) Filter out ignored files from above
# 3) Split C++ and C lexers (to be compiled appropriately)
# 4) Change lex extension to format .yy.c or .yy.cc (for C/C++ lexers)
#    and join all the C and C++ lexer source names
# 5) Create lex scanners default directories for headers
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(lexext) $(lexxext),\
        $(eval alllexer += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
alllexer := $(call filter-ignored,$(alllexer))
#------------------------------------------------------------------[ 3 ]
cxxlexer := $(foreach e,$(lexxext),$(filter %$e,$(alllexer)))
clexer   := $(filter-out $(cxxlexer),$(alllexer))
#------------------------------------------------------------------[ 4 ]
lexall   += $(foreach E,$(lexext) $(lexxext),\
                $(patsubst %$E,%.yy.cc,$(filter %$E,$(cxxlexer))))
lexall   += $(foreach E,$(lexext) $(lexxext),\
                $(patsubst %$E,%.yy.c,$(filter %$E,$(clexer))))
lexall   := $(strip $(lexall))
#------------------------------------------------------------------[ 5 ]
lexinc   := $(call not-root,$(basename $(basename $(lexall))))
lexinc   := $(addprefix $(firstword $(incdir))/,$(lexinc))
lexinc   := $(addsuffix -yy/,$(lexinc))

# Syntatic analyzer
# ==================
# 1) Find in a directory tree all the yacc files (with dir names)
# 3) Filter out ignored files from above
# 3) Split C++ and C parsers (to be compiled appropriately)
# 4) Change yacc extension to format .tab.c or .tab.cc (for C/C++ parsers)
#    and join all the C and C++ parser source names
# 5) Create yacc parsers default header files
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(yaccext) $(yaxxext),\
        $(eval allparser += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
allparser := $(call filter-ignored,$(allparser))
#------------------------------------------------------------------[ 3 ]
cxxparser := $(foreach e,$(yaxxext),$(filter %$e,$(allparser)))
cparser   := $(filter-out $(cxxparser),$(allparser))
#------------------------------------------------------------------[ 4 ]
yaccall   += $(foreach E,$(yaccext) $(yaxxext),\
                $(patsubst %$E,%.tab.cc,$(filter %$E,$(cxxparser))))
yaccall   += $(foreach E,$(yaccext) $(yaxxext),\
                $(patsubst %$E,%.tab.c,$(filter %$E,$(cparser))))
yaccall   := $(strip $(yaccall))
#------------------------------------------------------------------[ 5 ]
yaccinc   := $(call not-root,$(basename $(basename $(yaccall))))
yaccinc   := $(addprefix $(firstword $(incdir))/,$(yaccinc))
yaccinc   := $(addsuffix -tab/,$(yaccinc))

# Automatically generated files
# =============================
autoall := $(yaccall) $(lexall)
autoinc := $(yaccinc) $(lexinc)

# Source files
# =============
# 1) srcall : Find in the dir trees all source files (with dir names)
# 2) srcall : Filter out ignored files from above
# 2) srcall : Remove automatically generated source files from srcall
# 3) liball : Save complete paths for libraries (wildcard-expanded)
# 4) libpat : Save complete paths for libraries (non-wildcard-expanded)
# 5) srccln : Remove library src from normal src
# 5) autocln: Remove library src from normal auto generated src
# 6) src    : Remove root directory names from dir paths
# 6) autosrc: Remove root directory names from dir paths
#------------------------------------------------------------------[ 1 ]
ifneq ($(srcdir),.)
srcall := $(sort\
    $(foreach root,$(srcdir),\
        $(foreach E,$(srcext),\
            $(call rwildcard,$(root),*$E)\
)))
else 
$(warning Source directory is '.'. Deep search for source disabled.)
srcall := $(sort\
    $(foreach E,$(srcext),\
        $(wildcard *$E)\
))
endif
#------------------------------------------------------------------[ 2 ]
srcall := $(call filter-ignored,$(srcall))
#------------------------------------------------------------------[ 3 ]
srcall := $(call rfilter-out,$(lexall) $(yaccall),$(srcall))
#------------------------------------------------------------------[ 4 ]
liball := $(sort \
    $(foreach r,$(autoall) $(srcall) $(asmall),\
        $(foreach l,$(lib_in),\
            $(strip $(foreach s,$r,\
                $(if $(findstring $l,$s),$s)))\
)))
# Give error if there is no match with the lib name
$(foreach l,$(lib_in),\
    $(if $(findstring $l,$(liball)),,\
        $(error Library file/directory "$l" not found)))
#------------------------------------------------------------------[ 5 ]
# Search-for-complete-path steps:
# * Cases #6 (path witout root) and #7 (all path);
# * Case  #2 (path without file);
# * Case  #4 (path with file without extension);
libpat := $(sort \
    $(foreach l,$(lib_in),$(or\
        $(strip $(foreach s,$(srcall),\
            $(if $(findstring $l,$s),\
                $(filter %$l,$s))\
        )),\
        $(strip $(foreach root,$(srcdir),\
            $(firstword $(sort \
                $(foreach s,$(call rsubdir,$(root)),\
                    $(if $(findstring $l,$s),$s)\
                )\
        )))),\
        $(strip $(foreach s,$(srcall) $(autoall) $(asmall),\
            $(if $(findstring $l,$s),$s)\
        ))\
    ))\
)
#------------------------------------------------------------------[ 6 ]
srccln  := $(srcall)
srccln  := $(call rfilter-out,$(liball),$(srccln))

asmcln  := $(asmall)
asmcln  := $(call rfilter-out,$(liball),$(asmcln))

autocln := $(autoall)
autocln := $(call rfilter-out,$(liball),$(autocln))
#------------------------------------------------------------------[ 7 ]
src     := $(call not-root,$(srccln))
asmsrc  := $(call not-root,$(asmcln))
autosrc := $(call not-root,$(autocln))

# Static libraries
# =================
# 1) Get complete static library paths from all libraries
# 2) Store static library paths without root directory
# 3) Create one var with the object dependencies for each lib above
# 4) Create variables for all static library objects
# 5) Create library simple names, without directories or extension
# 6) Create library names, with directories, from the source
#------------------------------------------------------------------[ 1 ]
arpat   := \
$(foreach ar,$(ar_in),\
    $(foreach l,$(libpat),\
        $(if $(findstring $(ar),$l),$l)\
))
#------------------------------------------------------------------[ 2 ]
arpatsrc  := $(call not-root,$(arpat))
#------------------------------------------------------------------[ 3 ]
$(foreach ar,$(arpat),\
    $(eval arobj_$(call not-root,$(ar)) := \
        $(foreach l,$(liball),\
            $(if $(strip $(findstring $(ar),$l)),\
                $(addprefix $(objdir)/,\
                    $(addsuffix $(firstword $(objext)),\
                         $(call not-root,$(basename $l)\
)))))))
#------------------------------------------------------------------[ 4 ]
arobj   := $(foreach ar,$(arpatsrc),$(arobj_$(ar)))
#------------------------------------------------------------------[ 5 ]
arname  := $(notdir $(basename $(arpatsrc)))
#------------------------------------------------------------------[ 6 ]
arlib   := $(foreach s,$(arpatsrc),\
               $(patsubst $(subst ./,,$(dir $s))%,\
               $(subst ./,,$(dir $s))lib%,$s)\
           )
arlib   := $(patsubst %,$(firstword $(libdir))/%.a,$(basename $(arlib)))

# Dynamic libraries
# ==================
# 1) Get all source files that may be compiled to create the shared lib
# 2) Get complete dynamic library paths from all libraries
# 3) Store dynamic library paths without root directory
# 4) Create one var with the object dependencies for each lib above
# 5) Create variables for all dynamic library objects
# 6) Create library simple names, without directories or extension
# 7) Create library complete names, with directories, from the source
# 8) Set directories for locally searching for the libraries
#------------------------------------------------------------------[ 1 ]
shrall  := \
$(foreach so,$(shr_in),\
    $(foreach l,$(liball),\
        $(if $(findstring $(so),$l),$l)\
))
#------------------------------------------------------------------[ 2 ]
shrpat  := \
$(foreach so,$(shr_in),\
    $(foreach l,$(libpat),\
        $(if $(findstring $(so),$l),$l)\
))
#------------------------------------------------------------------[ 3 ]
shrpatsrc := $(call not-root,$(shrpat))
#------------------------------------------------------------------[ 4 ]
$(foreach shr,$(shrpat),\
    $(eval shrobj_$(call not-root,$(shr)) := \
        $(foreach l,$(liball),\
            $(if $(strip $(findstring $(shr),$l)),\
                $(addprefix $(objdir)/,\
                    $(addsuffix $(firstword $(objext)),\
                         $(call not-root,$(basename $l)\
)))))))
#------------------------------------------------------------------[ 5 ]
shrobj   := $(foreach shr,$(shrpatsrc),$(shrobj_$(shr)))
#------------------------------------------------------------------[ 6 ]
shrname := $(notdir $(basename $(shrpatsrc)))
#------------------------------------------------------------------[ 7 ]
shrlib  := $(foreach s,$(shrpatsrc),\
                $(patsubst $(subst ./,,$(dir $s))%,\
                $(subst ./,,$(dir $s))lib%,$s)\
            )
shrlib  := $(patsubst %,$(firstword $(libdir))/%.so,$(basename $(shrlib)))
#------------------------------------------------------------------[ 8 ]
$(if $(strip $(shrpatsrc)),\
    $(foreach d,$(sort $(dir $(shrlib))),\
        $(eval ldflags := -Wl,-rpath=$d $(ldflags))\
))

# External libraries
# ====================
# 1) externlib  : Extra libraries given by the user
# 2) externlib  : Filter out ignored files from above
# 2) externname : Extra libraries names, deduced from above
#------------------------------------------------------------------[ 1 ]
externlib  := \
$(foreach e,$(libext),\
    $(foreach d,$(wordlist 2,$(words $(libdir)),$(libdir)),\
        $(call rwildcard,$d,*$e)\
))
#------------------------------------------------------------------[ 2 ]
externlib  := $(call filter-ignored,$(externlib))
#------------------------------------------------------------------[ 3 ]
externname := \
$(foreach e,$(libext),\
    $(patsubst lib%$e,%,$(filter lib%$e,$(notdir $(externlib))))\
)

# Object files
# =============
# 1) Add obj suffix for each 'naked' assembly source file name (basename)
# 2) Add obj suffix for each 'naked' source file name (basename)
# 3) Prefix the build dir before each name
# 4) Join all object files (including auto-generated)
# 5) Repeat (1) and (3) for the automatically generated sources
#------------------------------------------------------------------[ 1 ]
obj := $(addsuffix $(firstword $(objext)),$(basename $(asmsrc)))
#------------------------------------------------------------------[ 2 ]
obj += $(addsuffix $(firstword $(objext)),$(basename $(src)))
#------------------------------------------------------------------[ 3 ]
obj := $(addprefix $(objdir)/,$(obj))
#------------------------------------------------------------------[ 4 ]
objall := $(obj) $(arobj) $(shrobj) #$(autoobj)
#------------------------------------------------------------------[ 5 ]
autoobj := $(addsuffix $(firstword $(objext)),$(basename $(autosrc)))
autoobj := $(addprefix $(objdir)/,$(autoobj))

# Header files
# =============
# 1) Get all subdirectories of the included dirs
# 2) Add them as paths to be searched for headers
# 3) Get all files able to be included
# 4) Filter out ignored files from above
#------------------------------------------------------------------[ 1 ]
incsub  := $(foreach i,$(incdir),$(call rsubdir,$i))
incsub  += $(lexinc) $(yaccinc)
#------------------------------------------------------------------[ 2 ]
clibs   := $(patsubst %,-I%,$(incsub))
flibs   := $(patsubst %,-I%,$(incsub))
cxxlibs := $(patsubst %,-I%,$(incsub))
#------------------------------------------------------------------[ 3 ]
incall  := $(foreach i,$(incdir),$(foreach e,$(incext),\
                $(call rwildcard,$i,*$e)))
#------------------------------------------------------------------[ 4 ]
incall  := $(call filter-ignored,$(incall))

# Library files
# ==============
# 1) lib: all static and shared libraries
# 2) libname: all static and shared libraries names
# 3) Get all subdirectories of the library dirs and 
#    add them as paths to be searched for libraries
lib     := $(arlib) $(shrlib) $(externlib)
libname := $(arname) $(shrname) $(externname)
libsub   = $(if $(strip $(lib)),$(foreach d,$(libdir),$(call rsubdir,$d)))
ldlibs   = $(sort $(patsubst %/,%,$(patsubst %,-L%,$(libsub))))

# Type-specific libraries
# ========================
# 1) Add c, f, cxx, lex and yacc only libraries in linker flags
$(if $(strip $(call has_c,$(srcall))),$(eval ldflags += $(LDC)))
$(if $(strip $(call has_f,$(srcall))),$(eval ldflags += $(LDF)))
$(if $(strip $(call has_cxx,$(srcall))),$(eval ldflags += $(LDCXX)))
$(if $(strip $(lexall)),$(eval ldflags += $(LDLEX)))
$(if $(strip $(yaccall)),$(eval ldflags += $(LDYACC)))

# Automated tests
# ================
# 1) testall: Get all source files in the test directory
# 2) testall: Filter out ignored files from above
# 3) testdep: Basenames without test suffix, root dirs and extensions
# 4) testrun: Alias to execute tests, prefixing run_ and 
#             substituting / for _ in $(testdep)
#------------------------------------------------------------------[ 1 ]
$(foreach E,$(srcext),\
    $(eval testall += $(call rwildcard,$(testdir),*$(testsuf)$E)))
#------------------------------------------------------------------[ 2 ]
testall := $(call filter-ignored,$(testall))
#------------------------------------------------------------------[ 3 ]
testdep := $(basename $(call not-root,$(subst $(testsuf).,.,$(testall))))
#------------------------------------------------------------------[ 4 ]
testrun := $(addprefix run_,$(subst /,_,$(testdep)))

# Dependency files
# =================
# 1) Dependencies will be generated for sources, auto sources and tests
# 2) Get the not-root basenames of all source directories
# 3) Create dependency names and directories
depall  := $(testall) $(call not-root,$(srcall) $(autoall))
depall  := $(strip $(basename $(depall)))
depall  := $(addprefix $(depdir)/,$(addsuffix $(depext),$(depall)))

# Binary
# =======
# 1) Define all binary names (with extensions if avaiable)
# 2) Store binary-specific files from source, objects and libs
# 3) Store common source, objects and libs filtering the above ones
# 4) Create variables:
#    4.1) binary-name_src, for binary's specific sources;
#    4.2) binary-name_obj, for binary's specific objects;
#    4.3) binary-name_lib, for binary's specific libraries;
#    4.4) binary-name_link, for binary's specific linker flags;
#    4.5) binary-name_aobj, for binary's specific auto-generated objects;
#    4.6) binary-name_asrc, for binary's specific auto-generated sources;
#    4.7) binary-name_is_cxx, to test if the binary may be C's or C++'s
#------------------------------------------------------------------[ 1 ]
bin     := $(addprefix $(bindir)/,$(notdir $(sort $(strip $(BIN)))))
bin     := $(call filter-ignored,$(bin))
bin     := $(if $(strip $(binext)),\
                $(addsuffix $(binext),$(bin)),$(bin))

sbin    := $(addprefix $(sbindir)/,$(notdir $(sort $(strip $(SBIN)))))
sbin    := $(call filter-ignored,$(sbin))
sbin    := $(if $(strip $(binext)),\
                $(addsuffix $(binext),$(sbin)),$(sbin))

libexec := $(addprefix $(execdir)/,$(notdir $(sort $(strip $(LIBEXEC)))))
libexec := $(call filter-ignored,$(libexec))
libexec := $(if $(strip $(binext)),\
                $(addsuffix $(binext),$(libexec)),$(libexec))

$(if $(strip $(bin) $(sbin) $(libexec)),\
    $(eval binall := $(bin) $(sbin) $(libexec)),\
    $(eval binall := $(bindir)/a.out)\
)
#------------------------------------------------------------------[ 2 ]
$(foreach sep,/ .,$(foreach b,$(notdir $(binall)),$(or\
    $(eval $b_src  += $(filter $b$(sep)%,$(src))),\
    $(eval $b_obj  += $(filter $(objdir)/$b$(sep)%,$(objall))),\
    $(eval $b_aobj += $(filter $(objdir)/$b$(sep)%,$(autoobj))),\
    $(eval $b_lib  += $(foreach d,$(libdir),\
                          $(filter $d/$b$(sep)%,$(lib)))),\
    $(eval $b_link += $(foreach n,$(libname),$(if $(strip \
                          $(filter %$n,$(basename $($b_lib)))),$n))),\
    $(eval $b_aall += $(foreach d,$(srcdir),\
                          $(filter $d/$b$(sep)%,$(autosrc)))),\
)))
#------------------------------------------------------------------[ 3 ]
define common-factory
$(call rfilter-out,$(foreach b,$(notdir $(binall)),$($b_$1)),$2)
endef
comsrc  := $(call common-factory,src,$(src))
comobj  := $(call common-factory,obj,$(objall))
comlib  := $(call common-factory,lib,$(lib))
comlink := $(call common-factory,link,$(libname))
comaobj := $(call common-factory,aobj,$(autoobj))
comaall := $(call common-factory,aall,$(autoall))
#------------------------------------------------------------------[ 4 ]
$(foreach b,$(notdir $(binall)),$(or\
    $(eval $b_src    := $(comsrc)  $($b_src)  ),\
    $(eval $b_obj    := $(comobj)  $($b_obj)  ),\
    $(eval $b_lib    := $(comlib)  $($b_lib)  ),\
    $(eval $b_aobj   := $(comaobj) $($b_aobj) ),\
    $(eval $b_aall   := $(comasrc) $($b_aall) ),\
    $(eval $b_link   := $(sort $(addprefix -l,$($b_link) $(comlink)))),\
    $(eval $b_is_f   := $(strip $(call is_f,$($b_src)))),\
    $(eval $b_is_cxx := $(strip $(call is_cxx,$($b_src)))),\
))

# Install binary
# ================
i_lib     := $(addprefix $(i_libdir)/,$(call not-root,$(lib)))
i_bin     := $(addprefix $(i_bindir)/,$(call not-root,$(bin)))
i_sbin    := $(addprefix $(i_sbindir)/,$(call not-root,$(sbin)))
i_libexec := $(addprefix $(i_libexecdir)/,$(call not-root,$(libexec)))

# Texinfo files
# ==============
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

# Debian packaging files
# =======================
# 1) debdep: debian packaging files in the default debian directory
debdep := changelog compat control copyright 
debdep += rules source/format $(DEB_PROJECT).dirs
debdep := $(sort $(strip $(addprefix $(debdir)/,$(debdep))))

########################################################################
##                              BUILD                                 ##
########################################################################

.PHONY: all
all: $(binall)

.PHONY: package
package: package-tar.gz

.PHONY: dist
dist: dist-tar.gz

.PHONY: tar
tar: dist-tar

.PHONY: check
check: $(testrun)
	$(if $(strip $^),$(call phony-ok,$(MSG_TEST_SUCCESS)))

.PHONY: nothing
nothing:

.PHONY: dpkg
dpkg: package-tar.gz $(debdep)
	
	@# Step 1: Rename the upstream tarball
	$(call phony-status,$(MSG_DEB_STEP1))
	$(quiet) $(MV) $(distdir)/$(PROJECT)-$(VERSION)_src.tar.gz \
	         $(distdir)/$(DEB_PROJECT)_$(VERSION).orig.tar.gz $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP1))
	
	@# Step 2: Unpack the upstream tarball
	$(call phony-status,$(MSG_DEB_STEP2))
	$(quiet) cd $(distdir) \
	         && tar xf $(DEB_PROJECT)_$(VERSION).orig.tar.gz $(ERROR)
	$(call srmdir,$(distdir)/$(DEB_PROJECT)-$(VERSION))
	$(quiet) $(MV) $(distdir)/$(PROJECT)-$(VERSION)_src \
	         $(distdir)/$(DEB_PROJECT)-$(VERSION) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP2))
	
	@# Step 3: Add the Debian packaging files
	$(call phony-status,$(MSG_DEB_STEP3))
	$(quiet) $(CP) $(debdir) \
             $(distdir)/$(DEB_PROJECT)-$(VERSION) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP3))
	
	@# Step 4: Install the package
	$(call phony-status,$(MSG_DEB_STEP4))
	$(quiet) cd $(distdir)/$(DEB_PROJECT)-$(VERSION) \
	         && $(DEBUILD) $(ERROR)
	$(call phony-ok,$(MSG_DEB_STEP4))

$(debdir)/changelog: | $(debdir)
	$(quiet) $(DCH)

$(debdir)/compat: | $(debdir)
	$(call touch,$@)
	$(quiet) echo 9 >> $@

$(debdir)/control: | $(debdir)
	$(call touch,$@)
	$(call select,$@)
	@echo " "                                                 >> $@
	@echo "Source: $(DEB_PROJECT)"                            >> $@
	@echo "Maintainer: $(MAINTEINER_NAME) $(MAINTEINER_MAIL)" >> $@
	@echo "Section: misc"                                     >> $@
	@echo "Priority: $(DEB_PRIORITY)"                         >> $@
	@echo "Standards-Version: $(VERSION)"                     >> $@
	@echo "Build-Depends: debhelper (>= 9)"                   >> $@
	@echo " "                                                 >> $@
	@echo "Package: $(DEB_PROJECT)"                           >> $@
	@echo "Architecture: any"                                 >> $@
	@echo "Depends: "$$"{shlibs:Depends}, "$$"{misc:Depends}" >> $@
	@echo "Description: $(SYNOPSIS)"                          >> $@
	@echo " $(DESCRIPTION)"                                   >> $@
	$(call select,stdout)

$(debdir)/copyright: | $(debdir)
	$(call touch,$@,$(NOTICE))

$(debdir)/rules: | $(debdir)
	$(call touch,$@)
	$(call select,$@)
	$(call cat,"#!/usr/bin/make -f                                    ")
	$(call cat,"                                                      ")
	$(call cat,"%:                                                    ")
	$(call cat,"\tdh "$$"@                                            ")
	$(call cat,"                                                      ")
	$(call cat,"override_dh_auto_install:                             ")
	$(call cat,"\t"$$"(MAKE) \\"                                       )
	$(call cat,"    DESTDIR="$$""$$"(pwd)/debian/$(DEB_PROJECT) \\"    )
	$(call cat,"    prefix=/usr install"                               )
	$(call select,stdout)

$(debdir)/source/format: | $(debdir)
	$(call mksubdir,$(debdir),$@)
	$(call touch,$@)
	$(quiet) echo "3.0 (quilt)" >> $@

$(debdir)/$(DEB_PROJECT).dirs: | $(debdir)
	$(call touch,$@)
	$(call select,$@)
	$(if $(strip $(bin)),     $(call cat,'$(i_bindir)                '))
	$(if $(strip $(sbin)),    $(call cat,'$(i_sbindir)               '))
	$(if $(strip $(libexec)), $(call cat,'$(i_libexecdir)            '))
	$(if $(strip $(lib)),     $(call cat,'$(i_libdir)                '))
	$(if $(strip $(texiinfo)),$(call cat,'$(i_docdir)/info           '))
	$(call select,stdout)

########################################################################
##                          INITIALIZATION                            ##
########################################################################

.PHONY: init
init:
	$(call mkdir,$(srcdir))
	$(call mkdir,$(incdir))
	$(call mkdir,$(docdir))
	$(quiet) $(MAKE) config > Config.mk
	$(quiet) $(MAKE) gitignore > .gitignore

.PHONY: standard
standard:
	$(call mv,$(objext),$(objdir))
	$(call mv,$(libext),$(firstword libdir))
	$(call mv,$(docext),$(docdir))
	$(call mv,$(incext),$(firstword incdir))
	$(call mv,$(srcext) $(asmext),$(firstword srcdir))
	$(call mv,$(lexext) $(lexxext) $(yaccext) $(yaxxext),\
        $(firstword srcdir))

########################################################################
##                           INSTALLATION                             ##
########################################################################

.PHONY: install-strip
install-strip:
	$(MAKE) INSTALL_PROGRAM='$(INSTALL_PROGRAM) -s' install

.PHONY: install
install: $(i_lib) $(i_bin) $(i_sbin) $(i_libexec) install-docs

.PHONY: install-docs
install-docs: install-info install-html install-dvi
install-docs: install-pdf install-ps

.PHONY: install-info
install-info: 
	$(if $(strip $(texiinfo)),$(foreach f,$(texiinfo),\
        $(INSTALL_DATA) $f $(i_infodir)/$(notdir $f);\
        if $(SHELL) -c '$(INSTALL_INFO) --version' $(NO_OUTOUT) 2>&1; \
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
##                          DOCUMENTATION                             ##
########################################################################

.PHONY: docs
all-docs: $(if $(strip $(doxyfile)),doxy) 
all-docs: $(if $(strip $(texiall)),info html dvi pdf ps)

ifneq ($(strip $(doxyfile)),) ####

.PHONY: doxy
doxy: $(docdir)/$(doxyfile).mk
	$(call phony-status,$(MSG_DOXY_DOCS))
	$(quiet) $(DOXYGEN) $< $(NO_OUTPUT) $(NO_ERROR)
	$(call phony-ok,$(MSG_DOXY_DOCS))

$(docdir)/$(doxyfile).mk: | $(docdir) $(docdir)/doxygen
$(docdir)/$(doxyfile).mk: $(doxyfile) $(srcall) $(incall)
	$(call status,$(MSG_DOXY_MAKE))
	$(quiet) $(CP) $< $@
	
	@echo "                                                      " >> $@
	@echo "######################################################" >> $@
	@echo "##                 MAKEFILE CONFIGS                 ##" >> $@
	@echo "######################################################" >> $@
	@echo "                                                      " >> $@
	@echo "# Project info                                        " >> $@
	@echo "PROJECT_NAME     = $(PROJECT)                         " >> $@
	@echo "PROJECT_NUMBER   = $(VERSION)                         " >> $@
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

endif # ifneq($(strip $(doxyfile)),) ####

########################################################################
##                              RULES                                 ##
########################################################################

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

ifeq ($$(wildcard $$(firstword $$(incdir))/$1-yy),)
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
    $(LEX_CXX))\
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

ifeq ($$(wildcard $$(firstword $$(incdir))/$1-tab),)
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
    $(YACC_CXX))\
))

#======================================================================#
# Function: compile-asm                                                #
# @param  $1 Assembly extension                                        #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all Assembly files with the given          #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-asm
$$(objdir)/$3%$$(firstword $$(objext)): $2%$1 | $$(depdir)
	$$(call status,$$(MSG_ASM_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$3$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(AS) $$(ASMFLAGS) $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_ASM_COMPILE),$$@)
endef
$(foreach root,$(srcdir),\
    $(foreach E,$(asmext),\
        $(eval $(call compile-asm,$E,$(root)/))))

#======================================================================#
# Function: compile-c                                                  #
# @param  $1 C extension                                               #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all C files with the given extension,      #
#         looking in the right root directory                          #
#======================================================================#
define compile-c
$$(objdir)/$3%$$(firstword $$(objext)): $2%$1 | $$(depdir)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$3$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) $$(cflags) $$(clibs) -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_C_COMPILE),$$@)
endef
$(foreach root,$(srcdir),$(foreach E,$(cext),\
    $(eval $(call compile-c,$E,$(root)/))))
$(foreach E,$(cext),\
    $(eval $(call compile-c,$E,$(testdir)/,$(testdir)/)))

#======================================================================#
# Function: compile-cpp                                                #
# @param  $1 C++ extension                                             #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all C++ files with the given extension     #
#         looking in the right root directory                          #
#======================================================================#
define compile-cpp
$$(objdir)/$3%$$(firstword $$(objext)): $2%$1 | $$(depdir)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call cpp-depend,$$<,$$@,$3$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) $$(cxxlibs) $$(cxxflags) -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_CXX_COMPILE),$$@)
endef
$(foreach root,$(srcdir),$(foreach E,$(cxxext),\
    $(eval $(call compile-cpp,$E,$(root)/))))
$(foreach E,$(cxxext),\
    $(eval $(call compile-cpp,$E,$(testdir)/,$(testdir)/)))

#======================================================================#
# Function: compile-fortran                                            #
# @param  $1 Fortran extension                                         #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all Fortran files with the given           #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-fortran
$$(objdir)/$3%$$(firstword $$(objext)): $2%$1 | $$(depdir)
	$$(call status,$$(MSG_F_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call fortran-depend,$$<,$$@,$3$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(FC) $$(fflags) $$(flibs) -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_F_COMPILE),$$@)
endef
$(foreach root,$(srcdir),$(foreach E,$(fext),\
    $(eval $(call compile-fortran,$E,$(root)/))))
$(foreach E,$(fext),\
    $(eval $(call compile-fortran,$E,$(testdir)/,$(testdir)/)))

# Include dependencies for each src extension
-include $(depall)

#======================================================================#
# Function: compile-sharedlib-linux-c                                  #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the C library file                         #
#======================================================================#
define compile-sharedlib-linux-c
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_C_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call c-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) -fPIC $$(clibs) $$(cflags) -c $$< -o $$@ $$(ERROR)
	
	$$(call ok,$$(MSG_C_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(cext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-c,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: compile-sharedlib-linux-cpp                                #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the C++ library file                       #
#======================================================================#
define compile-sharedlib-linux-cpp
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_CXX_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call cpp-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) -fPIC $$(cxxlibs) $$(cxxflags) -c $$< -o $$@ \
              $$(ERROR)
	
	$$(call ok,$$(MSG_CXX_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(cxxext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-cpp,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: compile-sharedlib-linux-fortran                            #
# @param  $1 File root directory                                       #
# @param  $2 File basename without root dir                            #
# @param  $3 File extension                                            #
# @return Target to compile the Fortran library file                   #
#======================================================================#
define compile-sharedlib-linux-fortran
$$(objdir)/$2$$(firstword $$(objext)): $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_F_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call fortran-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(FC) -fPIC $$(flibs) $$(fflags) -c $$< -o $$@ \
              $$(ERROR)
	
	$$(call ok,$$(MSG_F_LIBCOMP),$$@)
endef
$(foreach s,$(foreach E,$(fext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-fortran,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: link-sharedlib-linux                                       #
# @param  $1 Directory in which the lib may be put                     #
# @param  $2 Subdirectories in which the lib may be put                #
# @param  $3 File/dir basename that makes the name of the dir          #
# @param  $4 Object dependencies of this static library                #
# @return Target to create a shared library from objects               #
#======================================================================#
define link-sharedlib-linux
$1/$2lib$3.so: $4 | $1
	$$(call status,$$(MSG_CXX_SHRDLIB))
	$$(quiet) $$(call mksubdir,$1,$$(objdir)/$2)
	$$(quiet) $$(CXX) $$(soflags) -o $$@ $$^ $$(ERROR)
	$$(call ok,$$(MSG_CXX_SHRDLIB),$$@)
endef
$(foreach s,$(shrpatsrc),\
    $(eval $(call link-sharedlib-linux,$(firstword $(libdir)),$(patsubst ./%,%,$(dir $s)),$(notdir $(basename $s)),$(shrobj_$s))))

#======================================================================#
# Function: link-statlib-linux                                         #
# @param  $1 Directory in which the lib may be put                     #
# @param  $2 Subdirectories in which the lib may be put                #
# @param  $3 File/dir basename that makes the name of the dir          #
# @param  $4 Object dependencies of this static library                #
# @return Target to create a static library from objects               #
#======================================================================#
define link-statlib-linux
$1/$2lib$3.a: $4 | $1
	$$(call status,$$(MSG_STATLIB))
	$$(quiet) $$(call mksubdir,$1,$$(objdir)/$2)
	$$(quiet) $$(AR) $$(arflags) $$@ $$^ $$(NO_OUTPUT) $$(NO_ERROR)
	$$(quiet) $$(RANLIB) $$@
	$$(call ok,$$(MSG_STATLIB),$$@)
endef
$(foreach a,$(arpatsrc),\
    $(eval $(call link-statlib-linux,$(firstword $(libdir)),$(patsubst ./%,%,$(dir $a)),$(notdir $(basename $a)),$(arobj_$a))))

#======================================================================#
# Function: test-factory                                               #
# @param  $1 Binary name for the unit test module                      #
# @param  $2 Object with main function for running unit test           #
# @param  $3 Object with the code that will be tested by the unit test #
# @param  $4 Alias to execute tests, prefixing run_ and                #
#            substituting / for _ in $(testdep)                        #
# @return Target to generate binary file for the unit test             #
#======================================================================#
define test-factory
$1: $2 $3 | $$(bindir)
	$$(call status,$$(MSG_TEST_COMPILE))
	$$(quiet) $$(call mksubdir,$$(bindir),$$@)
	$$(quiet) $$(CXX) $$^ -o $$@ $$(ldflags) $$(ldlibs)
	$$(call ok,$$(MSG_TEST_COMPILE),$$@)

.PHONY: $4
$4: $1
	$$(call phony-status,$$(MSG_TEST))
	@./$$< $$(NO_OUTPUT) || $$(call test-error,$$(MSG_TEST_FAILURE))
	$$(call phony-ok,$$(MSG_TEST))
endef
$(foreach s,$(testdep),$(eval\
    $(call test-factory,\
        $(bindir)/$(testdir)/$s$(testsuf)$(binext),\
        $(objdir)/$(testdir)/$s$(testsuf)$(firstword $(objext)),\
        $(if $(strip \
            $(filter $(objdir)/$s$(firstword $(objext)),$(objall))),\
                $(objdir)/$s$(firstword $(objext)),\
                $(warning "$(objdir)/$s$(firstword $(objext)) not found")\
        ),\
        run_$(subst /,_,$s)\
)))

#======================================================================#
# Function: binary-factory                                             #
# @param  $1 Binary name                                               #
# @param  $2 Compiler to be used (C's or C++'s)                        #
# @return Target to generate binaries and dependencies of its object   #
#         files (to create objdir and automatic source)                #
#======================================================================#
define binary-factory
$1$2: $$($2_lib) $$($2_aobj) $$($2_obj) | $1
	$$(call status,$$(MSG_$$(strip $3)_LINKAGE))
	$$(quiet) $4 $$($2_aobj) $$($2_obj) -o $$@ \
              $$(ldflags) $$($2_link) $$(ldlibs) $$(ERROR)
	$$(call ok,$$(MSG_$$(strip $3)_LINKAGE),$$@)

$$($2_obj): | $$(objdir)

$$($2_aobj): $$($2_aall) | $$(objdir)
endef
$(foreach b,$(binall),$(eval\
    $(call binary-factory,$(dir $b),$(notdir $b),\
        $(if $($(strip $(notdir $b))_is_c),C,\
        $(if $($(strip $(notdir $b))_is_f),F,\
        $(if $($(strip $(notdir $b))_is_cxx),CXX,CXX\
    ))),\
        $(if $($(strip $(notdir $b))_is_c),$(CC),\
        $(if $($(strip $(notdir $b))_is_f),$(FC),\
        $(if $($(strip $(notdir $b))_is_cxx),$(CXX),$(CXX)\
    ))),\
)))

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
$1: $$(texi$1)
	$$(call phony-ok,$$(MSG_TEXI_DOCS))

$$(docdir)/$1/%$2: $$(filter $$(docdir)/$$*%,$$(texiall)) | $$(docdir)/$1
	$$(call status,$$(MSG_TEXI_FILE))
	$$(call mksubdir,$$(docdir)/$1,$$<)
	$$(quiet) $3 $$< -o $$@ $$(ERROR)
	$$(call srm,$$(notdir $$(basename $$@)).*)
	$$(call ok,$$(MSG_TEXI_FILE),$$@)

$$(docdir)/$1:
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
$1/$$(call not-root,$2): | $1
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
$1/$$(call not-root,$2): | $1
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
%.$1: $$(binall)
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
package-$1: dirs := Makefile $$(make_configs)
package-$1: dirs += $$(srcdir) $$(incdir) $$(datadir) $$(docdir)
package-$1: dirs += $$(if $$(strip $$(lib)),$$(libdir)) $$(bindir) 
package-$1: $$(distdir)/$$(PROJECT)-$$(VERSION)_src.$1

.PHONY: dist-$1
dist-$1: dirs := Makefile $$(make_configs)
dist-$1: dirs += $$(if $$(strip $$(lib)),$$(libdir)) $$(bindir)
dist-$1: $$(distdir)/$$(PROJECT)-$$(VERSION).$1
endef
$(foreach e,tar.gz tar.bz2 tar zip tgz tbz2,\
    $(eval $(call dist-factory,$e)))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: mostlyclean
mostlyclean:
	$(call rm-if-empty,$(objdir),$(objall) $(autoobj))

.PHONY: clean
clean: mostlyclean
	$(call rm-if-empty,$(bindir),$(bin))
	$(call rm-if-empty,$(sbindir),$(sbin))
	$(call rm-if-empty,$(execdir),$(libexec))

.PHONY: distclean
distclean: clean
	$(call rm-if-empty,$(depdir),$(depall))
	$(call rm-if-empty,$(distdir))
	$(call rm-if-empty,$(firstword $(libdir)),\
        $(filter $(firstword $(libdir))/%,$(lib))\
    )

.PHONY: docclean
docclean:
	$(call rm-if-empty,$(docdir)/doxygen)
	$(call rm-if-empty,$(docdir)/info,$(texiinfo))
	$(call rm-if-empty,$(docdir)/html,$(texihtml))
	$(call rm-if-empty,$(docdir)/dvi,$(texidvi))
	$(call rm-if-empty,$(docdir)/pdf,$(texipdf))
	$(call rm-if-empty,$(docdir)/ps,$(texips))

.PHONY: packageclean
packageclean:
	$(call rm-if-empty,$(distdir)/$(DEB_PROJECT)-$(VERSION))
	$(call rm-if-empty,$(debdir),$(debdep))

.PHONY: realclean
realclean: docclean distclean packageclean
	$(if $(lexall),\
        $(call rm,$(lexall)),\
        $(call phony-ok,$(MSG_LEX_NONE))  )
	$(if $(yaccall),\
        $(call rm,$(yaccall)),\
        $(call phony-ok,$(MSG_YACC_NONE)) )

.PHONY: mainteiner-clean
mainteiner-clean: 
	@$(MAKE) realclean MAINTEINER_CLEAN=1

.PHONY: uninitialize
ifndef U
uninitialize:
	@echo $(MSG_UNINIT_WARN)
	@echo $(MSG_UNINIT_ALT)
else
uninitialize: mainteiner-clean
	$(call rm-if-empty,$(srcdir),$(srcall))
	$(call rm-if-empty,$(incdir),$(incall))
	$(call rm-if-empty,$(docdir),$(texiall))
	$(call rm,Config.mk config.mk)
	$(call rm,Config_os.mk config_os.mk)
endif

########################################################################
##                              OUTPUT                                ##
########################################################################
ifdef SILENT
V := 1
endif

# Hide command execution details
V   ?= 0
Q_0 := @
quiet := $(Q_$V)

O_0 := 1> /dev/null
E_0 := 2> /dev/null
NO_OUTPUT := $(O_$V)
NO_ERROR  := $(E_$V)

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

MSG_CMD_UNRECOG   = "${RED}Command $@ unknown. Type '${DEF}make"\
                    "projecthelp${RED}' for valid targets.${RES}"

MSG_RM            = "${BLUE}Removing ${RES}$1${RES}"
MSG_MKDIR         = "${CYAN}Creating directory $1${RES}"
MSG_UNINIT_WARN   = "${RED}Are you sure you want to delete all"\
                    "sources, headers and configuration files?"
MSG_UNINIT_ALT    = "${DEF}Run ${BLUE}'make uninitialize U=1'${RES}"

MSG_MOVE          = "${YELLOW}Populating directory $(firstword $2)${RES}"
MSG_NO_MOVE       = "${PURPLE}Nothing to put in $(firstword $2)${RES}"

MSG_TOUCH         = "${PURPLE}Creating new file ${DEF}$1${RES}"
MSG_NEW_EXT       = "${RED}Extension '$1' invalid${RES}"
MSG_DELETE_WARN   = "${RED}Are you sure you want to do deletes?${RES}"
MSG_DELETE_ALT    = "${DEF}Run ${BLUE}'make delete FLAGS D=1'${RES}"

MSG_RMDIR         = "${BLUE}Removing directory ${CYAN}$1${RES}"
MSG_RM_NOT_EMPTY  = "${PURPLE}Directory ${WHITE}$d${RES} not empty"
MSG_RM_EMPTY      = "${PURPLE}Nothing to remove in $d${RES}"

MSG_TEXI_FILE     = "${DEF}Generating $1 file ${WHITE}$@${RES}"
MSG_TEXI_DOCS     = "${BLUE}Generating docs in ${WHITE}$@${RES}"

MSG_DOXY_DOCS     = "${YELLOW}Generating Doxygen docs${RES}"
MSG_DOXY_FILE     = "${BLUE}Generating Doxygen file ${WHITE}$@${RES}"
MSG_DOXY_MAKE     = "${BLUE}Generating Doxygen config ${WHITE}$@${RES}"

MSG_INSTALL_BIN   = "${DEF}Installing binary file ${GREEN}$@${RES}"
MSG_UNINSTALL_BIN = "${DEF}Uninstalling binary file ${GREEN}$@${RES}"
MSG_INSTALL_DAT   = "${DEF}Installing data file ${GREEN}$@${RES}"
MSG_UNINSTALL_DAT = "${DEF}Uninstalling data file ${GREEN}$@${RES}"
MSG_INSTALL_DOC   = "${DEF}Installing document file ${BLUE}$f${RES}"
MSG_UNINSTALL_DOC = "${DEF}Uninstalling document file ${BLUE}$f${RES}"

MSG_DEB_STEP1     = "${YELLOW}[STEP_1]${DEF} Rename upstream tarball to"\
                    "${BLUE}${DEB_PROJECT}_${VERSION}.orig.tar.gz${RES}"
MSG_DEB_STEP2     = "${YELLOW}[STEP_2]${DEF} Unpacking upstream tarball"\
                    "and renaming directory${RES}"
MSG_DEB_STEP3     = "${YELLOW}[STEP_3]${DEF} Adding directory${CYAN}"\
                    "${debdir}${DEF} with Debian packaging files${RES}"
MSG_DEB_STEP4     = "${YELLOW}[STEP_4]${DEF} Building the Debian"\
                    "package${RES}"

MSG_LEX           = "${PURPLE}Generating scanner ${BLUE}$@${RES}"
MSG_LEX_NONE      = "${PURPLE}No auto-generated lexers${RES}"
MSG_LEX_COMPILE   = "${DEF}Compiling scanner ${WHITE}$@${RES}"
MSG_YACC          = "${PURPLE}Generating parser ${BLUE}$@${RES}"
MSG_YACC_NONE     = "${PURPLE}No auto-generated parsers${RES}"
MSG_YACC_COMPILE  = "${DEF}Compiling parser ${WHITE}$@${RES}"

MSG_TEST          = "${BLUE}Testing ${WHITE}$(notdir $<)${RES}"
MSG_TEST_COMPILE  = "${DEF}Generating test executable"\
                    "${GREEN}$(notdir $(strip $@))${RES}"
MSG_TEST_FAILURE  = "${CYAN}Test $(notdir $@) not passed${RES}"
MSG_TEST_SUCCESS  = "${YELLOW}All tests passed successfully${RES}"

MSG_STATLIB       = "${RED}Generating static library $@${RES}"
MSG_MAKETAR       = "${RED}Generating tar file ${BLUE}$@${RES}"
MSG_MAKEZIP       = "${RED}Generating zip file ${BLUE}$@${RES}"
MSG_MAKETGZ       = "${YELLOW}Compressing file ${BLUE}$@"\
                    "${YELLOW}(gzip)${RES}"
MSG_MAKETBZ2      = "${YELLOW}Compressing file ${BLUE}$@"\
                    "${YELLOW}(bzip2)${RES}"

MSG_ASM_COMPILE   = "${DEF}Generating Assembly artifact ${WHITE}$@${RES}"

MSG_C_COMPILE     = "${DEF}Generating C artifact ${WHITE}$@${RES}"
MSG_C_LINKAGE     = "${YELLOW}Generating C executable ${GREEN}$@${RES}"
MSG_C_SHRDLIB     = "${RED}Generating C shared library $@${RES}"
MSG_C_LIBCOMP     = "${DEF}Generating C library artifact"\
                    "${YELLOW}$@${RES}"

MSG_F_COMPILE     = "${DEF}Generating Fortran artifact ${WHITE}$@${RES}"
MSG_F_LINKAGE     = "${YELLOW}Generating Fortran executable"\
                    "${GREEN}$@${RES}"
MSG_F_SHRDLIB     = "${RED}Generating Fortran shared library $@${RES}"
MSG_F_LIBCOMP     = "${DEF}Generating Fortran library artifact"\
                    "${YELLOW}$@${RES}"

MSG_CXX_COMPILE   = "${DEF}Generating C++ artifact ${WHITE}$@${RES}"
MSG_CXX_LINKAGE   = "${YELLOW}Generating C++ executable ${GREEN}$@${RES}"
MSG_CXX_SHRDLIB   = "${RED}Generating C++ shared library $@${RES}"
MSG_CXX_LIBCOMP   = "${DEF}Generating C++ library artifact"\
                    "${YELLOW}$@${RES}"

########################################################################
##                            FUNCTIONS                               ##
########################################################################

## DEPENDENCIES ########################################################
# Functions: *-depend
# @param $1 Source name (with path)
# @param $2 Main target to be analised
# @param $3 Dependency file name

define c-depend
$(CC) -MM                     \
    -MF $(depdir)/$3$(depext) \
    -MP -MT $2                \
    $(clibs) $(cflags)        \
    $1
endef

define cpp-depend
$(CXX) -MM                    \
    -MF $(depdir)/$3$(depext) \
    -MP -MT $2                \
    $(cxxlibs) $(cxxflags)    \
    $1
endef

define fortran-depend
$(FC) -MM                     \
    -MF $(depdir)/$3$(depext) \
    -MP -MT $2                \
    $(flibs) $(fflags)      \
    $1
endef

## DIRECTORIES #########################################################
$(sort $(bindir) $(sbindir) $(execdir) ):
	$(call mkdir,$@)

$(sort $(objdir) $(depdir) $(libdir) $(docdir) $(debdir) ):
	$(call mkdir,$@)

define mkdir
	$(if $(strip $(patsubst .,,$1)), $(call phony-status,$(MSG_MKDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(MKDIR) $1              )
	$(if $(strip $(patsubst .,,$1)), $(call phony-ok,$(MSG_MKDIR))     )
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
$(quiet) $(strip $(foreach e,$(strip $1),\
    $(if $(strip $(wildcard *$e)),\
        $(MV) $(wildcard *$e) $(firstword $2); )\
))
$(if $(strip $(foreach e,$(strip $1),$(wildcard *$e))),\
    $(call phony-ok,$(MSG_MOVE)),\
    $(call phony-ok,$(MSG_NO_MOVE))\
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
	$(if $(strip $2),$(call srm,$2))
	$(foreach d,$(strip $1),\
        $(if $(strip $(call rwildcard,$d,*)),\
            $(if $(strip $2),
                $(if $(strip $(MAINTEINER_CLEAN)),\
                    $(call rmdir,$d),\
                    $(if $(strip $(call rfilter-out,$2,\
                            $(call rfilter-out,\
                                $(filter-out $d,$(call rsubdir,$d)),\
                                $(call rwildcard,$d,*)))),\
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

## STATUS ##############################################################
ifndef SILENT

ifneq ($(strip $(quiet)),)
    define phony-status
    	@echo -n $1 "... ";
    endef
    
    define status
    	@$(RM) $@ && echo -n $1 "... ";
    endef

    define vstatus
    	@$(RM) $@ && echo $1 "... ";
    endef
endif

define phony-ok
	@echo "\r${GREEN}[OK]${RES}" $1 "     ";
endef

define ok
@if [ -f $2 ]; then\
	echo "\r${GREEN}[OK]${RES}" $1 "     ";\
else\
	echo "\r${RED}[ERROR]${RES}" $1 "${RED}(STATUS: $$?)${RES}"; exit 42;\
fi
endef

endif
## ERROR ###############################################################
ifndef MORE
    define ERROR 
    2>&1 | sed '1 i error' | sed 's/^/> /' | sed ''/"> error"/s//`printf "${ERR}"`/''
    endef
else
    define ERROR 
    2>&1 | more
    endef
endif 

define phony-error
	@echo "${RED}[ERROR]${RES}" $1; exit 42;
endef

define test-error
(echo "\r${RED}[FAILURE]${RES}" $1"."\
      "${RED}Aborting status: $$?${RES}" && exit 42)
endef

## TEXT ################################################################
define uc
$(shell echo $1 | tr "a-z" "A-Z")
endef

define lc
$(shell echo $1 | tr "A-Z" "a-z")
endef

# Function: select 
# Define which ostream should be used
define select
$(eval ostream = \
    $(strip $(if $(strip $(subst stdout,,$(strip $1))),$1,)))
endef

# Function: cat
# Add a text in the end of a ostream
define cat
$(if $(strip $(wildcard $(ostream)*)),,\
    $(quiet) echo $1 $(if $(strip $(ostream)),>> $(ostream)))
endef

# Function: touch
# Create a new file based on a model
# @param $1 File to be created
# @param $1 Model to be used in the creation (optional)
define touch
$(if $(wildcard $1*),,\
    $(call phony-status,$(MSG_TOUCH)))
$(if $(wildcard $1*),,\
    $(if $(strip $2),\
        $(quiet) cat $2 > $1,\
        $(quiet) touch $1))
$(if $(wildcard $1*),,\
    $(call phony-ok,$(MSG_TOUCH)))
endef

########################################################################
##                           MANAGEMENT                               ##
########################################################################

# Namespace/Module variable
# ===========================
# 1) Remove trailing bars if it is a directory-only name
# 2) If the name includes a root src/inc directory, remove-it.
# 3) Manipulates IN to be used in a #ifndef C/C++ preproc directive
# 4) Define identation accordingly to namespace depth
ifdef IN
#------------------------------------------------------------------[ 1 ]
override IN := $(strip $(call remove-trailing-bar,$(IN)))
#------------------------------------------------------------------[ 2 ]
override IN := $(strip $(or $(strip $(foreach d,$(srcdir) $(incdir),\
                   $(if $(strip $(patsubst $d%,%,$(call root,$(IN)))),,\
                       $(call not-root,$(IN))\
               ))),$(IN)))
#------------------------------------------------------------------[ 3 ]
indef       := $(strip $(call uc,$(subst /,_,$(strip $(IN)))))_
#------------------------------------------------------------------[ 3 ]
idnt        := $(if $(strip $(IN)),    )
endif

# Extension variables
# =====================
override SRC_EXT := $(strip $(if $(strip $(SRC_EXT)),\
    $(or $(filter .%,$(SRC_EXT)),.$(SRC_EXT))))
override INC_EXT := $(strip $(if $(strip $(INC_EXT)),\
    $(or $(filter .%,$(INC_EXT)),.$(INC_EXT))))

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
define start-namespace
$(if $(strip $(IN)),\
    $(call cat,$(subst \\n ,\\n,\
        $(patsubst %,namespace % {\\n,$(subst /, ,$(IN)))\
)))
endef

# Function: end-namespace
# End the namespaces using the IN variable for namespace depth
define end-namespace
$(if $(strip $(IN)),\
    $(call cat,$(subst } ,},$(foreach n,$(subst /, ,$(IN)),}))))
endef

# Path variables
# ================
# Auxiliar variables to the default place to create/remove 
# files created by this makefile (usually the first inc/src dirs)
override incbase   := $(strip $(firstword $(incdir)))$(if $(IN),/$(IN))
override srcbase   := $(strip $(firstword $(srcdir)))$(if $(IN),/$(IN))

# Artifacts
# ===========
# C/C++ Artifacts that may be created by this Makefile
override NAMESPACE  := $(strip $(notdir $(NAMESPACE)))
override CLASS      := $(strip $(basename $(notdir $(CLASS))))
override C_FILE     := $(strip $(basename $(notdir $(C_FILE))))
override F_FILE     := $(strip $(basename $(notdir $(F_FILE))))
override CXX_FILE   := $(strip $(basename $(notdir $(CXX_FILE))))
override TEMPLATE   := $(strip $(basename $(notdir $(TEMPLATE))))
override C_MODULE   := $(strip $(basename $(notdir $(C_MODULE))))
override CXX_MODULE := $(strip $(basename $(notdir $(CXX_MODULE))))

.PHONY: new
new:
	$(if $(or $(NAMESPACE),$(CLASS),$(C_FILE),$(F_FILE),$(CXX_FILE),\
         $(TEMPLATE),$(C_MODULE),$(CXX_MODULE)),,\
         $(error No filetype defined. Type 'make projecthelp' for info))
ifdef NAMESPACE
	$(call mkdir,$(incbase)/$(NAMESPACE))
	$(call mkdir,$(srcbase)/$(NAMESPACE))
endif
ifdef CLASS
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CLASS)$(INC_EXT),$(NOTICE))
	$(call select,$(incbase)/$(CLASS)$(INC_EXT))
	$(call cat,''                                                      )
	$(call cat,'#ifndef HPP_$(indef)$(call uc,$(CLASS))_DEFINED'       )
	$(call cat,'#define HPP_$(indef)$(call uc,$(CLASS))_DEFINED'       )
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
	$(call touch,$(srcbase)/$(CLASS)$(SRC_EXT),$(NOTICE))
	$(call select,$(srcbase)/$(CLASS)$(SRC_EXT))
	$(call cat,''                                                      )
	$(call cat,'// Libraries'                                          )
	$(call cat,'#include "$(CLASS)$(INC_EXT)"'                         )
	$(call cat,'using namespace $(subst /,::,$(IN));'                  )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef C_FILE                                                            
	$(if $(INC_EXT),,$(eval override INC_EXT := .h))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .c))
	
	$(call invalid-ext,$(INC_EXT),$(hext))
	$(call touch,$(incbase)/$(C_FILE)$(INC_EXT),$(NOTICE))
	$(call select,$(incbase)/$(C_FILE)$(INC_EXT))
	$(call cat,''                                                      )
	$(call cat,'#ifndef H_$(indef)$(call uc,$(C_FILE))_DEFINED'        )
	$(call cat,'#define H_$(indef)$(call uc,$(C_FILE))_DEFINED'        )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cext))
	$(call touch,$(srcbase)/$(C_FILE)$(SRC_EXT),$(NOTICE))
	$(call select,$(srcbase)/$(C_FILE)$(SRC_EXT))
	$(call cat,''                                                      )
	$(call cat,'/* Libraries */'                                       )
	$(call cat,'#include "$(C_FILE)$(INC_EXT)"'                        )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef F_FILE
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .f))
	                        
	$(call invalid-ext,$(SRC_EXT),$(fext))
	$(call touch,$(srcbase)/$(F_FILE)$(SRC_EXT),$(NOTICE))
	$(call select,$(srcbase)/$(F_FILE)$(SRC_EXT))
	$(call cat,'c $(call lc,$(F_FILE))$(SRC_EXT)'                      )
	$(call cat,''                                                      )
	$(call cat,'      program $(call lc,$(F_FILE))'                    )
	$(call cat,'          stop'                                        )
	$(call cat,'      end'                                             )
	
	$(call select,stdout)
endif
ifdef CXX_FILE                                                          
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	$(if $(SRC_EXT),,$(eval override SRC_EXT := .cpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CXX_FILE)$(INC_EXT),$(NOTICE))
	$(call select,$(incbase)/$(CXX_FILE)$(INC_EXT))
	$(call cat,''                                                      )
	$(call cat,'#ifndef HPP_$(indef)$(call uc,$(CXX_FILE))_DEFINED'    )
	$(call cat,'#define HPP_$(indef)$(call uc,$(CXX_FILE))_DEFINED'    )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call invalid-ext,$(SRC_EXT),$(cxxext))
	$(call touch,$(srcbase)/$(CXX_FILE)$(SRC_EXT),$(NOTICE))
	$(call select,$(srcbase)/$(CXX_FILE)$(SRC_EXT))
	$(call cat,''                                                      )
	$(call cat,'// Libraries'                                          )
	$(call cat,'#include "$(CXX_FILE)$(INC_EXT)"'                      )
	$(call cat,'using namespace $(subst /,::,$(IN));'                  )
	$(call cat,''                                                      )
	
	$(call select,stdout)
endif
ifdef TEMPLATE
	$(if $(INC_EXT),,$(eval override INC_EXT := .tcc))
	                        
	$(call invalid-ext,$(INC_EXT),$(tlext))
	$(call touch,$(incbase)/$(TEMPLATE)$(INC_EXT),$(NOTICE))
	$(call select,$(incbase)/$(TEMPLATE)$(INC_EXT))
	$(call cat,''                                                      )
	$(call cat,'#ifndef HPP_$(indef)$(call uc,$(TEMPLATE))_DEFINED'    )
	$(call cat,'#define HPP_$(indef)$(call uc,$(TEMPLATE))_DEFINED'    )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call select,stdout)
endif
ifdef C_MODULE
	$(if $(INC_EXT),,$(eval override INC_EXT := .h))
	
	$(call invalid-ext,$(INC_EXT),$(hext))
	$(call touch,$(incbase)/$(C_MODULE)$(INC_EXT),$(NOTICE))
	$(call select,$(incbase)/$(C_MODULE)$(INC_EXT))
	$(call cat,''                                                      )
	$(call cat,'#ifndef H_$(indef)$(call uc,$(C_MODULE))_DEFINED'      )
	$(call cat,'#define H_$(indef)$(call uc,$(C_MODULE))_DEFINED'      )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call mkdir,$(srcbase)/$(C_MODULE))
endif
ifdef CXX_MODULE
	$(if $(INC_EXT),,$(eval override INC_EXT := .hpp))
	
	$(call invalid-ext,$(INC_EXT),$(hxxext))
	$(call touch,$(incbase)/$(CXX_MODULE)$(INC_EXT),$(NOTICE))
	$(call select,$(incbase)/$(CXX_MODULE)$(INC_EXT))
	$(call cat,''                                                      )
	$(call cat,'#ifndef HPP_$(indef)$(call uc,$(CXX_MODULE))_DEFINED'  )
	$(call cat,'#define HPP_$(indef)$(call uc,$(CXX_MODULE))_DEFINED'  )
	$(call cat,''                                                      )
	$(call start-namespace                                             )
	$(call cat,'$(idnt)'                                               )
	$(call end-namespace                                               )
	$(call cat,''                                                      )
	$(call cat,'#endif'                                                )
	
	$(call mkdir,$(srcbase)/$(CXX_MODULE))
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
	$(if $(or $(NAMESPACE),$(CLASS),$(C_FILE),$(F_FILE),$(CXX_FILE),\
         $(TEMPLATE),$(C_MODULE),$(CXX_MODULE)),,\
         $(error No filetype defined. Type 'make projecthelp' for info))
ifndef D
	@echo $(MSG_DELETE_WARN)
	@echo $(MSG_DELETE_ALT)
else
ifdef NAMESPACE
	$(call rm-if-empty,$(incbase)/$(NAMESPACE))
	$(call rm-if-empty,$(srcbase)/$(NAMESPACE))
endif
ifdef CLASS
	$(call delete-file,$(incbase)/$(CLASS),$(INC_EXT) $(hxxext))
	$(call delete-file,$(srcbase)/$(CLASS),$(SRC_EXT) $(cxxext))
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
ifdef TEMPLATE
	$(call delete-file,$(incbase)/$(TEMPLATE),$(INC_EXT) $(tlext))
endif
ifdef C_MODULE
	$(call delete-file,$(incbase)/$(C_MODULE),$(INC_EXT) $(hext))
	$(call rm-if-empty,$(srcbase)/$(C_MODULE))
endif
ifdef CXX_MODULE
	$(call delete-file,$(incbase)/$(CXX_MODULE),$(INC_EXT) $(hxxext))
	$(call rm-if-empty,$(srcbase)/$(CXX_MODULE))
endif
endif

########################################################################
##                         HELP AND CONFIGS                           ##
########################################################################

.PHONY: config
config:
	@echo ""
	@echo "############################################################"
	@echo "##         DELETE ANY TARGET TO USE THE DEFAULT!          ##"
	@echo "############################################################"
	@echo ""
	@echo "# Project setting"
	@echo "PROJECT  := # Project name. Default is 'Default'"
	@echo "VERSION  := # Version. Default is '1.0'"
	@echo ""
	@echo "# Program settings"
	@echo "BIN      := # Binaries' names. If a subdir of the source"
	@echo "            # directories has the same name of this binary,"
	@echo "            # this dir and all subdir will be compiled"
	@echo "            # only for this specific binary."
	@echo "SBIN     := # Same as above, but for shell-only binaries."
	@echo "LIBEXEC  := # Again, but for binaries runnable only by"
	@echo "            # other programs, not normal users."
	@echo ""
	@echo "IGNORED  := # Files within Make dirs and bins to be ignored."
	@echo ""
	@echo "ARLIB    := # Static/Shared libraries' names. If one is a"
	@echo "SHRLIB   := # lib, all source files will make the library."
	@echo ""
	@echo "# Flags"
	@echo "ASFLAGS  := # Assembly Flags"
	@echo "CFLAGS   := # C Flags"
	@echo "CXXFLAGS := # C++ Flags"
	@echo "LDFLAGS  := # Linker flags"
	@echo ""
	@echo "# Documentation"
	@echo "LICENSE  := # File with a License (def: LICENSE)"
	@echo "NOTICE   := # File with a Notice of the License, to be used"
	@echo "            # in the beggining of any file (def: NOTICE)."
	@echo "DOXYFILE := # Config file for Doxygen (def: Doxyfile)"
	@echo ""
	@echo "# Package info"
	@echo "MAINTEINER_NAME := # Your name"
	@echo "MAINTEINER_MAIL := # your_name@mail.com"
	@echo "SYNOPSIS        := # One-line description of the program"
	@echo "DESCRIPTION     := # Longer description of the program"
	@echo ""

.PHONY: gitignore
gitignore:
	@echo ""
	@echo "# Automatically generated directories"
	@echo "#======================================"
	@$(foreach d,$(depdir),echo $d/; )
	@$(foreach d,$(objdir),echo $d/; )
	@$(foreach d,$(libdir),echo $d/; )
	@$(foreach d,$(bindir),echo $d/; )
	@$(foreach d,$(sbindir),echo $d/; )
	@$(foreach d,$(execdir),echo $d/; )
	@$(foreach d,$(distdir),echo $d/; )
	@echo ""
	@echo "# Objects, Libraries and Binaries"
	@echo "#=================================="
	@$(foreach e,$(objext),echo *$e; )
	@$(foreach e,$(libext),echo *$e; )
	@$(foreach e,$(binext),echo *$e; )
	@echo ""
	@echo "# Make auxiliars"
	@echo "#================="
	@$(if $(strip $(doxyfile)),echo $(docdir)/doxygen/)
	@$(if $(strip $(doxyfile)),echo $(docdir)/$(doxyfile).mk)
	@$(foreach e,$(depext),echo *$e; )
	@echo ""

.PHONY: help
help:
	@echo "                                                            "
	@echo "Makefile for C/C++ by Renato Cordeiro Ferreira.             "
	@echo "Type 'make projecthelp' for additional info.                "
	@echo "                                                            "

.PHONY: projecthelp
projecthelp:
	@echo "                                                            "
	@echo "$(PROJECT)-$(VERSION)                                       "
	@echo "=============================                               "
	@echo "                                                            "
	@echo "Default targets:                                            "
	@echo "-----------------                                           "
	@echo " * all-docs:     Generate docs in all formats avaiable      "
	@echo " * all:          Generate all executables                   "
	@echo " * check:        Compile and run Unit Tests                 "
	@echo " * config:       Outputs Config.mk model for user's options "
	@echo " * delete:       Remove C/C++ artifact (see above)          "
	@echo " * dpkg:         Create a debian package from the project   "
	@echo " * dist-*:       As 'dist', with many types of compression  "
	@echo " * dist:         Create .tar.gz with binaries and libraries "
	@echo " * doxy:         Create Doxygen docs (if doxyfile defined)  "
	@echo " * gitignore:    Outputs .gitignore model for user          "
	@echo " * init:         Create directories for beggining projects  "
	@echo " * install-*:    Install docs in info, html, dvi, pdf or ps "
	@echo " * install-docs: Install documentation in all formats       "
	@echo " * install:      Install executables and libraries          "
	@echo " * installcheck: Run installation tests (if avaiable)       "
	@echo " * new:          Create C/C++ artifact (see above)          "
	@echo " * package-*:    As 'package', with many compressions       "
	@echo " * package:      As 'dist', but also with sources and data  "
	@echo " * standard:     Move files to their standard directories   "
	@echo " * tar:          Create .tar with binaries and libraries    "
	@echo " * uninstall:    Uninstall anything created by any install  "
	@echo "                                                            "
	@echo "Debug targets:                                              "
	@echo "---------------                                             "
	@echo " * dump:         Print main vars used within this Makefile  "
	@echo " * nothing:      Self-explicative, hun?                     "
	@echo "                                                            "
	@echo "Cleaning targets:                                           "
	@echo "------------------                                          "
	@echo " * mostlyclean:  Clean all object files                     "
	@echo " * clean:        Above and all types of binaries            "
	@echo " * distclean:    Above and libraries, .tar and .tar.gz      "
	@echo " * docclean:     Remove all documentation files             "
	@echo " * packageclean: Remove all debian and RPM packages         "
	@echo " * realclean:    Above, auto-generated source and docs      "
	@echo " * uninitialize: Above and source/include directories       "
	@echo "                                                            "
	@echo "Help targets:                                               "
	@echo "---------------                                             "
	@echo " * help:         Info about this Makefile                   "
	@echo " * projecthelp:  Perharps you kwnow if you are here         "
	@echo "                                                            "
	@echo "Special flags:                                              "
	@echo "---------------                                             "
	@echo " * D:            Allow deletion of a C/C++ artifact         "
	@echo " * U:            Allow uninitilization of the project       "
	@echo " * V:            Allow the verbose mode                     "
	@echo " * MORE:         With error, use 'more' to read stderr      "
	@echo " * SILENT:       Just output the plain commands as executed "
	@echo " * INC_EXT:      Include extension for files made by 'new'  "
	@echo " * SRC_EXT:      Source extension for files made by 'new'   "
	@echo " * NO_COLORS:    Outputs are made without any color         "
	@echo "                                                            "
	@echo "Management flags                                            "
	@echo "-----------------                                           "
	@echo "* NAMESPACE:     Create new directory for namespace         "
	@echo "* CLASS:         Create new file for a C++ class            "
	@echo "* C_FILE:        Create ordinaries C files                  "
	@echo "* CXX_FILE:      Create ordinaries C++ files                "
	@echo "* C_MODULE:      Create C header and dir for its sources    "
	@echo "* CXX_MODULE:    Create C++ header and dif for its sources  "
	@echo "* TEMPLATE:      Create C++ template file                   "
	@echo "                                                            "

########################################################################
##                            DEBUGGING                               ##
########################################################################

define prompt
@echo "${YELLOW}"$1"${RES}"\
      $(if $(strip $2),"$(strip $2)","${RED}Empty${RES}")
endef

.PHONY: dump
dump: 
	@echo "${WHITE}\nIGNORED FILES         ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"ignored:     ",$(ignored)     )
	
	@echo "${WHITE}\nACCEPTED EXTENSIONS   ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"srcext:      ",$(srcext)      )
	$(call prompt,"incext:      ",$(incext)      )
	$(call prompt,"libext:      ",$(libext)      )
	$(call prompt,"lexext:      ",$(lexext)      )
	$(call prompt,"lexxext:     ",$(lexxext)     )
	$(call prompt,"yaccext:     ",$(yaccext)     )
	$(call prompt,"yaxxext:     ",$(yaxxext)     )
	$(call prompt,"docext:      ",$(docext)      )
	
	@echo "${WHITE}\nLEXER                 ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"alllexer:    ",$(alllexer)    )
	$(call prompt,"clexer:      ",$(clexer)      )
	$(call prompt,"cxxlexer:    ",$(cxxlexer)    )
	$(call prompt,"lexall:      ",$(lexall)      )
	
	@echo "${WHITE}\nPARSER                ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"allparser:   ",$(allparser)   )
	$(call prompt,"cparser:     ",$(cparser)     )
	$(call prompt,"cxxparser:   ",$(cxxparser)   )
	$(call prompt,"yaccall:     ",$(yaccall)     )
	
	@echo "${WHITE}\nSOURCE                ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"srcall:      ",$(srcall)      )
	$(call prompt,"srccln:      ",$(srccln)      )
	$(call prompt,"src:         ",$(src)         )
	$(call prompt,"asmall:      ",$(asmall)      )
	$(call prompt,"asmcln:      ",$(asmcln)      )
	$(call prompt,"asmsrc:      ",$(asmsrc)      )
	$(call prompt,"autoall:     ",$(autoall)     )
	$(call prompt,"autocln:     ",$(autocln)     )
	$(call prompt,"autosrc:     ",$(autosrc)     )
	
	@echo "${WHITE}\nHEADERS               ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"incall:      ",$(incall)      )
	$(call prompt,"autoinc:     ",$(autoinc)     )
	
	@echo "${WHITE}\nTEST                  ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"testall:     ",$(testall)     )
	$(call prompt,"testdep:     ",$(testdep)     )
	$(call prompt,"testrun:     ",$(testrun)     )
	
	@echo "${WHITE}\nLIBRARY               ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"lib_in:      ",$(lib_in)      )
	$(call prompt,"libpat:      ",$(libpat)      )
	$(call prompt,"liball:      ",$(liball)      )
	$(call prompt,"libsrc:      ",$(libsrc)      )
	$(call prompt,"libname:     ",$(libname)     )
	$(call prompt,"lib:         ",$(lib)         )
	
	@echo "${WHITE}\nEXTERNAL LIBRARY      ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"externlib:   ",$(externlib)   )
	$(call prompt,"externname:  ",$(externname)  )
	
	@echo "${WHITE}\nSTATIC LIBRARY        ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"ar_in:       ",$(ar_in)       )
	$(call prompt,"arpat:       ",$(arpat)       )
	$(call prompt,"arpatsrc:    ",$(arpatsrc)    )
	$(call prompt,"arname:      ",$(arname)      )
	$(call prompt,"arlib:       ",$(arlib)       )
	
	@echo "${WHITE}\nDYNAMIC LIBRARY       ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"shr_in:      ",$(shr_in)      )
	$(call prompt,"shrpat:      ",$(shrpat)      )
	$(call prompt,"shrpatsrc:   ",$(shrpatsrc)   )
	$(call prompt,"shrall:      ",$(shrall)      )
	$(call prompt,"shrname:     ",$(shrname)     )
	$(call prompt,"shrlib:      ",$(shrlib)      )
	
	@echo "${WHITE}\nOBJECT                ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"obj:         ",$(obj)         )
	$(call prompt,"arobj:       ",$(arobj)       )
	$(call prompt,"shrobj:      ",$(shrobj)      )
	$(call prompt,"autoobj:     ",$(autoobj)     )
	$(call prompt,"objall:      ",$(objall)      )
	
	@echo "${WHITE}\nDEPENDENCY            ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"depall:      ",$(depall)      )
	
	@echo "${WHITE}\nBINARY                ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"bin:         ",$(bin)         )
	$(call prompt,"sbin:        ",$(sbin)        )
	$(call prompt,"libexec:     ",$(libexec)     )
	
	@echo "${WHITE}\nINSTALLATION          ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"destdir:     ",$(destdir)     )
	$(call prompt,"prefix:      ",$(prefix)      )
	$(call prompt,"exec_prefix: ",$(exec_prefix) )
	$(call prompt,"i_bindir:    ",$(i_bindir)    )
	$(call prompt,"i_sbindir:   ",$(i_sbindir)   )
	$(call prompt,"i_libexecdir:",$(i_libexecdir))
	$(call prompt,"i_docdir:    ",$(i_docdir)    )
	
	@echo "${WHITE}\nDOCUMENTATION         ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"texiall:     ",$(texiall)     )
	$(call prompt,"texisrc:     ",$(texiall)     )
	$(call prompt,"texiinfo:    ",$(texiinfo)    )
	$(call prompt,"texihtml:    ",$(texihtml)    )
	$(call prompt,"texidvi:     ",$(texidvi)     )
	$(call prompt,"texipdf:     ",$(texipdf)     )
	$(call prompt,"texips:      ",$(texips)      )
	
	@echo "${WHITE}\nFLAGS                 ${RES}"
	@echo "--------------------------------------"
	$(call prompt,"cflags:      ",$(cflags)      )
	$(call prompt,"clibs:       ",$(clibs)       )
	$(call prompt,"fflags:      ",$(fflags)      )
	$(call prompt,"flibs:       ",$(flibs)       )
	$(call prompt,"cxxflags:    ",$(cxxflags)    )
	$(call prompt,"cxxlibs:     ",$(cxxlibs)     )
	$(call prompt,"ldlibs:      ",$(ldlibs)      )
	$(call prompt,"ldflags:     ",$(ldflags)     )
	
	$(call prompt,"lib_in:      ",$(lib_in)      )
