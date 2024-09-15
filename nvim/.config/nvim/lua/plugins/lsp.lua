return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- LSP Support
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Autocompletion
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',

        -- Snippets
        'L3MON4D3/LuaSnip',

        'j-hui/fidget.nvim',
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "rust_analyzer",
                "clangd",
                "lua_ls",
                "pyright",
                "gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities =  capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })


        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                   require('luasnip').lsp_expand(args.body) -- For `luasnip` users. 
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
        sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' }, -- For luasnip users.
            }, {
              { name = 'buffer' },
              })
      })

      vim.diagnostic.config({
          -- update_in_insert = true,
          float = {
              focusable = false,
              style = "minimal",
              border = "rounded",
              source = "always",
              header = "",
              prefix = "",
          },
      })
        
        --lsp_zero.on_attach(function(client, bufnr)
        --    local opts = {buffer = bufnr, remap = false}

        --    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        --    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        --    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        --    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        --    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        --    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        --    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        --    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        --    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        --    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        --end)

        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        --require('mason').setup({})
        --require('mason-lspconfig').setup({
        --    ensure_installed = {'tsserver','rust_analyzer', 'clangd', 'lua_ls', 'pyright', 'gopls'},
        --    handlers = {
        --        lsp_zero.default_setup,
        --        lua_ls = function()
        --            local lua_opts = lsp_zero.nvim_lua_ls()
        --            require('lspconfig').lua_ls.setup(lua_opts)
        --        end,
        --    }
        --})

        --local cmp = require('cmp')
        --local cmp_select = {behavior = cmp.SelectBehavior.Select}

        ---- this is the function that loads the extra snippets to luasnip
        ---- from rafamadriz/friendly-snippets
        --require('luasnip.loaders.from_vscode').lazy_load()

        --cmp.setup({
        --    sources = {
        --        {name = 'path'},
        --        {name = 'nvim_lsp'},
        --        {name = 'nvim_lua'},
        --        {name = 'luasnip', keyword_length = 2},
        --        {name = 'buffer', keyword_length = 3},
        --    },
        --    formatting = lsp_zero.cmp_format(),
        --    mapping = cmp.mapping.preset.insert({
        --        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        --        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        --        ['<C-Space>'] = cmp.mapping.complete(),
        --    }),
        --})
    end
}
