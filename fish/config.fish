set -gx EDITOR "nvim"
set -gx GPG_TTY (tty)
set -gx ERL_AFLAGS "-kernel shell_history enabled"

if test -d /opt/homebrew/bin
  set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

fish_add_path -g -a $HOME/.elixir-ls

if status is-interactive
  alias vim="nvim"

  alias gco="git checkout"
  alias gst="git status -sb"
  alias gc="git commit"
  alias gcm="git commit -m"
  alias ga="git add"
  alias gaa="git add -A"
  alias gap="git add --patch"
  alias gpl="git pull"
  alias gl="git log --color --graph --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
  alias gps="git push"

  if type -q bat
    alias cat="bat"
  end

  if type -q batcat
    alias cat="batcat"
  end

  alias print="lpr -o sides=two-sided-long-edge"
  alias icat="kitty +kitten icat"
end
