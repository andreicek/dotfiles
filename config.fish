alias ls "exa --long --git"
alias rm "trash"
abbr title "it2setkeylabel set status"
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

# My prompt
function fish_prompt
	set_color $fish_color_cwd
  echo -n (basename $PWD)
  set_color normal
  echo -n ' ) '
end

# ENVs
set -gx EDITOR "vim"
test -e {$HOME}/.config/fish/secret.fish; and source {$HOME}/.config/fish/secret.fish
set -Ua fish_user_paths {$HOME}/.dotfiles/bin