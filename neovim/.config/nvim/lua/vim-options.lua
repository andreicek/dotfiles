vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = ''
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
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

vim.api.nvim_create_user_command('CopyPathAbs', function()
  local path = vim.fn.expand '%:p' -- absolute path
  vim.fn.setreg('+', path)
  print('Absolute path copied to clipboard: ' .. path)
end, {})

vim.api.nvim_create_user_command('CopyPath', function()
  local path = vim.fn.expand '%' -- relative path
  vim.fn.setreg('+', path)
  print('Relative path copied to clipboard: ' .. path)
end, {})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
