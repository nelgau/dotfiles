return require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    use('nvim-lualine/lualine.nvim')

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-treesitter/playground')

    use('gruvbox-community/gruvbox')

    -- OG config section

    -- use "preservim/nerdtree"
    use {'santiagovrancovich/nerdtree', branch = 'hotfix-issue-#1321'}

    use 'tpope/vim-commentary'
    use {'neoclide/coc.nvim', branch = 'release'}
end)
