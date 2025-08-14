#!/bin/zsh
##
## The root of everything, rewritten for Zsh.
##

## The main dispatcher function. It calls functions prefixed with "b_".
b() {
    local func_name="b_$1" # Store the target function name
    
    # Check if there's an argument to begin with
    if (( $# == 0 )); then
        echo "Usage: b <command> [args...]" >&2
        return 1
    fi

    if ! fn_exists "$func_name"; then
        echo "billy does not accept '$1' as a parameter!" >&2
        return 1
    else 
        # echo "running $func_name" # Optional: uncomment for debugging
        shift # Removes the first argument (e.g., "add") from the list
        "$func_name" "$@" # Calls the function (e.g., "b_add") with the remaining arguments
    fi
}

## A simple alias for the main "b" function.
billy() {
    b "$@"
}

## Check if a function exists (Zsh-idiomatic way).
fn_exists() {
    # [[ ... ]] is more robust than [ ... ]
    # "$(...)" is the modern way for command substitution
    [[ "$(type -t "$1")" == "function" ]]
}


## Pull in all the required files that contain our code
# Note: Zsh can use 'source' or the '.' command interchangeably
source ~/terminal-ext/functions.sh
source ~/terminal-ext/prompt.sh
source ~/terminal-ext/flutter.sh
source ~/terminal-ext/git.sh
source ~/terminal-ext/docker.sh
source ~/terminal-ext/server.sh
source ~/terminal-ext/python.sh
source ~/terminal-ext/mysql.sh