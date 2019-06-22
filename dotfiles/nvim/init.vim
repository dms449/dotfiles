let mapleader = "\Space"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin("~/./config/nvim")
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-clang'
call plug#end()

inoremap jq <Esc>:wq<cr>
nnoremap <leader>b :Buffer<CR>
nnoremap <leader>/ :Files<CR>
nnoremap <leader>g :GFiles?<CR>
nnoremap <leader>ff :Ag<space>
nnoremap <leader>fs :Ag<space><c-R><c-W><CR>
nnoremap <leader>ft :Ag<space><c-R>"<CR>

nmap <leader>gb <Plug>TigBlame
nmap <leader>y <Plug>TigLatestCommitForLine

" fuzzy find
set rtp+=~/.fzf
set hidden
