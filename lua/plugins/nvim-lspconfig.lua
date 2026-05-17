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
        local ensure_installed = {
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
                'zls',
                'pylsp',
                'ts_ls', -- requires npm to be installed
                'gopls',
                'yamlls', -- requires npm to be installed
                'eslint',  -- ESLint LSP
                'elixirls',
        }
        require('mason').setup()
        require('mason-lspconfig').setup({
            -- Install these LSPs automatically
            ensure_installed = ensure_installed
        })

        -- Call setup on each LSP server
        for _, server_name in ipairs(ensure_installed) do
            vim.lsp.enable(server_name)
        end

        -- Example Lua code to enable completion for a buffer and client
        -- vim.api.nvim_create_autocmd('LspAttach', {
        --     callback = function(args)
        --         local client = vim.lsp.get_client_by_id(args.data.client_id)
        --         -- Check if the client supports completion
        --         if client.supports_method('textDocument/completion') and vim.lsp.completion then
        --             -- Enable completion for the client and buffer,
        --             -- with autotrigger enabled.
        --             vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        --         end
        --     end,
        -- })

        -- Lua LSP settings
        vim.lsp.config('lua-lsp', {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                    },
                    workspace = {
                        checkThirdParty = false,
                        telemetry = { enable = false },
                        library = {
                            "${3rd}/love2d/library"
                        }
                    }
                },
            },
        })

        -- Null-ls for prettier integration
        local null_ls = require('null-ls')
        vim.lsp.config('null-ls', {
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

