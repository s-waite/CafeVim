local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
		prompt_prefix = "  ",
		selection_caret = " ",
		path_display = { "smart" },
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
			vertical = {
				mirror = false,
			},
			preview_cutoff = 120,
		},
		winblend = 0,
		border = {},
		borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
		color_devicons = true,
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")

vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="#2e383c"})
vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#2e383c"})
vim.api.nvim_set_hl(0, "TelescopePromptNormal", {bg="#374145"})
vim.api.nvim_set_hl(0, "TelescopePromptBorder", {bg="#374145"})
vim.api.nvim_set_hl(0, "TelescopePromptTitle", {bg="#7fbbb3", fg="#2e383c"})
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", {bg="#d699b6", fg="#2e383c"})
