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
ARLIB  := math
SHRLIB := 

########################################################################
##                              FLAGS                                 ##
########################################################################
						 
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
CC         := gcc
CXX        := g++
RANLIB     := ranlib

# File manipulation
CP 		   := cp -rap
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

# Auxiliar functions:
# * rsubdir  : For listing all subdirectories of a given dir
# * rwildcard: For wildcard deep-search in the directory tree
rsubdir   = $(foreach d,$1,$(shell $(FIND) $d $(FIND_FLAGS)))
rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2)$(filter $(subst *,%,$2),$d)) 

# C and C++ code
# $(foreach E,$(CEXT),  $(eval CSRC   += $(call rwildcard,$(SRCDIR),*$E)))
# $(foreach E,$(CXXEXT),$(eval CXXSRC += $(call rwildcard,$(SRCDIR),*$E)))

# Library files:
# 1) Store libraries as being shared and static libs
# 2) Check if any name is invalid (there is only a suffix)
LIB := $(ARLIB) $(SHRLIB)

# TODO: Find a better way of remove all this things
ARLIB := $(foreach s,$(ARLIB),$(if $(or $(call not $(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))
SHRLIB := $(foreach s,$(SHRLIB),$(if $(or $(call not $(dir $s)),$(suffix $s),$(notdir $(basename $s))),$s,$(patsubst %/,%,$s)))

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
LIB := $(patsubst $(SRCDIR)/%,%,$(LIB))

# Lexical analyzer
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
LDFLAGS  += -lfl

# Syntatic analyzer
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
AUTOSRC := $(YACCSRC) $(LEXSRC)

# Source files:
# 1) Find in a directory tree all the source files (with dir names)
# 2) Remove src root directory name from all sources
# 3) Save complete paths for libraries
# 4) Remove library paths from ordinary src
$(foreach E,$(SRCEXT),$(eval SRC += $(call rwildcard,$(SRCDIR),*$E)))
LIB := $(foreach l,$(LIB),$(or $(filter %$l,$(SRC)),$(SRCDIR)/$l) )
SRC := $(foreach l,$(LIB),$(filter-out %$l,$(SRC)))
SRC := $(sort $(foreach ROOT,$(SRCDIR),$(patsubst $(ROOT)/%,%,$(SRC))))

# Static libraries:
# 1) Set flags to create static lib
# 2) Get static library paths from all libraries (src)
# 3) Create analogous object files from it
# 4) Change names to lib%.a
ARFLAGS ?= -rcv
ARSRC   := $(foreach a,$(ARLIB),$(filter %$a,$(LIB)))
ARALL   := $(foreach s,$(ARSRC),$(if $(suffix $s),$s,$(wildcard $s/*)))
ARALL   := $(patsubst $(SRCDIR)/%,%,$(ARALL))
AROBJ   := $(patsubst %.c,$(OBJDIR)/%.o,$(ARALL))
# ARLIB   := $(patsubst %,$(LIBDIR)/lib%.a,$(notdir $(basename $(ARSRC))))
ARLIB   := $(foreach s,$(ARSRC),\
               $(patsubst $(dir $s)%,$(dir $s)lib%,$s))
ARLIB   := $(patsubst $(SRCDIR)/%,$(LIBDIR)/%,$(ARLIB))
ARLIB   := $(addsuffix .so,$(basename $(ARLIB)))
LDFLAGS += $(addprefix -l,$(notdir $(basename $(ARSRC))))

# Dynamic libraries:
# 1) Set flags to create shared lib
# 2) Take out last 
# 2) Get static library paths from all libraries (src)
# 3) Create analogous object files from it
# 4) Change names to lib%.so
SOFLAGS += -shared 
LDFLAGS := -Wl,-rpath=$(LIBDIR) $(LDFLAGS)
SHRSRC  := $(foreach s,$(SHRLIB),$(filter %$s,$(LIB)))
SHRALL  := $(foreach s,$(SHRSRC),$(if $(suffix $s),$s,$(wildcard $s/*)))
SHRALL  := $(patsubst $(SRCDIR)/%,%,$(SHRALL))
SHROBJ  := $(patsubst %,$(OBJDIR)/%.o,$(basename $(SHRALL)))
SHRLIB  := $(foreach s,$(SHRSRC),\
               $(patsubst $(dir $s)%,$(dir $s)lib%,$s))
SHRLIB  := $(patsubst $(SRCDIR)/%,$(LIBDIR)/%,$(SHRLIB))
SHRLIB  := $(addsuffix .so,$(basename $(SHRLIB)))
LDFLAGS += $(addprefix -l,$(notdir $(basename $(SHRSRC))))

# Object files:
# 1) Add '.o' suffix for each 'naked' source file name (basename)
# 2) Prefix the build dir before each name
OBJ := $(addsuffix .o,$(basename $(SRC)))
OBJ := $(addprefix $(OBJDIR)/,$(OBJ))

# Header files:
# 1) Get all subdirectories of the included dirs
# 2) Add them as paths to be searched for headers
INCSUB  := $(call rsubdir,$(INCDIR))
CLIBS   := $(patsubst %,-I%,$(INCSUB))
CXXLIBS := $(patsubst %,-I%,$(INCSUB))

# Library files:
# 1) Get all subdirectories of the library dirs
# 2) Add them as paths to be searched for libraries
LIBSUB = $(call rsubdir,$(LIBDIR))
LDLIBS = $(sort $(patsubst %/,%,$(patsubst %,-L%,$(LIBSUB))))

# Automated tests:
# 1) Get all source files in the test directory
$(foreach E,$(SRCEXT),$(eval TESTSRC += $(call rwildcard,$(TESTDIR),*_tests$E)))
TESTOBJ := $(addsuffix .o,$(basename $(TESTSRC)))
TESTBIN := $(strip $(basename $(TESTSRC)))

# Binary:
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

# TODO: Remove tests
.PHONY: test
test: 
	@echo "base up:  " $(patsubst $(SRCDIR)/%,%,$(dir src/math))
	@echo "Src:      " $(SRC)
	@echo "Lib:      " $(LIB)
	@echo "shrsrc:   " $(ARSRC)
	@echo "shrobj:   " $(AROBJ)
	@echo "shrlib:   " $(ARLIB)
	@echo "shrall:   " $(ARALL)
	@echo "path:     " $(foreach s,$(ARSRC),$(dir $s))
	@echo "main:     " $(foreach s,$(ARSRC),$(notdir $(basename $s)))
	@echo "suffix:   " $(foreach s,$(ARSRC),$(or $(suffix $s),/))
	@echo "wildcard: " $(foreach s,$(ARSRC),$(wildcard $s/*))

ifneq ($(IS_CXX),)
$(BIN): $(OBJ) | $(ARLIB) $(SHRLIB) $(BINDIR)
	$(call status,$(MSG_CXX_LINKAGE))
	$(QUIET) $(CXX) $^ -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS)
	$(call ok,$(MSG_CXX_LINKAGE))
else
$(BIN): $(OBJ) | $(ARLIB) $(SHRLIB) $(BINDIR)
	$(call status,$(MSG_C_LINKAGE))
	$(QUIET) $(CC) $^ -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS)
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

# TODO: Create test-factory
# define test-factory
# $1: $1.o | $$(BINDIR)
	# $$(QUIET) $$(call mksubdir,$$(OBJDIR),$$<)   
	# $$(QUIET) $$(CXX) $$^ -o $$(BINDIR)/$$@ $$(LDFLAGS) $$(LDLIBS)
# endef

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

define compile-c
$$(OBJDIR)/%.o: $$(SRCDIR)/%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*)         
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$$*$1)         
	$$(QUIET) $$(CC) $$(CFLAGS) $$(CLIBS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_COMPILE))
endef
$(foreach EXT,$(CEXT),$(eval $(call compile-c,$(EXT))))

define compile-cpp
$$(OBJDIR)/%.o: $$(SRCDIR)/%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*.d) 
	$$(QUIET) $$(call mksubdir,$$(OBJDIR),$$*$1)   
	$$(QUIET) $$(CXX) $$(CXXLIBS) $$(CXXFLAGS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_CXX_COMPILE))
endef
$(foreach EXT,$(CXXEXT),$(eval $(call compile-cpp,$(EXT))))

# Include dependencies for each src extension
-include $(DEPDIR)/*.d

.SECONDARY: $(filter %.o,$(AROBJ))
$(LIBDIR)/lib%.a: $(filter %.o,$(AROBJ)) | $(LIBDIR)
	$(call status,$(MSG_STATLIB))
	$(QUIET) $(AR) $(ARFLAGS) $@ $<
	$(QUIET) $(RANLIB) $@
	$(call ok,$(MSG_STATLIB))

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

define link-sharedlib-linux
$$(LIBDIR)/$2lib$3.so: $$(SHROBJ) | $$(LIBDIR)
	$$(call status,$$(MSG_CXX_SHRDLIB))
	
	@#echo 
	@#echo 1:$1 2:$2 3:$3 4:$4
	@#echo $1$2$3$4
	@echo $$(wildcard $1$2$3$4*)
	$$(QUIET) $$(call mksubdir,$$(LIBDIR),$2)
	$$(QUIET) $$(CXX) $$(SOFLAGS) $$(call src2obj,$$(wildcard $1$2$3$4*)) -o $$@
	
	$$(call ok,$$(MSG_CXX_SHRDLIB))
endef
$(foreach s,$(SHRSRC),\
    $(eval $(call link-sharedlib-linux,$(SRCDIR)/,$(patsubst $(SRCDIR)/%,%,$(dir $s)),$(notdir $(basename $s)),$(or $(suffix $s),/))))

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
	$(MKDIR) $1/$(dir $2)
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
QUIET := $(Q_$(V))

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

MSG_STATLIB      = "${RED}Generating static library $@${RES}"
MSG_MAKETAR      = "${RED}Generating tar file $@${RES}"
MSG_MAKETGZ      = "${RED}Ziping file $@${RES}"

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

define ok
	@echo "\r${GREEN}[OK]${RES}" $1 "     "
endef
