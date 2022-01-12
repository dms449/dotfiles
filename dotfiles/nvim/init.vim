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
" Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mattn/emmet-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
Plug 'digitaltoad/vim-pug'
Plug 'jelera/vim-javascript-syntax'
Plug 'thoughtbot/vim-rspec'
Plug 'benmills/vimux'

" Completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-syntax'
Plug 'ncm2/ncm2-ultisnips'
Plug 'wellle/tmux-complete.vim'
Plug 'JuliaEditorSupport/julia-vim'

" Git
"Plug 'tpope/vim-fugitive'

" vim specific
Plug 'SirVer/ultisnips'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
"Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
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
nnoremap <leader>F :Find<CR>
nnoremap <leader>s /<C-r><C-w><CR>
" nnoremap <leader>S :Find <C-r><C-w><CR>
nnoremap <leader>t :Tags <C-r><C-w><cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>b :Buffers <C-r><C-w><CR>
nnoremap <leader>B :Buffers <CR>
nnoremap <leader>gd :GFiles?<CR>


" RSpec.vim mappings
let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rr :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>


" when splitting automatically offer to open file
nnoremap <leader>- :split \| :PFiles<CR>
nnoremap <leader>\ :vsplit \| :PFiles<CR>

" other
nmap <leader>gb <Plug>TigBlame
nmap <leader>y <Plug>TigLatestCommitForLine
nmap <leader>. <Plug>RailsOpenAlt

" Language Client Mappings
nnoremap <F5> :call LanguageClient_contextMenu()<C-r><C-w><CR>
nnoremap <silent>K :call LanguageClient#textDocument_hover()<C-r><C-w><CR>
nnoremap <leader>df :call LanguageClient#textDocument_definition()<C-r><C-w><CR>
nnoremap <silent><F2> :call LanguageClient#textDocument_rename()<C-r><C-w><CR>


" LanguageClient
" ---------------------------------------------------------
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'cuda': ['clangd'],
    \ 'objc': ['clangd'],
    \ 'python': ['python3','-m', 'pyls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'ruby':['solargraph', 'stdio'], 
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
    \ ']}

" ncm2 
" --------------------------------------------------------------------------
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

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" 

" Devalue the LangueClient Suggestions
call ncm2#override_source('ultisnips', {'priority': 9})

" UltiSnips
" --------------------------------------------------------------------------
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger	= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

let g:latex_to_unicode_auto = 1

" vue
" --------------------------------------------------------------------------
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
function! Dashcase(word)
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)
  let word = substitute(word,'_','-','g')
  return word
endfunction
set includeexpr=Dashcase(v:fname)

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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"command! -bang -nargs=* Files call fzf#vim#files(<q-args>, <bang>0)

" :Files will preview the selected file
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" :PFiles (Project Files) is almost identical to GitFiles except it includes
"   files that have not been checked in to git
command! -bang PFiles 
    \ call fzf#vim#files(split(system('git rev-parse --show-toplevel'),'\n')[0], fzf#vim#with_preview(),<bang>0)


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

