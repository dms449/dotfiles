return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    opts = {
      options = { theme = 'gruvbox_dark' },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'diff'},
        lualine_c = {{'filename', path=1}},
        lualine_x = {{'diagnostics', sources = { 'nvim_diagnostic', 'nvim_lsp' }}},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {'quickfix', 'fzf'}
    }
  }
}
