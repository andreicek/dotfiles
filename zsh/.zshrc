if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  exec tmux new-session -A -s main
fi

export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$PATH"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

[[ -f ~/.secrets ]] && source ~/.secrets

export EDITOR=vim
export GPG_TTY=$(tty)
_fix_ssh_auth_sock() {
  if [ -z "$SSH_CONNECTION" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  fi
}
_fix_ssh_auth_sock
export ERL_AFLAGS="-kernel shell_history enabled"

alias cat='batcat --theme=ansi'
alias ls='eza --icons'
alias pbcopy='wl-copy'

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

if [[ -n "$TMUX_POPUP" ]]; then
  _exit_popup() { exit }
  zle -N _exit_popup
  bindkey '^D' _exit_popup
fi

autoload -Uz compinit && compinit

setopt PROMPT_SUBST
autoload -Uz add-zsh-hook
autoload -U colors && colors

typeset -g _git_async_pid=0
typeset -g _git_async_result=""

_git_prompt_compute() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || { echo ""; return; }
  local dirty=""
  if [ -n "$(git status --porcelain --ignore-submodules=dirty 2>/dev/null)" ]; then
    dirty=" %{$fg[yellow]%}✗%{$reset_color%}"
  fi
  echo " %{$fg[blue]%}git:(%{$fg[red]%}${branch}%{$fg[blue]%})%{$reset_color%}${dirty}"
}

_git_async_worker() {
  _git_prompt_compute > "/tmp/zsh_git_prompt_$$"
  kill -s USR1 $$ 2>/dev/null
}

TRAPUSR1() {
  _git_async_result="$(cat /tmp/zsh_git_prompt_$$)"
  _git_async_pid=0
  zle && zle reset-prompt
}

_git_precmd() {
  _git_async_result=""
  (( _git_async_pid )) && kill -s HUP $_git_async_pid 2>/dev/null
  _git_async_worker &!
  _git_async_pid=$!
}

add-zsh-hook precmd _git_precmd
add-zsh-hook precmd _fix_ssh_auth_sock

PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}${_git_async_result} '

eval "$(mise activate zsh)"
eval "$(mise exec -- gh completion -s zsh)"
eval "$(mise exec -- jira completion zsh)"

eval "$(zoxide init zsh)"
source <(fzf --zsh)

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
