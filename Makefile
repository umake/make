########################################################################
##                             PROGRAM                                ##
########################################################################

# Project setting 
PROJECT := Robot-Battle

# Program settings
BIN    := Main
ARLIB  := 
SHRLIB := math.cpp

########################################################################
##                              FLAGS                                 ##
########################################################################
						 
# C Options
CEXT     := .c
CFLAGS   := -Wall -ansi -pedantic -O2 -g

# C++ Options
CXXEXT   := .C .cc .cpp .cxx .c++ .tcc
CXXFLAGS := $(CFLAGS) -std=gnu++11

# Linker flags
LDFLAGS  :=

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

TRUE := 1

# Parser and Lexer
LEX        := $(if TRUE,flex++,flex)
LEXFLAGS   := 
YACC       := $(if TRUE,bison++,bison)
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

########################################################################
##                              PATHS                                 ##
########################################################################

LEXEXT  := .l
YACCEXT := .y

# Source extensions
SRCEXT := $(CEXT) $(CXXEXT)

# Path
vpath %        $(BINDIR) # All binaries in bindir
vpath lib%.a   $(LIBDIR) # All static libs in libdir
vpath lib%.so  $(LIBDIR) # All shared libs in libdir
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
$(foreach E,$(CEXT),  $(eval CSRC   += $(call rwildcard,$(SRCDIR),*$E)))
$(foreach E,$(CXXEXT),$(eval CXXSRC += $(call rwildcard,$(SRCDIR),*$E)))

# Library files:
LIB := $(ARLIB) $(SHRLIB)

# Lexical analyzer
# 1) Find in a directory tree all the lex files (with dir names)
# 2) Change lex extension to format .yy.c
$(foreach E,$(LEXEXT),$(eval LEXSRC += $(call rwildcard,$(SRCDIR),*$E)))
ext     := $(if $(CXXEXT),cc,c)
LEXSRC  := $(foreach E,$(LEXEXT),$(patsubst %$E,%.yy.$(ext),$(LEXSRC)))
LDFLAGS += -lfl # Flex default library

# Syntatic analyzer
# 1) Find in a directory tree all the lex files (with dir names)
# 2) Change lex extension to format .yy.c
$(foreach E,$(YACCEXT),$(eval YACCSRC += $(call rwildcard,$(SRCDIR),*$E)))
ext     := $(if $(CXXEXT),cc,c)
YACCSRC := $(foreach E,$(YACCEXT),$(patsubst %$E,%.tab.$(ext),$(YACCSRC)))

# Source files:
# 1) Find in a directory tree all the source files (with dir names)
# 2) Remove src root directory name from all sources
# 3) Save complete paths for libraries
# 3) Remove library paths from ordinary src
SRC := $(CSRC) $(CXXSRC)
LIB := $(foreach l,$(LIB),$(filter %$l,$(SRC)))
SRC := $(foreach l,$(LIB),$(filter-out %$l,$(SRC)))
SRC += $(LEXSRC) $(YACCSRC)
SRC := $(foreach ROOT,$(SRCDIR),$(patsubst $(ROOT)/%,%,$(SRC)))

# Static libraries:
# 1) Set flags to create static lib
# 2) Get static library paths from all libraries (src)
# 3) Create analogous object files from it
# 4) Change names to lib%.a
ARFLAGS ?= -rcv
ARSRC   := $(foreach a,$(ARLIB),$(filter %$(a),$(LIB)))
AROBJ   := $(patsubst %.c,$(OBJDIR)/%.o,$(ARSRC))
ARLIB   := $(patsubst %,$(LIBDIR)/lib%.a,$(notdir $(basename $(ARSRC))))
LDFLAGS += $(addprefix -l,$(notdir $(basename $(ARSRC))))

