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
nnoremap <leader>f :Find<CR>
nnoremap <leader>F :Files ~<CR>
nnoremap <leader>g :GFiles?<CR>
"nnoremap <leader>ff :Ag<space>
"nnoremap <leader>fs :Ag<space><c-R><c-W><CR>
"nnoremap <leader>ft :Ag<space><c-R>"<CR>


nmap <leader>gb <Plug>TigBlame
nmap <leader>y <Plug>TigLatestCommitForLine

" deoplete
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" fuzzy find
set rtp+=~/.fzf
set hidden

" nvim theme 
" ---------------------------------------------------------------
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


colorscheme minimalist
" set background=dark " for the dark version
