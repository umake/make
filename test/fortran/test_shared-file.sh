#!/usr/bin/env bash

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../resources/shared_file.f.mk Config.mk" \
  "cp ../resources/say_hello.f hello1.f" \
  "cp ../resources/say_hello.f hello2.f" \
  "cp ../resources/say_hello.f hello3.f" \
  "cp ../resources/greetings.f ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"
