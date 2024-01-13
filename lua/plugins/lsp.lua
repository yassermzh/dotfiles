return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("fidget").setup({})
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'eslint', 'lua_ls' }
      })

      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = ""
        }
        im.lsp.buf.execute_command(params)
      end

      require("lspconfig").tsserver.setup({
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
          }
        },
      })


      local function filter(arr, fn)
        if type(arr) ~= "table" then
          return arr
        end

        local filtered = {}
        for k, v in pairs(arr) do
          if fn(v, k, arr) then
            table.insert(filtered, v)
          end
        end

        return filtered
      end

      local function filterDTS(value)
        return string.match(value.targetUri, 'd.ts') == nil
      end

      local tsserverHandler = function()
        print("setup tsserver... yasser")

        require("lspconfig").tsserver.setup({
          handlers = {
            -- https://github.com/typescript-language-server/typescript-language-server/issues/216
            ['textDocument/definition'] = function(err, result, method, ...)
              if vim.tbl_islist(result) and #result > 1 then
                local filtered_result = filter(result, filterDTS)
                return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
              end

              vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
            end
          },
          commands = {
            OrganizeImports = {
              organize_imports,
              description = "Organize Imports"
            }
          },
          on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentFormattingRangeProvider = false
          end,
        })
      end

      local defaultHandler = function(server_name) -- default handler
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities
        })

        vim.diagnostic.config({
          virtual_text = false,
          update_in_insert = true,
          severity_sort = true,
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })
      end

      --[[
      local handlers = {
        defaultHandler,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          })
        end,

        ["tsserver"] = tsserverHandler
      }
      ]]--
      -- require('mason-lspconfig').setup_handlers(handlers)
      -- require('mason-lspconfig').setup_handlers({ defaultHandler })

      -- tsserverHandler()

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-i>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-e>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-o>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true, },
        }),
        sources = cmp.config.sources({
          {
            name = 'nvim_lsp',
            -- Dont suggest Text from nvm_lsp
            entry_filter = function(entry)
              return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
            end
          },
          { name = 'luasnip' },
          { name = 'vim-dadbod-completion' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- Set up lspconfig.
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
      --   capabilities = capabilities
      -- }
    end
  }
}
