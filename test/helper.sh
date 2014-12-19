#!/bin/bash

function test() {
  echo -n .
  setup
  assert_type=ls
  assert_value=ls
  cmd=ls
  last_cmd=ls
  i=0
  test_name=0
  for arg
  do
    if [ $i -eq 0 ]
    then
      test_name=$arg
      i=1
    else
      eval $cmd &> /dev/null
      cmd=$assert_type
      assert_type=$assert_value
      assert_value=$arg
    fi
  done
  eval $assert_type "'"$cmd \# test $test_name"'" "'"$assert_value"'"
  teardown
}

function should_output() {
  eval assert "'"$1"'" "'"$2"'"
}

function should_raise() {
  eval assert_raises "'"$1"'" "'"$2"'"
}