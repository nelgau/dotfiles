vim.g.NERDTreeShowHidden = 1

vim.g.NERDTreeDirArrowExpandable = '+'
vim.g.NERDTreeDirArrowCollapsible = '~'

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nerdtree",
  callback = function()
    vim.opt_local.signcolumn = "no"
  end,
})
