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
PROJECT ?= Default
VERSION ?= 1.0

# Program settings
BIN     ?= a.out
ARLIB   ?= 
SHRLIB  ?= 

# Include configuration file if exists
-include config.mk
-include Config.mk

########################################################################
##                              FLAGS                                 ##
########################################################################

# Assembler flags
ASFLAGS   ?= -f elf32

# C Options
CFLAGS    ?= -Wall -ansi -pedantic -O2 -g

# C++ Options
CXXFLAGS  ?= $(CFLAGS) -std=gnu++11

# Parsers in C++
CXXLEXER  ?= 
CXXPARSER ?= 

# Linker flags
LDFLAGS   ?= 

# Library flags
ARFLAGS   ?= -rcv
SOFLAGS   ?= -shared 

########################################################################
##                            DIRECTORIES                             ##
########################################################################
ifndef SINGLE_DIR
SRCDIR  ?= src
BINDIR  ?= bin
DEPDIR  ?= dep
OBJDIR  ?= build
INCDIR  ?= include
LIBDIR  ?= lib
DISTDIR ?= dist
TESTDIR ?= test
else
$(foreach var,\
    SRCDIR BINDIR DEPDIR OBJDIR INCDIR LIBDIR DISTDIR TESTDIR,\
    $(eval $(var) := .)\
)
endif

########################################################################
##                            EXTENSIONS                              ##
########################################################################

# Assembly extensions
ASMEXT  ?= .asm .S

# Header extensions
HEXT    ?= .h
HXXEXT  ?= .H .hh .hpp .hxx .h++

# Source extensions
CEXT    ?= .c
CXXEXT  ?= .C .cc .cpp .cxx .c++ .tcc .icc

# Library extensions
LIBEXT  ?= .a .so .dll

# Parser/Lexer extensions
LEXEXT  ?= .l .ll .lpp
YACCEXT ?= .y .yy .ypp

# Dependence extensions
DEPEXT  ?= .d

# Binary extensions
OBJEXT  ?= .o
BINEXT  ?= 

# Test suffix
TESTSUF ?= _tests

#//////////////////////////////////////////////////////////////////////#
#----------------------------------------------------------------------#
#                           OS DEFINITIONS                             #
#----------------------------------------------------------------------#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#

########################################################################
##                             PROGRAMS                               ##
########################################################################
# Compilation
AR         := ar
AS         := nasm
CC         := gcc
CXX        := g++
RANLIB     := ranlib

# File manipulation
CP         := cp -rap
MV         := mv
RM         := rm -f
TAR        := tar -cvf
ZIP        := gzip
MKDIR      := mkdir -p
RMDIR      := rm -rf
FIND       := find
FIND_FLAGS := -type d -print 2> /dev/null

# Parser and Lexer
LEX        := flex
LEX_CXX    := flex++
LEXFLAGS   := 
YACC       := bison
YACC_CXX   := bison++
YACCFLAGS  := -d #-v -t

# Make
MAKE       += --no-print-directory

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

# Flags:
# Redefine flags to avoid conflict with user's local definitions
asflags   := $(ASFLAGS)
cflags    := $(CFLAGS)
cxxflags  := $(CXXFLAGS)
cxxlexer  := $(CXXLEXER)
cxxparser := $(CXXPARSER)
ldflags   := $(LDFLAGS)
arflags   := $(ARFLAGS)
soflags   := $(SOFLAGS)
lexflags  := $(LEXFLAG)
yaccflags := $(YACCFLAGS)

# Directories:
# No directories must end with a '/' (slash)
srcdir  := $(strip $(foreach d,$(SRCDIR),$(patsubst %/,%,$d)))
bindir  := $(strip $(foreach d,$(BINDIR),$(patsubst %/,%,$d)))
depdir  := $(strip $(foreach d,$(DEPDIR),$(patsubst %/,%,$d)))
objdir  := $(strip $(foreach d,$(OBJDIR),$(patsubst %/,%,$d)))
incdir  := $(strip $(foreach d,$(INCDIR),$(patsubst %/,%,$d)))
libdir  := $(strip $(foreach d,$(LIBDIR),$(patsubst %/,%,$d)))
distdir := $(strip $(foreach d,$(DISTDIR),$(patsubst %/,%,$d)))
testdir := $(strip $(foreach d,$(TESTDIR),$(patsubst %/,%,$d)))

# Check if every directory variable is non-empty
ifeq ($(and $(srcdir),$(bindir),$(depdir),$(objdir),\
            $(incdir),$(libdir),$(distdir),$(testdir)),)
$(error There must be at least one directory of each type, or '.'.)
endif

ifneq ($(words $(depdir) $(objdir) $(distdir)),3)
$(error There must be one dependency, object and distribution dir.)
endif

# Extensions:
testsuf := $(strip $(sort $(TESTSUF)))
ifneq ($(words $(testsuf)),1)
    $(error Just one suffix allowed for test sources!)
endif

# Extensions:
# Every extension must begin with a '.' (dot)
hext    := $(strip $(sort $(HEXT)))
hxxext  := $(strip $(sort $(HXXEXT)))
cext    := $(strip $(sort $(CEXT)))
cxxext  := $(strip $(sort $(CXXEXT)))
asmext  := $(strip $(sort $(ASMEXT)))
libext  := $(strip $(sort $(LIBEXT)))
lexext  := $(strip $(sort $(LEXEXT)))
yaccext := $(strip $(sort $(YACCEXT)))
depext  := $(strip $(sort $(DEPEXT)))
objext  := $(strip $(sort $(OBJEXT)))
binext  := $(strip $(sort $(BINEXT)))

