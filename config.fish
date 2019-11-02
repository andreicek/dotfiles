alias ls "exa --long --git"
alias rm "trash"
alias cat "bat"
alias grep "rg"

abbr map "xargs -n1"
abbr gco "git checkout"
abbr gst "git status -sb"
abbr gc "git commit"
abbr gcm "git commit -m"
abbr ga "git add"
abbr gaa "git add -A"
abbr gap "git add --patch"
abbr gpl "git pull"
abbr gps "git push"
abbr scrapvm "docker run -ti --rm ubuntu"
abbr upload "rsync -avzu --progress"

set -gx EDITOR "vim"
test -e {$HOME}/.config/fish/secret.fish; and source {$HOME}/.config/fish/secret.fish
set -Ua fish_user_paths {$HOME}/.dotfiles/bin

starship init fish | source
