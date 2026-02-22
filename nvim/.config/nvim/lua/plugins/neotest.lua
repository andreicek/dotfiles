return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "jfpedroza/neotest-elixir",
  },
  keys = {
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Run Nearest Test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File Tests" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last Test" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test Output" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test Summary" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-elixir"),
      },
    })
  end,
}
