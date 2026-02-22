# dotfiles

My dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick start

```
curl -fsSL https://raw.githubusercontent.com/andreicek/dotfiles/master/install.sh | bash
```

Or manually:

```
git clone https://github.com/andreicek/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

The installer handles everything — APT packages, Docker, zoxide, mise, runtimes, Expert LSP, Claude Code, stow, and setting zsh as the default shell. It uses [gum](https://github.com/charmbracelet/gum) for progress output (installed automatically).

Re-running is safe — already-installed items are skipped.

## Manual stow

To re-stow individual packages:

```
cd ~/.dotfiles
stow git zsh bin nvim kitty mise
```
