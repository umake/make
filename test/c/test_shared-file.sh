#!/usr/bin/env bash

test "the compilation of shared files built with different flags" \
  "cp ../assets/shared_file.c.mk Config.mk" \
  "cp ../assets/say_hello.c hello1.c" \
  "cp ../assets/say_hello.c hello2.c" \
  "cp ../assets/say_hello.c hello3.c" \
  "cp ../assets/greetings.h ." \
  "cp ../assets/greetings.c ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"

test "the recompilation of a modified main that uses shared files" \
  "cp ../assets/shared_file.c.mk Config.mk" \
  "cp ../assets/say_hello.c hello1.c" \
  "cp ../assets/say_hello.c hello2.c" \
  "cp ../assets/say_hello.c hello3.c" \
  "cp ../assets/greetings.h ." \
  "cp ../assets/greetings.c ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/hello1.c" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "touch src/hello2.c" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "touch src/hello3.c" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "cat results.txt" \
  should_output "2\n2\n2"

test "the recompilation of a modified shared file" \
  "cp ../assets/shared_file.c.mk Config.mk" \
  "cp ../assets/say_hello.c hello1.c" \
  "cp ../assets/say_hello.c hello2.c" \
  "cp ../assets/say_hello.c hello3.c" \
  "cp ../assets/greetings.h ." \
  "cp ../assets/greetings.c ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/greetings.c" \
  "$MAKE | grep \"greetings.o\" | wc -l" \
  should_output "3"

test "that there is no unnecessary recompilations when using shared files" \
  "cp ../assets/shared_file.c.mk Config.mk" \
  "cp ../assets/say_hello.c hello1.c" \
  "cp ../assets/say_hello.c hello2.c" \
  "cp ../assets/say_hello.c hello3.c" \
  "cp ../assets/greetings.h ." \
  "cp ../assets/greetings.c ." \
  "$MAKE standard" \
  "$MAKE" \
  "$MAKE | grep \"is up to date\" | wc -l" \
  should_output "3"

test "that there is a recompilation caused by the use of new flags when using shared files" \
  "cp ../assets/shared_file.c.mk Config.mk" \
  "cp ../assets/say_hello.c hello1.c" \
  "cp ../assets/say_hello.c hello2.c" \
  "cp ../assets/say_hello.c hello3.c" \
  "cp ../assets/greetings.h ." \
  "cp ../assets/greetings.c ." \
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
  should_output "0\n0\n3\n3"
