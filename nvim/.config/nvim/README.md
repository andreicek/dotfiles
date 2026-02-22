# Neovim Config

## Setup

All prerequisites (neovim, tree-sitter, Expert LSP, wl-clipboard) are handled by the dotfiles installer:

```sh
cd ~/.dotfiles && bash install.sh
```

After install, launch `nvim` — lazy.nvim bootstraps itself, installs all plugins, and compiles Treesitter parsers automatically. Run `:Mason` to verify `lua_ls` and `stylua` are installed.

### Formatters

- **stylua** — installed automatically via Mason
- **mix format** — ships with Elixir
- **prettier** (optional, for JSON/YAML/Markdown) — `npm i -g prettier`

## Keymaps

Leader key: `Space`

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>sg` | Grep |
| `<leader>gg` | Lazygit |
| `<leader>,` | Switch buffer |
| `\` | Toggle Neo-tree |
| `<C-/>` | Toggle terminal |
| `gd` | Goto definition |
| `gr` | Goto references |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>tn` | Run nearest test |

Run `<leader>sk` to search all keymaps.
