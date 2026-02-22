return {
  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>s", group = "Search" },
        { "<leader>g", group = "Git" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>t", group = "Test" },
        { "<leader>h", group = "Hunk" },
        { "<leader>r", group = "Rename" },
        { "<leader>u", group = "UI" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>a", group = "AI" },
      },
    },
  },

  -- TODO/FIXME highlighting
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
      { "<leader>xt", "<cmd>TodoQuickFix<CR>", desc = "TODO Quickfix" },
    },
  },

  -- Auto-detect indentation
  { "tpope/vim-sleuth" },
}
