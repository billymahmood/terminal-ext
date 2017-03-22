#!/bin/bash
function b_help() {
    clear;
    echo "b start - go to /Users/$USER/Sites";
    echo "b errors - tail apache error log (/var/log/apache2/error_log)";
    echo "b host - port to start php server on a port";
    echo "b tail {path} - to tail any file";
    echo "b find {string} - search for directory the in current directory"
}

function b_fresh() {
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

## Tail the end of a file
function b_tail() {
    tail -f $1;
}

## find a folder with the name of
function b_find() {
    echo 'You searched for:' $1
    ls -d *$1*;
}

function b_setup() {
  echo -n "Do you want to create a new directory? (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
      echo -n "Please enter the directory name: $"
        read directory
        mkdir "$directory"
        cd "$directory"
  else
      echo No
  fi
}
