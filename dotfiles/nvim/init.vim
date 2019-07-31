let mapleader = "\Space"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
set omnifunc=syntaxcomplete#Complete
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin("~/.config/nvim")
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'artur-shaik/vim-javacomplete2'
Plug 'JuliaEditorSupport/deoplete-julia'

" python
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
 


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

" deoplete
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" fuzzy find
set rtp+=~/.fzf
set hidden
