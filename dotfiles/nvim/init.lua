function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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

require('plugins')
require('settings')
require('mappings')
require('plugin_config/coq')
require('plugin_config/fzf')
require('plugin_config/latex-unicoder')
require('plugin_config/lualine')
require('plugin_config/nvim-autopairs')
require('plugin_config/nvim-lspconfig')
require('plugin_config/nvim-treesitter')
require('plugin_config/nvim-treesitter-endwise')
require('plugin_config/tig')
require('plugin_config/undotree')
require('plugin_config/vcs-jump')
require('plugin_config/vim-argwrap')
require('plugin_config/vim-closetag')
require('plugin_config/vim-fugitive')
require('plugin_config/vim-rspec')
require('plugin_config/vim-ruby')
require('plugin_config/vim-tmux-navigator')

vim.api.nvim_command [[colorscheme gruvbox]]

