local nnn = require("nnn")
local builtin = require("nnn").builtin

nnn.setup({
	explorer = {
		cmd = "n", -- command overrride (-F1 flag is implied, -a flag is invalid!)
		width = 30, -- width of the vertical split
		side = "topleft", -- or "botright", location of the explorer window
		session = "", -- or "global" / "local" / "shared"
		tabs = true, -- seperate nnn instance per tab
	},
	mappings = {
		{ "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
		{ "<C-s>", builtin.open_in_split }, -- open file(s) in split
		{ "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
		{ "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
		{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<C-w>", builtin.cd_to_path }, -- cd to file directory
		{ "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
	},
	replace_netrw = "picker",
	auto_close = true,
})
