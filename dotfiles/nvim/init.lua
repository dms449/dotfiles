-- Common
vim.o.mouse = 'a'
vim.o.hidden = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.path = vim.o.path .. '**'
vim.o.wildmenu = true
vim.o.smarttab = true
vim.o.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = ' '
vim.g.netrw_banner = false
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.coq_settings = {
   auto_start = 'shut-up',
}

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.path = vim.o.path .. '**'

vim.wo.number = true
vim.wo.signcolumn = 'number'
vim.wo.colorcolumn = "120"
vim.wo.relativenumber = true

-- require('packer.lua')
-- require('lua.lsp.lua')

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

map("n", "<leader>J", "<PageDown>")
map("n", "<leader>K", "<PageUp>")

-- switch panes
map("n", "<leader>h", ":wincmd h<CR>")
map("n", "<leader>j", ":wincmd j<CR>")
map("n", "<leader>k", ":wincmd k<CR>")
map("n", "<leader>l", ":wincmd l<CR>")

-- plugins
map("n", "<leader>gg", ":GitGutterToggle<CR>")


-- ============================= Theme ==============================
-- colorscheme
-- status bar
require('lualine').setup {
  options = { theme = 'gruvbox_dark' }
}
vim.api.nvim_command [[colorscheme gruvbox]]

-- ============================= LSP ==============================
-- local lsp = require "lspconfig"
local coq = require "coq"
require('nvim-lspconfig')


-- :PFiles (Project Files) is almost identical to GitFiles except it includes
--   files that have not been checked in to git
vim.api.nvim_command [[command! -bang PFiles call fzf#vim#files(split(system('git rev-parse --show-toplevel'),'\n')[0], fzf#vim#with_preview(),<bang>0)]]


-- define Find: functionality
vim.api.nvim_command [[command! -bang -nargs=* Find call fzf#vim#grep('rg --column --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)]]
