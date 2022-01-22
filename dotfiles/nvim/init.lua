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

vim.g.mapleader = ' '
vim.g.netrw_banner = false

vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.path = vim.o.path .. '**'

vim.wo.number = true
vim.wo.signcolumn = 'number'
vim.wo.colorcolumn = "120"
vim.wo.relativenumber = true


-- Plugins
require("packer").startup(
  function()
    use 'wbthomason/packer.nvim'

    -- generic vim
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'rstacruz/vim-closer'
    use 'machakann/vim-highlightedyank'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-eunuch'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    -- use 'haorenW1025/completion-nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- completion
    use {'ms-jpq/coq_nvim', branch = 'coq'}


    -- Theme
    use 'nvim-lualine/lualine.nvim'
    use 'morhetz/gruvbox'
end)


-- ============================= Theme ==============================
-- colorscheme
-- status bar
require('lualine').setup {
  options = { theme = 'gruvbox_dark' }
}

-- vim.cmd [[set termguicolors]]
 vim.api.nvim_command [[let g:gruvbox_contrast_dark='hard']]
 vim.api.nvim_command [[colorscheme gruvbox]]
-- why isn't this working?
-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.g.colorscheme = 'gruvbox'

-- ============================= LSP ==============================
local lsp = require "lspconfig"
local coq = require "coq"

lsp.julials.setup{}
lsp.cssls.setup{}
lsp.eslint.setup{}
-- require'lspconfig'.bashls.setup{}
-- lsp.<server>.setup(coq.lsp_ensure_capabilities(<stuff...>)) -- after
