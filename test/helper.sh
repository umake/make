function test() {
  # echo -n .
  setup
  assert_type=ls
  assert_value=ls
  cmd=ls
  last_cmd=ls
  for arg
  do
    eval $cmd &> /dev/null
    cmd=$assert_type
    assert_type=$assert_value
    assert_value=$arg
  done
  eval $assert_type "'"$cmd"'" "'"$assert_value"'"
  teardown
}

function should_be() {
  eval assert "'"$1"'" "'"$2"'"
}

function should_raise() {
  eval assert_raises "'"$1"'" "'"$2"'"
}