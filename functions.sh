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
    echo 'You searched for: ' $1
    ls -d *$1*;
}

function b_setup() {
  ## Do we need a new folder for your projet
  echo -n "Do you want to create a new directory for your project? (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
      echo -n "Please enter the directory name: $ "
        read directory
        mkdir "$directory"
        cd "$directory"
  fi

  ## Lets download the git code
  echo -n "Please enter the Git repo url: $ "
  read repo
  git clone "$repo" && cd `echo $_ | sed -n -e 's/^.*\/\([^.]*\)\(.git\)*/\1/p'`

  ## copy the .env.example to .env
  echo -n "Do you want to copy the .env.example to .env (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
      cp .env.example .env
  fi

  ## Install composer
  echo -n "Do you want to install composer packages (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
      composer install
  fi

}
