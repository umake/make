#!/usr/bin/env bash

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../assets/shared_file.c.mk Config.mk" \
  "cp ../assets/say_hello.c hello1.c" \
  "cp ../assets/say_hello.c hello2.c" \
  "cp ../assets/say_hello.c hello3.c" \
  "cp ../assets/greetings.h ." \
  "cp ../assets/greetings.c ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"

test "if \"$MAKE\" does not rebuild in 2nd recompilation" \
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

test "if \"$MAKE\" rebuilds only the touched main in 2nd recompilation" \
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

test "if \"$MAKE\" rebuilds the touched shared file in 2nd recompilation" \
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

test "if \"$MAKE\" rebuilds correctly in 2nd recompilation with args" \
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
