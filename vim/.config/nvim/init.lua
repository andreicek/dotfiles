-- Notes:
--
--    - https://github.com/nanotee/nvim-lua-guide - a guide to using Lua in Neovim,
--
vim.opt.backspace     = "2"
vim.opt.wildmenu      = true
vim.opt.wildmode      = "list:longest"
vim.opt.autoindent    = true
vim.opt.showmatch     = true
vim.opt.ignorecase    = true
vim.opt.ruler  	      = true
vim.opt.number        = true
vim.opt.wrap          = false
vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2
vim.opt.expandtab     = true
vim.opt.mouse         = "a"
vim.opt.syntax        = "on"
vim.opt.termguicolors = true
vim.opt.background    = "dark"
vim.opt.grepprg       = "rg --vimgrep --hidden"
vim.opt.grepformat    = "%f:%l:%c:%m"
vim.opt.omnifunc      = "vim.lsp.omnifunc"
vim.opt.guicursor     = ""
vim.g.mix_format_on_save = "1"

vim.cmd('colorscheme NeoSolarized')

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

vim.api.nvim_set_keymap("n", "<c-s>i", "<cmd>LspInfo<cr>",        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-s>l", "<cmd>LspLog<cr>",         { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-f>",  ":silent lgrep<Space>",    { noremap = true })
vim.api.nvim_set_keymap("n", "<c-p>",  "<cmd>GFiles!<cr>",        { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "8",      "<cmd>Git blame<cr>",      { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "9",      "<cmd>NERDTreeToggle<cr>", { noremap = true, silent = true })

-- Opening quickfix window everytime searching happens:
--
--    - vim -> lua tips: https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42
--    - navigating quickfix: https://stackoverflow.com/a/55305200/80851

local autoquickfix = vim.api.nvim_create_augroup("Highlights", { clear = true })

vim.api.nvim_create_autocmd("QuickFixCmdPost", { command = "cwindow", group = autoquickfix, pattern = "[^l]*" })
vim.api.nvim_create_autocmd("QuickFixCmdPost", { command = "lwindow", group = autoquickfix, pattern = "l*" })

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.lsp.set_log_level 'info'

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require('packer').startup(function(use)
  use 'tpope/vim-unimpaired'
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use 'junegunn/fzf.vim'
  use 'tpope/vim-rhubarb'
  use 'elixir-lang/vim-elixir'
  use 'scrooloose/nerdtree'
  use 'tpope/vim-fugitive'
  use 'jlanzarotta/bufexplorer'
  use 'neovim/nvim-lspconfig'
  use 'mhinz/vim-mix-format'
  use 'overcache/NeoSolarized'
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  
  if packer_bootstrap then
    require('packer').sync()
  end
  
end)
