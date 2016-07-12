#!/bin/bash

test() {
  setup

  test_behavior="$1"

  for cmd in "${@:2:$#-4}"; do
    eval $cmd &> /dev/null
  done

  assert_cmd="${@:$#-2:1}"
  assert_type="${@:$#-1:1}"
  assert_value="${@:$#-0:1}"

  eval $assert_type "\""$test_behavior"\"" "'"$assert_cmd"'" "'"$assert_value"'"

  teardown
}

should_output() {
  assert "$@"
}

should_raise() {
  assert_raises "$@"
}
