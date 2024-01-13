return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_background = false,
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = 'auto',
      })

      function ColorMyPencils(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)
      end

      ColorMyPencils()
    end
  },
  "mbbill/undotree",
  { "theprimeagen/refactoring.nvim", opts = {} },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {}
  },


  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  -- { "davidmh/cspell.nvim", dependencies = { "Joakker/lua-json5" } },

  "ntpeters/vim-better-whitespace",


  "lifepillar/vim-solarized8",

  "easymotion/vim-easymotion",

  "ThePrimeagen/vim-be-good",

  "tpope/vim-surround",

  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",

}
