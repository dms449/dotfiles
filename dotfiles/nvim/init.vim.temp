let mapleader = "\Space"

set runtimepath^=~/.vim runtimepath+=~/.vim/after
set omnifunc=syntaxcomplete#Complete
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin("~/.config/nvim")
Plug 'junegunn/fzf', { 'dir': '~/.fzf/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


" Language specific
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'tpope/vim-rails'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
Plug 'digitaltoad/vim-pug'
Plug 'jelera/vim-javascript-syntax'
Plug 'thoughtbot/vim-rspec'
Plug 'benmills/vimux'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-syntax'
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'wellle/tmux-complete.vim'
Plug 'JuliaEditorSupport/julia-vim'

" Git
Plug 'tpope/vim-fugitive'

" vim specific
Plug 'kthibodeaux/tig.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

set clipboard+=unnamedplus

" opening files, tags, buffers, or all

nnoremap <leader>o :Files<CR>
nnoremap <leader>O :Files ~<CR>
nnoremap <leader>f :Find <C-r><C-w><CR>
nnoremap <leader>F :Find
nnoremap <leader>s /<C-r><C-w><CR>
" nnoremap <leader>S :Find <C-r><C-w><CR>
nnoremap <leader>t :Tags <C-r><C-w><CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>b :Buffers<CR>
" nnoremap <leader>gf :GFiles?<CR>
nnoremap <leader>gd :Git diff<CR>

" when splitting automatically offer to open file
nnoremap <leader>- :split \| :PFiles<CR>
nnoremap <leader>\ :vsplit \| :PFiles<CR>

" other
" let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
nmap <leader>gb <Plug>TigBlame
nmap <leader>y <Plug>TigLatestCommitForLine
nmap <leader>. <Plug>RailsOpenAlt


" {{{ coc.vim
" {{{ functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}
" {{{ mappings
let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
inoremap <silent><expr> <c-n> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" :coc#refresh()
inoremap <expr><S-c-n> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" Use <c-n> to trigger completion.
inoremap <silent><expr> <c-n> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <tab> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" }}}
" {{{ commands
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" }}}
" {{{ snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_prev = '<c-p>'
let g:coc_snippet_next = '<c-n>'
" }}}
" {{{ extensions
let g:coc_global_extensions = [
      \'coc-css',
      \'coc-eslint',
      \'coc-html',
      \'coc-json',
      \'coc-snippets',
      \'coc-solargraph',
      \'coc-tsserver',
      \'coc-vetur',
      \'coc-yaml',
      \]

" LanguageClient
" ---------------------------------------------------------
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_serverCommands = {
"     \ 'c': ['clangd'],
"     \ 'cpp': ['clangd'],
"     \ 'cuda': ['clangd'],
"     \ 'objc': ['clangd'],
"     \ 'python': ['python3','-m', 'pyls'],
"     \ 'javascript': {
"     \   'name': 'typescript-language-server',
"     \   'command': ['typescript-language-server', '--stdio'],
"     \   'initializationOptions': {
"     \     'preferences': {
"     \     },
"     \   },
"     \ },
"     \ 'typescript': ['typescript-language-server', '--stdio'],
"     \ 'ruby':['solargraph', 'stdio'],
"     \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
"     \     using LanguageServer;
"     \     using Pkg;
"     \     import StaticLint;
"     \     import SymbolServer;
"     \     env_path = dirname(Pkg.Types.Context().env.project_file);
"     \     debug = false;
"     \
"     \     server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
"     \     server.runlinter = true;
"     \     run(server);
"     \ ']}

set completefunc=LanguageClient#complete


" ncm2
" --------------------------------------------------------------------------
" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
" set completeopt=noinsert,menuone,noselect

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Devalue the LangueClient Suggestions
" call ncm2#override_source('ultisnips', {'priority': 9})

" UltiSnips
" --------------------------------------------------------------------------
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger	= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

let g:latex_to_unicode_auto = 1

" vue
" --------------------------------------------------------------------------
" Vue `gf` for components
function! Dashcase(word)
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)
  let word = substitute(word,'_','-','g')
  return word
endfunction
set suffixesadd=.vue
set includeexpr=Dashcase(v:fname)
set path=.,app/javascript/**,frontend/src/**
let g:vim_vue_plugin_config = {
    \'syntax': {
    \   'template': ['pug'],
    \   'script': ['javascript'],
    \   'style': ['css'],
    \},
    \'full_syntax': [],
    \'initial_indent': [],
    \'attribute': 0,
    \'keyword': 0,
    \'foldexpr': 0,
    \'debug': 0,
    \} "
let g:vue_pre_processors = ['pug', 'scss']

" Vue `gf` for components
set suffixesadd=.vue
set path=.,app/javascript/**,frontend/src/**

" TMUX
" --------------------------------------------------------------------------
" NOTE: I don't remember what this does.
" This is for VIM in TMUX
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" FZF
" --------------------------------------------------------------------------
set rtp+=~/.fzf
set hidden

" define Find: functionality
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"command! -bang -nargs=* Files call fzf#vim#files(<q-args>, <bang>0)

" :Files will preview the selected file
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" :PFiles (Project Files) is almost identical to GitFiles except it includes
"   files that have not been checked in to git
command! -bang PFiles
    \ call fzf#vim#files(split(system('git rev-parse --show-toplevel'),'\n')[0], fzf#vim#with_preview(),<bang>0)

" set -U FZF_DEFAULT_OPTS " \
"          --multi --cycle --keep-right -1 \
"          --height=80% --layout=reverse --info=default \
"          --preview-window right:50%:wrap \
"          --preview '__fzf_preview {}' \
"          --ansi"

"
" theme
" --------------------------------------------------------------------------
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

" setup theme
" -----------
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic='1'
colorscheme gruvbox

" airline theme stuff
let g:airline_theme='deus'
let g:airline_powerline_fonts=1



" Lens
" ----
let g:lens#disabled=0
let g:lens#animate=1

" Undo config
set undofile
set undodir=~/.config/nvim/undodir
