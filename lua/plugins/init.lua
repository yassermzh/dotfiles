return {
  { 'rose-pine/neovim',                name = 'rose-pine' },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim",   dependencies = { 'nvim-lua/plenary.nvim' } },
  "tpope/vim-fugitive",
  "theprimeagen/harpoon",
  "mbbill/undotree",
  "theprimeagen/refactoring.nvim",

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- Mason
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  -- LSP
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  -- "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",
  --    "cmp-cmdline",

  -- prettier
  "nvimtools/none-ls.nvim",
  "MunifTanjim/prettier.nvim",

  -- ai
  "Exafunction/codeium.vim",

  -- browser tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      -- "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },


  -- folding
  { "kevinhwang91/nvim-ufo",                    dependencies = { "kevinhwang91/promise-lib" } },

  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- images
  {
    "princejoogie/chafa.nvim",
    derequires = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim"
    },
  },

  -- gitsigns
  "lewis6991/gitsigns.nvim",

  --telescope frequency
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  "folke/zen-mode.nvim",

  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
  },


  -- { "davidmh/cspell.nvim", dependencies = { "Joakker/lua-json5" } },

  "ntpeters/vim-better-whitespace",

  "nvim-telescope/telescope-media-files.nvim",

  "nvim-telescope/telescope-live-grep-args.nvim",


  "lifepillar/vim-solarized8",

  "easymotion/vim-easymotion",

  "ThePrimeagen/vim-be-good",

  "tpope/vim-surround",

  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "kristijanhusak/vim-dadbod-completion",
}
