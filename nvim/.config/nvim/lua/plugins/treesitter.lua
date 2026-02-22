local parsers = {
  "bash",
  "diff",
  "elixir",
  "heex",
  "eex",
  "html",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "regex",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter").install(parsers, { force = true })
  end,
  config = function()
    -- Install missing parsers on startup
    local installed = require("nvim-treesitter.config").get_installed()
    local missing = vim.tbl_filter(function(p)
      return not vim.list_contains(installed, p)
    end, parsers)
    if #missing > 0 then
      require("nvim-treesitter").install(missing)
    end
  end,
}
