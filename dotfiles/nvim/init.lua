-- Common
vim.o.mouse = 'a'
vim.o.hidden = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.path = vim.o.path .. '**'
vim.o.wildmenu = true
vim.o.smarttab = true
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.autoindent = true
vim.o.backspace = 'indent,start,eol'
vim.o.backupcopy = 'yes'
vim.o.colorcolumn = '80'
vim.o.encoding = 'utf-8'
vim.o.expandtab = true
vim.o.fileencoding = 'utf-8'
vim.o.foldlevelstart = 3
vim.o.foldmethod = 'syntax'
vim.o.gdefault = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.path = '.,app/javascript/**,frontend/src/**,src/**'
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 3
vim.o.shiftwidth = 2
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.suffixesadd = '.vue'
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 100
vim.o.undofile = true
vim.o.updatetime = 300
vim.o.visualbell = true
vim.o.winwidth = 90
vim.o.wrap = false

vim.g.mapleader = ' '
vim.g.netrw_banner = false
vim.g.netrw_liststyle = 3
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.netrw_liststyle = 3
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.coq_settings = {
   auto_start = 'shut-up', }

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.path = vim.o.path .. '**'

vim.wo.number = true
vim.wo.signcolumn = 'number'
vim.wo.colorcolumn = "120"
vim.wo.relativenumber = true

-- Plugins
require("packer").startup(
  function()
    use 'wbthomason/packer.nvim' -- generic vim
    use {"junegunn/fzf",
        run = function()
          vim.fn["fzf#install"]()
        end}
    use "junegunn/fzf.vim"
    use 'rstacruz/vim-closer'
    use 'machakann/vim-highlightedyank'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'FooSoft/vim-argwrap'

    -- Language specific
    use 'jelera/vim-javascript-syntax'
    use 'tpope/vim-rails'
    use 'posva/vim-vue'
    use 'digitaltoad/vim-pug'
    use 'slim-template/vim-slim'
    use 'benmills/vimux'
    -- use 'vim-ruby/vim-ruby'
    use 'thoughtbot/vim-rspec'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    -- use 'haorenW1025/completion-nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- completion
    use {
      'ms-jpq/coq_nvim',
      requires = {
         {'ms-jpq/coq.artifacts', branch = 'artifacts'},
         {'ms-jpq/coq.thirdparty', branch = '3p'},
      },
      branch = 'coq'
    }

    -- Theme
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use 'morhetz/gruvbox'
end)

function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>o", ":PFiles<CR>")
map("n", "<leader>f", ":Find <C-r><C-w><CR>")
map("n", "<leader>F", ":Find ")
map("n", "<leader>b", ":Buffers<CR>")
map("n", "<leader>t", ":Tags<CR>")
map("n", "<leader>-", ":split | :Files<CR>")
map("n", "<leader>\\", ":vsplit | :Files<CR>")

map("n", "<leader>jj", "<PageDown>")
map("n", "<leader>kk", "<PageUp>")

map("n", "<leader>rr", ":%s/\\C<C-r><C-w>/")
map("n", "<leader>s", "/<C-r><C-w><C-w>")

-- switch panes
map("n", "<leader>h", ":wincmd h<CR>")
map("n", "<leader>j", ":wincmd j<CR>")
map("n", "<leader>k", ":wincmd k<CR>")
map("n", "<leader>l", ":wincmd l<CR>")

-- plugins
map("n", "<leader>gg", ":GitGutterToggle<CR>")
map("n", "<leader>a", ":ArgWrap<CR>")


-- ============================= Theme ==============================
-- colorscheme
-- status bar
require('lualine').setup {
  options = { theme = 'gruvbox_dark' }
}
vim.api.nvim_command [[colorscheme gruvbox]]


-- ============================= requires ==============================

local coq = require "coq"
require('nvim-lspconfig')

require('plugin_config/auto-pairs')
require('plugin_config/fzf')
require('plugin_config/tig')
require('plugin_config/undotree')
require('plugin_config/vcs-jump')
require('plugin_config/vim-argwrap')
require('plugin_config/vim-closetag')
require('plugin_config/vim-rspec')
require('plugin_config/vim-ruby')
require('plugin_config/vim-tmux-navigator')

