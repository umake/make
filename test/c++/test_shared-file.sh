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

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../resources/shared_file.cpp.mk Config.mk" \
  "cp ../resources/say_hello.cpp hello1.cpp" \
  "cp ../resources/say_hello.cpp hello2.cpp" \
  "cp ../resources/say_hello.cpp hello3.cpp" \
  "cp ../resources/greetings.hpp ." \
  "cp ../resources/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "$MAKE | grep \"is up to date\" | wc -l" \
  should_output "3"

test "if \"$MAKE\" rebuilds only the touched main in 2nd recompilation" \
  "cp ../resources/shared_file.cpp.mk Config.mk" \
  "cp ../resources/say_hello.cpp hello1.cpp" \
  "cp ../resources/say_hello.cpp hello2.cpp" \
  "cp ../resources/say_hello.cpp hello3.cpp" \
  "cp ../resources/greetings.hpp ." \
  "cp ../resources/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/hello1.cpp" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "touch src/hello2.cpp" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "touch src/hello3.cpp" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "cat results.txt" \
  should_output "2\n2\n2"

test "if \"$MAKE\" rebuilds the touched shared file in 2nd recompilation" \
  "cp ../resources/shared_file.cpp.mk Config.mk" \
  "cp ../resources/say_hello.cpp hello1.cpp" \
  "cp ../resources/say_hello.cpp hello2.cpp" \
  "cp ../resources/say_hello.cpp hello3.cpp" \
  "cp ../resources/greetings.hpp ." \
  "cp ../resources/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/greetings.cpp" \
  "$MAKE | grep \"greetings.o\" | wc -l" \
  should_output "3"

test "if \"$MAKE\" rebuilds correctly in 2nd recompilation with args" \
  "cp ../resources/shared_file.cpp.mk Config.mk" \
  "cp ../resources/say_hello.cpp hello1.cpp" \
  "cp ../resources/say_hello.cpp hello2.cpp" \
  "cp ../resources/say_hello.cpp hello3.cpp" \
  "cp ../resources/greetings.hpp ." \
  "cp ../resources/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "$MAKE CPPFLAGS=-Dbla | grep \"is up to date\" | wc -l >> results.txt" \
  "$MAKE" \
  "$MAKE CFLAGS=-Wall   | grep \"is up to date\" | wc -l >> results.txt" \
  "$MAKE" \
  "$MAKE CXXFLAGS=-Wall | grep \"is up to date\" | wc -l >> results.txt" \
  "$MAKE" \
  "$MAKE FFLAGS=-Wall   | grep \"is up to date\" | wc -l >> results.txt" \
  "$MAKE" \
  "cat results.txt" \
  should_output "0\n3\n0\n3"
