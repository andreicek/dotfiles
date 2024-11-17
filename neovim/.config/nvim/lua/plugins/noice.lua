return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        cmdline = {
          enabled = true,
          view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
          opts = { buf_options = { filetype = 'vim' } },
          icons = {
            ['/'] = { icon = ' ', hl_group = 'DiagnosticWarn' },
            ['?'] = { icon = ' ', hl_group = 'DiagnosticWarn' },
            [':'] = { icon = ' ', hl_group = 'DiagnosticInfo', firstc = false },
          },
        },
        popupmenu = {
          enabled = true,
          backend = 'nui', -- backend to use to show regular cmdline completions
        },
      }
    end,
  },
}
