-- vim: foldmethod=marker
-- Options to use for all keymaps
local opts = { noremap = true, silent = true }

-- Options to use for all terminal keymaps
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- {{{ Insert Mode 
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- }}}

-- {{{ Normal Mode
-- Sideways plugin, for moving function arguments around
keymap("n", "<C-h>", ":SidewaysLeft<CR>", opts)
keymap("n", "<C-l>", ":SidewaysRight<CR>", opts)

-- Adding blank lines above or below
vim.api.nvim_set_keymap('n', '<CR>', 'mxo<Esc>k`x', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-CR>', 'mxO<Esc>`x', { noremap = true })

-- Clear Highlights
keymap("n", "<Space><Space>", ":noh<CR>", opts)

-- LSP
-- Some keymaps are found in whichkey.lua
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--[[ keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) ]]
--[[ keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) ]]
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--[[ keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) ]]
--[[ keymap("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) ]]
--[[ keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts) ]]
--[[ keymap( ]]
--[[   "n", ]]
--[[   "gl", ]]
--[[   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', ]]
--[[   opts ]]
--[[ ) ]]
--[[ keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts) ]]
--[[ keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) ]]
-- }}}
