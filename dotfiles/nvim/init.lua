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
    use 'wbthomason/packer.nvim'

    -- generic vim
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

function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>o", ":Files<CR>")
map("n", "<leader>f", ":Find <C-r><C-w><CR>")

map("n", "<leader>J", "<PageDown>")
map("n", "<leader>K", "<PageUp>")
-- switch panes
map("n", "<leader>h", ":wincmd h<CR>")
map("n", "<leader>j", ":wincmd j<CR>")
map("n", "<leader>k", ":wincmd k<CR>")
map("n", "<leader>l", ":wincmd l<CR>")


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
