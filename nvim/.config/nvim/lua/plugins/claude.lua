return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send to Claude" },
  },
}
