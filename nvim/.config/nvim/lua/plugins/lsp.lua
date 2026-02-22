return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/lazydev.nvim",
    },
    config = function()
      -- Setup lazydev for Neovim Lua API completions
      require("lazydev").setup()

      -- Setup fidget for LSP progress
      require("fidget").setup()

      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      -- Shared capabilities (blink.cmp provides these)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("gr", function() Snacks.picker.lsp_references() end, "Goto References")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("K", vim.lsp.buf.hover, "Hover Documentation")
        end,
      })

      -- Expert Elixir LSP (native vim.lsp.config for Neovim 0.11+)
      vim.lsp.config("expert", {
        cmd = { vim.fn.expand("~/.local/bin/expert"), "--stdio" },
        filetypes = { "elixir", "eelixir", "heex" },
        root_markers = { "mix.exs", ".git" },
        capabilities = capabilities,
      })
      vim.lsp.enable("expert")

      -- lua_ls via native API
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
}
