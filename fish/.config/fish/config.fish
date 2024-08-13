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

###
# Aliases
###

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

###
# Prompt
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

###
# Plugins
###

zoxide init fish | source
mise activate fish | source
