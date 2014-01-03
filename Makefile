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
CEXT     := c
HEXT     := h
CFLAGS   := -Wall -ansi -pedantic -O2

# C++ Options
CXXEXT   := C cc cpp cxx c++ tcc
HXXEXT   := H hh hpp hxx h++
CXXFLAGS := -std=gnu++11

# Libraries options

# Linker flags
LDFLAGS  :=

########################################################################
##                             PROGRAMS                               ##
########################################################################
AR         := ar
CC         := gcc
CXX        := g++
RM         := rm -f
MKDIR      := mkdir -p
RMDIR      := rm -rf
FIND       := find
FIND_FLAGS := -type d -print
ECHO       := echo
TAR        := tar -cvf
ZIP        := gzip

########################################################################
##                            DIRECTORIES                             ##
########################################################################
SRCDIR := src
BINDIR := bin
DEPDIR := dep
OBJDIR := obj
INCDIR := include
LIBDIR := lib
DISDIR := dist

########################################################################
##                              PATHS                                 ##
########################################################################

# Source extensions
SRCEXT := $(CEXT) $(CXXEXT)
INCEXT := $(HEXT) $(HXXEXT)

# Path
vpath %       $(BINDIR) # All binaries in bindir
vpath lib%.a  $(LIBDIR) # All static libs in libdir
vpath lib%.so $(LIBDIR) # All shared libs in libdir
$(foreach d,$(SRCDIR),$(foreach e,$(SRCEXT),$(eval vpath %.$e $d)))

########################################################################
##                              FILES                                 ##
########################################################################

# Auxiliar functions:
# * rsubdir  : For listing all subdirectories of a given dir
# * rwildcard: For wildcard deep-search in the directory tree
rsubdir   = $(foreach d,$1,$(shell $(FIND) $d $(FIND_FLAGS)))
rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2)$(filter $(subst *,%,$2),$d)) 

# Library files:
LIB := $(ARLIB) $(SHRLIB)

# Source files:
# 1) Find in a directory tree all the source files (with dir names)
# 2) Remove src root directory name from all sources
# 3) Save complete paths for libraries
# 3) Remove library paths from ordinary src
$(foreach EXT,$(SRCEXT),$(eval SRC += $(call rwildcard,$(SRCDIR),*.$(EXT))))
SRC := $(foreach ROOT,$(SRCDIR),$(patsubst $(ROOT)/%,%,$(SRC)))
LIB := $(foreach l,$(LIB),$(filter %$l,$(SRC)))
SRC := $(foreach l,$(LIB),$(filter-out %$l,$(SRC)))

# Static libraries:
# 1) Set flags to create static lib
# 2) Get static library paths from all libraries (src)
# 3) Create analogous object files from it
# 4) Change names to lib%.a
ARFLAGS ?= -rcv
ARSRC   := $(foreach a,$(ARLIB),$(filter %$(a),$(LIB)))
AROBJ   := $(patsubst %.c,$(OBJDIR)/%.o,$(ARSRC))
ARLIB   := $(patsubst %,lib%.a,$(notdir $(basename $(ARSRC))))
LDFLAGS += $(addprefix -l,$(notdir $(basename $(ARSRC))))

# Dynamic libraries:
# 1) Set flags to create shared lib
# 2) Get static library paths from all libraries (src)
# 3) Create analogous object files from it
# 4) Change names to lib%.so
SOFLAGS += -shared -Wl,-rpath=$(LIBDIR)
SHRSRC  := $(foreach so,$(SHRLIB),$(filter %$(so),$(LIB)))
SHROBJ  := $(patsubst %.c,$(OBJDIR)/%.o,$(SHRSRC))
SHRLIB  := $(patsubst %,lib%.so,$(notdir $(basename $(SHRLIB))))
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

########################################################################
##                              BUILD                                 ##
########################################################################

.PHONY: all
# all: $(BIN)

# .PHONY: dist
all: $(PROJECT).tar.gz

.PHONY: tar
tar: $(PROJECT).tar

$(BIN): $(OBJ) | $(ARLIB) $(SHRLIB) $(BINDIR)
	$(call status,$(MSG_CXX_LINKAGE))
	$(call check, $(CXX) $^ -o $(BINDIR)/$@ $(LDFLAGS) $(LDLIBS) )
	$(call ok,$(MSG_CXX_LINKAGE))

$(OBJ): | $(OBJDIR)

########################################################################
##                              RULES                                 ##
########################################################################

%.tar.gz: %.tar
	$(call status,$(MSG_MAKETGZ))
	$(call check, $(ZIP) $(DISDIR)/$< )
	$(call ok,$(MSG_MAKETGZ))

%.tar: $(DISDIR) $(BIN) 
	$(call status,$(MSG_MAKETAR))
	$(call check, $(TAR) $(DISDIR)/$@ $(LIBDIR) $(BINDIR) )
	$(call ok,$(MSG_MAKETAR))

define compile-c
$$(OBJDIR)/%.o: %.c | $$(DEPDIR)
	$$(call status,$$(MSG_C_COMPILE))
	
	$$(call check, $$(call make-depend,$$<,$$@,$$*)          )
	$$(call check, $$(call make-dir,$$(OBJDIR),$$<)          )
	$$(call check, $$(CC) $$(CFLAGS) $$(CLIBS) -c $$< -o $$@ )
	
	$$(call ok,$$(MSG_C_COMPILE))
endef
$(foreach EXT,$(CEXT),$(eval $(call compile-c,$(EXT))))

