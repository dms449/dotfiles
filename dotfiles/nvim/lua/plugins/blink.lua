return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  enabled = false,
  opts = {
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'select_and_accept' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    },
    signature = { enabled = true },

    appearance = {
      nerd_font_variant = 'normal'
    },

    completion = { documentation = { auto_show = false } },

    sources = {
      default = { 'codeium', 'lsp', 'path', 'buffer', 'snippets' },
      providers = {
        codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
