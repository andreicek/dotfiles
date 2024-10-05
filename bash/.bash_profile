export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export GPG_TTY=$(tty)
export ERL_AFLAGS="-kernel shell_history enabled"

alias ls="ls --color"
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
alias cat="bat"
alias rm="trash"
alias vim="nvim"

# Git branch and dirty status functions
git_branch_name() {
  git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||'
}

is_git_dirty() {
  [ -n "$(git status -s --ignore-submodules=dirty 2>/dev/null)" ]
}

# Custom prompt
custom_prompt() {
  local git_info=""
  if [ -n "$(git_branch_name)" ]; then
    git_info=":$(git_branch_name)"
    if is_git_dirty; then
      git_info="$git_info*"
    fi
  fi
  PS1="\w$git_info> "
}

# Set the custom prompt
PROMPT_COMMAND=custom_prompt

eval "$(zoxide init bash)"
eval "$(mise activate bash)"
eval "$(fzf --bash)"

