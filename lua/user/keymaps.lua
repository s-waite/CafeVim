local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Clear Highlights
keymap("n", "<Space><Space>", ":noh<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Adding blank lines above or below
vim.api.nvim_set_keymap('n', '<CR>', 'mxo<Esc>k`x', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-CR>', 'mxO<Esc>`x', { noremap = true })

-- Insert
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Sideways
keymap("n", "<C-h>", ":SidewaysLeft<CR>", opts)
keymap("n", "<C-l>", ":SidewaysRight<CR>", opts)
vim.cmd([[
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
]])
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
