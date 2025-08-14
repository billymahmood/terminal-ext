#!/bin/zsh
##
##  A collection of useful MySQL helper functions for Zsh.
##

# -----------------------------------------------------------------------------
# -- Connection & Info
# -----------------------------------------------------------------------------

## ⚡ Log in to the MySQL shell.
## Defaults to the 'root' user and 'localhost'.
## Usage: b mysql_login [user] [host] [database]
b_mysql_login() {
    local user="${1:-root}"
    local host="${2:-localhost}"
    local db_arg=""
    # If a third argument (database) is provided, format it correctly
    if [[ -n "$3" ]]; then
        db_arg="-D $3"
    fi
    echo "Attempting to log in as '$user' on '$host'..."
    mysql -u "$user" -h "$host" -p $db_arg
}

## 📋 List all databases on the server.
## Usage: b mysql_dbs [user]
b_mysql_dbs() {
    local user="${1:-root}"
    echo "Listing all databases as user '$user'..."
    mysql -u "$user" -p -e "SHOW DATABASES;"
}

## 👥 List all MySQL users and their hosts.
## Usage: b mysql_users [user]
b_mysql_users() {
    local user="${1:-root}"
    echo "Listing all MySQL users as root..."
    mysql -u "$user" -p -e "SELECT user, host FROM mysql.user;"
}

## 🏃 Show all running MySQL processes.
## Usage: b mysql_procs [user]
b_mysql_procs() {
    local user="${1:-root}"
    mysql -u "$user" -p -e "SHOW FULL PROCESSLIST;"
}

# -----------------------------------------------------------------------------
# -- Database Management
# -----------------------------------------------------------------------------

## ➕ Create a new database.
## Usage: b mysql_create_db <db_name> [user]
b_mysql_create_db() {
    if (( $# == 0 )); then
        echo "Error: Please provide a database name to create." >&2
        return 1
    fi
    local db_name="$1"
    local user="${2:-root}"
    echo "Creating database '$db_name'..."
    # Using backticks is a safeguard for names with special characters
    mysql -u "$user" -p -e "CREATE DATABASE IF NOT EXISTS \`$db_name\`;"
}

## 🗑️ Drop a database after confirmation.
## ⚠️ THIS IS A DESTRUCTIVE OPERATION.
## Usage: b mysql_drop_db <db_name> [user]
b_mysql_drop_db() {
    if (( $# == 0 )); then
        echo "Error: Please provide a database name to drop." >&2
        return 1
    fi
    local db_name="$1"
    local user="${2:-root}"
    
    echo "☢️  --- WARNING: You are about to permanently delete the database '$db_name' --- ☢️"
    read -q "REPLY?Are you absolutely sure? (y/n) "
    echo ""
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Dropping database '$db_name'..."
        mysql -u "$user" -p -e "DROP DATABASE IF EXISTS \`$db_name\`;"
    else
        echo "Drop command cancelled."
    fi
}

# -----------------------------------------------------------------------------
# -- Import & Export
# -----------------------------------------------------------------------------

## 📤 Export a database to a .sql file.
## Includes routines, events, and drop database statements for a complete backup.
## Usage: b mysql_dump <db_name> <output_file.sql> [user]
b_mysql_dump() {
    if (( $# < 2 )); then
        echo "Error: Please provide a database name and an output file path." >&2
        echo "Usage: b mysql_dump my_db ./backup.sql" >&2
        return 1
    fi
    local db_name="$1"
    local output_file="$2"
    local user="${3:-root}"
    
    echo "📦 Exporting database '$db_name' to '$output_file'..."
    mysqldump --add-drop-database --routines --events -u "$user" -p "$db_name" > "$output_file"
    echo "✅ Dump complete."
}

## 📥 Import a .sql file into a database.
## The database should ideally exist first.
## Usage: b mysql_import <db_name> <input_file.sql> [user]
b_mysql_import() {
    if (( $# < 2 )); then
        echo "Error: Please provide a database name and an input file path." >&2
        echo "Usage: b mysql_import my_db ./backup.sql" >&2
        return 1
    fi
    local db_name="$1"
    local input_file="$2"
    local user="${3:-root}"

    if [[ ! -f "$input_file" ]]; then
        echo "Error: Input file not found at '$input_file'" >&2
        return 1
    fi

    echo "📥 Importing '$input_file' into database '$db_name'..."
    mysql -u "$user" -p "$db_name" < "$input_file"
    echo "✅ Import complete."
}