# Dynamic libraries:
# 1) Set flags to create shared lib
# 2) Get static library paths from all libraries (src)
# 3) Create analogous object files from it
# 4) Change names to lib%.so
SOFLAGS += -shared -Wl,-rpath=$(LIBDIR)
SHRSRC  := $(foreach so,$(SHRLIB),$(filter %$(so),$(LIB)))
SHROBJ  := $(patsubst %.c,$(OBJDIR)/%.o,$(SHRSRC))
SHRLIB  := $(patsubst %,$(LIBDIR)/lib%.so,$(notdir $(basename $(SHRLIB))))
LDFLAGS += $(addprefix -l,$(notdir $(basename $(SHRSRC))))

# Object files:
# 1) Add '.o' suffix for each 'naked' source file name (basename)
# 2) Prefix the build dir before each name
OBJ := $(addsuffix .o,$(basename $(SRC)))
OBJ := $(addprefix $(OBJDIR)/,$(OBJ))

# Header files:
# 1) Get all subdirectories of the included dirs
# 2) Add them as paths to be searched for headers
# INCSUB  := $(sort $(dir $(foreach I,$(INCDIR),$(call rwildcard,$I,*))))
INCSUB  := $(call rsubdir,$(INCDIR))
CLIBS   := $(patsubst %,-I%,$(INCSUB))
CXXLIBS := $(patsubst %,-I%,$(INCSUB))

# Library files:
# 1) Get all subdirectories of the library dirs
# 2) Add them as paths to be searched for libraries
LIBSUB = $(call rsubdir,$(LIBDIR))
LDLIBS = $(sort $(patsubst %/,%,$(patsubst %,-L%,$(LIBSUB))))

# Binary:
# 1) Find out if any source is C++ code, and then make this binary
IS_CXX := $(foreach EXT,$(CXXEXT),$(findstring $(EXT),$(SRC)))

########################################################################
##                              BUILD                                 ##
########################################################################

.PHONY: all
all: $(BIN)

.PHONY: dist
dist: $(DISTDIR)/$(PROJECT).tar.gz

.PHONY: tar
tar: $(DISTDIR)/$(PROJECT).tar

.PHONY: test
test:
	@echo $(ext)
	@echo $(SRC)
	@echo $(OBJ)
	@echo $(LEXSRC)
	@echo $(YACCSRC)

ifneq ($(IS_CXX),)
$(BIN): $(OBJ) | $(ARLIB) $(SHRLIB) $(BINDIR)
	$(call status,$(MSG_CXX_LINKAGE))
	$(QUIET) $(CXX) $^ -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS)
	$(call ok,$(MSG_CXX_LINKAGE))
else
$(BIN): $(OBJ) | $(ARLIB) $(SHRLIB) $(BINDIR)
	$(call status,$(MSG_CXX_LINKAGE))
	$(QUIET) $(CC) $^ -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS)
	$(call ok,$(MSG_CXX_LINKAGE))
endif

$(OBJ): | $(OBJDIR)

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

# %.yy.$(if $(IS_CXX),cc,c): %.l $(YACCSRC)
%.yy.c %.yy.cc: %.l $(YACCSRC)
	$(call vstatus,$(MSG_YACC))
	$(QUIET) $(LEX) $(LEXFLAGS) -o$@ $< 
	$(call ok,$(MSG_YACC))
	
%.tab.cc %.tab.c: %.y
	$(call vstatus,$(MSG_LEX))
	$(QUIET) $(YACC) $(YACCFLAGS) $< -o $@ 
	$(call ok,$(MSG_LEX))

define compile-c
$$(OBJDIR)/%.o: $$(SRCDIR)/%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*)         
	$$(QUIET) $$(call make-dir,$$(OBJDIR),$$<)         
	$$(QUIET) $$(CC) $$(CFLAGS) $$(CLIBS) -c $$< -o $$@
	
	$$(call ok,$$(MSG_C_COMPILE))
endef
$(foreach EXT,$(CEXT),$(eval $(call compile-c,$(EXT))))

define compile-cpp
$$(OBJDIR)/%.o: CXX_FLAGS = $$(CXXLIBS) $$(CXXFLAGS) 
$$(OBJDIR)/%.o: $$(SRCDIR)/%$1 | $$(DEPDIR)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*.d) 
	$$(QUIET) $$(call make-dir,$$(OBJDIR),$$<)   
	$$(QUIET) $$(CXX) $$(CXX_FLAGS) -c $$< -o $$@
	
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

