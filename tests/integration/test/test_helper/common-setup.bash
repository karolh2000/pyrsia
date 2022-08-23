#!/usr/bin/env bash

PYRSIA_FOLDER=/tmp/pyrsia
BATS_TEST_TIMEOUT=1000*1200 # the tests will timeout in 20 min


_common_setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$PROJECT_ROOT/src:$PATH"
    # git clone --branch karolh2000/integ_tests_bats https://github.com/karolh2000/pyrsia.git  /tmp/pyrsia
    echo "Building the Pyrsia sources, it might take several minutes..." >&3
    cargo build --profile=release --package=pyrsia_cli --manifest-path=$PYRSIA_FOLDER/Cargo.toml
    echo "Building Pyrsia completed!" >&3
    PYRSIA_CLI_FOLDER=$PYRSIA_FOLDER/target/release
    echo "Building the Pyrsia Node docker image and starting the container, it might take several minutes..." >&3
    docker-compose -f $PYRSIA_FOLDER/docker-compose.yml up -d
    echo "Pyrsia Node docker container is up!" >&3
}
