return {
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    keys = {
      { "<C-h>", ":TmuxNavigateLeft<CR>" },
      { "<C-j>", ":TmuxNavigateDown<CR>" },
      { "<C-k>", ":TmuxNavigateUp<CR>" },
      { "<C-l>", ":TmuxNavigateRight<CR>"},
    }
  },
  {
    "preservim/vimux",
  }

}
