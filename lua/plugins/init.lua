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
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },

    -- prettier
    "jose-elias-alvarez/null-ls.nvim",
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
    }
}
