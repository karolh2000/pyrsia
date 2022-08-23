#!/usr/bin/expect -f

set timeout -1
spawn /tmp/pyrsia/target/release/pyrsia config --edit
    expect "Enter host:"
    send -- "dupa\n"

echo -ne '\n' | /tmp/pyrsia/target/release/pyrsia config --edit
