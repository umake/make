########################################################################
##                             PROGRAM                                ##
########################################################################

# Program settings
BIN := Main

########################################################################
##                              FLAGS                                 ##
########################################################################
# C Options
CEXT     := c
CLIBS    := -Iinclude
CFLAGS   := -Wall -ansi -pedantic -O2

# C++ Options
CXXEXT   := C cc cpp cxx c++ tcc
CXXLIBS  := -Iinclude
CXXFLAGS := -std=gnu++11

# Linker flags
LDFLAGS  := 

########################################################################
##                             PROGRAMS                               ##
########################################################################
CC    := gcc
CXX   := g++
RM    := rm -f
MKDIR := mkdir -p
RMDIR := rm -rf

########################################################################
##                            DIRECTORIES                             ##
########################################################################
SRCDIR := src
BINDIR := bin
DEPDIR := dep
OBJDIR := obj

# Path
VPATH  := $(SRCDIR):$(OBJDIR):$(BINDIR)

########################################################################
##                                 FILES                              ##
########################################################################

# Auxiliar function for deep-search in directory tree
rwildcard = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# Source extensions
SRCEXT := $(CEXT) $(CXXEXT)

# Source files: 
# 1) Find in a directory tree all the source files (with dir names)
# 2) Take out main source file directory
$(foreach EXT,$(SRCEXT),$(eval SRC += $(call rwildcard,$(SRCDIR),*.$(EXT))))
SRC := $(patsubst $(SRCDIR)/%,%,$(SRC))

# Object files
# 1) Add '.o' suffix for each 'naked' source file name (basename)
# 2) Prefix the build dir before each name
OBJ := $(addsuffix .o,$(basename $(SRC)))
OBJ := $(addprefix $(OBJDIR)/,$(OBJ))

########################################################################
##                              BUILD                                 ##
########################################################################
.PHONY: all
all: $(BIN)

$(BIN): $(OBJ) | $(BINDIR)
	$(CXX) $^ -o $(BINDIR)/$@ $(LDFLAGS)

$(OBJ): | $(OBJDIR)

########################################################################
##                              RULES                                 ##
########################################################################

define compile-c
$$(OBJDIR)/%.o: %.c | $$(DEPDIR)
	@# Create dependency files
	# @$$(call make-depend,$$<,$$@,$$(DEPDIR)/$$*.d)
	@$$(call make-depend,$$<,$$@,$$(DEPDIR)/$$(notdir $$*).d)
	
	@# Compile C code
	@$$(call make-dir,$$(OBJDIR),$$<)
	$$(CC) $$(CFLAGS) $$(CLIBS) -c $$< -o $$@
endef
$(foreach EXT,$(CEXT),$(eval $(call compile-c,$(EXT))))

define compile-cpp
$$(OBJDIR)/%.o: %.$1 | $$(DEPDIR)
	@# Create dependency files
	@$$(call make-depend,$$<,$$@,$$(DEPDIR)/$$(notdir $$*).d)
	
	@# Compile C++ code
	@$$(call make-dir,$$(OBJDIR),$$<)
	$$(CXX) $$(CFLAGS) $$(CXXFLAGS) $$(CXXLIBS) -c $$< -o $$@
endef
$(foreach EXT,$(CXXEXT),$(eval $(call compile-cpp,$(EXT))))

# Include dependencies for each src extension
-include $(foreach EXT,$(SRCEXT),$(SRCS:%.$(EXT)=$(DEPDIR)/%.d))

########################################################################
##                              CLEAN                                 ##
########################################################################
.PHONY: clean
clean:
	$(RM) *.o
	$(RMDIR) $(OBJDIR)

.PHONY: distclean
distclean: clean
	$(RMDIR) $(BINDIR) $(DEPDIR)

########################################################################
##                             FUNCIONS                               ##
########################################################################
# Directories
$(BINDIR) $(OBJDIR) $(DEPDIR):
	$(MKDIR) $@

define make-dir
	$(MKDIR) $1/$(patsubst $(SRCDIR)/%,%,$(dir $2))
endef

define make-depend
$(CXX) -MM      \
	-MF $3      \
	-MP         \
	-MT $2      \
	$(CFLAGS)   \
	$(CXXFLAGS) \
	$(CXXLIBS)  \
	$1
endef
