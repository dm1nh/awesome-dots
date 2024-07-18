-- Settings for Editor > Text Editor > External
-- Use External Editor: On
-- Exec Path: /usr/bin/nvim
-- Exec Flags: --server /home/dm1nh/.cache/nvim/server.pipe --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"

-- setup client-server for godot
local path = vim.fn.getcwd() .. "/project.godot"
local is_godot_root = vim.fn.findfile(path) == path

if is_godot_root then
	local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
	if not vim.uv.fs_stat(pipepath) then
		vim.fn.serverstart(pipepath)
	end
end

return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "gdscript",
			root = { "project.godot" },
		})
	end,
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "gdscript", "gdshader", "godot_resource" } },
	},
	{
		"mason.nvim",
		opts = { ensure_installed = { "gdtoolkit" } },
	},
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				["gdscript"] = { "gdlint" },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["gdscript"] = { "gdformat" },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				gdscript = {},
			},
		},
	},
}
