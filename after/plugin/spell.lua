local cspell = require('cspell')
require("null-ls").setup {
  sources = {
    cspell.diagnostics
  }
}
