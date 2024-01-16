return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    config = function()
      vim.defer_fn(function()
        require 'nvim-treesitter.configs'.setup {
          -- A list of parser names, or "all"
          ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust" },

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,

              keymaps = {
                ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
                ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                ["rf"] = { query = "@call.inner", desc = "Select inner part of a function call" },
                ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                ["rm"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
              },
            },
          },
        }
      end, 0)
    end
  } }