define compile-cpp
$$(OBJDIR)/%.o: CXX_FLAGS = $$(CFLAGS) $$(CXXFLAGS) $$(CXXLIBS) 
$$(OBJDIR)/%.o: %.$1 | $$(DEPDIR)
	$$(call status,$$(MSG_CXX_COMPILE))
	
	$$(call check, $$(call make-depend,$$<,$$@,$$*.d)   )
	$$(call check, $$(call make-dir,$$(OBJDIR),$$<)     )
	$$(call check, $$(CXX) $$(CXX_FLAGS) -c $$< -o $$@  )
	
	$$(call ok,$$(MSG_CXX_COMPILE))
endef
$(foreach EXT,$(CXXEXT),$(eval $(call compile-cpp,$(EXT))))

# Include dependencies for each src extension
-include $(DEPDIR)/*.d

.SECONDARY: $(filter %.o,$(AROBJ))
lib%.a: $(filter %.o,$(AROBJ)) | $(LIBDIR)
	$(call status,$(MSG_STATLIB) ...)
	$(call check, $(AR) $(ARFLAGS) $(LIBDIR)/$@ $< )
	$(call ok,$(MSG_STATLIB))

define sharedlib-c
lib%.so: C_FLAGS = $$(CFLAGS) $$(CLIBS) 
lib%.so: $$(filter %.$1,$$(SHRSRC)) | $$(LIBDIR)
	$$(call status,$$(MSG_C_SHRDLIB))
	
	$$(call check, $$(call make-depend,$$<,$$@,$$*)    )
	$$(call check, $$(call make-dir,$$(OBJDIR),$$<)    )
	$$(call check, $$(CC) -fPIC $$(C_FLAGS) -c $$< -o $$(OBJDIR)/$$*.o   )
	$$(call check, $$(CC) -o $$(LIBDIR)/$$@ $$(SOFLAGS) $$(OBJDIR)/$$*.o )
	
	$$(call ok,$$(MSG_C_SHRDLIB))
endef
$(foreach EXT,$(CEXT),$(eval $(call sharedlib-c,$(EXT))))

define sharedlib-cpp
lib%.so: CXX_FLAGS = $$(CFLAGS) $$(CXXFLAGS) $$(CXXLIBS) 
lib%.so: $$(filter %.$1,$$(SHRSRC)) | $$(LIBDIR)
	$$(call status,$$(MSG_CXX_SHRDLIB))
	
	$$(call check, $$(call make-depend,$$<,$$@,$$*) )
	$$(call check, $$(call make-dir,$$(OBJDIR),$$<) )
	$$(call check, $$(CXX) -fPIC $$(CXX_FLAGS) -c $$< -o $$(OBJDIR)/$$*.o )
	$$(call check, $$(CXX) -o $$(LIBDIR)/$$@ $$(SOFLAGS) $$(OBJDIR)/$$*.o )
	
	$$(call ok,$$(MSG_CXX_SHRDLIB))
endef
$(foreach EXT,$(CXXEXT),$(eval $(call sharedlib-cpp,$(EXT))))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: clean
clean:
	$(RM) *.o
	$(RMDIR) $(OBJDIR)

.PHONY: distclean
distclean: clean
	$(RMDIR) $(BINDIR) $(DEPDIR) $(LIBDIR) $(DISDIR)

########################################################################
##                             FUNCIONS                               ##
########################################################################
# Directories
$(BINDIR) $(OBJDIR) $(DEPDIR) $(LIBDIR) $(DISDIR):
	$(call status,$(MSG_MAKEDIR))
	$(call check, $(MKDIR) $@ )
	$(call ok,$(MSG_MAKEDIR))

define make-dir
	$(MKDIR) $1/$(patsubst $(SRCDIR)/%,%,$(dir $2))
endef

define make-depend
$(CXX) -MM                     \
	-MF $(DEPDIR)/$(notdir $3) \
	-MP                        \
	-MT $2                     \
	$(CFLAGS)                  \
	$(CXXFLAGS)                \
	$(CXXLIBS)                 \
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
MSG_MAKEDIR     = "${CYAN}Creating directory $@${RES}"
MSG_STATLIB     = "${RED}Generating static library $@${RES}"
MSG_MAKETAR     = "${RED}Generating tar file $@${RES}"
MSG_MAKETGZ     = "${RED}Ziping file $@${RES}"

MSG_C_COMPILE   = "Generating C artifact ${WHITE}$@${RES}"
MSG_C_LINKAGE   = "${BLUE}Generating C executable ${GREEN}$@${RES}"
MSG_C_SHRDLIB   = "${RED}Generating C shared library $@${RES}"

MSG_CXX_COMPILE = "Generating C++ artifact ${WHITE}$@${RES}"
MSG_CXX_LINKAGE = "${BLUE}Generating C++ executable ${GREEN}$@${RES}"
MSG_CXX_SHRDLIB = "${RED}Generating C++ shared library $@${RES}"
endif

# Check error status
define check
	$(QUIET) $1 || ($(call Error) && exit 2)
endef

ifneq ($(strip $(QUIET)),)
    define status
    	@$(ECHO) -n $1 " ..."
    endef
endif

define Error
	$(ECHO) -n "${RED}[ERROR]${RES} "
endef

define warn
	$(ECHO) " ${YELLOW}[WARNING]${RES} "
endef

define ok
	@$(ECHO) "\r${GREEN}[OK]${RES}" $1 "     "
endef
