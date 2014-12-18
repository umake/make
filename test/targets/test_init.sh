#!/bin/bash

# Tests initialization
test \
  "make init" \
  should_raise 0

# Tests if 'make init' creates the right folders
test \
  "make init" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"
