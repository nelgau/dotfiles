set number
set relativenumber

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space

set nowrap
set mouse=a

call plug#begin()

" Plug 'preservim/nerdtree'
Plug 'santiagovrancovich/nerdtree', {'branch': 'hotfix-issue-#1321'}
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tc50cal/vim-terminal'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set termguicolors
silent! colorscheme jellybeans

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1

let g:airline_powerline_fonts = 1
