let mapleader="\<Space>"

" set some variables
syntax on
set tabstop=2
set list
set autoindent
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set colorcolumn=80
set clipboard+=unnamedplus
set encoding=utf-8
set fileencoding=utf-8
set laststatus=2
set nrformats-=octal
set number
set relativenumber
set ruler
set scrolloff=1
set mouse=a
set showcmd
set showmatch
set timeout
set timeoutlen=1000
set ttimeoutlen=100
set splitright
set splitbelow

" searching
set hlsearch
set ignorecase
set smartcase
set gdefault
set incsearch

" mappings [Normal]
nnoremap <leader>J <PageDown>
nnoremap <leader>K <PageUp>
nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
nnoremap <leader>z <C-w>_<CR>
nnoremap <leader>Z <C-w>=<CR>
nnoremap <Leader>rr :%s/\C<C-r><C-w>/

" mappings [Visual and Select]"

" movement between splits
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>


