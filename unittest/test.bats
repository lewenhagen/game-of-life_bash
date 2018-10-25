#!../test/libs/bats/bin/bats

load '../test/libs/bats-support/load'
load '../test/libs/bats-assert/load'

@test "Should add numbers together" {
    assert_equal $(echo 1+1 | bc) 2
}
