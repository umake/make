function test() {
  echo -n .
  setup
  i=0
  for arg
  do
    if [ $i -gt 2 ]
    then
      eval $arg &> /dev/null
    fi
    i=$((i+1))
  done
  eval $1 "'"$2"'" "'"$3"'"
  teardown
}