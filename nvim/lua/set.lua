-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "0" -- maybe 80 columns



-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.clipboard = "unnamedplus"

vim.opt.spelllang = 'en'
vim.opt.spell = true
vim.opt.spellcapcheck = ''
vim.opt.spelloptions = "camel"

vim.opt.mouse = "a"

-- vim.keymap.set("i", "<S-Insert>", [[<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>]], { noremap = true, silent = true })

