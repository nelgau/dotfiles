local opt = vim.opt

opt.termguicolors = true
opt.guicursor = ""
opt.mouse = "a"

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.hlsearch = false
opt.incsearch = false

-- Keep the diagnostics gutter open to prevent popping.
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.wrap = false

opt.updatetime = 50

vim.g.mapleader = " "
