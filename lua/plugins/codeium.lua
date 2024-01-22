return {
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.g.codeium_manual = false
      vim.keymap.set('i', '<C-\\>', function() return vim.fn['codeium#Complete']() end, { expr = true })
    end
  }
}
