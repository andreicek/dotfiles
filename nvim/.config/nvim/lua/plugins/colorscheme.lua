return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.o.background = "light"
    require("gruvbox").setup({
      contrast = "hard",
      overrides = {
        SignColumn = { bg = "NONE" },
      },
    })
    vim.cmd.colorscheme("gruvbox")
  end,
}
