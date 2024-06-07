return {
	{
		"elixir-tools/elixir-tools.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local elixir = require("elixir")

			elixir.setup({
				nextls = {
					enable = true,
					spitfire = false,
					init_options = {
						experimental = {
							completions = {
								enable = true,
							},
						},
					},
				},
				credo = { enable = false },
				elixirls = { enable = false },
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"elixir",
				"heex",
				"eex",
			})
		end,
	},
}
