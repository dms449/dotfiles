require("packer").startup(
  function()
    use 'wbthomason/packer.nvim' -- generic vim
    use {"junegunn/fzf",
        run = function()
          vim.fn["fzf#install"]()
        end}
    use "junegunn/fzf.vim"
    use 'machakann/vim-highlightedyank'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-abolish'
    use 'airblade/vim-gitgutter'
    use 'FooSoft/vim-argwrap'
    use 'windwp/nvim-autopairs'
    use 'mbbill/undotree'
    use 'kthibodeaux/tig.vim'
    use 'RRethy/nvim-treesitter-endwise'

    -- Language specific
    use 'tpope/vim-rails'
    use 'posva/vim-vue'
    use 'digitaltoad/vim-pug'
    use 'slim-template/vim-slim'
    use 'benmills/vimux'
    use 'thoughtbot/vim-rspec'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- completion
    use {
      'ms-jpq/coq_nvim',
      requires = {
         {'ms-jpq/coq.artifacts', branch = 'artifacts'},
         {'ms-jpq/coq.thirdparty', branch = '3p'},
      },
      branch = 'coq'
    }

    -- Theme
    use 'ryanoasis/vim-devicons'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use 'ellisonleao/gruvbox.nvim'
end)

