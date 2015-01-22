#!/usr/bin/env bash

test "initialization"\
  "$MAKE init" \
  should_raise 0

test "if \"$MAKE init\" creates the right folders"\
  "$MAKE init" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"
