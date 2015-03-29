#!/usr/bin/env bash

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../resources/shared_file.c.mk Config.mk" \
  "cp ../resources/say_hello.c hello1.c" \
  "cp ../resources/say_hello.c hello2.c" \
  "cp ../resources/say_hello.c hello3.c" \
  "cp ../resources/greetings.h ." \
  "cp ../resources/greetings.c ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"
