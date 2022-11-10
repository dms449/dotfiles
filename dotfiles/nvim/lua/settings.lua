local home = vim.env.HOME
local config = home .. '/.config/nvim'

vim.o.mouse = 'a'
vim.o.hidden = true
vim.o.completeopt="menuone,noinsert,noselect"
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
vim.o.expandtab = true vim.o.fileencoding = 'utf-8' vim.o.foldlevelstart = 3
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
vim.opt.iskeyword:append({'-'})

vim.g.mapleader = ' '
vim.g.netrw_banner = false
vim.g.netrw_liststyle = 3
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.gruvbox_contrast_dark = 'hard'

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.path = vim.o.path .. '**'

vim.wo.number = true
vim.wo.colorcolumn = "120"
vim.wo.relativenumber = true
