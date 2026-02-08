# --- Path Configuration ---
# Prepend paths (equivalent to fish_add_path -m)
export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$PATH"

# --- Environment Variables ---
export EDITOR=vim
export GPG_TTY=$(tty)
# Note: Zsh splits words differently than Fish, but this string is safe.
export ERL_AFLAGS="-kernel shell_history enabled"

# Disable default login message (Zsh equivalent involves creating a .hushlogin file)
# You can run: touch ~/.hushlogin to silence the "Last login" system message.

# --- Wrappers & Aliases ---

# cat wrapper (batcat)
if command -v batcat > /dev/null; then
  alias cat='batcat --theme=ansi'
elif command -v bat > /dev/null; then
  # Fallback if binary is named 'bat' instead of 'batcat'
  alias cat='bat --theme=ansi'
fi

# ls wrapper (eza)
if command -v eza > /dev/null; then
  alias ls='eza --icons'
fi

# --- Git Aliases ---
alias gco="git checkout"
alias gst="git status -sb"
alias gc="git commit"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add --patch"
alias gpl="git pull -r"
alias gps="git push"
alias gl="git log --oneline"

# --- Custom Prompt ---
# Enable command substitution in the prompt
setopt PROMPT_SUBST

# Helper function for git branch
function _git_branch_name() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||'
}

# Helper function for dirty status
function _is_git_dirty() {
  git status -s --ignore-submodules=dirty 2> /dev/null
}

# The main prompt construction
function build_prompt() {
  local git_info=""
  local branch=$(_git_branch_name)

  if [ -n "$branch" ]; then
    git_info=":$branch"
    if [ -n "$(_is_git_dirty)" ]; then
      git_info="${git_info}*"
    fi
  fi

  # %c prints the current directory basename (equivalent to basename (prompt_pwd))
  echo "%c${git_info}> "
}

PROMPT='$(build_prompt)'

# --- Tools Initialization ---

# mise (formerly rtx)
if command -v mise > /dev/null; then
  eval "$(mise activate zsh)"
fi

# zoxide
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# fzf
if command -v fzf > /dev/null; then
  source <(fzf --zsh)
fi
