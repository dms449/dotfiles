return {
  { "machakann/vim-highlightedyank"},
  {
    "FooSoft/vim-argwrap",
    keys = { {"<leader>a", ":ArgWrap<CR>"}} ,
    init = function()
      vim.g.argwrap_padded_braces = '{'
    end
  },
  {
    "mbbill/undotree",
    keys = {{ "<F5>", ":UndotreeToggle<CR>"}}
  },

  {
    "joom/latex-unicoder.vim",
    init = function()
      vim.g.unicoder_no_map = 1
      vim.api.nvim_set_keymap('n', '<leader>l', ':call unicoder#start(0)<CR>', {})
    end
  },
  { "posva/vim-vue"},
  { "digitaltoad/vim-pug"},
  { "slim-template/vim-slim"},
  {
    "thoughtbot/vim-rspec",
    init=function()
      vim.g.rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
    end
  },

  { "ellisonleao/gruvbox.nvim",
    config = function ()
      vim.cmd([[colorscheme gruvbox]])
    end,
    priority = 1000
  },
}

