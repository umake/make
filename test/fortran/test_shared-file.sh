#!/usr/bin/env bash

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
  "$MAKE standard" \
  "$MAKE | grep greetings.o | wc -l" \
  should_output "3"

test "if \"$MAKE\" builds shared files with different flags" \
  "cp ../assets/shared_file.f.mk Config.mk" \
  "cp ../assets/say_hello.f hello1.f" \
  "cp ../assets/say_hello.f hello2.f" \
  "cp ../assets/say_hello.f hello3.f" \
  "cp ../assets/greetings.f ." \
  "$MAKE standard" \
  "$MAKE" \
  "$MAKE | grep \"is up to date\" | wc -l" \
  should_output "3"

test "if \"$MAKE\" rebuilds only the touched main in 2nd recompilation" \
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

test "if \"$MAKE\" rebuilds the touched shared file in 2nd recompilation" \
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

test "if \"$MAKE\" rebuilds correctly in 2nd recompilation with args" \
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
