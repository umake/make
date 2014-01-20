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

########################################################################
##                             PROGRAM                                ##
########################################################################

# Project setting 
PROJECT ?= Robot-Battle
VESRION ?= 1.0

# Program settings
BIN     ?= Main
ARLIB   ?= 
SHRLIB  ?= 

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
FIND_FLAGS := -type d -print

# Parser and Lexer
LEX        := flex
LEX_CXX    := flex++
LEXFLAGS   := 
YACC       := bison
YACC_CXX   := bison++
YACCFLAGS  := -d #-v -t

########################################################################
##                            DIRECTORIES                             ##
########################################################################
SRCDIR  ?= src
BINDIR  ?= bin
DEPDIR  ?= dep
OBJDIR  ?= build
INCDIR  ?= include
LIBDIR  ?= lib
DISTDIR ?= dist
TESTDIR ?= test

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

########################################################################
##                       USER INPUT VALIDATION                        ##
########################################################################

# Binary:
# One single binary allowed (for a while...)
ifneq ($(words $(BIN)),1)
    $(error Just one binary allowed per Makefile. Check BIN variable)
endif

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
srcdir  := $(foreach d,$(SRCDIR),$(patsubst %/,%,$d))
bindir  := $(foreach d,$(BINDIR),$(patsubst %/,%,$d))
depdir  := $(foreach d,$(DEPDIR),$(patsubst %/,%,$d))
objdir  := $(foreach d,$(OBJDIR),$(patsubst %/,%,$d))
incdir  := $(foreach d,$(INCDIR),$(patsubst %/,%,$d))
libdir  := $(foreach d,$(LIBDIR),$(patsubst %/,%,$d))
distdir := $(foreach d,$(DISTDIR),$(patsubst %/,%,$d))
testdir := $(foreach d,$(TESTDIR),$(patsubst %/,%,$d))

# Extensions:
# Evety extension must begin with a '.' (dot)
incext := $(HEXT) $(HXXEXT)
srcext := $(CEXT) $(CXXEXT)
allext := $(incext) $(srcext) $(ASMEXT) $(LIBEXT) $(LEXEXT) $(YACCEXT)
$(foreach ext,$(allext),\
    $(if $(filter .%,$(ext)),,\
        $(error "$(ext)" is not a valid extension)))

########################################################################
##                              PATHS                                 ##
########################################################################

# Define extensions as the only valid ones
.SUFFIXES:
.SUFFIXES: $(allext)

# Path
vpath %        $(bindir)  # All binaries in bindir
vpath lib%.a   $(libdir)  # All static libs in libdir
vpath lib%.so  $(libdir)  # All shared libs in libdir
vpath %.tar    $(distdir) # All tar files in distdir
vpath %.tar.gz $(distdir) # All tar.gz files in distdir
$(foreach root,$(srcdir),$(foreach e,$(srcext),$(eval vpath %$e $(root))))

########################################################################
##                              FILES                                 ##
########################################################################

# Auxiliar functions
# ===================
# 1) root: Gets the root directory (first in the path) of a path or file
# 2) not-root: Given a path or file, take out the root directory of it
# 3) not: Returns empty if its argument was defined, or T otherwise
# 4) remove-trailing-bar: Removes the last / of a directory-onl name
define root
$(foreach s,$1,\
	$(if $(findstring /,$s),\
		$(call root,$(patsubst %/,%,$(dir $s))),$(strip $s)))
endef

define not-root
$(foreach s,$1,$(strip $(subst $(strip $(call root,$s))/,,$s)))
endef

define not
$(strip $(if $1,,T))
endef

