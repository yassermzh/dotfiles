vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines
vim.keymap.set("v", "E", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "I", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "k", "nzzzv")
vim.keymap.set("n", "m", "Nzzzv")
vim.keymap.set("n", "<C-m>", "m")

vim.keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-e>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-i>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>e", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>i", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)


vim.keymap.set("n", "<C-b>", vim.cmd.NvimTreeFindFileToggle)
vim.keymap.set("n", "<leader>w", ':w<CR>')


vim.keymap.set("n", "<leader>z", "<cmd>only<CR>")

vim.keymap.set({ 'n', 'v' }, 'n', 'h', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'e', 'j', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'i', 'k', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'o', 'l', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 't', 'i', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'T', 'I', { noremap = true })
vim.keymap.set('n', 'l', 'o', { noremap = true })
vim.keymap.set('n', 'L', 'O', { noremap = true })
vim.keymap.set('n', 'h', ':', { noremap = true })
vim.keymap.set('n', '<C-,>', '<C-o>', { noremap = true })
vim.keymap.set('n', '<C-.>', '<C-i>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'W', 'e', { noremap = true })
vim.keymap.set('i', '<C-x>', '<Esc>lxi', { noremap = true })
vim.keymap.set('v', '<', 'o')
