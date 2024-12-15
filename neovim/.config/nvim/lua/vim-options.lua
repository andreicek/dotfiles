-- Make line numbers default
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = ''
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.keymap.set('v', ',y', '"*y', { desc = 'Copy to clipboard' })
vim.keymap.set('v', ',;', '"*p', { desc = 'Paste from clipboard' })
vim.keymap.set('n', ',;', '"*p', { desc = 'Paste from clipboard' })
vim.keymap.set('v', '<C-j>', '}', { desc = 'Move down paragraph' })
vim.keymap.set('v', '<C-k>', '{', { desc = 'Move up paragraph' })

vim.keymap.set('n', '<C-f>', vim.lsp.buf.signature_help, { desc = 'LSP signature help' })
vim.keymap.set('n', ',f', function()
  vim.diagnostic.open_float { border = 'rounded' }
end, { desc = 'Floating diagnostic' })

vim.keymap.set('n', '<leader>rb', '<cmd>Gitsigns reset_buffer<CR>', { desc = 'Reset Buffer' })
vim.keymap.set('n', ',n', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Next hunk' })
vim.keymap.set('n', ',<leader>', '<cmd>nohlsearch<CR>', { desc = 'Remove highlights' })
vim.keymap.set('n', '<C-j>', '}', { desc = 'Move down paragraph' })
vim.keymap.set('n', '<C-k>', '{', { desc = 'Move up paragraph' })
vim.keymap.set('n', ',t', ':TestNearest<CR>', { desc = 'Test nearest' })
vim.keymap.set('n', ',T', ':TestFile<CR>', { desc = 'Test file' })
vim.keymap.set('n', ',l', ':TestLast<CR>', { desc = 'Test last' })
vim.keymap.set('n', ',s', ':Trouble document_diagnostics<CR>', { desc = 'Trouble document diagnostics' })
vim.keymap.set('n', '<space>i', '<cmd>TSToolsOrganizeImports<CR>', { desc = 'Organize imports' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Move down (wrap)' })
vim.keymap.set('n', 'k', 'gk', { desc = 'Move up (wrap)' })
vim.keymap.set('n', '*', '*``', { desc = 'Search word under cursor' })

vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', ':m .+2<CR>==', { desc = 'Move line down' })

-- User command
vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('File path copied to clipboard: ' .. path)
end, {})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
