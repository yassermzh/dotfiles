return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
      "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
      vim.keymap.set('n', '<leader>pb', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      -- vim.keymap.set('n', '<leader>ps', function()
      -- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
      -- end)

      vim.keymap.set('n', '<leader>ps', builtin.grep_string)
      -- vim.keymap.set('n', '<leader>pS', builtin.live_grep)

      vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

      -- vim.keymap.set("n", "<leader><leader>", "<Cmd>Telescope frecency<CR>")
      vim.keymap.set("n", "<leader>pS", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg" -- find command (defaults to `fd`)
          }
        },
        defaults = {
          path_display = { truncate = 2 },
          mappings = {
            i = {
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
      telescope.load_extension "frecency"
      telescope.load_extension("live_grep_args")


      -- require("telescope.builtin").help_tags()
    end
  }
}
