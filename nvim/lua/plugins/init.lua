return {
  'nvim-tree/nvim-web-devicons',
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_background = false,
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = 'auto',
      })

      local function set_color_scheme_based_on_time()
        local hour = tonumber(os.date("%H"))
        if hour >= 6 and hour < 18 then
          -- Set your daytime colorscheme
          vim.cmd("colorscheme rose-pine-dawn")
        else
          -- Set your nighttime colorscheme
          vim.cmd("colorscheme rose-pine-moon")
        end
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = set_color_scheme_based_on_time,
      })
    end
  },
  "mbbill/undotree",
  { "theprimeagen/refactoring.nvim", opts = {} },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1500
    end,
    opts = {}
  },




  "ntpeters/vim-better-whitespace",


  "lifepillar/vim-solarized8",

  -- "easymotion/vim-easymotion",

  "ThePrimeagen/vim-be-good",

  "tpope/vim-surround",

  "mg979/vim-visual-multi",
}
