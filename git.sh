#!/bin/zsh
##
##  This is a custom git functions file
##  Author: Balal Butt (Billy Mahmood)
##  Email: billy124@msn.com
##  Please do not remove this header
##  We are using the b_ prefix to prevent our custom functions from overwriting existing functions
##

# A helper function to get the current branch name.
_b_get_current_branch() {
  git branch --show-current 2>/dev/null
}

# A helper function to get a commit message, prompting if one isn't provided.
# This avoids code duplication in b_commit and b_acommit.
_b_get_commit_message() {
  local commit_msg="$*"
  if [[ -z "$commit_msg" ]]; then
    # Zsh-idiomatic way to prompt for input
    read "commit_msg?$USER, please enter a commit message: "
  fi

  if [[ -z "$commit_msg" ]]; then
    echo "Commit cancelled: No message provided." >&2
    return 1 # Failure
  fi

  echo "$commit_msg"
  return 0 # Success
}

# --- Main Functions ---

## Add specified files to staging.
## Usage: b_add <file1> <file2> ...
b_add() {
  if (( $# == 0 )); then
    echo "Error: Please specify which files to add." >&2
    return 1
  fi
  git add "$@"
  echo "✅ Added: $@"
}

## Commit staged changes with a message.
## Usage: b_commit <message>
b_commit() {
  local MESSAGE
  MESSAGE=$(_b_get_commit_message "$@")
  # Check the return code of the helper function
  if (( $? != 0 )); then
    return 1
  fi

  git commit -m "$MESSAGE"
}

## Add all tracked files and commit with a message.
## Usage: b_acommit <message>
b_acommit() {
  local MESSAGE
  MESSAGE=$(_b_get_commit_message "$@")
  if (( $? != 0 )); then
    return 1
  fi

  git add . && git commit -m "$MESSAGE"
}

## Pull changes from a remote branch.
## Usage: b_pull [remote] [branch]
b_pull() {
  local remote="${1:-origin}"
  local branch="${2:-$(_b_get_current_branch)}"
  if [[ -z "$branch" ]]; then
    echo "Error: Could not determine current branch. Please specify one." >&2
    return 1
  fi
  git pull "$remote" "$branch"
}

## Push changes to a remote branch.
## Usage: b_push [remote] [branch]
b_push() {
  local remote="${1:-origin}"
  local branch="${2:-$(_b_get_current_branch)}"
  if [[ -z "$branch" ]]; then
    echo "Error: Could not determine current branch. Please specify one." >&2
    return 1
  fi
  git push "$remote" "$branch"
}

## Switch to a different branch. (Uses modern `git switch`)
## Usage: b_switch <branch>
b_switch() {
  if (( $# == 0 )); then
    echo "Error: Please specify a branch to switch to." >&2
    return 1
  fi
  git switch "$1"
}

## Create and switch to a new branch.
## Usage: b_new_branch <new-branch-name>
b_new_branch() {
    if (( $# == 0 )); then
        echo "Error: Please specify a name for the new branch." >&2
        return 1
    fi
    git switch -c "$1"
}