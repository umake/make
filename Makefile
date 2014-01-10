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
PROJECT := Robot-Battle
VESRION := 1.0

# Program settings
BIN    := Main
ARLIB  := 
SHRLIB := 

########################################################################
##                              FLAGS                                 ##
########################################################################

# Assembler flags
ASFLAGS   := -f elf32

# C Options
CFLAGS    := -Wall -ansi -pedantic -O2 -g

# C++ Options
CXXFLAGS  := $(CFLAGS) -std=gnu++11

# Parsers in C++
CXXLEXER  := 
CXXPARSER := 

# Linker flags
LDFLAGS   := 

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
TAR        := tar -cvf
ZIP        := gzip
RM         := rm -f
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
YACCFLAGS  := #-v -t

########################################################################
##                            DIRECTORIES                             ##
########################################################################
SRCDIR  := src
BINDIR  := bin
DEPDIR  := dep
OBJDIR  := build
INCDIR  := include
LIBDIR  := lib
DISTDIR := dist
TESTDIR := test

########################################################################
##                              PATHS                                 ##
########################################################################

# Assembly extensions
ASMEXT := .asm .S

# Header extensions
HEXT   := .h
HXXEXT := .H .hh .hpp .hxx .h++
INCEXT := $(HEXT) $(HXXEXT)

# Source extensions
CEXT   := .c
CXXEXT := .C .cc .cpp .cxx .c++ .tcc
SRCEXT := $(CEXT) $(CXXEXT)

.SUFFIXES:
.SUFFIXES: $(INCEXT) $(SRCEXT) .l .y .a .so .dll

# Path
vpath %        $(BINDIR)  # All binaries in bindir
vpath lib%.a   $(LIBDIR)  # All static libs in libdir
vpath lib%.so  $(LIBDIR)  # All shared libs in libdir
vpath %.tar    $(DISTDIR) # All tar files in DISTDIR
vpath %.tar.gz $(DISTDIR) # All tar.gz files in DISTDIR
$(foreach d,$(SRCDIR),$(foreach e,$(SRCEXT),$(eval vpath %$e $d)))

########################################################################
##                              FILES                                 ##
########################################################################

# Auxiliar functions
# ===================
# 1) rsubdir: For listing all subdirectories of a given dir
# 2) rwildcard: For wildcard deep-search in the directory tree
rsubdir   = $(foreach d,$1,$(shell $(FIND) $d $(FIND_FLAGS)))
rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2)$(filter $(subst *,%,$2),$d)) 

# Assembly files
# ==============
# 1) Find all assembly files in the source directory
# 2) Remove source directory root paths from ordinary assembly src
$(foreach E,$(ASMEXT),$(eval ASMSRC += $(call rwildcard,$(SRCDIR),*$E)))
ASMSRC := $(sort $(foreach ROOT,$(SRCDIR),$(patsubst $(ROOT)/%,%,$(ASMSRC))))

