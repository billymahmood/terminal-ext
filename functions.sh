#!/bin/bash
function b_help() {
    clear;
    echo "billy start - go to /Users/$USER/Sites";
    echo "billy errors - tail apache error log (/var/log/apache2/error_log)";
    echo "billy host - port to start php server on a port";
    echo "billy tail {path} - to tail any file";

    echo "billy find {string} - search for directory the in current directory"
}

function b_updateTerminal() {
    source ~/terminal-ext/billy.sh
}

function b_start() {
    cd '/Users/'$USER'/Sites'
}

function b_errors() {
    tail -f /var/log/apache2/error_log
}


## custom functions
function b_host() {
    php -S localhost:$1 -t $2
}

## Tail a file
function b_tail() {
    tail -f $1;
}

## find folder
function b_find() {
    echo 'You searched for:' $1
    ls -d *$1*;
}
