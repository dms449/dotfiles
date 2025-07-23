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

vim.g.mapleader = " "
require('config.lazy')
require('settings')
require('mappings')
require('commands')
