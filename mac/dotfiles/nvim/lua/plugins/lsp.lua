return {
  -- Mason: Portable package manager for Neovim
  --
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      ensure_installed = {
        "lua_ls",
        "bashls",
        "pyright",
        "julials",
        "postgres_lsp",
        "vtsls",
        "dockerls",
        "marksman",
      }
      -- Ensure these servers are installed
      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })



      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.preselectSupport = true
      capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.deprecatedSupport = true
      capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
      capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          'documentation',
          'detail',
          'additionalTextEdits',
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local bufnr = ev.buf
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings using modern vim.keymap.set
          local opts = { buffer = bufnr, noremap = true, silent = true }

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'df', function() vim.lsp.buf.definition({ reuse_win = true }) end, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<space>e', vim.diagnostic.setqflist, opts)
          vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
        end
      })

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●', -- Could be '■', '▎', 'x', '●', etc.
          spacing = 4,
          source = "if_many", -- Or "always"
          format = nil,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Configure each LSP server from ensure_installed
      for _, server in ipairs(ensure_installed) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end


      local vue_language_server_path = vim.fn.stdpath('data') ..
            "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      vim.lsp.config('vtsls', {
        capabilities = capabilities,
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_language_server_path,
                  languages = { 'vue' },
                },
              },
            },
          },
        },
      })



    end,
  },
}
