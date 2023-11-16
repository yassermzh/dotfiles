return {
  { 'rose-pine/neovim', name = 'rose-pine' },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  { "nvim-telescope/telescope.nvim",  dependencies = { 'nvim-lua/plenary.nvim' } },
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "tpope/vim-fugitive",
  "theprimeagen/harpoon",
  "mbbill/undotree",
  "theprimeagen/refactoring.nvim",
  
  -- Mason
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  -- LSP
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
}

