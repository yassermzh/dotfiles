return {
  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    config = function()
      require('windows').setup()
      vim.keymap.set("n", "<C-w>z", "<cmd>WindowsMaximize<CR>", { desc = "Maximize window" })
    end
  }
}
