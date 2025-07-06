return {
  {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify"
  },
  config = function()
    require("noice").setup({
      cmdline = {
        view = "cmdline_popup", -- Use floating popup for command line
      },
      views = {
        cmdline_popup = {
          position = {
            row = "50%", -- Middle of screen
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
    })
  end,
}
}
