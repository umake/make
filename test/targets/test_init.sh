#!/usr/bin/env bash

test "if 'init' works"\
  "$MAKE init" \
  should_raise 0

test "if 'init' creates the right folders"\
  "$MAKE init" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"
