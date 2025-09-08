return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').help_tags)
      vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').live_grep({ hidden = true }) end)
      vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string)
      vim.keymap.set('n', '<leader>p', function() require('telescope.builtin').find_files({ hidden = true }) end)
      vim.keymap.set('n', '<leader>o', require('telescope.builtin').git_files)
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_status)
      vim.keymap.set('n', '<leader>en', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end)
    end
  }
}
