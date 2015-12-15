## 
##  This is a custom git functions file
##  Author: Balal Butt (Billy Mahmood)
##  Email: billy124@msn.com
##  Please do not remove this header
##  We are using the b_ prefix to prevent our custom functions from overwriting existing functions
## 

## get the current Branch name with (branch name)
## this function cannot be invoked by b
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## Get the branch name
## this function cannot be invoked by b
get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

## Add all changes and commit
function b_add() {
    if [ -z "$1" ];
        then
            echo "$USER, please enter which files you want to add"
        else
            git add "${@:2}"
            echo "command executed - git add ${@:0}";
    fi
}

## commit changes
function b_commit() {
    if [ -z "$1" ];
        then
            echo -n "$USER, please enter a commit message : "
            read MESSAGE
        else
            MESSAGE=$1
    fi

    git commit -m "$MESSAGE"
    echo "command executed - git commit -m \"$MESSAGE\""; 
}

## Add all changes and commit
function b_acommit() {
    if [ -z "$1" ];
        then
            echo -n "$USER, please enter a commit message : "
            read MESSAGE
        else
            MESSAGE=$1
    fi

    git add . && git commit -m "$MESSAGE"
    echo "command executed - git add . && git commit -m \"$MESSAGE\""; 
}

## pull branch
function b_pull() {
    if [ -z "$1" ];
        then
            ORIGIN='origin'
            BRANCH="$(get_git_branch)"
        else
            ORIGIN=$1
            BRANCH=$2
    fi

    git pull $ORIGIN $BRANCH
    echo "-- command executed - git pull $ORIGIN $BRANCH";
}

## push branch
function b_push() {
    if [ -z "$1" ];
        then
            ORIGIN='origin'
            BRANCH="$(get_git_branch)"
        else
            ORIGIN=$1
            BRANCH=$2
    fi

    git push $ORIGIN $BRANCH
    echo "-- command executed - git push $ORIGIN $BRANCH";
}

## change branch to another
function b_change() {
    if [ -z "$1" ];
        then
            echo "Mate, change to what branch?";
        else
            git checkout $1
            echo "command executed - git checkout $1";
    fi
}

## create a new branch and check it out
function b_create() {
    if [ -z "$1" ];
        then
            echo "Slow day? Create a branch with named...?";
        else
            git checkout -b $1
            echo "command executed - git checkout -b $1";
    fi
}

## create a new branch and check it out
function b_diff() {
    git diff
    echo "command executed - git diff";
}

## create a new branch and check it out
function b_status() {
    git status
    echo "command executed - git status";
}

function b_showChangesInCommit() {
    git show --name-only $1
    echo "command executed - git show --name-only $1";
}

function b_remote() {
    git remote -v
    echo "command executed - git remote -v";
}

function b_changeRemote() {
    git remote set-url origin $1
    echo "command executed - git remote set-url origin $1";
}