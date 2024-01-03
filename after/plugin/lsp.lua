local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommended")

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'eslint', 'lua_ls' },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
    end
  },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-i>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-e>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-o>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
  enabled = function()
    if vim.bo.buftype == 'prompt' then
      return false
    end

    return true
  end,
})

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "gn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  -- vim.keymap.set('n', '<space>f', function()
  --    vim.lsp.buf.format { async = true }
  -- end, opts)
end)


-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls(
--     {
--         settings = {
--             Lua = {
--                 diagnostics = {
--                     globals = { 'vim' }
--                 }
--             }
--         }
--     }
-- ))

lsp_zero.setup()

vim.diagnostic.config({
  virtual_text = true
})


