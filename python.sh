#!/bin/zsh
##
##  A collection of useful Python helper functions for Zsh.
##

# -----------------------------------------------------------------------------
# -- Virtual Environments (venv)
# -----------------------------------------------------------------------------

## 📦 Create a new Python virtual environment in a 'venv' directory.
## Usage: b python_venv_create
b_python_venv_create() {
    if [ -d "venv" ]; then
        echo "A 'venv' directory already exists." >&2
        return 1
    fi
    echo "📦 Creating Python virtual environment..."
    python3 -m venv venv
    echo "✅ Done. Activate it with 'b python_venv_on'"
}

## 🟢 Activate the virtual environment.
## Usage: b python_venv_on
b_python_venv_on() {
    local venv_activator="venv/bin/activate"
    if [ ! -f "$venv_activator" ]; then
        echo "Error: Could not find '$venv_activator'. Did you create the venv yet?" >&2
        return 1
    fi
    source "$venv_activator"
    echo "🟢 Virtual environment activated."
}

## 🔴 Deactivate the virtual environment.
## Usage: b python_venv_off
b_python_venv_off() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        echo "No virtual environment is currently active." >&2
        return 1
    fi
    deactivate
    echo "🔴 Virtual environment deactivated."
}

# -----------------------------------------------------------------------------
# -- Dependency Management (pip)
# -----------------------------------------------------------------------------

## 📥 Install packages from a requirements.txt file.
## Usage: b python_reqs
b_python_reqs() {
    if [ ! -f "requirements.txt" ]; then
        echo "Error: requirements.txt not found." >&2
        return 1
    fi
    echo "📥 Installing dependencies from requirements.txt..."
    python -m pip install -r requirements.txt
}

## ✨ Install one or more Python packages.
## Usage: b python_install <package1> <package2>
b_python_install() {
    if (( $# == 0 )); then
        echo "Error: Please provide at least one package to install." >&2
        return 1
    fi
    echo "✨ Installing packages: $@"
    python -m pip install "$@"
}

## 🧊 Freeze current packages into a requirements.txt file.
## Usage: b python_freeze
b_python_freeze() {
    echo "🧊 Freezing dependencies to requirements.txt..."
    python -m pip freeze > requirements.txt
    echo "✅ requirements.txt created."
}

## 🚀 Upgrade pip to the latest version.
## Usage: b python_pip_upgrade
b_python_pip_upgrade() {
    echo "🚀 Upgrading pip..."
    python -m pip install --upgrade pip
}

# -----------------------------------------------------------------------------
# -- Code Quality & Testing
# -----------------------------------------------------------------------------

## 🎨 Format code with isort and black.
## Checks for the existence of both tools first.
## Usage: b python_format
b_python_format() {
    if ! command -v isort &> /dev/null || ! command -v black &> /dev/null; then
        echo "Error: 'isort' and 'black' must be installed to use this command." >&2
        echo "Install them with: b python_install black isort" >&2
        return 1
    fi
    echo "🎨 Sorting imports with isort..."
    isort .
    echo "🎨 Formatting code with black..."
    black .
    echo "✅ Formatting complete."
}

## 🔬 Lint code with flake8.
## Usage: b python_lint
b_python_lint() {
    if ! command -v flake8 &> /dev/null; then
        echo "Error: 'flake8' must be installed to use this command." >&2
        echo "Install it with: b python_install flake8" >&2
        return 1
    fi
    echo "🔬 Linting with flake8..."
    flake8 .
}

## ✅ Run tests with pytest.
## You can pass specific file paths as arguments.
## Usage: b python_test [path/to/test_file.py]
b_python_test() {
    if ! command -v pytest &> /dev/null; then
        echo "Error: 'pytest' must be installed to use this command." >&2
        echo "Install it with: b python_install pytest" >&2
        return 1
    fi
    echo "✅ Running tests with pytest..."
    pytest "$@"
}

# -----------------------------------------------------------------------------
# -- Project Tools
# -----------------------------------------------------------------------------

## 🧹 Clean up Python cache files.
## Removes all .pyc files and __pycache__ directories.
## Usage: b python_clean
b_python_clean() {
    echo "🧹 Removing .pyc files and __pycache__ directories..."
    find . -type f -name "*.pyc" -delete
    find . -type d -name "__pycache__" -exec rm -r {} +
    echo "✅ Cleanup complete."
}

## 📓 Start a Jupyter Notebook server.
## Usage: b python_notebook
b_python_notebook() {
    if ! command -v jupyter &> /dev/null; then
        echo "Error: 'jupyter' must be installed to use this command." >&2
        echo "Install it with: b python_install notebook" >&2
        return 1
    fi
    echo "📓 Starting Jupyter Notebook server..."
    jupyter notebook
}