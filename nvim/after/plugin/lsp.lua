local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- lspconfig.lua_ls.setup({
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" }
--       }
--     }
--   }
-- })
--
lspconfig.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

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


lspconfig.ts_ls.setup({
  capabilities = capabilities,
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


lspconfig.phpactor.setup {
  capabilities = capabilities,
  init_options = {
    -- ["language_server_phpstan.enabled"] = false,
    -- ["language_server_psalm.enabled"] = false,
    ["language_server_php_cs_fixer.enabled"] = true, -- Enable PHP CS Fixer
    ["language_server_php_cs_fixer.bin"] = "/home/yas/works/spreadgroup/backend/vendor/friendsofphp/php-cs-fixer/php-cs-fixer",
    -- ["php_code_sniffer.enabled"] = true,
    -- ["php_code_sniffer.bin"] = "/home/yas/works/spreadgroup/backend/vendor/squizlabs/php_codesniffer/bin/phpcs"
  }
}
