require("user.options")
require("user.colorscheme")
require("user.keymaps")
require("user.commands")
require("user.lsp")

-- Plugins
require("user.plugins")
require("user.comment")
require("user.treesitter")
require("user.cmp")
require("user.telescope")
require("user.bufferline")
require("user.toggleterm")
--[[ require("user.autocommands") ]]
--[[ require("user.autopairs") ]]
--[[ require("user.nnn") ]]
--[[ require("user.gitsigns") ]]
--[[ require("user.lualine") ]]
--[[ require("user.indent") ]]
--[[ require("user.alpha") ]]
--[[ require("user.whichkey") ]]
--[[ require("user.dap-python") ]]
--[[ require("user.dap-dart") ]]
--[[ require("user.glow") ]]
--[[ require("user.vimtex") ]]

-- vim.cmd "set statusline+=%{expand(&filetype)}"
--[[ vim.api.nvim_set_hl("FloatBorder", { guibg = "None" }, false) ]]
--[[ vim.api.nvim_set_hl(0, "FloatBorder", {} ) ]]
--[[ vim.api.nvim_set_hl(0, "WhichKeyFloat", {} ) ]]
--[[ vim.api.nvim_set_hl(0, "NormalFloat", {}) ]]
--[[]]
--[[ vim.api.nvim_set_hl("NormalFloat", { guibg = "None", guifg = "None" }, false) ]]
--[[ vim.api.nvim_set_hl("FloatBorder", { guibg = "None" }, false) ]]
--[[ vim.api.nvim_set_hl("WhichKeyFloat", { guibg = "None" }, false) ]]
