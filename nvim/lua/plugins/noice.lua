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
        -- 👇 Add this to prevent long messages going to splits
        presets = {
          long_message_to_split = false,
        },
        -- 👇 Optional: mark Noice buffers as unlisted
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { kind = "confirm" },
                { kind = "confirm_sub" },
                { kind = "" }, -- normal messages
              },
            },
            opts = { skip = false },
          },
        },
      })

      -- 👇 Extra protection: mark any Noice buffer as unlisted
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = "noice://*",
        callback = function()
          vim.opt_local.buflisted = false
        end,
      })
    end,
  }
}

