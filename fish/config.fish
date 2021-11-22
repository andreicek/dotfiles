set -U fish_user_paths /opt/homebrew/bin/ $fish_user_paths
set -gx GPG_TTY (tty)
set -gx EDITOR "vim"

if status is-interactive
    starship init fish | source

    alias gco="git checkout"
    alias gst="git status -sb"
    alias gc="git commit"
    alias gcm="git commit -m"
    alias ga="git add"
    alias gaa="git add -A"
    alias gap="git add --patch"
    alias gpl="git pull"
    alias gps="git push"

    alias cat="bat"
end
