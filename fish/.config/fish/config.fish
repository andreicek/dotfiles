fish_add_path -g -m /usr/local/bin /usr/bin /bin

set -gx EDITOR nvim
set -gx GPG_TTY (tty)
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -g fish_greeting

if status is-interactive
  mise activate fish --shims | source
  mise completion fish | source
  zoxide init fish | source
  fzf --fish | source
end

