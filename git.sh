#!/bin/zsh
##
## Custom Git Functions (More Robust Version)
##

# A helper function to get the current branch name.
_b_get_current_branch() {
  git branch --show-current 2>/dev/null
}

## Add specified files to staging.
b_add() {
  if (( $# == 0 )); then
    echo "Error: Please specify which files to add." >&2
    return 1
  fi
  # Use -A to ensure new files and deletions are staged.
  git add -A "$@"
  echo "✅ Added: $@"
}

## A helper function to get a commit message, prompting if one isn't provided.
_b_get_commit_message() {
  local commit_msg="$*"
  if [[ -z "$commit_msg" ]]; then
    read "commit_msg?$USER, please enter a commit message: "
  fi

  if [[ -z "$commit_msg" ]]; then
    echo "Commit cancelled: No message provided." >&2
    return 1
  fi

  echo "$commit_msg"
  return 0
}

## Commit staged changes with a message.
b_commit() {
  local MESSAGE
  MESSAGE=$(_b_get_commit_message "$@")
  if (( $? != 0 )); then
    return 1
  fi
  git commit -m "$MESSAGE"
}

## Add all tracked files and commit with a message.
b_acommit() {
  local MESSAGE
  MESSAGE=$(_b_get_commit_message "$@")
  if (( $? != 0 )); then
    return 1
  fi
  # Use -A to stage all changes, including new and deleted files.
  git add -A . && git commit -m "$MESSAGE"
}

## Pull changes from a remote branch.
b_pull() {
  local remote="${1:-origin}"
  local branch="${2:-$(_b_get_current_branch)}"
  if [[ -z "$branch" ]]; then
    echo "Error: Could not determine current branch. Please specify one." >&2
    return 1
  fi
  git pull "$remote" "$branch"
}

## Push changes to a remote branch, setting the upstream if it's not set.
b_push() {
  local remote="${1:-origin}"
  local branch="${2:-$(_b_get_current_branch)}"
  if [[ -z "$branch" ]]; then
    echo "Error: Could not determine current branch. Please specify one." >&2
    return 1
  fi

  # Check if the upstream branch is set. If not, set it on the first push.
  if ! git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
      echo " upstream branch not set. Setting it now..."
      git push --set-upstream "$remote" "$branch"
  else
      git push "$remote" "$branch"
  fi
}

## Commit STAGED changes and push to the remote.
b_cpush() {
    local MESSAGE
    MESSAGE=$(_b_get_commit_message "$@")
    if (( $? != 0 )); then
        return 1
    fi
    git commit -m "$MESSAGE" && b_push
}

## Add ALL files, commit, and push in one command.
b_acp() {
    local MESSAGE
    MESSAGE=$(_b_get_commit_message "$@")
    if (( $? != 0 )); then
        return 1
    fi
    # Use -A to stage all changes, including new and deleted files.
    git add -A . && git commit -m "$MESSAGE" && b_push
}

## Switch to a different branch.
b_switch() {
  if (( $# == 0 )); then
    echo "Error: Please specify a branch to switch to." >&2
    return 1
  fi
  git switch "$1"
}

## Create and switch to a new branch.
b_new_branch() {
    if (( $# == 0 )); then
        echo "Error: Please specify a name for the new branch." >&2
        return 1
    fi
    git switch -c "$1"
}