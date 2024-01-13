return {
  {
    "okuuva/auto-save.nvim",
    config = function()
      require('auto-save').setup({
        trigger_events = {
          immediate_save = {
            { "BufLeave",  pattern = { "*.ts", "*.tsx", ".js", ".json" } },
            { "FocusLost", pattern = { "*.ts", "*.tsx", ".js", ".json", ".lua" } },
          },
          defer_save = {}
        }
      })
    end,
  }
}
