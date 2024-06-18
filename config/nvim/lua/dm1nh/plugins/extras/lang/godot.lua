-- Settings for Editor > Text Editor > External
-- Use External Editor: On
-- Exec Path: /usr/bin/nvim
-- Exec Flags: --server /home/dm1nh/.cache/nvim/server.pipe --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"

-- setup client-server for godot
local path = vim.fn.getcwd() .. "/project.godot"
local is_gdproject = vim.fn.findfile(path) == path

if is_gdproject then
  local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
  if not vim.uv.fs_stat(pipepath) then
    vim.fn.serverstart(pipepath)
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gdscript", "gdshader", "godot_resource" })
      end
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gdtoolkit" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["gdscript"] = { "gdlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["gdscript"] = { "gdformat" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
      },
    },
  },
}
