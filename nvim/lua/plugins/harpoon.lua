return {
  {
    "theprimeagen/harpoon",
    -- keys = {
    --   {
    --     "<leader>a",
    --     function()
    --       require("harpoon.mark").add_file()
    --     end,
    --     desc = "add file to harpoon"
    --   },
    --   {
    --     "<C-t>",
    --     function()
    --       require("harpoon.ui").toggle_quick_menu()
    --     end,
    --     desc = "toggle harpoon quick menu"
    --   },
    -- },
    config = function()
      require("harpoon").setup({
        global_settings = {
          mark_branch = true
        },
        menu = {
          width = 90
        }
      })
      vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end,
        { desc = "add file to harpoon" })
      vim.keymap.set("n", "<C-t>", function() require("harpoon.ui").toggle_quick_menu() end,
        { desc = "toggle harpoon quick menu" })
    end,

    -- vim.keymap.set("n", "<C-n>", function() ui.nav_file(1) end)
    -- vim.keymap.set("n", "<C-e>", function() ui.nav_file(2) end)
    -- vim.keymap.set("n", "<C-i>", function() ui.nav_file(3) end)
    -- vim.keymap.set("n", "<C-o>", function() ui.nav_file(4) end)
  }
}
