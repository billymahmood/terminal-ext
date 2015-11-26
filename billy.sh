#!/bin/bash
## The roof of everything
function b() {
    if ! fn_exists "b_$1"; 
        then
            echo "billy does not except $1 as a pram"
        else
            "b_$1" "${@:2}"
    fi
}

## check if a function exists
fn_exists() {
    # appended double quote is an ugly trick to make sure we do get a string -- if $1 is not a known command, type does not output anything
    [ `type -t $1`"" == 'function' ]
}


## Servers
source ~/terminal-ext/server.sh
source ~/terminal-ext/grunt.sh
source ~/terminal-ext/cordova.sh
source ~/terminal-ext/functions.sh
source ~/terminal-ext/git.sh