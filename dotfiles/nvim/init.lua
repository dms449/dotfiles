vim.api.nvim_create_user_command(
  'FileManager',
  function()
    vim.b.VimuxOrientation = 'h'
    vim.b.VimuxHeight = '50'
    vim.b.VimuxCloseOnExit = true
    vim.call('VimuxRunCommandInDir', 'lf', 1)
    vim.call('VimuxTmux', 'select-pane'.." -t "..vim.g.VimuxRunnerIndex)
  end,
  {desc = 'Open lf file manager'}
)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
require("lazy").setup('plugins')
require('settings')
require('mappings')
