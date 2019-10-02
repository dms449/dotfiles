let mapleader = "\Space"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
set omnifunc=syntaxcomplete#Complete
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin("~/.config/nvim")
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'JuliaEditorSupport/deoplete-julia'

" Deoplete (Completetion)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/deoplete-zsh'
Plug 'Shougo/deoplete-clangx'

" vim specific
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'https://tpope.io/vim/surround.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'

 


call plug#end()

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>gg :GitGutterToggle<cr>
nnoremap <leader>gg :GitGutterToggle<cr>
"nnoremap <leader>ff :Ag<space>
"nnoremap <leader>fs :Ag<space><c-R><c-W><CR>
"nnoremap <leader>ft :Ag<space><c-R>"<CR>



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

" airline theme stuff
let g:airline_theme='deus'
let g:airline_powerline_fonts=1
"let g:airline_statusline_ontop=1

" git gutter 

" set background=dark " for the dark version
