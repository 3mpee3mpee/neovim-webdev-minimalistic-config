return {
  -- LSP Configuration
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'williamboman/mason-lspconfig.nvim' },

    -- Useful status updates for LSP
    -- https://github.com/j-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim', opts = {} },

    -- Prettier integration (optional, can use LSP or as formatter)
    { 'jose-elias-alvarez/null-ls.nvim', opts = {} },  -- For integrating prettier and eslint
  },
  config = function ()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      ensure_installed = {
        'bashls', -- requires npm to be installed
        'cssls', -- requires npm to be installed
        'html', -- requires npm to be installed
        'lua_ls',
        'jsonls', -- requires npm to be installed
        'lemminx',
        'marksman',
        'quick_lint_js',
        'astro',
        'clangd',
        'tsserver', -- requires npm to be installed
        'gopls',
        'yamlls', -- requires npm to be installed
        'eslint',  -- ESLint LSP
      }
    })

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Create your keybindings here...
    end

    -- Call setup on each LSP server
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end
    })

    -- Lua LSP settings
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    }

    -- ESLint configuration
    lspconfig.eslint.setup {
      on_attach = function(client, bufnr)
        -- Auto format with eslint on save
        if client.resolved_capabilities.document_formatting then
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
      end
    }

    -- Null-ls for prettier integration
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = {
        -- Clang Formatter
        null_ls.builtins.formatting.clang_format,
        -- Prettier Formatter
        null_ls.builtins.formatting.prettier,
        -- ESLint
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
      },
    })

    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end
}

