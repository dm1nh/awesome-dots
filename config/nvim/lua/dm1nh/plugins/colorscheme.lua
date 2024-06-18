return {
  { -- galax colorscheme
    dir = "~/repos/galax.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("galax").setup({ compile = false })
      vim.cmd("colorscheme galax")
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
}
