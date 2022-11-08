local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.wrap = false
opt.mouse = "a"

opt.termguicolors = true

-- Keep the diagnostics gutter open to prevent popping.
opt.signcolumn = "yes:1"
