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

      vim.cmd.colorscheme("rose-pine-dawn")
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


  "ntpeters/vim-better-whitespace",


  "lifepillar/vim-solarized8",

  -- "easymotion/vim-easymotion",

  "ThePrimeagen/vim-be-good",

  "tpope/vim-surround",

  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",

  "mg979/vim-visual-multi",
}
