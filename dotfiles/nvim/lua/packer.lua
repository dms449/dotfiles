-- Plugins
require("packer").startup(
  function()
    use 'wbthomason/packer.nvim'

    -- generic vim
    use 'junegunn/fzf', { 'dir': '~/.fzf/fzf', 'do': './install --all' }
    use 'junegunn/fzf.vim'
    use 'rstacruz/vim-closer'
    use 'machakann/vim-highlightedyank'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-eunuch'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    -- use 'haorenW1025/completion-nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- completion
    use {'ms-jpq/coq_nvim', branch = 'coq'}

    -- Theme
    use 'nvim-lualine/lualine.nvim'
    use 'morhetz/gruvbox'
end)
