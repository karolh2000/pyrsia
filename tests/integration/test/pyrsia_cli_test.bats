#!/usr/bin/env bash

setup_file() {
  load 'test_helper/common-setup'
  _common_setup_file
}

setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "Testing pyrsia HELP, check if the help is shown." {
  # run pyrsia help
  run "$PYRSIA_TARGET_DIR"/pyrsia help

  #echo "$output" >&3
  # check if pyrsia ping returns errors
  assert_output --partial 'USAGE:'
  assert_output --partial 'OPTIONS:'
  assert_output --partial 'SUBCOMMANDS:'
}

@test "Testing pyrsia PING, check if the node is up and reachable." {
  # run pyrsia ping
  run "$PYRSIA_TARGET_DIR"/pyrsia ping
  #echo "$output" >&3
  # check if pyrsia ping returns errors
  refute_output --partial 'Error'
}

@test "Testing pyrsia STATUS, check if the node is connected to peers." {
  # run pyrsia ping
  run "$PYRSIA_TARGET_DIR"/pyrsia status
  # echo "\n $output" >&3
  # check if pyrsia ping returns errors
  refute_output --partial '0'
}

@test "Testing 'pyrsia LIST' CLI, check if the node returns list of peers." {
  skip #skip this test since it's broken
  # run pyrsia ping
  run "$PYRSIA_TARGET_DIR"/pyrsia list
  #echo "$output" >&3
  # check if pyrsia ping returns errors
  refute_output --partial '[]'
}

@test 'Pyrsia CLI CONFIG EDIT, show the config and check the values' {
  # skip
  run "$PYRSIA_TARGET_DIR"/pyrsia config --show
  #echo "$output" >&3
  assert_output --partial 'localhost'
  assert_output --partial '7888'
}

teardown_file() {
  echo "Tearing down the tests environment..." >&3
  echo "Cleaning up Docker..."  >&3
  #docker system prune --all -f
  echo "Removing the temp files..."  >&3
  #rm -rf "$PYRSIA_SRC_DIR"
  echo "Done tearing done the environment!" >&3
}
