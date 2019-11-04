let mapleader = "\Space"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
set omnifunc=syntaxcomplete#Complete
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin("~/.config/nvim")
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Servers/Clients stuff
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'JuliaEditorSupport/julia-vim'

" Completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'

" vim specific
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'https://tpope.io/vim/surround.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/kien/ctrlp.vim'
call plug#end()

" opening files, tags, buffers, or all
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>O :Files ~<CR>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMixed<CR>

" when splitting automatically offer to open file
nnoremap <leader>- :split \| :CtrlP<CR>
nnoremap <leader>\ :vsplit \| :CtrlP<CR>

nnoremap <leader>gg :GitGutterToggle<cr>
nmap <leader>gb <Plug>TigBlame
nmap <leader>y <Plug>TigLatestCommitForLine

inoremap jq <Esc>:wq<cr>
nnoremap <leader>gf :GFiles<CR>
"nnoremap <leader>gd :GFiles?<CR>
nnoremap <C-f> :Find<CR>

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
call ncm2#override_source('LanguageClient_python', {'enable': 0})
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" LanguageClient
" ---------------------------------------------------------
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'cuda': ['clangd'],
    \ 'objc': ['clangd'],
    \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    \     using LanguageServer;
    \     using Pkg;
    \     import StaticLint;
    \     import SymbolServer;
    \     env_path = dirname(Pkg.Types.Context().env.project_file);
    \     debug = false; 
    \     
    \     server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
    \     server.runlinter = true;
    \     run(server);
    \ '],
    \}

  " ncm2 
  " ---------------------------------------------------------
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " Affects the visual representation of what happens after you hit <C-x><C-o>
  " https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
  " https://neovim.io/doc/user/options.html#'completeopt'
  "
  " This will show the popup menu even if there's only one match (menuone),
  " prevent automatic selection (noselect) and prevent automatic text injection
  " into the current line (noinsert).
  set completeopt=noinsert,menuone,noselect

  " deoplete
  " ---------------------------------------------------------
  "autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  "let g:deoplete#enable_at_startup = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " fuzzy find
  set rtp+=~/.fzf
  set hidden
"
  " theme 
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

  " ctrlP 
  let g:ctrlp_user_command='rg --files %s'
  let g:ctrlp_use_caching = 0

  " set background=dark " for the dark version
