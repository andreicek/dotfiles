return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      local statusline = require 'mini.statusline'

      local original_active = statusline.active

      statusline.active = function()
        local statusline_content = original_active()

        if vim.fn.reg_recording() ~= '' then
          local recording_reg = vim.fn.reg_recording()
          return " Recording @" .. recording_reg .. " " .. statusline_content
        end

        return statusline_content
      end

      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
