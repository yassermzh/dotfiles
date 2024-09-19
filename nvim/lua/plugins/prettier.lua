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
    end
  }
}
