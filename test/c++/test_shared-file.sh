#!/usr/bin/env bash

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../resources/shared_file.cpp.mk Config.mk" \
  "cp ../resources/say_hello.cpp hello1.cpp" \
  "cp ../resources/say_hello.cpp hello2.cpp" \
  "cp ../resources/say_hello.cpp hello3.cpp" \
  "cp ../resources/greetings.hpp ." \
  "cp ../resources/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"
