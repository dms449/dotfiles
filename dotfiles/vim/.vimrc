let mapleader="\<Space>"

" set some variables
set tabstop=2
set list
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
nnoremap <leader>J <PageDown>
nnoremap <leader>K <PageUp>
nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
nnoremap <leader>z <C-w>_<CR>
nnoremap <leader>Z <C-w>=<CR>
nnoremap <leader>- :split \| :GFiles<CR>
nnoremap <leader>\ :vsplit \| :GFiles<CR>
nnoremap <Leader>s /<C-r><C-w><CR>
nnoremap <Leader>r :%s/<C-r><C-w>/

inoremap jq <Esc>:wq<cr>
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>f :Find<CR>
nnoremap <leader>o :GFiles<CR>
nnoremap <leader>O :Files ~<CR>
nnoremap <leader>gd :GFiles?<CR>

nmap <leader>gb <Plug>TigBlame
nmap <leader>y <Plug>TigLatestCommitForLine
" mappings [Insert]
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap <C-k> <Esc>:m-2<CR>
" inoremap <C-j> <Esc>:m+<CR>

" mappings [Visual and Select]"
" vnoremap 

" movement between splits
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" This is for VIM in TMUX
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" setup theme
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic='1'
colorscheme gruvbox

" define Find: functionality
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
