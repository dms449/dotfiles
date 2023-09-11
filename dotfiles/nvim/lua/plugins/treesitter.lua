return {
  {
    "RRethy/nvim-treesitter-endwise",
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')
      local ts_conds = require('nvim-autopairs.ts-conds')

      npairs.setup({
        check_ts = true,

        -- must be done for coq integration. see plugin_config/coq.lua
        map_cr = false,
        map_bs = false,

        ts_config = {
            lua = {'string'},-- it will not add a pair on that treesitter node
            javascript = {'template_string'},
            java = false,-- don't check treesitter on java
        }
      })


      -- press % => %% only while inside a comment or string
      npairs.add_rules({
        Rule("%", "%", "lua")
          :with_pair(ts_conds.is_ts_node({'string','comment'})),
        Rule("$", "$", "lua")
          :with_pair(ts_conds.is_not_ts_node({'function'}))
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      vim.o.foldexpr="nvim_treesitter#foldexpr()"
    end,
    build = ":TSUpdate",
    opts = {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = {'lua', 'julia', 'ruby', 'javascript', 'svelte', 'vim', 'bash', 'vue', 'pug'},

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      auto_install = true,

      -- List of parsers to ignore installing
      ignore_install = {},

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
      },

      indent = {
        enable = true
      },
      endwise = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    },
  },
}
