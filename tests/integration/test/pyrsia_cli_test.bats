#!/usr/bin/expect -f

#tests timeout
BATS_TEST_TIMEOUT=10

setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "Testing 'pyrsia HELP' CLI, check if the help is shown..." {
  # run pyrsia help
  run $PYRSIA_CLI_FOLDER/pyrsia help
  # check if pyrsia ping returns errors
  refute_output --partial 'Error'
}

@test "Testing 'pyrsia PING' CLI, check if the node is up..." {
  # run pyrsia ping
  run $PYRSIA_CLI_FOLDER/pyrsia ping
  # check if pyrsia ping returns errors
  refute_output --partial 'Error'
}

@test "Testing 'pyrsia STATUS' CLI, check if the node is up..." {
  # run pyrsia ping
  run $PYRSIA_CLI_FOLDER/pyrsia status
  # check if pyrsia ping returns errors
  refute_output --partial '0'
}

@test "Testing 'pyrsia LIST' CLI, check if the node is up..." {
  # run pyrsia ping
  run $PYRSIA_CLI_FOLDER/pyrsia list
  # check if pyrsia ping returns errors
  refute_output --partial '[]'
}

@test 'Pyrsia CLI CONFIG EDIT' {
    run $PYRSIA_CLI_FOLDER/pyrsia config --show
    refute_output --partial 'localhost'
}

#teardown() {
#  rm -rf $PYRSIA_FOLDER
#}
