return {
	{ -- disable neotree
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},

	{ -- override mini.files
		"echasnovski/mini.files",
		opts = {
			windows = { preview = false },
		},
		keys = {
			{
				"<leader>e",
				function()
					if not require("mini.files").close() then
						require("mini.files").open(vim.uv.cwd(), true)
					end
				end,
				desc = "Explorer (cwd)",
			},
			{
				"<leader>E",
				function()
					if not require("mini.files").close() then
						require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
					end
				end,
				desc = "Explorer (Current File)",
			},
		},
	},

	{ -- override which-key
		"folke/which-key.nvim",
		opts = {
			icons = {
				mappings = false,
			},
			show_help = false,
			show_keys = false,
		},
	},
}
