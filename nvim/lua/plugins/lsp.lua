local M = {
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
    "Exafunction/codeium.vim",
  }
}

M.config = function()
  require("fidget").setup({})
  require('mason').setup({})
  require('mason-lspconfig').setup({
    ensure_installed = { 'ts_ls', 'lua_ls', 'phpactor' }
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

  -- local lspconfig = require("lspconfig")
  --
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  --
  -- local defaultHandler = function(server_name) -- default handler
  --   print('server name is ', server_name);
  --   lspconfig[server_name].setup({
  --     capabilities = capabilities
  --   })
  --
  --   -- vim.diagnostic.config({
  --   --   virtual_text = false,
  --   --   update_in_insert = true,
  --   --   severity_sort = true,
  --   --   float = {
  --   --     focusable = true,
  --   --     style = "minimal",
  --   --     border = "rounded",
  --   --     source = "always",
  --   --     header = "",
  --   --     prefix = "",
  --   --   },
  --   -- })
  -- end
  --
  -- local handlers = {
  --   defaultHandler,
  --
  --   ["lua_ls"] = function()
  --     lspconfig.lua_ls.setup({
  --       capabilities = capabilities,
  --       settings = {
  --         Lua = {
  --           diagnostics = {
  --             globals = { "vim" }
  --           }
  --         }
  --       }
  --     })
  --   end,
  -- }
  --
  -- require('mason-lspconfig').setup_handlers(handlers)

  local cmp = require('cmp')
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  local cmp_mapping_ic = function(item)
    return cmp.mapping(item, { 'i', 'c' })
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Up>'] = cmp_mapping_ic(cmp.mapping.select_prev_item(cmp_select)),
      ['<Down>'] = cmp_mapping_ic(cmp.mapping.select_next_item(cmp_select)),
      -- ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true, }), { 'i' }),
      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true, }), { 'i', 'c' }),
      -- ['<C-i>'] = cmp_mapping_ic(cmp.mapping.select_prev_item(cmp_select)),
      -- ['<C-e>'] = cmp_mapping_ic(cmp.mapping.select_next_item(cmp_select)),
      -- ['<C-o>'] = cmp_mapping_ic(cmp.mapping.confirm({ select = true })),
      ['<C-Space>'] = cmp_mapping_ic(cmp.mapping.complete()),
      ['<C-n>'] = cmp_mapping_ic(cmp.mapping.abort()),
    }),
    sources = cmp.config.sources({
      {
        name = 'nvim_lsp',
        -- Dont suggest Text from nvm_lsp
        entry_filter = function(entry)
          return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
        end
      },
      { name = "codeium" },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
    completion = {
      autocomplete = false,
    },
  })

  -- Setup up vim-dadbod
  cmp.setup.filetype({ "sql", "mysql" }, {
    sources = {
      { name = "vim-dadbod-completion" },
      { name = "buffer" },
      { name = "codeium" },
    },
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
    },
    completion = {
      autocomplete = false,
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
      -- ['<C-i>'] = cmp_mapping_ic(cmp.mapping.select_prev_item(cmp_select)),
      -- ['<C-e>'] = cmp_mapping_ic(cmp.mapping.select_next_item(cmp_select)),
    }),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    completion = {
      autocomplete = false,
    },
  })

  -- Set up lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  --   capabilities = capabilities
  -- }
end

return M
