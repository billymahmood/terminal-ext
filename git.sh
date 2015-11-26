## 
##  This is a custom git functions file
##  Author: Balal Butt (Billy Mahmood)
##  Email: billy124@msn.com
##  Please do not remove this header
## 

## get the current Branch name with (branch name)
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

## Get the branch name
get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

## Add all changes and commit all changes
function b_commit() {
    if [ -z "$1" ];
        then
            echo "Billy! pass a commit message.";
        else
            git add . && git commit -m "$1"
            echo "command executed - git add . && git commit -m \"$1\"";
    fi
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
    git status
    echo "command executed - git status";
}

function b_showChangesInCommit() {
    git show --name-only $1
    echo "command executed - git show --name-only $1";
}