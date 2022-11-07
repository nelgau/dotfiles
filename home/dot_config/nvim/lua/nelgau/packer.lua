return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- use "preservim/nerdtree"
    use {'santiagovrancovich/nerdtree', branch = 'hotfix-issue-#1321'}

    use 'tpope/vim-commentary'
    use 'vim-airline/vim-airline'
    use 'rafi/awesome-vim-colorschemes'
    use 'tc50cal/vim-terminal'
    use {'neoclide/coc.nvim', branch = 'release'}

    -- Lua port is available: https://github.com/ellisonleao/gruvbox.nvim
    use 'morhetz/gruvbox'
end)