# Library files
# ==============
# 1) Remove the laast / if there is a path only
# 1) Store libraries as being shared and static libs
# 3) If there is only a suffix, throw an error. Otherwise, make
#    the same action as above
# 4) Remove src root directories from libraries
#------------------------------------------------------------------[ 1 ]
ARLIB := $(foreach s,$(ARLIB),$(if $(or $(call not $(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))
SHRLIB := $(foreach s,$(SHRLIB),$(if $(or $(call not $(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))
#------------------------------------------------------------------[ 2 ]
LIB := $(ARLIB) $(SHRLIB)
#------------------------------------------------------------------[ 3 ]
LIB := \
$(foreach s,$(LIB),                                                    \
  $(if $(and                                                           \
      $(strip $(suffix $s)),$(if $(strip $(notdir $(basename $s))),,T) \
  ),                                                                   \
  $(error "Invalid argument $s in library variable"),                  \
  $(if                                                                 \
    $(or $(call not $(dir $s)),$(suffix $s),$(notdir $(basename $s))), \
    $s,$(patsubst %/,%,$s))                                            \
))
#------------------------------------------------------------------[ 4 ]
LIB := $(patsubst $(SRCDIR)/%,%,$(LIB))

# Lexical analyzer
# =================
# 1) Find in a directory tree all the lex files (with dir names)
# 2) Split C++ and C lexers (to be compiled appropriately)
# 3) Change lex extension to format .yy.c or .yy.cc (for C/C++ lexers)
# 4) Join all the C and C++ lexer source names
# 5) Add lex default library with linker flags
LEXSRC   := $(call rwildcard,$(SRCDIR),*.l)
CXXLEXER := $(foreach l,$(CXXLEXER),$(filter %$l,$(LEXSRC)))
CLEXER   := $(filter-out $(CXXLEXER),$(LEXSRC))
CXXLEXER := $(patsubst %.l,%.yy.cc,$(CXXLEXER))
CLEXER   := $(patsubst %.l,%.yy.c ,$(CLEXER))
LEXSRC   := $(strip $(CLEXER) $(CXXLEXER))
$(if $(strip $(LEXSRC)),$(eval LDFLAGS += -lfl))

# Syntatic analyzer
# ==================
# 1) Find in a directory tree all the yacc files (with dir names)
# 2) Split C++ and C parsers (to be compiled appropriately)
# 3) Change yacc extension to format .tab.c or .tab.cc (for C/C++ parsers)
# 4) Join all the C and C++ parser source names
YACCSRC   := $(call rwildcard,$(SRCDIR),*.y)
CXXPARSER := $(foreach y,$(CXXPARSER),$(filter %$y,$(YACCSRC)))
CPARSER   := $(filter-out $(CXXPARSER),$(YACCSRC))
CXXPARSER := $(patsubst %.y,%.tab.cc,$(CXXPARSER))
CPARSER   := $(patsubst %.y,%.tab.c ,$(CPARSER))
YACCSRC   := $(strip $(CPARSER) $(CXXPARSER))

# Auto source code
# =================
AUTOSRC := $(YACCSRC) $(LEXSRC)

# Source files
# =============
# 1) Find in a directory tree all the source files (with dir names)
# 2) Remove src root directory name from all sources
# 3) Save complete paths for libraries
# 4) Remove source directory root paths from ordinary src
$(foreach E,$(SRCEXT),$(eval SRC += $(call rwildcard,$(SRCDIR),*$E)))
LIB := $(foreach l,$(LIB),$(or $(filter %$l,$(SRC)),$(SRCDIR)/$l) )
SRC := $(or $(foreach l,$(LIB),$(filter-out %$l,$(SRC))),$(SRC))
SRC := $(sort $(foreach ROOT,$(SRCDIR),$(patsubst $(ROOT)/%,%,$(SRC))))

# Static libraries
# =================
# 1) Set flags to create static libraries
# 2) Get complete static library paths from all libraries
# 3) Expand directories to their paths, getting ALL sources without 
#    root directories
# 4) Create analogous object files from the above
# 5) Create library names, with directories, from the source
# 6) Set libraries to be linked with the binaries
#------------------------------------------------------------------[ 1 ]
ARFLAGS ?= -rcv
#------------------------------------------------------------------[ 2 ]
ARSRC   := $(foreach a,$(ARLIB),$(filter %$a,$(LIB)))
#------------------------------------------------------------------[ 3 ]
ARALL   := $(foreach s,$(ARSRC),$(if $(suffix $s),$s,$(wildcard $s/*)))
ARALL   := $(patsubst $(SRCDIR)/%,%,$(ARALL))
#------------------------------------------------------------------[ 4 ]
AROBJ   := $(patsubst %,$(OBJDIR)/%.o,$(basename $(ARALL)))
#------------------------------------------------------------------[ 5 ]
ARLIB   := $(foreach s,$(ARSRC),\
               $(patsubst $(dir $s)%,$(dir $s)lib%,$s))
ARLIB   := $(patsubst $(SRCDIR)/%,$(LIBDIR)/%,$(ARLIB))
ARLIB   := $(addsuffix .a,$(basename $(ARLIB)))
#------------------------------------------------------------------[ 6 ]
LDFLAGS += $(addprefix -l,$(notdir $(basename $(ARSRC))))

# Dynamic libraries
# ==================
# 1) Set flags to create shared libraries
# 2) Get complete static library paths from all libraries
# 3) Expand directories to their paths, getting ALL sources without 
#    root directories
# 4) Create analogous object files from the above
# 5) Create library names, with directories, from the source
# 6) Set libraries to be linked with the binaries
#------------------------------------------------------------------[ 1 ]
SOFLAGS += -shared 
#------------------------------------------------------------------[ 2 ]
SHRSRC  := $(foreach s,$(SHRLIB),$(filter %$s,$(LIB)))
#------------------------------------------------------------------[ 3 ]
SHRALL  := $(foreach s,$(SHRSRC),$(if $(suffix $s),$s,$(wildcard $s/*)))
SHRALL  := $(patsubst $(SRCDIR)/%,%,$(SHRALL))
#------------------------------------------------------------------[ 4 ]
SHROBJ  := $(patsubst %,$(OBJDIR)/%.o,$(basename $(SHRALL)))
#------------------------------------------------------------------[ 5 ]
SHRLIB  := $(foreach s,$(SHRSRC),\
               $(patsubst $(dir $s)%,$(dir $s)lib%,$s))
SHRLIB  := $(patsubst $(SRCDIR)/%,$(LIBDIR)/%,$(SHRLIB))
SHRLIB  := $(addsuffix .so,$(basename $(SHRLIB)))
#------------------------------------------------------------------[ 6 ]
LDFLAGS += $(addprefix -l,$(notdir $(basename $(SHRSRC))))
$(if $(strip $(SHRSRC)),$(eval LDFLAGS := -Wl,-rpath=$(LIBDIR) $(LDFLAGS)))

# Object files
# =============
# 1) Add '.o' suffix for each 'naked' assembly source file name (basename)
# 2) Add '.o' suffix for each 'naked' source file name (basename)
# 3) Prefix the build dir before each name
OBJ := $(addsuffix .o,$(basename $(ASMSRC)))
OBJ += $(addsuffix .o,$(basename $(SRC)))
OBJ := $(addprefix $(OBJDIR)/,$(OBJ))

# Header files
# =============
# 1) Get all subdirectories of the included dirs
# 2) Add them as paths to be searched for headers
INCSUB  := $(call rsubdir,$(INCDIR))
CLIBS   := $(patsubst %,-I%,$(INCSUB))
CXXLIBS := $(patsubst %,-I%,$(INCSUB))

# Library files
# ==============
# 1) Get all subdirectories of the library dirs
# 2) Add them as paths to be searched for libraries
LIB    := $(ARLIB) $(SHRLIB)
LIBSUB  = $(if $(strip $(LIB)),$(call rsubdir,$(LIBDIR)))
LDLIBS  = $(sort $(patsubst %/,%,$(patsubst %,-L%,$(LIBSUB))))

# Automated tests
# ================
# 1) Get all source files in the test directory
$(foreach E,$(SRCEXT),$(eval TESTSRC += $(call rwildcard,$(TESTDIR),*_tests$E)))
TESTOBJ := $(addsuffix .o,$(basename $(TESTSRC)))
TESTBIN := $(strip $(addprefix $(BINDIR)/,$(basename $(TESTSRC))))

# Binary
# =======
# 1) Find out if any source is C++ code, and then make this binary
IS_CXX := $(foreach EXT,$(CXXEXT),$(findstring $(EXT),$(SRC)))

########################################################################
##                              BUILD                                 ##
########################################################################

.PHONY: all
all: $(BIN)

.PHONY: dist
dist: $(DISTDIR)/$(PROJECT)-$(VERSION).tar.gz

.PHONY: tar
tar: $(DISTDIR)/$(PROJECT)-$(VERSION).tar

.PHONY: check
check: $(TESTBIN)
	$(if $(strip $^),$(call ok,$(MSG_TEST_SUCCESS)))

# TODO: Remove tests
.PHONY: test
test: 
	@echo "clexer:   " $(CLEXER)
	@echo "cxxlexer: " $(CXXLEXER)
	@echo "lexsrc:   " $(LEXSRC)
	@echo "asm:      " $(ASMSRC)
	@echo "testsrc:  " $(TESTSRC)
	@echo "testbin:  " $(TESTBIN)
	@echo "base up:  " $(patsubst $(SRCDIR)/%,%,$(dir src/math))
	@echo "Src:      " $(SRC)
	@echo "Lib:      " $(LIB)
	@echo "shrsrc:   " $(SHRSRC)
	@echo "shrobj:   " $(SHROBJ)
	@echo "shrlib:   " $(SHRLIB)
	@echo "shrall:   " $(SHRALL)
	@echo "path:     " $(foreach s,$(SHRSRC),$(dir $s))
	@echo "main:     " $(foreach s,$(SHRSRC),$(notdir $(basename $s)))
	@echo "suffix:   " $(foreach s,$(SHRSRC),$(or $(suffix $s),/))
	@echo "wildcard: " $(foreach s,$(SHRSRC),$(wildcard $s/*))

ifneq ($(IS_CXX),)
$(BIN): $(OBJ) $(LIB) | $(BINDIR)
	$(call status,$(MSG_CXX_LINKAGE))
	$(QUIET) $(CXX) $(OBJ) -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS)
	$(call ok,$(MSG_CXX_LINKAGE))
else
$(BIN): $(OBJ) $(LIB) | $(BINDIR)
	$(call status,$(MSG_C_LINKAGE))
	$(QUIET) $(CC) $(OBJ) -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS)
	$(call ok,$(MSG_C_LINKAGE))
endif

$(OBJ): $(AUTOSRC) | $(OBJDIR)

########################################################################
##                              RULES                                 ##
########################################################################

%.tar.gz: %.tar
	$(call status,$(MSG_MAKETGZ))
	$(QUIET) $(ZIP) $<
	$(call ok,$(MSG_MAKETGZ))

%.tar: TARFILE = $(notdir $@)
%.tar: $(BIN)
	$(call mkdir,$(dir $@))
	$(call mkdir,$(TARFILE))
	$(QUIET) $(CP) $(LIBDIR) $(BINDIR) $(TARFILE)
	
	$(call vstatus,$(MSG_MAKETAR))
	$(QUIET) $(TAR) $@ $(TARFILE)
	$(call ok,$(MSG_MAKETAR))
	
	$(call rmdir,$(TARFILE))

#======================================================================#
# Function: lex-factory                                                #
# @param  $1 Basename of the lex file                                  #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define lex-factory
$1.yy.$2: $1.l $$(YACCSRC)
	$$(call vstatus,$$(MSG_LEX))
	$$(QUIET) $3 $$(LEXFLAGS) -o$$@ $$< 
	$$(call ok,$$(MSG_LEX))
endef
c_lbase   := $(patsubst %.yy.c, %,$(CLEXER))
cxx_lbase := $(patsubst %.yy.cc,%,$(CXXLEXER))
$(foreach s,$(c_lbase)  ,$(eval $(call lex-factory,$s,c,$(LEX))))
$(foreach s,$(cxx_lbase),$(eval $(call lex-factory,$s,cc,$(LEX_CXX))))

#======================================================================#
# Function: yacc-factory                                               #
# @param  $1 Basename of the yacc file                                 #
# @param  $2 Extesion depending on the parser type (C/C++)             #
# @param  $3 Program to be used depending on the parser type (C/C++)   #
# @return Target to generate source files according to its type        #
#======================================================================#
define yacc-factory
$1.tab.$2: $1.y
	$$(call vstatus,$$(MSG_YACC))
	$$(QUIET) $3 $$(YACCFLAGS) $$< -o $$@ 
	$$(call ok,$$(MSG_YACC))
endef
c_pbase   := $(patsubst %.tab.c, %,$(CPARSER))
cxx_pbase := $(patsubst %.tab.cc,%,$(CXXPARSER))
$(foreach s,$(c_pbase)  ,$(eval $(call yacc-factory,$s,c,$(YACC))))
$(foreach s,$(cxx_pbase),$(eval $(call yacc-factory,$s,cc,$(YACC_CXX))))

#======================================================================#
# Function: compile-asm                                                #
# @param  $1 Assembly extension                                        #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all Assembly files with the given          #
#         extension, looking in the right root directory               #
#======================================================================#
define compile-asm
$$(OBJDIR)/$3%.o: $2%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_ASM_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*.d)
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$$@)
	$$(QUIET) $$(AS) $$(ASMFLAGS) $$< -o $$@
	
	$$(call ok,$$(MSG_ASM_COMPILE))
endef
$(foreach E,$(ASMEXT),\
    $(eval $(call compile-asm,$E,$(SRCDIR)/)))

#======================================================================#
# Function: compile-c                                                  #
# @param  $1 C extension                                               #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all C files with the given extension,      #
#         looking in the right root directory                          #
#======================================================================#
define compile-c
$$(OBJDIR)/$3%.o: $2%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*)
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$$@)
	$$(QUIET) $$(CC) $$(CFLAGS) $$(CLIBS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_COMPILE))
endef
$(foreach E,$(CEXT),\
    $(eval $(call compile-c,$E,$(SRCDIR)/)))
$(foreach E,$(CEXT),\
    $(eval $(call compile-c,$E,$(TESTDIR)/,$(TESTDIR)/)))

#======================================================================#
# Function: compile-cpp                                                #
# @param  $1 C++ extension                                             #
# @param  $2 Root source directory                                     #
# @param  $3 Source tree specific path in objdir to put objects        #
# @return Target to compile all C++ files with the given extension     #
#         looking in the right root directory                          #
#======================================================================#
define compile-cpp
$$(OBJDIR)/$3%.o: $2%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*.d)
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$$@)
	$$(QUIET) $$(CXX) $$(CXXLIBS) $$(CXXFLAGS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_COMPILE))
endef
$(foreach E,$(CXXEXT),\
    $(eval $(call compile-cpp,$E,$(SRCDIR)/)))
$(foreach E,$(CXXEXT),\
    $(eval $(call compile-cpp,$E,$(TESTDIR)/,$(TESTDIR)/)))

# Include dependencies for each src extension
-include $(DEPDIR)/*.d

#======================================================================#
# Function: compile-sharedlib-linux-c                                  #
# @param  $1 File basename                                             #
# @param  $2 File extension                                            #
# @return Target to compile the C library file                         #
#======================================================================#
define compile-sharedlib-linux-c
$$(OBJDIR)/$1.o: $$(SRCDIR)/$1$2 | $$(DEPDIR)
	$$(call status,$$(MSG_C_LIBCOMP))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$(notdir $1).d)
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$1)
	$$(QUIET) $$(CC) -fPIC $$(CLIBS) $$(CFLAGS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_LIBCOMP))
endef
$(foreach E,$(CEXT),\
    $(foreach s,$(filter %$E,$(SHRALL)),\
	    $(eval $(call compile-sharedlib-linux-c,$(basename $s),$E))\
))

#======================================================================#
# Function: compile-sharedlib-linux-cpp                                #
# @param  $1 File basename                                             #
# @param  $2 File extension                                            #
# @return Target to compile the C++ library file                       #
#======================================================================#
define compile-sharedlib-linux-cpp
$$(OBJDIR)/$1.o: $$(SRCDIR)/$1$2 | $$(DEPDIR)
	$$(call status,$$(MSG_CXX_LIBCOMP))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$(notdir $1).d)
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$1)
	$$(QUIET) $$(CXX) -fPIC $$(CXXLIBS) $$(CXXFLAGS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_LIBCOMP))
endef
$(foreach E,$(CXXEXT),\
    $(foreach s,$(filter %$E,$(SHRALL)),\
        $(eval $(call compile-sharedlib-linux-cpp,$(basename $s),$E))\
))

#======================================================================#
# Function: link-sharedlib-linux                                       #
# @param  $1 Root dir                                                  #
# @param  $2 Subdirectories                                            #
# @param  $3 File/dir basename                                         #
# @param  $4 File/dir extension                                        #
# @return Target to create a shared library from objects               #
#======================================================================#
define link-sharedlib-linux
$$(LIBDIR)/$2lib$3.so: $$(SHROBJ) | $$(LIBDIR)
	$$(call status,$$(MSG_CXX_SHRDLIB))
	
	$$(QUIET) $$(call mksubdir,$$(LIBDIR),$2)
	$$(QUIET) $$(CXX) $$(SOFLAGS) -o $$@ \
              $$(call src2obj,$$(wildcard $1$2$3$4*)) 
	
	$$(call ok,$$(MSG_CXX_SHRDLIB))
endef
$(foreach s,$(SHRSRC),\
    $(eval $(call link-sharedlib-linux,$(SRCDIR)/,$(patsubst $(SRCDIR)/%,%,$(dir $s)),$(notdir $(basename $s)),$(or $(suffix $s),/))))

#======================================================================#
# Function: link-statlib-linux                                         #
# @param  $1 Root dir                                                  #
# @param  $2 Subdirectories                                            #
# @param  $3 File/dir basename                                         #
# @param  $4 File/dir extension                                        #
# @return Target to create a static library from objects               #
#======================================================================#
define link-statlib-linux
$$(LIBDIR)/$2lib$3.a: $$(AROBJ) | $$(LIBDIR)
	$$(call status,$$(MSG_STATLIB))
	$$(QUIET) $$(call mksubdir,$$(LIBDIR),$2)
	$$(QUIET) $$(AR) $$(ARFLAGS) $$@ \
              $$(call src2obj,$$(wildcard $1$2$3$4*))
	$$(QUIET) $$(RANLIB) $$@
	$$(call ok,$$(MSG_STATLIB))
endef
$(foreach s,$(ARSRC),\
    $(eval $(call link-statlib-linux,$(SRCDIR)/,$(patsubst $(SRCDIR)/%,%,$(dir $s)),$(notdir $(basename $s)),$(or $(suffix $s),/))))

#======================================================================#
# Function: test-factory                                               #
# @param  $1 Binary name for the unit test module                      #
# @return Target to generate binary file for the unit test             #
#======================================================================#
define test-factory
.PHONY: $$(BINDIR)/$1
$$(BINDIR)/$1: $$(OBJDIR)/$1.o | $$(BINDIR)
	$$(call status,$$(MSG_TEST))
	
	$$(QUIET) $$(call mksubdir,$$(BINDIR),$$@)
	$$(QUIET) $$(CXX) $$^ -o $$@ $$(LDFLAGS) $$(LDLIBS)
	
	@./$$@ $$(NO_OUTPUT) || $$(call shell-error,$$(MSG_TEST_FAILURE))
	
	$$(call ok,$$(MSG_TEST))
endef
$(foreach s,$(basename $(TESTSRC)),$(eval $(call test-factory,$s)))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: mostlyclean
mostlyclean:
	$(call rmdir,$(OBJDIR))

.PHONY: clean
clean: mostlyclean
	$(call rmdir,$(LIBDIR))
	$(call rmdir,$(BINDIR))

.PHONY: distclean
distclean: clean
	$(call rmdir,$(DEPDIR))
	$(call rmdir,$(DISTDIR))

.PHONY: realclean
realclean: distclean
	$(if $(LEXSRC), $(call rm,$(LEXSRC)), $(call ok,$(MSG_LEX_NONE)))
	$(if $(YACCSRC),$(call rm,$(YACCSRC)),$(call ok,$(MSG_YACC_NONE)))

########################################################################
##                             FUNCIONS                               ##
########################################################################
# Directories
$(BINDIR) $(OBJDIR) $(DEPDIR) $(LIBDIR):
	$(call mkdir,$@)

define src2obj
$(addprefix $(OBJDIR)/,       \
    $(patsubst $(SRCDIR)/%,%, \
        $(addsuffix .o,       \
            $(basename $1     \
))))
endef

define rm
	$(call status,$(MSG_RM))
	$(QUIET) $(RM) $1
	$(call ok,$(MSG_RM))
endef

define rmdir
	$(call status,$(MSG_RMDIR))
	$(QUIET) $(RMDIR) $1
	$(call ok,$(MSG_RMDIR))
endef

define mkdir
	$(call status,$(MSG_MKDIR))
	$(QUIET) $(MKDIR) $1
	$(call ok,$(MSG_MKDIR))
endef

define mksubdir
	$(MKDIR) $1/$(patsubst $1/%,%,$(dir $2))
endef

# Function: make-depend
# @param $1 Source name (with path)
# @param $2 Main target to be analised
# @param $3 Dependency file name
define make-depend
$(CXX) -MM                     \
	-MF $(DEPDIR)/$(notdir $3) \
	-MP                        \
	-MT $2                     \
	$(CXXLIBS)                 \
	$(CXXFLAGS)                \
	$1
endef

########################################################################
##                              OUTPUT                                ##
########################################################################

# Hide command execution details
V   ?= 0
Q_0 := @
Q_1 :=
QUIET := $(Q_$V)
O_0 := 1> /dev/null
O_1 := 
NO_OUTPUT := $(O_$V)
E_0 := 2> /dev/null
E_1 := 
NO_ERROR := $(E_$V)

# ANSII Escape Colors
RED     := \033[1;31m
GREEN   := \033[1;32m
YELLOW  := \033[1;33m
BLUE    := \033[1;34m
PURPLE  := \033[1;35m
CYAN    := \033[1;36m
WHITE   := \033[1;37m
RES     := \033[0m

MSG_RM           = "${BLUE}Removing $1${RES}"
MSG_MKDIR        = "${CYAN}Creating directory $1${RES}"
MSG_RMDIR        = "${BLUE}Removing directory $1${RES}"

MSG_LEX          = "${PURPLE}Generating scanner $@${RES}"
MSG_LEX_NONE     = "${PURPLE}No auto-generated lexers${RES}"
MSG_LEX_COMPILE  = "Compiling scanner ${WHITE}$@${RES}"
MSG_YACC         = "${PURPLE}Generating parser $@${RES}"
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

ifneq ($(strip $(QUIET)),)
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
