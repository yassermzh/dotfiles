return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- "nvim-telescope/telescope-frecency.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
      "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "find files" })
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      -- vim.keymap.set('n', '<leader>ps', builtin.grep_string)
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "help tags" })
      vim.keymap.set("n", "<leader>pr", "<cmd>Telescope resume<CR>", { desc = "Last Search" })

      -- vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency<CR>")

      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")
      local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

      vim.keymap.set("n", "<leader>ps", live_grep_args_shortcuts.grep_word_under_cursor,
        { desc = "grep word under cursor" })
      vim.keymap.set("n", "<leader>pS", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        { desc = "live grep" })

      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = {         -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
          },
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
            find_cmd = "rg" -- find command (defaults to `fd`)
          }
        },
        defaults = {
          path_display = { truncate = 2 },
          mappings = {
            i = {
              ["<C-n>"] = "preview_scrolling_left",
              ["<C-o>"] = "preview_scrolling_right",
              ["<C-e>"] = "move_selection_next",
              ["<C-i>"] = "move_selection_previous",
            }
          }
        },
      })

      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      -- telescope.load_extension('fzf')
      telescope.load_extension('media_files')
      -- telescope.load_extension "frecency"
      telescope.load_extension("live_grep_args")


      -- require("telescope.builtin").help_tags()
    end
  }
}
