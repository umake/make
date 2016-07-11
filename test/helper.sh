#!/bin/bash

test() {
  echo -n .
  setup

  test_behavior=$1

  for cmd in "${@:2:$#-4}"; do
    eval $cmd &> /dev/null
  done

  assert_cmd="${@:$#-2:1}"
  assert_type="${@:$#-1:1}"
  assert_value="${@:$#-0:1}"

  eval $assert_type "'"$assert_cmd \# test $test_name"'" "'"$assert_value"'"
  teardown
}

should_output() {
  eval assert "'"$1"'" "'"$2"'"
}

should_raise() {
  eval assert_raises "'"$1"'" "'"$2"'"
}
