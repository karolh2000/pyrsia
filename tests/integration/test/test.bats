setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "Pyrsia CLI HELP" {
  # run pyrsia ping
  run $PYRSIA_CLI_FOLDER/pyrsia help
  # check if pyrsia ping returns errors
  refute_output --partial 'Error'
}

@test "Pyrsia CLI PING" {
  # run pyrsia ping
  run $PYRSIA_CLI_FOLDER/pyrsia ping
  # check if pyrsia ping returns errors
  refute_output --partial 'Error'
}

#teardown() {
#  rm -rf $PYRSIA_FOLDER
#}
