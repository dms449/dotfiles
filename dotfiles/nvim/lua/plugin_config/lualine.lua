require('lualine').setup {
  options = { theme = 'gruvbox_dark' },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {{'diagnostics', sources = { 'nvim_diagnostic', 'nvim_lsp' }}},
    lualine_x = {'filename', {'filetype', icon_only=true}},
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
