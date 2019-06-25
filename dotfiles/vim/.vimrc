let mapleader="\<Space>"

" set some variables
set list
set tabstop=2
set autoindent
set shiftwidth=2
set softtabstop=2
set expandtab
syntax on
set backspace=indent,eol,start
set colorcolumn=80
set encoding=utf-8
set fileencoding=utf-8
set laststatus=2
set nowrap
set nrformats-=octal
set number
set relativenumber
set ruler
set scrolloff=1
set showcmd
set showmatch
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set splitright
set splitbelow

" mappings [Normal]
nnoremap <leader>jj <PageDown>
nnoremap <leader>kk <PageUp>
nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>

" mappings [Insert]
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap <C-k> <Esc>:m-2<CR>
inoremap <C-j> <Esc>:m+<CR>

" mappings [Visual and Select]"
" vnoremap 
