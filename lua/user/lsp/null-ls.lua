local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			filetypes = {
				"handlebars",
				"javascriptreact",
				"javascript",
				"vue",
				"typescript",
				"typescriptreact",
				"less",
				"yaml",
				"css",
				"markdown",
				"scss",
				"jsonc",
				"json",
				"graphql",
			},
			extra_args = { "--single-quote", "--jsx-single-quote" },
		}),
		formatting.dart_format.with({
			filetypes = { "dart" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.tidy,
		-- formatting.yapf,
		formatting.stylua,
		diagnostics.tidy,
		diagnostics.flake8,
	},
})
