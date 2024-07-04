vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.mouse = "" -- disable mouse

opt.cmdheight = 0

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

opt.number = true
opt.relativenumber = false

opt.completeopt = "menu,menuone,noselect"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.breakindent = false
opt.smartindent = false

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 4
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50
opt.timeoutlen = 300

opt.laststatus = 2

opt.guicursor = "n-v-c-sm:block-Cursor/lCursor,i-ci-ve:block-iCursor,r-cr-o:block-rCursor"

opt.jumpoptions = "view"
