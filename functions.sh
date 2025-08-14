#!/bin/zsh

#
# Custom Terminal Functions - Combined & Modernized for Zsh
#

# A helper function for clean yes/no prompts.
_b_confirm() {
    # -q waits for one key press, no Enter needed
    read -q "response?$1 (y/n) "
    echo # Move to the next line
    # Check if the response was 'y' or 'Y'
    [[ "$response" =~ ^[Yy]$ ]]
}

# ------------------------------------------------------------------------------
# >> Utility Functions
# ------------------------------------------------------------------------------

## Go to the primary development directory.
function b_start() {
    local DEV_DIR=~/Sites
    if [[ -d "$DEV_DIR" ]]; then
        cd "$DEV_DIR"
        echo "Navigated to $DEV_DIR"
    else
        echo "Error: Development directory not found at $DEV_DIR"
        return 1
    fi
}

## Tail the Apache error log.
function b_errors() {
    local LOG_FILE=/var/log/apache2/error_log
    if [[ -f "$LOG_FILE" ]]; then
        echo "Tailing Apache error log... (Ctrl+C to exit)"
        tail -f "$LOG_FILE"
    else
        echo "Error: Apache log file not found at $LOG_FILE"
        return 1
    fi
}

## Start a local PHP server.
## Usage: b host [port] [directory]
function b_host() {
    local PORT="${1:-8000}"
    local DOC_ROOT="${2:-.}"
    if ! [[ -d "$DOC_ROOT" ]]; then
        echo "Error: Directory '$DOC_ROOT' not found."
        return 1
    fi
    echo "🚀 Starting PHP server at http://localhost:$PORT in '$DOC_ROOT'"
    php -S "localhost:$PORT" -t "$DOC_ROOT"
}

## Tail any file with live updates.
## Usage: b tail <file_path>
function b_tail() {
    if [[ -z "$1" ]] || ! [[ -f "$1" ]]; then
        echo "Error: Please provide a valid file to tail."
        return 1
    fi
    tail -f "$1"
}

## Recursively find files or directories by name.
## Usage: b find <search_string>
function b_find() {
    if [[ -z "$1" ]]; then
        echo "Error: Please provide a search string."
        return 1
    fi
    echo "🔎 Searching for names containing '$1'..."
    # Zsh's recursive globbing is powerful and fast.
    print -l -- **/*$1*(-.)
}

## Interactively set up a new project from a Git repository.
function b_setup() {
    if _b_confirm "Create a new directory for your project?" ;then
        read "directory?Please enter the directory name: "
        if [[ -n "$directory" ]]; then
            mkdir -p "$directory" && cd "$directory"
        else
            echo "No directory name given. Continuing in current folder."
        fi
    fi

    read "repo?Please enter the Git repo URL: "
    if [[ -n "$repo" ]]; then
        # Extract project name from repo URL to cd into it
        local PROJECT_DIR=$(basename -s .git "$repo")
        git clone "$repo" && cd "$PROJECT_DIR" || return 1
    else
        echo "Error: No repository URL provided."
        return 1
    fi

    if [[ -f ".env.example" ]] && _b_confirm "Copy .env.example to .env?" ;then
        cp .env.example .env
        echo "✅ .env file created."
    fi

    if [[ -f "composer.json" ]] && _b_confirm "Install Composer packages?" ;then
        if command -v composer &> /dev/null; then
            composer install
        else
            echo "Warning: 'composer' command not found."
        fi
    fi
    echo "\n🎉 Project setup complete in `pwd`"
}

# ------------------------------------------------------------------------------
# >> Git Functions (from previous request)
# ------------------------------------------------------------------------------

_b_get_current_branch() { git branch --show-current 2>/dev/null; }
function b_add() { if (($# == 0)); then echo "Error: Files to add?"; return 1; fi; git add "$@"; }
function b_commit() { local m="$*"; if [[ -z "$m" ]]; then read "m?Commit message: "; fi; if [[ -n "$m" ]]; then git commit -m "$m"; else echo "Commit aborted."; fi; }
function b_acommit() { local m="$*"; if [[ -z "$m" ]]; then read "m?Commit message: "; fi; if [[ -n "$m" ]]; then git add . && git commit -m "$m"; else echo "Commit aborted."; fi; }
function b_pull() { local o="${1:-origin}"; local b="${2:-$(_b_get_current_branch)}"; git pull "$o" "$b"; }
function b_push() { local o="${1:-origin}"; local b="${2:-$(_b_get_current_branch)}"; git push "$o" "$b"; }
function b_change() { if [[ -z "$1" ]]; then echo "Error: Branch name?"; return 1; fi; git checkout "$1"; }
function b_create() { if [[ -z "$1" ]]; then echo "Error: New branch name?"; return 1; fi; git checkout -b "$1"; }
function b_status() { git status; }
function b_diff() { git diff; }
function b_remote() { git remote -v; }
function b_show() { if [[ -z "$1" ]]; then echo "Error: Commit hash?"; return 1; fi; git show --name-only "$1"; }
function b_change_remote() { if [[ -z "$1" ]]; then echo "Error: New URL?"; return 1; fi; git remote set-url origin "$1"; }

# ------------------------------------------------------------------------------
# >> Master Dispatcher Function
# ------------------------------------------------------------------------------

function b() {
    if [[ -z "$1" ]]; then
        b help
        return
    fi

    local SUBCOMMAND="$1"
    shift # Pass remaining arguments to the function

    # Check if the function exists and call it
    if declare -f "b_$SUBCOMMAND" &>/dev/null; then
        "b_$SUBCOMMAND" "$@"
    # Handle hyphenated or alternate names
    elif [[ "$SUBCOMMAND" == "change-remote" ]]; then
        b_change_remote "$@"
    elif [[ "$SUBCOMMAND" == "fresh" ]]; then
        source ~/.zshrc && echo "✅ Config reloaded."
    elif [[ "$SUBCOMMAND" == "help" ]]; then
        b_help
    else
        echo "Error: Unknown command 'b $SUBCOMMAND'"
        b help
    fi
}

function b_help() {
    cat <<-'EOF'
	
	Usage: b <command> [arguments]

	GIT:
	  add <files...>       Stage files
	  commit <message>     Commit staged files
	  acommit <message>    Add all and commit
	  pull [remote] [br]   Pull from remote
	  push [remote] [br]   Push to remote
	  change <branch>      Switch branches
	  create <branch>      Create and switch to a new branch
	  status, diff         Run git status/diff
	  show <hash>          Show files in a commit
	  remote, change-remote  Manage remotes

	UTILITY:
	  start                Navigate to dev directory
	  setup                Run interactive project setup
	  host [port] [dir]    Start PHP server (defaults: 8000, .)
	  errors               Tail Apache error log
	  find <string>        Find files/dirs by name
	  tail <file>          Live-tail a file
	  fresh                Reload shell configuration
	  help                 Show this message

	EOF
}