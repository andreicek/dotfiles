alias ls "exa --long --git"
alias rm "trash"
alias cat "bat"
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

function touchbar_prompt
  if type -q it2setkeylabel
    set -l pwd (prompt_pwd)
    set -l git_branch (git branch ^/dev/null | grep \* | sed 's/* //')
    if test "$git_branch" = ""
      it2setkeylabel set status "$pwd"
    else
      it2setkeylabel set status "$pwd ($git_branch)"
    end
  end
end

function fish_prompt
  touchbar_prompt
  set_color $fish_color_cwd
  echo -n (basename $PWD)
  set_color normal
  echo -n ' ) '
end

set -gx EDITOR "vim"
test -e {$HOME}/.config/fish/secret.fish; and source {$HOME}/.config/fish/secret.fish
set -Ua fish_user_paths {$HOME}/.dotfiles/bin

if type -q it2setkeylabel
  function ssh
    it2setkeylabel set status "ssh $argv"
    /usr/bin/ssh $argv
  end
end
