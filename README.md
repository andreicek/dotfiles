# dotfiles

My dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's in here

- **git** — commit signing via 1Password, rebase-heavy workflow with fixup helpers, rerere, histogram diffs
- **zsh** — minimal prompt with git info, aliases, fzf/zoxide/mise integration, autosuggestions + syntax highlighting
- **kitty** — Gruvbox Dark, IBM Plex Mono, splits and tabs with super key bindings
- **zed** — Gruvbox Dark, Elixir/HEEX setup with mix format

## Usage

```
cd ~/.dotfiles
stow git zsh kitty zed
```

This symlinks everything into the right place under `$HOME`.

## Dependencies

Things I expect to have installed:

- [eza](https://github.com/eza-community/eza), [bat](https://github.com/sharkdp/bat), [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide)
- [mise](https://mise.jdx.dev/) for runtime/tool management
- [1Password](https://1password.com/) for SSH + commit signing
- zsh-autosuggestions, zsh-syntax-highlighting (system packages)
