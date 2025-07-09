return {
  "Exafunction/windsurf.nvim",
  event = 'BufEnter',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
    })
    -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Complete']() end, { expr = true })

    -- Change '<C-g>' here to any keycode you like.
    -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    -- vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    --   { expr = true, silent = true })
    -- vim.keymap.set('i', '<C-.>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    --   { expr = true, silent = true })
    -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })


    -- These use the new Lua API and support multiline completions
    vim.keymap.set('i', '<C-\\>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })

    -- vim.g.codeium_manual = true
  end
}