incext := $(hext) $(hxxext)
srcext := $(cext) $(cxxext)

# Check all extensions
allext := $(incext) $(srcext) $(asmext) $(libext) 
allext += $(lexext) $(yaccext) $(depext) $(objext) $(binext)
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

# Define extensions as the only valid ones
.SUFFIXES:
.SUFFIXES: $(allext)

# Paths
# ======
vpath %.tar    $(distdir) # All tar files in distdir
vpath %.tar.gz $(distdir) # All tar.gz files in distdir

# Binaries, libraries and source extensions
$(foreach b,$(bindir) $(bindir)/$(testdir),\
    $(if $(binext),\
        $(foreach e,$(binext),$(eval vpath %$e $(bindir))),\
        $(eval vpath %$e $(bindir)))\
)
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
# 3) not: Returns empty if its argument was defined, or T otherwise
# 4) remove-trailing-bar: Removes the last / of a directory-onl name
# 5) is-cxx: find out if there is a C++ file in its single argument
define root
$(foreach s,$1,\
	$(if $(findstring /,$s),\
		$(call root,$(patsubst %/,%,$(dir $s))),$(strip $s)))
endef

define not-root
$(foreach s,$1,$(strip $(patsubst $(strip $(call root,$s))/%,%,$s)))
endef

define not
$(strip $(if $1,,T))
endef

