fish_add_path /opt/homebrew/bin
fish_add_path ~/.bin

source ~/.asdf/asdf.fish
zoxide init fish | source

if status is-interactive
    set -Ux EDITOR vim
    set -Ux TERM xterm
    set -Ux LOLCOMMITS_DELAY 5
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

    alias cat bat
    alias rm trash

    alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
end

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

function fish_greeting
    lolcat ~/.dotfiles/fish/.config/fish/motd.txt
end
