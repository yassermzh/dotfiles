return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "davidmh/cspell.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local cspell = require('cspell')

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
          cspell.diagnostics,
          cspell.code_actions,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
              end,
              desc = "[lsp] format on save",
            })
          end
        end,
      })
    end
  }
}
