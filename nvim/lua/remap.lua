vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines
-- vim.keymap.set("v", "E", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move line down" })
-- vim.keymap.set("v", "I", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "k", "nzzzv", { noremap = true, desc = "Next match" })
vim.keymap.set("n", "m", "Nzzzv", { noremap = true, desc = "Prev match" })
vim.keymap.set("n", "<C-m>", "m", { noremap = true, desc = "Mark" })

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)


vim.keymap.set("n", "<leader>b", vim.cmd.NvimTreeFindFileToggle, { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>w", ':w<CR>', { desc = "Save file" })

vim.keymap.set("n", "<leader>z", "<cmd>only<CR>", { desc = "Close other buffers" })

-- vim.keymap.set({ 'n', 'v' }, 'n', 'h', { noremap = true }) -- left
-- vim.keymap.set({ 'n', 'v' }, 'e', 'j', { noremap = true }) -- down
-- vim.keymap.set({ 'n', 'v' }, 'i', 'k', { noremap = true }) -- up
-- vim.keymap.set({ 'n', 'v' }, 'o', 'l', { noremap = true }) -- right
vim.keymap.set('n', '<C-w>N', '<C-w>H', { noremap = true, silent = true, desc = "Move window to left" })
vim.keymap.set('n', '<C-w>E', '<C-w>J', { noremap = true, silent = true, desc = "Move window to down" })
vim.keymap.set('n', '<C-w>I', '<C-w>K', { noremap = true, silent = true, desc = "Move window to up" })
vim.keymap.set('n', '<C-w>O', '<C-w>L', { noremap = true, silent = true, desc = "Move window to right" })
vim.keymap.set('n', '<C-w>n', '<C-w>h', { noremap = true, silent = true, desc = "Go to left window" })
vim.keymap.set('n', '<C-w>e', '<C-w>j', { noremap = true, silent = true, desc = "Go to down window" })
vim.keymap.set('n', '<C-w>i', '<C-w>k', { noremap = true, silent = true, desc = "Go to up window" })
vim.keymap.set('n', '<C-w>o', '<C-w>l', { noremap = true, silent = true, desc = "Go to right window" })
-- vim.keymap.set('n', 't', 'i', { noremap = true })          -- insert mode
-- vim.keymap.set('n', 'T', 'I', { noremap = true })          -- insert mode
-- vim.keymap.set('n', 'l', 'o', { noremap = true })          -- newline below
-- vim.keymap.set('n', 'L', 'O', { noremap = true })          -- newline above
vim.keymap.set({ 'n', 'v' }, 'h', ':', { noremap = true }) -- command mode
vim.keymap.set('n', '<C-g>', '<C-o>', { noremap = true })  -- go back
vim.keymap.set('n', '<C-z>', '<C-i>', { noremap = true })  -- go forward
-- vim.keymap.set({ 'n', 'v' }, 'W', 'e', { noremap = true }) -- end of word
-- vim.keymap.set('i', <C-x>', '<Esc>lxi', { noremap = true })
-- vim.keymap.set('v', '/', 'o', { noremap = true })          -- go to first selection line
-- vim.keymap.set('v', '.', 'i', { noremap = true })          -- inside

vim.keymap.set("n", "<C-e>", "<cmd>cnext<CR>zz", { noremap = true, desc = "Next diagnostic" })
vim.keymap.set("n", "<C-i>", "<cmd>cprev<CR>zz", { noremap = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>e", "<cmd>lnext<CR>zz", { noremap = true, desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>i", "<cmd>lprev<CR>zz", { noremap = true, desc = "Previous diagnostic" })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

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
    vim.keymap.set("n", "gs", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
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

vim.keymap.set("n", "<leader>n", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "No Highlight" })
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false })

vim.keymap.set("n", "<leader>ll", ':LspRestart<CR>', { noremap = true, silent = true })

-- vim.keymap.set('c', '<C-i>', '<Up>', { noremap = true, silent = true })
-- vim.keymap.set('c', '<C-e>', '<Down>', { noremap = true, silent = true })
--
-- Map Ctrl+S to save in normal and insert mode
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