define remove-trailing-bar
$(foreach s,$1,$(if $(or $(call not,$(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))
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
rwildcard = $(foreach d,$(wildcard $1/*),$(call rwildcard,$d,$2)$(filter $(subst *,%,$2),$d)) 

# Assembly files
# ==============
# 1) Find all assembly files in the source directory
# 2) Remove source directory root paths from ordinary assembly src
$(foreach root,$(srcdir),\
    $(foreach E,$(ASMEXT),\
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
lib_in := $(ar_in) $(shr_in) #$(testlib)
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
    $(foreach E,$(LEXEXT),\
        $(eval alllexer += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
cxxlexer := $(foreach l,$(cxxlexer),$(filter %$l,$(alllexer)))
clexer   := $(filter-out $(cxxlexer),$(alllexer))
#------------------------------------------------------------------[ 3 ]
lexall   += $(foreach E,$(LEXEXT),\
                $(patsubst %$E,%.yy.cc,$(filter %$E,$(cxxlexer))))
lexall   += $(foreach E,$(LEXEXT),\
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
    $(foreach E,$(YACCEXT),\
        $(eval allparser += $(call rwildcard,$(root),*$E))\
))
#------------------------------------------------------------------[ 2 ]
cxxparser := $(foreach y,$(cxxparser),$(filter %$y,$(allparser)))
cparser   := $(filter-out $(cxxparser),$(allparser))
#------------------------------------------------------------------[ 3 ]
yaccall   += $(foreach E,$(YACCEXT),\
                $(patsubst %$E,%.tab.cc,$(filter %$E,$(cxxparser))))
yaccall   += $(foreach E,$(YACCEXT),\
                $(patsubst %$E,%.tab.c,$(filter %$E,$(cparser))))
yaccall   := $(strip $(yaccall))
#------------------------------------------------------------------[ 4 ]
yaccinc   := $(addprefix $(incdir)/,$(call not-root,$(yaccall)))
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
srcall := $(sort\
    $(foreach root,$(srcdir),\
        $(foreach E,$(srcext),\
            $(call rwildcard,$(root),*$E)\
)))
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
incsub  := $(call rsubdir,$(incdir))
clibs   := $(patsubst %,-I%,$(incsub))
cxxlibs := $(patsubst %,-I%,$(incsub))

# Library files
# ==============
# 1) Get all subdirectories of the library dirs
# 2) Add them as paths to be searched for libraries
lib    := $(arlib) $(shrlib)
libsub  = $(if $(strip $(lib)),$(call rsubdir,$(libdir)))
ldlibs  = $(sort $(patsubst %/,%,$(patsubst %,-L%,$(libsub))))

# Automated tests
# ================
# 1) Get all source files in the test directory
$(foreach E,$(srcext),\
    $(eval testall += $(call rwildcard,$(testdir),*_tests$E)))
testbin := $(strip $(addprefix $(bindir)/,$(basename $(testall))))

# Binary
# =======
# 1) Find out if any source is C++ code, and then make a C++ binary
is_cxx := $(foreach ext,$(CXXEXT),$(findstring $(ext),$(src) $(autoall)))

########################################################################
##                              BUILD                                 ##
########################################################################

.PHONY: all
all: $(BIN)

.PHONY: dist
dist: $(distdir)/$(PROJECT)-$(VERSION).tar.gz

.PHONY: tar
tar: $(distdir)/$(PROJECT)-$(VERSION).tar

.PHONY: check
check: $(testbin)
	$(if $(strip $^),$(call ok,$(MSG_TEST_SUCCESS)))

.PHONY: dump
dump: 
	@echo "alllexer: " $(alllexer)
	@echo "clexer:   " $(clexer)
	@echo "cxxlexer: " $(cxxlexer)
	@echo "lexall:   " $(lexall)
	
	@echo "---------------------"
	@echo "allparser:" $(allparser)
	@echo "cparser:  " $(cparser)
	@echo "cxxparser:" $(cxxparser)
	@echo "yaccall:  " $(yaccall)
	
	@echo "---------------------"
	@echo "srcall:   " $(srcall)
	@echo ""
	@echo "srccln:   " $(srccln)
	@echo ""
	@echo "src:      " $(src)
	@echo ""
	@echo "testsrc:  " $(testsrc)
	@echo ""
	@echo "autoall:  " $(autoall)
	@echo ""
	@echo "autosrc:  " $(autosrc)
	
	@echo "---------------------"
	@echo "lib_in:   " $(lib_in)
	@echo ""
	@echo "libpat:   " $(libpat)
	@echo ""
	@echo "liball:   " $(liball)
	@echo ""
	@echo "libsrc:   " $(libsrc)
	@echo ""
	@echo "lib:      " $(lib)
	
	@echo "---------------------"
	@echo "ar_in:    " $(ar_in)
	@echo ""
	@echo "arpat:    " $(arpat)
	@echo ""
	@echo "arpsrc:   " $(arpsrc)
	@echo ""
	@echo "arall:    " $(arall)
	@echo ""
	@echo "arasrc:   " $(arasrc)
	@echo ""
	@echo "arlib:    " $(arlib)
	
	@echo "---------------------"
	@echo "shr_in:   " $(shr_in)
	@echo ""
	@echo "shrpat:   " $(shrpat)
	@echo ""
	@echo "shrpsrc:  " $(shrpsrc)
	@echo ""
	@echo "shrall:   " $(shrall)
	@echo ""
	@echo "shrasrc:  " $(shrasrc)
	@echo ""
	@echo "shrlib:   " $(shrlib)
	
	@echo "---------------------"
	@echo "obj:      " $(obj)
	@echo ""
	@echo "arobj:    " $(arobj)
	@echo ""
	@echo "shrobj:   " $(shrobj)
	@echo ""
	@echo "autoobj:  " $(autoobj)
	
	@echo "---------------------"
	@echo "cflags:   " $(cflags)
	@echo "clibs:    " $(clibs) 
	@echo "cxxflags: " $(cxxflags)
	@echo "cxxlibs:  " $(cxxlibs) 
	@echo "ldlibs:   " $(ldlibs)
	@echo "ldflags:  " $(ldflags)
	

ifneq ($(is_cxx),)
$(BIN): $(autoobj) $(obj) $(lib) | $(bindir)
	$(call status,$(MSG_CXX_LINKAGE))
	$(quiet) $(CXX) $(filter %.o,$^) -o $(bindir)/$@ $(ldflags) $(ldlibs)
	$(call ok,$(MSG_CXX_LINKAGE))
else
$(BIN): $(autoobj) $(obj) $(lib) | $(bindir)
	$(call status,$(MSG_C_LINKAGE))
	$(quiet) $(CC) $(filter %.o,$^) -o $(bindir)/$@ $(ldflags) $(ldlibs)
	$(call ok,$(MSG_C_LINKAGE))
endif

$(obj): | $(objdir)

$(autoobj): $(autoall) | $(objdir)

########################################################################
##                              RULES                                 ##
########################################################################

%.tar.gz: %.tar
	$(call status,$(MSG_MAKETGZ))
	$(quiet) $(ZIP) $<
	$(call ok,$(MSG_MAKETGZ))

%.tar: tarfile = $(notdir $@)
%.tar: $(BIN)
	$(call mkdir,$(dir $@))
	$(call mkdir,$(tarfile))
	$(quiet) $(CP) $(libdir) $(bindir) $(tarfile)
	
	$(call vstatus,$(MSG_MAKETAR))
	$(quiet) $(TAR) $@ $(tarfile)
	$(call ok,$(MSG_MAKETAR))
	
	$(call rmdir,$(tarfile))

#======================================================================#
# Function: lex-factory                                                #
# @param  $1 Basename of the lex file                                  #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define lex-factory
$1.yy.$2: $3 $$(yaccall)
	$$(call vstatus,$$(MSG_LEX))
	$$(quiet) $4 $$(lexflags) -o$$@ $$< 
	$$(call ok,$$(MSG_LEX))
endef
$(foreach s,$(clexer),$(eval\
    $(call lex-factory,$(basename $s),c,\
    $s,$(LEX))\
))
$(foreach s,$(cxxlexer),$(eval\
    $(call lex-factory,$(basename $s),cc,\
    $s,$(LEX_CXX))\
))

#======================================================================#
# Function: yacc-factory                                               #
# @param  $1 Basename of the yacc file                                 #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define yacc-factory
$1.tab.$2 $3.tab.$4: $5
	$$(call vstatus,$$(MSG_YACC))
	$$(quiet) $$(call mksubdir,$$(incdir),$$@)
	$$(quiet) $6 $$(yaccflags) $$< -o $1.tab.$2
	$$(quiet) $$(MV) $1.h $3.tab.$4
	$$(call ok,$$(MSG_YACC))
endef
$(foreach s,$(cparser),$(eval\
    $(call yacc-factory,\
        $(basename $s),c,\
        $(incdir)/$(call not-root,$(basename $s)),h,\
        $s,$(YACC))\
))
$(foreach s,$(cxxparser),$(eval\
    $(call yacc-factory,\
        $(basename $s),cc,\
        $(incdir)/$(call not-root,$(basename $s)),hh,\
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
	
	$$(quiet) $$(call make-depend,$$<,$$@,$$*.d)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(AS) $$(ASMFLAGS) $$< -o $$@
	
	$$(call ok,$$(MSG_ASM_COMPILE))
endef
$(foreach root,$(srcdir),\
    $(foreach E,$(ASMEXT),\
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
	
	$$(quiet) $$(call make-depend,$$<,$$@,$$*)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CC) $$(cflags) $$(clibs) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_COMPILE))
endef
$(foreach root,$(srcdir),$(foreach E,$(CEXT),\
    $(eval $(call compile-c,$E,$(root)/))))
$(foreach E,$(CEXT),\
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
	
	$$(quiet) $$(call make-depend,$$<,$$@,$$*.d)
	$$(quiet) $$(call mksubdir,$$(objdir),$$@)
	$$(quiet) $$(CXX) $$(cxxlibs) $$(cxxflags) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_COMPILE))
endef
$(foreach root,$(srcdir),$(foreach E,$(CXXEXT),\
    $(eval $(call compile-cpp,$E,$(root)/))))
$(foreach E,$(CXXEXT),\
    $(eval $(call compile-cpp,$E,$(testdir)/,$(testdir)/)))

# Include dependencies for each src extension
-include $(depdir)/*.d

#======================================================================#
# Function: compile-sharedlib-linux-c                                  #
# @param  $1 File basename                                             #
# @param  $2 File extension                                            #
# @return Target to compile the C library file                         #
#======================================================================#
define compile-sharedlib-linux-c
$$(objdir)/$2.o: $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_C_LIBCOMP))
	
	$$(quiet) $$(call make-depend,$$<,$$@,$(notdir $2).d)
	$$(quiet) $$(call mksubdir,$$(objdir),$2)
	$$(quiet) $$(CC) -fPIC $$(clibs) $$(cflags) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_LIBCOMP))
endef
$(foreach s,$(foreach E,$(CEXT),$(filter %$E,$(shrall))),\
    $(eval $(call compile-sharedlib-linux-c,$(call root,$s)/,$(call not-root,$(basename $s)),$(suffix $s))))

#======================================================================#
# Function: compile-sharedlib-linux-cpp                                #
# @param  $1 File basename                                             #
# @param  $2 File extension                                            #
# @return Target to compile the C++ library file                       #
#======================================================================#
define compile-sharedlib-linux-cpp
$$(objdir)/$2.o: $1$2$3 | $$(depdir)
	$$(call status,$$(MSG_CXX_LIBCOMP))
	
	$$(quiet) $$(call make-depend,$$<,$$@,$(notdir $2).d)
	$$(quiet) $$(call mksubdir,$$(objdir),$2)
	$$(quiet) $$(CXX) -fPIC $$(cxxlibs) $$(cxxflags) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_LIBCOMP))
endef
$(foreach s,$(foreach E,$(CXXEXT),$(filter %$E,$(shrall))),\
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
# @return Target to generate binary file for the unit test             #
#======================================================================#
define test-factory
.PHONY: $$(bindir)/$1
$$(bindir)/$1: $$(objdir)/$1.o | $$(bindir)
	$$(call status,$$(MSG_TEST))
	
	$$(quiet) $$(call mksubdir,$$(bindir),$$@)
	$$(quiet) $$(CXX) $$^ -o $$@ $$(ldflags) $$(ldlibs)
	
	@./$$@ $$(NO_OUTPUT) || $$(call shell-error,$$(MSG_TEST_FAILURE))
	
	$$(call ok,$$(MSG_TEST))
endef
$(foreach s,$(basename $(testall)),$(eval $(call test-factory,$s)))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: mostlyclean
mostlyclean:
	$(call rmdir,$(objdir))

.PHONY: clean
clean: mostlyclean
	$(call rmdir,$(libdir))
	$(call rmdir,$(bindir))

.PHONY: distclean
distclean: clean
	$(call rmdir,$(depdir))
	$(call rmdir,$(distdir))

.PHONY: realclean
realclean: distclean
	$(if $(lexall),\
        $(call rm,$(lexall)),\
        $(call ok,$(MSG_LEX_NONE))  )
	$(if $(yaccall),\
        $(call rm,$(yaccall) $(yaccinc)),\
        $(call ok,$(MSG_YACC_NONE)) )

########################################################################
##                             FUNCIONS                               ##
########################################################################
# Directories
$(bindir) $(objdir) $(depdir) $(libdir):
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

define rm
	$(call status,$(MSG_RM))
	$(quiet) $(RM) $1
	$(call ok,$(MSG_RM))
endef

define rmdir
	$(call status,$(MSG_RMDIR))
	$(quiet) $(RMDIR) $1
	$(call ok,$(MSG_RMDIR))
endef

define mkdir
	$(call status,$(MSG_MKDIR))
	$(quiet) $(MKDIR) $1
	$(call ok,$(MSG_MKDIR))
endef

define mksubdir
	$(MKDIR) $1/$(call not-root,$(dir $2))
endef

# Function: make-depend
# @param $1 Source name (with path)
# @param $2 Main target to be analised
# @param $3 Dependency file name
define make-depend
$(CXX) -MM                     \
	-MF $(depdir)/$(notdir $3) \
	-MP                        \
	-MT $2                     \
	$(cxxlibs)                 \
	$(cxxflags)                \
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

MSG_LEX          = "${PURPLE}Generating scanner $@${RES}"
MSG_LEX_NONE     = "${PURPLE}No auto-generated lexers${RES}"
MSG_LEX_COMPILE  = "Compiling scanner ${WHITE}$@${RES}"
MSG_YACC         = "${PURPLE}Generating parser ${BLUE}$@${RES}"
MSG_YACC_NONE    = "${PURPLE}No auto-generated parsers${RES}"
MSG_YACC_COMPILE = "Compiling parser ${WHITE}$@${RES}"

MSG_TEST         = "${BLUE}Testing ${WHITE}$(notdir $<)${RES}"
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
