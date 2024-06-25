vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.mouse = "" -- disable mouse

vim.opt.cmdheight = 0

vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.breakindent = false
vim.opt.smartindent = false

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

vim.opt.laststatus = 2

vim.opt.guicursor = "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:block-iCursor,r-cr-o:block-rCursor"
