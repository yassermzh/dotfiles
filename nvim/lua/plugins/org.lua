return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                spreadgroup = "~/works/spreadgroup/notes",
              },
            },
          },
        },
        keybinds = {
          ["<leader>vv"] = "<Plug>(neorg.esupports.hop.hop-link)"
        }
      })
    end
  }
}
