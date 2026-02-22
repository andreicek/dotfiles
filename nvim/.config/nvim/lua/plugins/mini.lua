return {
  "echasnovski/mini.nvim",
  config = function()
    -- Statusline
    require("mini.statusline").setup()

    -- Surround (sa, sd, sr)
    require("mini.surround").setup()

    -- a/i textobjects (function, argument, etc.)
    require("mini.ai").setup()

    -- Auto-pairs
    require("mini.pairs").setup()
  end,
}
