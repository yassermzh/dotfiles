return {
  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    keys = {
      '<C-w>z', "<cmd>WindowsMaximize<CR>", desc = "Maximize window"
    },
    config = function()
      require('windows').setup()
    end
  }
}
