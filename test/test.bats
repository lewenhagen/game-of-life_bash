#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
# load 'bats-helper'


@test "Invoking script with wrong command" {
  run ./main.bash rand
  [ "$status" -eq 1 ]
}

@test "Invoking script with nonexistent pattern" {
  run ./main.bash load i-do-not-exist
  [ "$status" -eq 1 ]
  [ "$output" = "No such pattern: i-do-not-exist" ]
}

@test "Test version" {
  run ./main.bash --version
  # [ "$status" -eq 0 ]
  [ "$output" = "main.bash version 1.0.0" ]
}
