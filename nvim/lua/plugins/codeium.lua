return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
    })
    vim.g.codeium_manual = true
    vim.keymap.set('i', '<C-\\>', function() return vim.fn['codeium#Complete']() end, { expr = true })
  end
}
