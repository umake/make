#!/usr/bin/env bash

test "the compilation of shared files built with different flags" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"

test "the recompilation of a modified program that uses shared files" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/hello1.f" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "touch src/hello2.f" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "touch src/hello3.f" \
  "$MAKE | grep \"is up to date\" | wc -l >> results.txt" \
  "cat results.txt" \
  should_output "2\n2\n2"

test "the recompilation of a modified shared file" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "touch src/greetings.f" \
  "$MAKE | grep \"greetings.o\" | wc -l" \
  should_output "3"

test "that there is no unnecessary recompilations when using shared files" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "$MAKE | grep \"is up to date\" | wc -l" \
  should_output "3"

test "that there is a recompilation caused by the use of new flags when using shared files" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
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
  should_output "0\n3\n3\n0"
