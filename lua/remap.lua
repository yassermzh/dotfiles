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

vim.keymap.set({ 'n', 'v' }, 'n', 'h', { noremap = true }) -- left
vim.keymap.set({ 'n', 'v' }, 'e', 'j', { noremap = true }) -- down
vim.keymap.set({ 'n', 'v' }, 'i', 'k', { noremap = true }) -- up
vim.keymap.set({ 'n', 'v' }, 'o', 'l', { noremap = true }) -- right
vim.keymap.set('n', 't', 'i', { noremap = true })          -- insert mode
vim.keymap.set('n', 'T', 'I', { noremap = true })          -- insert mode
vim.keymap.set('n', 'l', 'o', { noremap = true })          -- newline below
vim.keymap.set('n', 'L', 'O', { noremap = true })          -- newline above
vim.keymap.set({ 'n', 'v' }, 'h', ':', { noremap = true }) -- command mode
vim.keymap.set('n', '<C-,>', '<C-o>', { noremap = true })  -- go back
vim.keymap.set('n', '<C-.>', '<C-i>', { noremap = true })  -- go forward
vim.keymap.set({ 'n', 'v' }, 'W', 'e', { noremap = true }) -- end of word
-- vim.keymap.set('i', '<C-x>', '<Esc>lxi', { noremap = true })
vim.keymap.set('v', '<', 'o')                              -- go to first selection line
vim.keymap.set('v', 'r', 'i')                              -- inside



-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('YasserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "gf", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --    vim.lsp.buf.format { async = true }
    -- end, opts)
  end
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false })


vim.keymap.set('c', '<C-i>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-e>', '<Down>', { noremap = true, silent = true })
