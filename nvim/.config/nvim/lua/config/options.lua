local opt = vim.opt

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Line numbers
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Undo
opt.undofile = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Scroll
opt.scrolloff = 10
opt.sidescrolloff = 8

-- UI
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.wrap = false
opt.breakindent = true

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Treesitter-based highlighting and indentation (Neovim 0.11+)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Misc
opt.inccommand = "split"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
