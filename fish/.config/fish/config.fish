###
# Path
###

fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin/

###
# Variables
###

set -Ux EDITOR nvim
set -Ux GPG_TTY "$(tty)"
set -Ux ERL_AFLAGS "-kernel shell_history enabled"
set fish_greeting

###
# Aliases
###

alias ls="eza --icons"
alias cat="bat --theme=ansi"
alias vim="nvim"

abbr gco "git checkout"
abbr gst "git status -sb"
abbr gc "git commit"
abbr gcm "git commit -m"
abbr ga "git add"
abbr gaa "git add -A"
abbr gap "git add --patch"
abbr gpl "git pull -r"
abbr gps "git push"
abbr gl "git log --oneline"
abbr e "zed"

###
# Plugins
###

zoxide init fish | source
mise activate fish | source
mise completion fish | source
fzf --fish | source

###
## Prompt
###

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  if [ (_git_branch_name) ]
    set git_info (_git_branch_name)
    set git_info ":$git_info"

    if [ (_is_git_dirty) ]
      set -l dirty "*"
      set git_info "$git_info$dirty"
    end
  end

  echo -n -s (basename (prompt_pwd)) $git_info "> "
end

function notify_long_tasks --on-event fish_postexec
    if test "$CMD_DURATION" -gt 5000
        set -l cmd_name (string split ' ' -- $argv)[1]

        if not contains $cmd_name ssh python psql node iex less cat
            set -l duration_sec (math "$CMD_DURATION / 1000")
            echo -e "\033]777;notify;Command finished in $duration_sec s;$argv\007"
        end
    end
end
