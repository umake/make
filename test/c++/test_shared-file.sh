#!/usr/bin/env bash

test "the compilation of shared files built with different flags" \
  "cp ../assets/shared_file.cpp.mk Config.mk" \
  "cp ../assets/say_hello.cpp hello1.cpp" \
  "cp ../assets/say_hello.cpp hello2.cpp" \
  "cp ../assets/say_hello.cpp hello3.cpp" \
  "cp ../assets/greetings.hpp ." \
  "cp ../assets/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"

test "the recompilation of a modified main that uses shared files" \
  "cp ../assets/shared_file.cpp.mk Config.mk" \
  "cp ../assets/say_hello.cpp hello1.cpp" \
  "cp ../assets/say_hello.cpp hello2.cpp" \
  "cp ../assets/say_hello.cpp hello3.cpp" \
  "cp ../assets/greetings.hpp ." \
  "cp ../assets/greetings.cpp ." \
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

test "the recompilation of a modified shared file" \
  "cp ../assets/shared_file.cpp.mk Config.mk" \
  "cp ../assets/say_hello.cpp hello1.cpp" \
  "cp ../assets/say_hello.cpp hello2.cpp" \
  "cp ../assets/say_hello.cpp hello3.cpp" \
  "cp ../assets/greetings.hpp ." \
  "cp ../assets/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/greetings.cpp" \
  "$MAKE | grep \"greetings.o\" | wc -l" \
  should_output "3"

test "that there is no unnecessary recompilations when using shared files" \
  "cp ../assets/shared_file.cpp.mk Config.mk" \
  "cp ../assets/say_hello.cpp hello1.cpp" \
  "cp ../assets/say_hello.cpp hello2.cpp" \
  "cp ../assets/say_hello.cpp hello3.cpp" \
  "cp ../assets/greetings.hpp ." \
  "cp ../assets/greetings.cpp ." \
  "$MAKE standard" \
  "$MAKE" \
  "$MAKE | grep \"is up to date\" | wc -l" \
  should_output "3"

test "that there is a recompilation caused by the use of new flags when using shared files" \
  "cp ../assets/shared_file.cpp.mk Config.mk" \
  "cp ../assets/say_hello.cpp hello1.cpp" \
  "cp ../assets/say_hello.cpp hello2.cpp" \
  "cp ../assets/say_hello.cpp hello3.cpp" \
  "cp ../assets/greetings.hpp ." \
  "cp ../assets/greetings.cpp ." \
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
