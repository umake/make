#!/bin/bash

test "initialization"\
  "make init" \
  should_raise 0

test "if \"make init\" creates the right folders"\
  "make init" \
  "ls | sort -f" \
  should_output "Config.mk\ndep\ndoc\ninclude\nMakefile\nsrc"