define sharedlib-c
$$(LIBDIR)/lib%.so: C_FLAGS = $$(CLIBS) -fPIC $$(CFLAGS)
$$(LIBDIR)/lib%.so: $$(filter %$1,$$(SHRSRC)) | $$(LIBDIR)
	$$(call status,$$(MSG_C_SHRDLIB))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*)
	$$(QUIET) $$(call make-dir,$$(OBJDIR),$$<)
	$$(QUIET) $$(CC) $$(C_FLAGS) -c $$< -o $$(OBJDIR)/$$*.o
	$$(QUIET) $$(CC) $$(SOFLAGS) $$(OBJDIR)/$$*.o -o $$@
	
	$$(call ok,$$(MSG_C_SHRDLIB))
endef
$(foreach EXT,$(CEXT),$(eval $(call sharedlib-c,$(EXT))))

define sharedlib-cpp
$$(LIBDIR)/lib%.so: CXX_FLAGS = $$(CXXLIBS) -fPIC $$(CXXFLAGS) 
$$(LIBDIR)/lib%.so: $$(filter %$1,$$(SHRSRC)) | $$(LIBDIR)
	$$(call status,$$(MSG_CXX_SHRDLIB))
	
	$$(QUIET) $$(call make-depend,$$<,$$@,$$*)
	$$(QUIET) $$(call make-dir,$$(OBJDIR),$$<)
	$$(QUIET) $$(CXX) $$(CXX_FLAGS) -c $$< -o $$(OBJDIR)/$$*.o
	$$(QUIET) $$(CXX) $$(SOFLAGS) $$(OBJDIR)/$$*.o -o $$@
	
	$$(call ok,$$(MSG_CXX_SHRDLIB))
endef
$(foreach EXT,$(CXXEXT),$(eval $(call sharedlib-cpp,$(EXT))))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: clean
clean:
	$(call rmdir,$(OBJDIR))

.PHONY: distclean
distclean: clean
	$(call rmdir,$(DEPDIR))
	$(call rmdir,$(LIBDIR))
	$(call rmdir,$(BINDIR))
	$(call rmdir,$(DISTDIR))

.PHONY: realclean
realclean: distclean
	$(call rm,$(LEXSRC))
	$(call rm,$(YACCSRC))

########################################################################
##                             FUNCIONS                               ##
########################################################################
# Directories
$(BINDIR) $(OBJDIR) $(DEPDIR) $(LIBDIR):
	$(call mkdir,$@)

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

define make-dir
	$(MKDIR) $1/$(patsubst $(SRCDIR)/%,%,$(dir $2))
endef

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

ifneq ($(strip $(QUIET)),)
MSG_RM          = "${BLUE}Removing $1${RES}"
MSG_MKDIR       = "${CYAN}Creating directory $1${RES}"
MSG_RMDIR       = "${BLUE}Removing directory $1${RES}"

MSG_LEX         = "${PURPLE}Generating $(LEX) src $@${RES}"
MSG_YACC        = "${PURPLE}Generating $(YACC) src $@${RES}"

MSG_STATLIB     = "${RED}Generating static library $@${RES}"
MSG_MAKETAR     = "${RED}Generating tar file $@${RES}"
MSG_MAKETGZ     = "${RED}Ziping file $@${RES}"

MSG_C_COMPILE   = "Generating C artifact ${WHITE}$@${RES}"
MSG_C_LINKAGE   = "${YELLOW}Generating C executable ${GREEN}$@${RES}"
MSG_C_SHRDLIB   = "${RED}Generating C shared library $@${RES}"

MSG_CXX_COMPILE = "Generating C++ artifact ${WHITE}$@${RES}"
MSG_CXX_LINKAGE = "${YELLOW}Generating C++ executable ${GREEN}$@${RES}"
MSG_CXX_SHRDLIB = "${RED}Generating C++ shared library $@${RES}"
endif

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
