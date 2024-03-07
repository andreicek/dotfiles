typeset -aU path
path+=("/opt/homebrew/bin")

source "$HOME/.asdf/asdf.sh"
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
eval "$(zoxide init zsh)"

export EDITOR="vim"
export LOLCOMMITS_DELAY="2"
export GPG_TTY="$(tty)"
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
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

custom_prompt() {
  local git_info=""
  local branch_name=$(git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')

  if [[ -n "$branch_name" ]]; then
    git_info=":$branch_name"
    local dirty_status=$(git status -s --ignore-submodules=dirty 2> /dev/null)

    if [[ -n "$dirty_status" ]]; then
      git_info="$git_info*"
    fi
  fi

  PS1="%{$fg[red]%}%1~$git_info>%{$reset_color%} "
}

add-zsh-hook precmd custom_prompt
