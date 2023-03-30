-- vim: foldmethod=marker
local fn = vim.fn

-- Automatically install packer and plugins if packer not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer and plugins...\n")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "solid" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- {{{ General
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	-- }}}

	-- {{{ Colorschemes
	use("sainnhe/everforest")
	-- }}}

	-- {{{ Autocompletion
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	-- }}}

	-- {{{ Snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	-- }}}

	-- {{{ LSP
	-- for communication with language servers, code completion, refactoring, etc.
	-- nvim-cmp (autocompletion above) uses these language servers for its completion
	use({ "williamboman/mason.nvim", run = ":MasonUpdate" })
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	-- }}}

	-- {{{ Language, filetype, and framework specific
	use("mfussenegger/nvim-jdtls") -- Java
	-- Use the correct comment characters when dealing with jsx and tsx
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- }}}

	--  -- Lua
	--  use {
	--    "folke/trouble.nvim",
	--    requires = "kyazdani42/nvim-web-devicons",
	--    config = function()
	--      require("trouble").setup {
	--        -- your configuration comes here
	--        -- or leave it empty to use the default settings
	--        -- refer to the configuration section below
	--      }
	--    end
	--  }
	--
	-- {{{ Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- }}}

	-- {{{ Treesitter
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "p00f/nvim-ts-rainbow" })
	-- }}}

	-- {{{ Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	-- }}}

	--  -- Git
	--  use("lewis6991/gitsigns.nvim")
	--
	--  -- Text objects
	--  use("kana/vim-textobj-user")
	--  use("jceb/vim-textobj-uri")
	--  use("kana/vim-textobj-line")
	use("AndrewRadev/sideways.vim")
	--  use("kana/vim-textobj-indent")
	--  use("kana/vim-textobj-entire")
	--
	--  -- Frameworks/Languages
	--  use({
	--    "akinsho/flutter-tools.nvim",
	--    requires = "nvim-lua/plenary.nvim",
	--    config = function()
	--      require("flutter-tools").setup()
	--    end,
	--  })
	--  use({ 'simrat39/rust-tools.nvim',
	--    config = function()
	--      require("rust-tools").setup()
	--    end,
	--  })
end)