define remove-trailing-bar
$(foreach s,$1,$(if $(or $(call not,$(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))
endef

define is_cxx
$(foreach e,$(cxxext),$(findstring $e,$(suffix $1)))
endef

# Default variable names 
# ======================
# fooall: complete path WITH root directories
# foosrc: complete path WITHOUT root directories
# foopat: incomplete paths WITH root directories
# foolib: library names WITHOUT root directories

# Auxiliar functions
# ===================
# 1) rsubdir: For listing all subdirectories of a given dir
# 2) rwildcard: For wildcard deep-search in the directory tree
rsubdir   = $(foreach d,$1,$(shell $(FIND) $d $(FIND_FLAGS)))
rwildcard = $(foreach d,$(wildcard $1/*),\
                $(call rwildcard,$d,$2)$(filter $(subst *,%,$2),$d)) 

# Assembly files
# ==============
# 1) Find all assembly files in the source directory
# 2) Remove source directory root paths from ordinary assembly src
$(foreach root,$(srcdir),\
    $(foreach E,$(asmext),\
        $(eval asmsrc += $(call rwildcard,$(root),*$E))))
$(foreach root,$(srcdir),\
    $(eval asmsrc := $(patsubst $(root)/%,%,$(asmsrc))) )

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
# 			6: test6.c 7: test7/test7.c 8: src/test8/test8.c
# 1) ar_in/shr_in: Remove the last / if there is a path only
# 1) lib_in      : Store libraries as being shared and static libs
# 3) liball      : If there is only a suffix, throw an error. 
#                  Otherwise, make the same action as above
# 4) libsrc      : Remove src root directories from libraries
#------------------------------------------------------------------[ 1 ]
ar_in  := $(call remove-trailing-bar,$(ARLIB))
shr_in := $(call remove-trailing-bar,$(SHRLIB))
#------------------------------------------------------------------[ 2 ]
lib_in := $(ar_in) $(shr_in)
#------------------------------------------------------------------[ 3 ]
lib_in := \
$(foreach s,$(lib_in),                                                 \
  $(if $(and                                                           \
      $(strip $(suffix $s)),$(if $(strip $(notdir $(basename $s))),,T) \
  ),                                                                   \
  $(error "Invalid argument $s in library variable"),$s)               \
)
#------------------------------------------------------------------[ 4 ]
libsrc := $(lib_in)
$(foreach root,$(srcdir),\
    $(eval libsrc := $(patsubst $(root)/%,%,$(libsrc))) )

# Lexical analyzer
# =================
# 1) Find in a directory tree all the lex files (with dir names)
# 2) Split C++ and C lexers (to be compiled appropriately)
# 3) Change lex extension to format .yy.c or .yy.cc (for C/C++ lexers)
#    and join all the C and C++ lexer source names
# 4) Add lex default library with linker flags
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(lexext),\
        $(eval alllexer += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
cxxlexer := $(foreach l,$(cxxlexer),$(filter %$l,$(alllexer)))
clexer   := $(filter-out $(cxxlexer),$(alllexer))
#------------------------------------------------------------------[ 3 ]
lexall   += $(foreach E,$(lexext),\
                $(patsubst %$E,%.yy.cc,$(filter %$E,$(cxxlexer))))
lexall   += $(foreach E,$(lexext),\
                $(patsubst %$E,%.yy.c,$(filter %$E,$(clexer))))
lexall   := $(strip $(lexall))
#------------------------------------------------------------------[ 4 ]
$(if $(strip $(lexall)),$(eval ldflags += -lfl))

# Syntatic analyzer
# ==================
# 1) Find in a directory tree all the yacc files (with dir names)
# 2) Split C++ and C parsers (to be compiled appropriately)
# 3) Change yacc extension to format .tab.c or .tab.cc (for C/C++ parsers)
#    and join all the C and C++ parser source names
# 4) Create yacc parsers default header files
#------------------------------------------------------------------[ 1 ]
$(foreach root,$(srcdir),\
    $(foreach E,$(yaccext),\
        $(eval allparser += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
cxxparser := $(foreach y,$(cxxparser),$(filter %$y,$(allparser)))
cparser   := $(filter-out $(cxxparser),$(allparser))
#------------------------------------------------------------------[ 3 ]
yaccall   += $(foreach E,$(yaccext),\
                $(patsubst %$E,%.tab.cc,$(filter %$E,$(cxxparser))))
yaccall   += $(foreach E,$(yaccext),\
                $(patsubst %$E,%.tab.c,$(filter %$E,$(cparser))))
yaccall   := $(strip $(yaccall))
#------------------------------------------------------------------[ 4 ]
yaccinc   := $(call not-root,$(yaccall))
yaccinc   := $(addprefix $(firstword $(incdir))/,$(yaccinc))
yaccinc   := $(patsubst %.c,%.h,$(patsubst %.cc,%.hh,$(yaccinc)))

# Automatically generated files
# =============================
autoall := $(yaccall) $(lexall)
autosrc := $(call not-root,$(autoall))
autoobj := $(addsuffix .o,$(basename $(autosrc)))
autoobj := $(addprefix $(objdir)/,$(autoobj))

# Source files
# =============
# 1) srcall: Find in the directory trees all source files (with dir names)
# 2) liball: Save complete paths for libraries (wildcard-expanded)
# 3) libpat: Save complete paths for libraries (non-wildcard-expanded)
# 4) srccln: Remove library src from normal src
# 5) src   : Remove root directory names from dir paths
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
liball := $(sort \
    $(foreach l,$(lib_in),$(or\
        $(strip $(foreach s,$(srcall),\
            $(if $(findstring $l,$s),$s))),\
        $(error Library file/directory "$l" not found))\
))
#------------------------------------------------------------------[ 3 ]
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
            $(foreach s,$(call rsubdir,$(root)),\
                $(if $(findstring $l,$s),$s)\
            )\
        )),\
        $(strip $(foreach s,$(srcall),\
            $(if $(findstring $l,$s),$s)\
        ))\
    ))\
)
#------------------------------------------------------------------[ 4 ]
srccln := $(srcall)
srccln := $(filter-out $(liball),$(srcall))
#------------------------------------------------------------------[ 5 ]
src    := $(srccln)
$(foreach root,$(srcdir),$(eval src := $(patsubst $(root)/%,%,$(src))))

# Static libraries
# =================
# 1) Get complete static library paths from all libraries
# 2) Expand directories to their paths, getting ALL sources without 
#    root directories
# 3) Create analogous object files from the above
# 4) Create library names, with directories, from the source
# 5) Set libraries to be linked with the binaries
#------------------------------------------------------------------[ 1 ]
arall   := \
$(foreach ar,$(ar_in),\
    $(foreach l,$(liball),\
        $(if $(findstring $(ar),$l),$l)\
))
arpat   := \
$(foreach ar,$(ar_in),\
    $(foreach l,$(libpat),\
        $(if $(findstring $(ar),$l),$l)\
))
#------------------------------------------------------------------[ 2 ]
arasrc   := $(arall)
$(foreach root,$(srcdir),\
    $(eval arasrc := $(patsubst $(root)/%,%,$(arasrc)))\
)
arpsrc  := $(arpat)
$(foreach root,$(srcdir),\
    $(eval arpsrc := $(patsubst $(root)/%,%,$(arpsrc)))\
)
#------------------------------------------------------------------[ 3 ]
arobj   := $(addprefix $(objdir)/,$(addsuffix .o,$(basename $(arasrc))))
#------------------------------------------------------------------[ 4 ]
arlib   := $(foreach s,$(arpsrc),\
                $(patsubst $(subst ./,,$(dir $s))%,\
                $(subst ./,,$(dir $s))lib%,$s)\
            )
arlib   := $(patsubst %,$(libdir)/%.a,$(basename $(arlib)))
#------------------------------------------------------------------[ 5 ]
ldflags += $(addprefix -l,$(notdir $(basename $(arpsrc))))

# Dynamic libraries
# ==================
# 1) Get complete static library paths from all libraries
# 2) Expand directories to their paths, getting ALL sources without 
#    root directories
# 3) Create analogous object files from the above
# 4) Create library names, with directories, from the source
# 5) Set libraries to be linked with the binaries
#------------------------------------------------------------------[ 1 ]
shrall  := \
$(foreach so,$(shr_in),\
    $(foreach l,$(liball),\
        $(if $(findstring $(so),$l),$l)\
))
shrpat  := \
$(foreach so,$(shr_in),\
    $(foreach l,$(libpat),\
        $(if $(findstring $(so),$l),$l)\
))
#------------------------------------------------------------------[ 2 ]
shrasrc  := $(shrall)
$(foreach root,$(srcdir),\
    $(eval shrasrc := $(patsubst $(root)/%,%,$(shrasrc)))\
)
shrpsrc := $(shrpat)
$(foreach root,$(srcdir),\
    $(eval shrpsrc := $(patsubst $(root)/%,%,$(shrpsrc)))\
)
#------------------------------------------------------------------[ 3 ]
shrobj  := $(patsubst %,$(objdir)/%.o,$(basename $(shrasrc)))
#------------------------------------------------------------------[ 4 ]
shrlib  := $(foreach s,$(shrpsrc),\
                $(patsubst $(subst ./,,$(dir $s))%,\
                $(subst ./,,$(dir $s))lib%,$s)\
            )
shrlib  := $(patsubst %,$(libdir)/%.so,$(basename $(shrlib)))
#------------------------------------------------------------------[ 5 ]
ldflags += $(addprefix -l,$(notdir $(basename $(shrpsrc))))
$(if $(strip $(shrpsrc)),$(eval ldflags := -Wl,-rpath=$(libdir) $(ldflags)))

# Object files
# =============
# 1) Add '.o' suffix for each 'naked' assembly source file name (basename)
# 2) Add '.o' suffix for each 'naked' source file name (basename)
# 3) Prefix the build dir before each name
# 4) Join all object files (including auto-generated)
obj := $(addsuffix .o,$(basename $(asmsrc)))
obj += $(addsuffix .o,$(basename $(src)))
obj := $(addprefix $(objdir)/,$(obj))
objall := $(obj) $(autoobj)

# Header files
# =============
# 1) Get all subdirectories of the included dirs
# 2) Add them as paths to be searched for headers
# 3) Get all files able to be included
incsub  := $(foreach i,$(incdir),$(call rsubdir,$i))
clibs   := $(patsubst %,-I%,$(incsub))
cxxlibs := $(patsubst %,-I%,$(incsub))
incall  := $(foreach i,$(incdir),$(foreach e,$(incext),\
				$(call rwildcard,$i,*$e)))

# Library files
# ==============
# 1) Get all subdirectories of the library dirs
# 2) Add them as paths to be searched for libraries
lib    := $(arlib) $(shrlib)
libsub  = $(if $(strip $(lib)),$(call rsubdir,$(libdir)))
ldlibs  = $(sort $(patsubst %/,%,$(patsubst %,-L%,$(libsub))))

# Automated tests
# ================
# 1) testall: Get all source files in the test directory
# 2) testdep: Basenames without test suffix, root dirs and extensions
# 3) testrun: Alias to execute tests, prefixing run_ and 
# 			  substituting / for _ in $(testdep)
#------------------------------------------------------------------[ 1 ]
$(foreach E,$(srcext),\
    $(eval testall += $(call rwildcard,$(testdir),*$(testsuf)$E)))
#------------------------------------------------------------------[ 2 ]
testdep := $(basename $(call not-root,$(subst $(testsuf).,.,$(testall))))
#------------------------------------------------------------------[ 3 ]
testrun := $(addprefix run_,$(subst /,_,$(testdep)))

# Dependency files
# =================
# 1) Dependencies will be generated for sources, auto sources and tests
# 2) Get the not-root basenames of all source directories
# 3) Create dependency names and directories
depall := $(testall) $(call not-root,$(srcall) $(autoall))
depall := $(strip $(basename $(depall)))
depall := $(addprefix $(depdir)/,$(addsuffix $(depext),$(depall)))

# Binary
# =======
# 1) Define all binary names (with extensions if avaiable)
# 2) Store common source, objects and libs between binaries
# 3) Create variables:
# 	 3.1) binary-name_src, for binary's specific sources;
# 	 3.2) binary-name_obj, for binary's specific objects;
# 	 3.3) binary-name_lib, for binary's specific libraries;
# 	 3.4) binary-name_aobj, for binary's specific auto-generated objects;
# 	 3.5) binary-name_asrc, for binary's specific auto-generated sources;
# 	 3.6) binary-name_is_cxx, to test if the binary may be C's or C++'s
#------------------------------------------------------------------[ 1 ]
bin := $(sort $(strip $(BIN)))
bin := $(if $(strip $(binext)),$(addprefix $(binext),$(bin)),$(bin))
#------------------------------------------------------------------[ 2 ]
$(foreach b,$(bin),$(or\
    $(eval comsrc  := $(filter-out $b/%,$(src))),\
    $(eval comobj  := $(filter-out $(objdir)/$b/%,$(obj))),\
    $(eval comlib  := $(filter-out $(libdir)/$b/%,$(lib))),\
    $(eval comaobj := $(filter-out $(objdir)/$b/%,$(autoobj))),\
    $(eval comaall := $(foreach b,$(bin),$(foreach s,$(srcdir),\
                        $(filter-out $s/$b/%,$(autoall)))))\
))
#------------------------------------------------------------------[ 3 ]
$(foreach b,$(bin),$(or\
    $(eval $b_src    := $(comsrc)  $(filter $b/%,$(src))),\
    $(eval $b_obj    := $(comobj)  $(filter $(objdir)/$b/%,$(objall))),\
    $(eval $b_lib    := $(comlib)  $(filter $(libdir)/$b/%,$(lib))),\
    $(eval $b_aobj   := $(comaobj) $(filter $(objdir)/$b/%,$(autoobj))),\
    $(eval $b_aall   := $(comasrc) $(foreach s,$(srcdir),\
                                       $(filter $s/$b/%,$(autosrc)))),\
    $(eval $b_is_cxx := $(strip $(call is_cxx,$($b_src)))),\
))

########################################################################
##                              BUILD                                 ##
########################################################################

.PHONY: all
all: $(bin)

.PHONY: dist
dist: $(distdir)/$(PROJECT)-$(VERSION).tar.gz

.PHONY: tar
tar: $(distdir)/$(PROJECT)-$(VERSION).tar

.PHONY: check
check: $(testrun)
	$(if $(strip $^),$(call ok,$(MSG_TEST_SUCCESS)))

.PHONY: nothing
nothing:

.PHONY: init
init:
	$(call mkdir,$(srcdir))
	$(call mkdir,$(incdir))
	$(quiet) $(MAKE) config > Config.mk

########################################################################
##                              RULES                                 ##
########################################################################

%.tar.gz: %.tar
	$(call status,$(MSG_MAKETGZ))
	$(quiet) $(ZIP) $<
	$(call ok,$(MSG_MAKETGZ))

%.tar: tarfile = $(notdir $@)
%.tar: $(bin)
	$(call mkdir,$(dir $@))
	$(call mkdir,$(tarfile))
	$(quiet) $(CP) $(libdir) $(bindir) $(tarfile)
	
	$(call vstatus,$(MSG_MAKETAR))
	$(quiet) $(TAR) $@ $(tarfile)
	$(call ok,$(MSG_MAKETAR))
	
	$(call rmdir,$(tarfile))

#======================================================================#
# Function: scanner-factory                                            #
# @param  $1 Basename of the lex file                                  #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define scanner-factory
$1.yy.$2: $3 $$(yaccall)
	$$(call vstatus,$$(MSG_LEX))
	$$(quiet) $4 $$(lexflags) -o$$@ $$< 
	$$(call ok,$$(MSG_LEX))
endef
$(foreach s,$(clexer),$(eval\
    $(call scanner-factory,$(basename $s),c,\
    $s,$(LEX))\
))
$(foreach s,$(cxxlexer),$(eval\
    $(call scanner-factory,$(basename $s),cc,\
    $s,$(LEX_CXX))\
))

#======================================================================#
# Function: parser-factory                                             #
# @param  $1 Basename of the yacc file                                 #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files accordingly to their types   #
#======================================================================#
define parser-factory
$1.tab.$2 $3.tab.$4: $5
	$$(call vstatus,$$(MSG_YACC))
	$$(quiet) $$(call mksubdir,$$(firstword $$(incdir)),$$@)
	$$(quiet) $6 $$(yaccflags) $$< -o $1.tab.$2
	$$(quiet) $$(MV) $1.h $3.tab.$4
	$$(call ok,$$(MSG_YACC))
endef
$(foreach s,$(cparser),$(eval\
    $(call parser-factory,\
        $(basename $s),c,\
        $(firstword $(incdir))/$(call not-root,$(basename $s)),h,\
        $s,$(YACC))\
))
$(foreach s,$(cxxparser),$(eval\
    $(call parser-factory,\
        $(basename $s),cc,\
        $(firstword $(incdir))/$(call not-root,$(basename $s)),hh,\
        $s,$(YACC_CXX))\
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
$$(objdir)/$3%.o: $2%$1 | $$(depdir)
	$$(call status,$$(MSG_ASM_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call make-depend,$$<,$$@,$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(AS) $$(ASMFLAGS) $$< -o $$@
	
	$$(call ok,$$(MSG_ASM_COMPILE))
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
$$(objdir)/$3%.o: $2%$1 | $$(depdir)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call make-depend,$$<,$$@,$3/$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) $$(cflags) $$(clibs) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_COMPILE))
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
$$(objdir)/$3%.o: $2%$1 | $$(depdir)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$$@)
	$$(quiet) $$(call make-depend,$$<,$$@,$3/$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) $$(cxxlibs) $$(cxxflags) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_COMPILE))
endef
$(foreach root,$(srcdir),$(foreach E,$(cxxext),\
    $(eval $(call compile-cpp,$E,$(root)/))))
$(foreach E,$(cxxext),\
    $(eval $(call compile-cpp,$E,$(testdir)/,$(testdir)/)))

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
$$(objdir)/$2.o: $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_C_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$2)
	$$(quiet) $$(call make-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$2)
	$$(quiet) $$(CC) -fPIC $$(clibs) $$(cflags) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_LIBCOMP))
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
$$(objdir)/$2.o: $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_CXX_LIBCOMP))
	
	$$(quiet) $$(call mksubdir,$$(depdir),$2)
	$$(quiet) $$(call make-depend,$$<,$$@,$2)
	$$(quiet) $$(call mksubdir,$$(objdir),$2)
	$$(quiet) $$(CXX) -fPIC $$(cxxlibs) $$(cxxflags) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_LIBCOMP))
endef
$(foreach s,$(foreach E,$(cxxext),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-cpp,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: link-sharedlib-linux                                       #
# @param  $1 Root dir                                                  #
# @param  $2 Subdirectories                                            #
# @param  $3 File/dir basename                                         #
# @param  $4 File/dir extension                                        #
# @return Target to create a shared library from objects               #
#======================================================================#
define link-sharedlib-linux
$$(libdir)/$2lib$3.so: $$(shrobj) | $$(libdir)
	$$(call status,$$(MSG_CXX_SHRDLIB))
	
	$$(quiet) $$(call mksubdir,$$(libdir),$2)
	$$(quiet) $$(CXX) $$(soflags) -o $$@ \
              $$(call src2obj,$$(wildcard $1$2$3$4*)) 
	
	$$(call ok,$$(MSG_CXX_SHRDLIB))
endef
$(foreach s,$(shrpat),\
    $(eval $(call link-sharedlib-linux,$(call root,$s)/,$(call not-root,$(dir $s)),$(notdir $(basename $s)),$(or $(suffix $s),/))))

#======================================================================#
# Function: link-statlib-linux                                         #
# @param  $1 Root dir                                                  #
# @param  $2 Subdirectories                                            #
# @param  $3 File/dir basename                                         #
# @param  $4 File/dir extension                                        #
# @return Target to create a static library from objects               #
#======================================================================#
define link-statlib-linux
$$(libdir)/$2lib$3.a: $$(arobj) | $$(libdir)
	$$(call status,$$(MSG_STATLIB))
	$$(quiet) $$(call mksubdir,$$(libdir),$2)
	$$(quiet) $$(AR) $$(arflags) $$@ \
              $$(call src2obj,$$(wildcard $1$2$3$4*)) $$(O_0) $$(E_0)
	$$(quiet) $$(RANLIB) $$@
	$$(call ok,$$(MSG_STATLIB))
endef
$(foreach a,$(arpat),\
    $(eval $(call link-statlib-linux,$(call root,$a)/,$(call not-root,$(dir $a)),$(notdir $(basename $a)),$(or $(suffix $a),/))))

#======================================================================#
# Function: test-factory                                               #
# @param  $1 Binary name for the unit test module                      #
# @param  $2 Object with main function for running unit test           #
# @param  $3 Object with the code that will be tested by the unit test #
# @param  $4 Alias to execute tests, prefixing run_ and                #
# 			 substituting / for _ in $(testdep)						   #
# @return Target to generate binary file for the unit test             #
#======================================================================#
define test-factory
$1: $2 $3 | $$(bindir)
	$$(call status,$$(MSG_TEST_COMPILE))
	
	$$(quiet) $$(call mksubdir,$$(bindir),$$@)
	$$(quiet) $$(CXX) $$^ -o $$@ $$(ldflags) $$(ldlibs)
	
	$$(call ok,$$(MSG_TEST_COMPILE))

.PHONY: $4
$4: $1
	$$(call status,$$(MSG_TEST))
	@./$$< $$(NO_OUTPUT) || $$(call shell-error,$$(MSG_TEST_FAILURE))
	$$(call ok,$$(MSG_TEST))

endef
$(foreach s,$(testdep),$(eval\
    $(call test-factory,\
        $(bindir)/$(testdir)/$s$(testsuf)$(binext),\
        $(objdir)/$(testdir)/$s$(testsuf).o,\
        $(filter $(objdir)/$s.o,$(objall)),\
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
$1: $$($1_obj) $$($1_lib) | $$(bindir)
	$$(call status,$$(MSG_CXX_LINKAGE))
	$$(quiet) $2 $$($1_obj) -o $$(bindir)/$$@ $$(ldflags) $$(ldlibs)
	$$(call ok,$$(MSG_CXX_LINKAGE))

$$($1_obj): | $$(objdir)

$$($1_aobj): $$($1_aall) | $$(objdir)
endef
$(foreach b,$(bin),$(eval\
    $(call binary-factory,$b,$(if $($b_is_cxx),$(CXX),$(CC)),\
        $(if $($b_is_cxx),$(MSG_CXX_LINKAGE),$(MSG_C_LINKAGE)))\
))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: mostlyclean
mostlyclean:
	$(call srm,$(objall))
	$(call rmdir,$(objdir))

.PHONY: clean
clean: mostlyclean
	$(call srm,$(liball))
	$(call rmdir,$(libdir))
	$(call srm,$(bin))
	$(call rmdir,$(bindir))

.PHONY: distclean
distclean: clean
	$(call srm,$(depall))
	$(call rmdir,$(depdir) $(call subdir,depdir))
	$(call srm,$(PROJECT)-$(VERSION).tar)
	$(call srm,$(PROJECT)-$(VERSION).tar.gz)
	$(call rmdir,$(distdir))

.PHONY: realclean
realclean: distclean
	$(if $(lexall),\
        $(call rm,$(lexall)),\
        $(call ok,$(MSG_LEX_NONE))  )
	$(if $(yaccall),\
        $(call rm,$(yaccall) $(yaccinc)),\
        $(call ok,$(MSG_YACC_NONE)) )

.PHONY: uninitialize
ifneq ($U,1)
uninitialize:
	@echo $(MSG_UNINIT_WARN)
	@echo $(MSG_UNINIT_ALT)
else
uninitialize: realclean
	$(call srm,$(srcall))
	$(call rmdir,$(srcdir))
	$(call srm,$(incall))
	$(call rmdir,$(incdir))
	$(call rm,Config.mk config.mk)
	$(call rm,Config_os.mk config_os.mk)
endif

########################################################################
##                             FUNCIONS                               ##
########################################################################
# Directories
$(sort $(bindir) $(objdir) $(depdir) $(libdir)):
	$(call mkdir,$@)

define src2obj
$(foreach root,$(srcdir),                 \
    $(addprefix $(objdir)/,               \
        $(patsubst $(root)/%,%,           \
            $(addsuffix .o,               \
                $(basename                \
                    $(filter $(root)/%,$1 \
))))))
endef

define srm
	$(quiet) $(RM) $1
endef

define rm
$(if $(strip $(patsubst .,,$1)),\
	$(call status,$(MSG_RM))
	$(quiet) $(RM) $1
	$(call ok,$(MSG_RM))
)
endef

define rmdir
	$(if $(strip $(patsubst .,,$1)), $(call status,$(MSG_RMDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(RMDIR) $1        )
	$(if $(strip $(patsubst .,,$1)), $(call ok,$(MSG_RMDIR))     )
endef

define mkdir
	$(if $(strip $(patsubst .,,$1)), $(call status,$(MSG_MKDIR)) )
	$(if $(strip $(patsubst .,,$1)), $(quiet) $(MKDIR) $1        )
	$(if $(strip $(patsubst .,,$1)), $(call ok,$(MSG_MKDIR))     )
endef

define mksubdir
$(if $(strip $(patsubst .,,$1)),\
	$(MKDIR) $1/$(call not-root,$(dir $2))
)
endef

# Function: make-depend
# @param $1 Source name (with path)
# @param $2 Main target to be analised
# @param $3 Dependency file name
define make-depend
$(CXX) -MM                    \
	-MF $(depdir)/$3$(depext) \
	-MP                       \
	-MT $2                    \
	$(cxxlibs)                \
	$(cxxflags)               \
	$1
endef

########################################################################
##                              OUTPUT                                ##
########################################################################

# Hide command execution details
V   ?= 0
Q_0 := @
quiet := $(Q_$V)

O_0 := 1> /dev/null
E_0 := 2> /dev/null
NO_OUTPUT := $(O_$V)
NO_ERROR  := $(E_$V)

# ANSII Escape Colors
RED     := \033[1;31m
GREEN   := \033[1;32m
YELLOW  := \033[1;33m
BLUE    := \033[1;34m
PURPLE  := \033[1;35m
CYAN    := \033[1;36m
WHITE   := \033[1;37m
RES     := \033[0m

MSG_RM           = "${BLUE}Removing ${RES}$1${RES}"
MSG_MKDIR        = "${CYAN}Creating directory $1${RES}"
MSG_RMDIR        = "${BLUE}Removing directory ${CYAN}$1${RES}"
MSG_UNINIT_WARN  = "${RED}Are you sure you want to delete all"\
				   "sources, headers and configuration files?"
MSG_UNINIT_ALT   = "Run ${BLUE}'make uninitialize U=1'${RES}"

MSG_LEX          = "${PURPLE}Generating scanner $@${RES}"
MSG_LEX_NONE     = "${PURPLE}No auto-generated lexers${RES}"
MSG_LEX_COMPILE  = "Compiling scanner ${WHITE}$@${RES}"
MSG_YACC         = "${PURPLE}Generating parser ${BLUE}$@${RES}"
MSG_YACC_NONE    = "${PURPLE}No auto-generated parsers${RES}"
MSG_YACC_COMPILE = "Compiling parser ${WHITE}$@${RES}"

MSG_TEST         = "${BLUE}Testing ${WHITE}$(notdir $<)${RES}"
MSG_TEST_COMPILE = "Generating test executable ${GREEN}$(notdir $@)${RES}"
MSG_TEST_FAILURE = "${CYAN}Test $(notdir $@) not passed${RES}"
MSG_TEST_SUCCESS = "${YELLOW}All tests passed successfully${RES}"

MSG_STATLIB      = "${RED}Generating static library $@${RES}"
MSG_MAKETAR      = "${RED}Generating tar file $@${RES}"
MSG_MAKETGZ      = "${RED}Ziping file $@${RES}"

MSG_ASM_COMPILE  = "Generating Assembly artifact ${WHITE}$@${RES}"

MSG_C_COMPILE    = "Generating C artifact ${WHITE}$@${RES}"
MSG_C_LINKAGE    = "${YELLOW}Generating C executable ${GREEN}$@${RES}"
MSG_C_SHRDLIB    = "${RED}Generating C shared library $@${RES}"
MSG_C_LIBCOMP    = "Generating C library artifact ${YELLOW}$@${RES}"

MSG_CXX_COMPILE  = "Generating C++ artifact ${WHITE}$@${RES}"
MSG_CXX_LINKAGE  = "${YELLOW}Generating C++ executable ${GREEN}$@${RES}"
MSG_CXX_SHRDLIB  = "${RED}Generating C++ shared library $@${RES}"
MSG_CXX_LIBCOMP  = "Generating C++ library artifact ${YELLOW}$@${RES}"

ifneq ($(strip $(quiet)),)
    define status
    	@echo -n $1 "... "
    endef

    define vstatus
    	@echo $1 "... "
    endef
endif

define shell-error
(echo "\r${RED}[FAILURE]${RES}" $1"."\
      "${RED}Aborting status: $$?${RES}" && exit 1)
endef

define ok
	@echo "\r${GREEN}[OK]${RES}" $1 "     "
endef

########################################################################
##                         HELP AND CONFIGS                           ##
########################################################################

.PHONY: config
config:
	@echo "                                                            "
	@echo "# Project setting                                           "
	@echo "PROJECT := # Project name. Default is 'Default'             "
	@echo "VERSION := # Version. Default is '1.0'                      "
	@echo "                                                            "
	@echo "# Program settings                                          "
	@echo "BIN     := # Binaries' names. If a subdir of the source     "
	@echo "           # directories has the same name of this binary,  "
	@echo "           # this dir and all subdir will be compiled just  "
	@echo "           # to this specific binary.                       "
	@echo "                                                            "
	@echo "ARLIB   := # Static/Shared libraries' names. If one is a    "
	@echo "SHRLIB  := # lib, all source files will make the library.   "
	@echo "                                                            "
	@echo "# Flags                                                     "
	@echo "ASFLAGS   := # Assembly Flags                               "
	@echo "CFLAGS    := # C Flags                                      "
	@echo "CXXFLAGS  := # C++ Flags                                    "
	@echo "LDFLAGS   := # Linker flags                                 "
	@echo "ARFLAGS   := # Static library flags                         "
	@echo "SOFLAGS   := # Shared library flags                         "
	@echo "                                                            "

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
	@echo " * all:         Generate all executables                    "
	@echo " * check:       Compile and run Unit Tests                  "
	@echo " * config:      Outputs Config.mk model for user's options  "
	@echo " * dist:        Create .tar.gz with binaries and libraries  "
	@echo " * init:        Create directories for beggining projects   "
	@echo " * tar:         Create .tar with binaries and libraries     "
	@echo "                                                            "
	@echo "Debug targets:                                              "
	@echo "---------------                                             "
	@echo " * dump:        Print main vars used within this Makefile   "
	@echo " * nothing:     Self-explicative, hun?                      "
	@echo "                                                            "
	@echo "Cleaning targets:                                           "
	@echo "------------------                                          "
	@echo " * mostlyclean: Clean all object files                      "
	@echo " * clean:       Above and dependencies ou are here          "
	@echo "                                                            "
	@echo "Help targets:                                               "
	@echo "---------------                                             "
	@echo " * help:        Info about this Makefile                    "
	@echo " * projecthelp: Perharps you kwnow if you are here          "
	@echo "                                                            "

########################################################################
##                            DEBUGGING                               ##
########################################################################

define prompt
	@echo "${YELLOW}"$1"${RES}" \
          $(if $(strip $2),"$(strip $2)\n","${RED}Empty${RES}")
endef

.PHONY: dump
dump: 
	$(call prompt,"alllexer: ",$(alllexer)  )
	$(call prompt,"clexer:   ",$(clexer)    )
	$(call prompt,"cxxlexer: ",$(cxxlexer)  )
	$(call prompt,"lexall:   ",$(lexall)    )
	
	@echo "---------------------"
	$(call prompt,"allparser:",$(allparser) )
	$(call prompt,"cparser:  ",$(cparser)   )
	$(call prompt,"cxxparser:",$(cxxparser) )
	$(call prompt,"yaccall:  ",$(yaccall)   )
	
	@echo "---------------------"
	$(call prompt,"srcall:   ",$(srcall)    )
	$(call prompt,"srccln:   ",$(srccln)    )
	$(call prompt,"src:      ",$(src)       )
	$(call prompt,"autoall:  ",$(autoall)   )
	$(call prompt,"autosrc:  ",$(autosrc)   )
	$(call prompt,"incall:   ",$(incall)    )
	
	@echo "---------------------"
	$(call prompt,"testall:  ",$(testall)   )
	$(call prompt,"testdep:  ",$(testdep)   )
	$(call prompt,"testrun:  ",$(testrun)   )
	
	@echo "---------------------"
	$(call prompt,"lib_in:   ",$(lib_in)    )
	$(call prompt,"libpat:   ",$(libpat)    )
	$(call prompt,"liball:   ",$(liball)    )
	$(call prompt,"libsrc:   ",$(libsrc)    )
	$(call prompt,"lib:      ",$(lib)       )
	
	@echo "---------------------"
	$(call prompt,"ar_in:    ",$(ar_in)     )
	$(call prompt,"arpat:    ",$(arpat)     )
	$(call prompt,"arpsrc:   ",$(arpsrc)    )
	$(call prompt,"arall:    ",$(arall)     )
	$(call prompt,"arasrc:   ",$(arasrc)    )
	$(call prompt,"arlib:    ",$(arlib)     )
	
	@echo "---------------------"
	$(call prompt,"shr_in:   ",$(shr_in)    )
	$(call prompt,"shrpat:   ",$(shrpat)    )
	$(call prompt,"shrpsrc:  ",$(shrpsrc)   )
	$(call prompt,"shrall:   ",$(shrall)    )
	$(call prompt,"shrasrc:  ",$(shrasrc)   )
	$(call prompt,"shrlib:   ",$(shrlib)    )
	
	@echo "---------------------"
	$(call prompt,"obj:      ",$(obj)       )
	$(call prompt,"arobj:    ",$(arobj)     )
	$(call prompt,"shrobj:   ",$(shrobj)    )
	$(call prompt,"autoobj:  ",$(autoobj)   )
	
	@echo "---------------------"
	$(call prompt,"dep:      ",$(depall)    )
	
	@echo "---------------------"
	$(call prompt,"cflags:   ",$(cflags)    )
	$(call prompt,"clibs:    ",$(clibs)     )
	$(call prompt,"cxxflags: ",$(cxxflags)  )
	$(call prompt,"cxxlibs:  ",$(cxxlibs)   )
	$(call prompt,"ldlibs:   ",$(ldlibs)    )
	$(call prompt,"ldflags:  ",$(ldflags)   )

