return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {},
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        hijack_netrw = true,        -- Deaktiviert netrw und verwendet nvim-tree stattdessen
        hijack_cursor = true,       -- Der Cursor bleibt in nvim-tree
        sync_root_with_cwd = false, -- Wechselt nicht automatisch das Arbeitsverzeichnis
        respect_buf_cwd = true,     -- Öffnet das Arbeitsverzeichnis des aktuellen Buffers
        -- keine Option zum automatischen Öffnen definieren
        view = {
          side = "right",
          adaptive_size = true
        },
        filters = {
          dotfiles = false
        },
        -- disable rendering icons
        renderer = {
          icons = {
            show = {
              file = true,
              folder = false,
              folder_arrow = true,
              git = true
            }
          }
        }
      })
    end,
  }
}
