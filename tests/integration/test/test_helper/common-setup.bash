#!/usr/bin/env bash

PYRSIA_FOLDER=/tmp/pyrsia

_common_setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$PROJECT_ROOT/src:$PATH"
    # git clone https://github.com/pyrsia/pyrsia.git  /tmp/pyrsia
    echo "Building Pyrsia sources..." >&3
    cargo build --profile=release --package=pyrsia_cli --manifest-path=$PYRSIA_FOLDER/Cargo.toml
    echo "Building Pyrsia completed!" >&3
    PYRSIA_CLI_FOLDER=$PYRSIA_FOLDER/target/release
    docker-compose -f $PYRSIA_FOLDER/docker-compose.yml
}
