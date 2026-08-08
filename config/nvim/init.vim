" NeoVim Config

filetype plugin on
syntax on

set nocompatible
set number
set encoding=utf-8
set clipboard+=unnamedplus   " using system clipboard
"set foldmethod=indent

" Cursor settings
set shiftwidth=2 smarttab
set expandtab
set tabstop=8 softtabstop=0

" Keymaps
"let mapleader=","
let mapleader="\<space>"
map gf :edit <cfile><cr>
nnoremap <leader>tc :set cursorline!<CR>
nnoremap <leader>tg :Goyo<bar><CR>
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>q :bd<CR>
"nnoremap <leader><space> zO<CR>
nnoremap <c-q> :q<CR>
nnoremap <c-f><c-q> :q!<CR>
nnoremap <c-s><c-s> :w<CR>
nnoremap <c-s><c-q> :wq<CR>

" Looks
hi Normal guibg=NONE ctermbg=NONE

