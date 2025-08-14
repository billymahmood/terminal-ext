## PS1
# --- Git Prompt Configuration ---

# Load required functions
autoload -Uz vcs_info add-zsh-hook

# Enable checking for version control systems
add-zsh-hook precmd vcs_info

# Set the format for the git branch information
zstyle ':vcs_info:git:*' formats ' %F{green}(%b)%f'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' nvcsformats ''

# Tell Zsh to perform variable substitution in the prompt
setopt PROMPT_SUBST

# Set the main prompt
PROMPT='%n@%~${vcs_info_msg_0_}$ '