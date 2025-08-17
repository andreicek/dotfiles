return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
    local function toggle_theme()
      if vim.o.background == 'dark' then
        vim.o.background = 'light'
      else
        vim.o.background = 'dark'
      end

      vim.cmd.colorscheme 'solarized'
    end
    vim.api.nvim_create_user_command('ToggleTheme', toggle_theme, {})
  end,
}
