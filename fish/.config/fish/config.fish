fish_add_path /opt/homebrew/bin
source (brew --prefix asdf)/libexec/asdf.fish
fish_add_path ~/.dotfiles/bin

if status is-interactive
  set -Ux EDITOR "nvim"
  set -Ux GPG_TTY (tty)
  set -Ux ERL_AFLAGS "-kernel shell_history enabled"

  alias gco "git checkout"
  alias gst "git status -sb"
  alias gc "git commit"
  alias gcm "git commit -m"
  alias ga "git add"
  alias gaa "git add -A"
  alias gap "git add --patch"
  alias gpl "git pull"
  alias gps "git push"
  alias gl "git log --oneline"
  alias gll "git log --oneline | fzf --preview \"awk '{ print $1 }' <<< {} | xargs git wc\" | awk '{print $1 }'"

  alias vim "nvim"
  alias cat "bat"
  alias printer "lpr -o sides=two-sided-long-edge"
  alias rm "trash"
end

