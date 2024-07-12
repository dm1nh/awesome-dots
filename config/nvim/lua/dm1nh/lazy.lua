local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "dm1nh.plugins" },

    -- debug
    -- { import = "dm1nh.plugins.extras.dap.core" },

    -- languages
    { import = "dm1nh.plugins.extras.lang.astro" },
    { import = "dm1nh.plugins.extras.lang.clangd" },
    { import = "dm1nh.plugins.extras.lang.cmake" },
    { import = "dm1nh.plugins.extras.lang.docker" },
    -- { import = "dm1nh.plugins.extras.lang.go" },
    { import = "dm1nh.plugins.extras.lang.godot" },
    { import = "dm1nh.plugins.extras.lang.json" },
    { import = "dm1nh.plugins.extras.lang.markdown" },
    -- { import = "dm1nh.plugins.extras.lang.python" },
    -- { import = "dm1nh.plugins.extras.lang.rust" },
    -- { import = "dm1nh.plugins.extras.lang.svelte" },
    -- { import = "dm1nh.plugins.extras.lang.toml" },
    { import = "dm1nh.plugins.extras.lang.tailwind" },
    { import = "dm1nh.plugins.extras.lang.typescript" },
    -- { import = "dm1nh.plugins.extras.lang.vue" },
    { import = "dm1nh.plugins.extras.lang.yaml" },

    -- linting
    { import = "dm1nh.plugins.extras.linting.eslint" },

    -- formatting
    { import = "dm1nh.plugins.extras.formatting.prettier" },
  },
  checker = {
    enabled = false,
  },
})
