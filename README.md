# Billy Mahmoods Custom Zsh Functions 🚀

This is a collection of helper functions for Zsh designed to streamline common workflows for Git, Docker, Flutter, and general terminal usage.

---

## 🛠️ Installation

To use these functions, it's best to keep them in a separate file for better organization.

1.  **Source the File**: Add the following line to the **end** of your `~/.zshrc` file. This tells Zsh to load your custom functions every time you open a new terminal.
    ```zsh
    # Load custom helper functions
    source ~/terminal-ext/billy.sh
    ```

2.  **Reload Your Shell**: To apply the changes, either close and reopen your terminal or run the command:
    ```zsh
    source ~/.zshrc
    ```

---

## 📚 Command Reference

Here is a complete list of all available commands, grouped by category.

### Git Commands (`b_`)

| Command | Description | Example Usage |
| :--- | :--- | :--- |
| **`b_add`** | Adds one or more specified files to staging. | `b_add file1.txt file2.js` |
| **`b_commit`** | Commits staged changes with a message. Prompts if no message is given. | `b_commit "Update user login logic"` |
| **`b_acommit`** | Adds all changed files and commits in one step. | `b_acommit "Fix typo in README"` |
| **`b_pull`** | Pulls changes from a remote branch (defaults to origin/current branch). | `b_pull origin main` |
| **`b_push`** | Pushes changes to a remote branch (defaults to origin/current branch). | `b_push` |
| **`b_switch`** | Switches to a different branch using the modern `git switch`. | `b_switch feature/new-design` |
| **`b_new_branch`**| Creates and switches to a new branch. | `b_new_branch hotfix/login-bug` |

### Docker Commands (`b_docker_`)

| Command | Description | Example Usage |
| :--- | :--- | :--- |
| **`b_docker_shell`** | Gets a shell inside a container (tries `bash`, falls back to `sh`). | `b_docker_shell my_api_container` |
| **`b_docker_ps`** | Lists all **running** containers. | `b_docker_ps` |
| **`b_docker_psa`** | Lists **all** containers, including stopped ones. | `b_docker_psa` |
| **`b_docker_stop`** | Stops a specific running container. | `b_docker_stop my_api_container` |
| **`b_docker_stop_all`** | Stops **all** running containers. | `b_docker_stop_all` |
| **`b_docker_logs`** | Shows the logs for a specific container. | `b_docker_logs my_api_container` |
| **`b_docker_logs_f`** | Follows the logs of a container in real-time. | `b_docker_logs_f my_api_container` |
| **`b_docker_images`**| Lists all Docker images on your system. | `b_docker_images` |
| **`b_docker_rm`** | Removes a **stopped** container. | `b_docker_rm my_api_container` |
| **`b_docker_prune_containers`**| Removes all stopped containers. | `b_docker_prune_containers` |
| **`b_docker_prune`** | Standard cleanup (removes stopped containers, dangling images, etc.). | `b_docker_prune` |
| **`b_docker_prune_all`** | ⚠️ **Aggressive cleanup.** Removes all unused Docker data. Asks for confirmation. | `b_docker_prune_all` |

### Flutter Commands (`b_flutter_`)

| Command | Description | Example Usage |
| :--- | :--- | :--- |
| **`b_flutter_get`** | Runs `flutter pub get`. | `b_flutter_get` |
| **`b_flutter_upgrade`**| Runs `flutter pub upgrade`. | `b_flutter_upgrade` |
| **`b_flutter_clean`** | Runs `flutter clean`. | `b_flutter_clean` |
| **`b_flutter_fix`** | Runs `clean` then `get`. Your go-to troubleshooting command. | `b_flutter_fix` |
| **`b_flutter_gen`** | Runs the `build_runner` code generator. | `b_flutter_gen` |
| **`b_flutter_analyze`**| Analyzes Dart code for issues. | `b_flutter_analyze` |
| **`b_flutter_test`** | Runs all project tests. | `b_flutter_test` |
| **`b_flutter_run`** | Starts the app on your selected device. | `b_flutter_run` |
| **`b_flutter_build_apk`**| Builds a release APK with `live` flavor. | `b_flutter_build_apk 1.2.3 45` |
| **`b_flutter_build_aab`**| Builds a release App Bundle with `live` flavor. | `b_flutter_build_aab 1.2.3 45` |
| **`b_flutter_build_ios`**| Builds a release `.app` for running on a physical device. | `b_flutter_build_ios staging` |
| **`b_flutter_build_ipa`**| Builds a release `.ipa` archive with `staging` flavor for distribution. | `b_flutter_build_ipa` |
| **`b_flutter_doctor`** | Checks your Flutter environment health. | `b_flutter_doctor` |

### General Terminal Commands (`b_`)

| Command | Description | Example Usage |
| :--- | :--- | :--- |
| **`b_ll`** | A shortcut for `ls -laF` to list all files with details. | `b_ll` |
| **`b_up`** & **`b_upup`** | Go up one or two parent directories. | `b_up` |
| **`b_mkcd`** | Creates a directory and immediately `cd`'s into it. | `b_mkcd my_new_project` |
| **`b_find`** | Searches for files by name (case-insensitive). | `b_find "*.log"` |
| **`b_grep`** | Searches for **text inside** files recursively. | `b_grep "api_key"` |
| **`b_tar`** | Creates a compressed `.tar.gz` archive. | `b_tar logs.tar.gz /var/log` |
| **`b_untar`** | Extracts a `.tar.gz` archive. | `b_untar logs.tar.gz` |
| **`b_psfind`** | Finds a running process by its name. | `b_psfind chrome` |
| **`b_kill`** | Finds a process by name and asks for confirmation before killing it. | `b_kill node` |
| **`b_myip`** | Shows your public IP address. | `b_myip` |
| **`b_serve`** | Starts a simple web server in the current directory (requires Python 3). | `b_serve 8080` |
| **`b_ports`** | Shows all listening network ports and the app using them. | `b_ports` |

---

> Original Git script header by Balal Butt (Billy Mahmood) - billy124@msn.com