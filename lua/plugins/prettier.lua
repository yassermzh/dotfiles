return {
  {
    "MunifTanjim/prettier.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },

    config = function()
      local prettier = require("prettier")

      prettier.setup({
        -- bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
        bin = 'prettierd',
        filetypes = {
          "css",
          "graphql",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "markdown",
          "scss",
          "typescript",
          "typescriptreact",
          "yaml",
        },
      })

      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
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
