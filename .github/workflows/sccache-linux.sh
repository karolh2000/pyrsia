#!/usr/bin/env bash

set -e
# Download and install sccache in the Linux specific cargo directories
mkdir -p /home/runner/.cargo/bin
curl -o- -sSLf https://github.com/mozilla/sccache/releases/download/v0.3.0/sccache-v0.3.0-aarch64-apple-darwin.tar.gz | tar --strip-components=1 -C /home/runner/.cargo/bin -xzf -
chmod 755 /home/runner/.cargo/bin/sccache
