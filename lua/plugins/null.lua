return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
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
          require("none-ls.diagnostics.eslint").with({
            name = "eslint_d",
            meta = {
              url = "https://github.com/mantoni/eslint_d.js/",
              description = "Like ESLint, but faster.",
              notes = {
                "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
              },
            },
            command = "eslint_d",
          }),
          null_ls.builtins.diagnostics.selene,
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
