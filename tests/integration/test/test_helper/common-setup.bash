#!/usr/bin/env bash

PYRSIA_SRC_DIR=/tmp/pyrsia/ # TODO Change this to /tmp/source/pyrsia

_common_setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    # PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    # PATH="$PROJECT_ROOT/src:$PATH"
    local git_branch="karolh2000/integ_tests_bats"
    # clone or update the sources
    if [ -d $PYRSIA_SRC_DIR/.git ]; then
       git --git-dir=$PYRSIA_SRC_DIR/.git fetch
       git --git-dir=$PYRSIA_SRC_DIR/.git --work-tree=$PYRSIA_SRC_DIR merge origin/main
    else
      mkdir -p $PYRSIA_SRC_DIR
      git clone --branch $git_branch https://github.com/karolh2000/pyrsia.git  $PYRSIA_SRC_DIR
    fi;

    printf "\t Building the Pyrsia sources, it might take several minutes... \n" >&3
    cargo build --profile=release --package=pyrsia_cli --manifest-path=$PYRSIA_SRC_DIR/Cargo.toml
    printf "\t Building Pyrsia completed! \n" >&3
    PYRSIA_CLI_FOLDER=$PYRSIA_SRC_DIR/target/release
    printf "\t Building the Pyrsia Node docker image and starting the container, it might take several minutes... \n" >&3
    docker-compose -f $PYRSIA_SRC_DIR/docker-compose.yml up -d
    printf "\t Pyrsia Node docker container is up! \n" >&3
    printf "\t Starting the test... \n" >&3
}
