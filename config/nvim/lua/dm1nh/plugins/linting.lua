return { -- linting
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  config = function()
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      lua = { "luacheck" },
      markdown = { "markdownlint" },
      gd = { "gdlint" },
      gdscript = { "gdlint" },
      gdscript3 = { "gdlint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
