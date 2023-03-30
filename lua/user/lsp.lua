-- Language server to install
local servers = {
  "cssls",
  "lua_ls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "emmet_ls",
  "gradle_ls",
  "tailwindcss",
}

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = servers,
})

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  -- disable formatting from "lua_ls" because we will be using a null-ls provider for formatting
  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local server_opts = {}

for _, server in pairs(servers) do
  server_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  server = vim.split(server, "@")[1]

  -- Add our settings defined in the 'lsp_settings' folder
  local require_ok, conf_opts = pcall(require, "user.lsp_settings." .. server)
	if require_ok then
		server_opts = vim.tbl_deep_extend("force", conf_opts, server_opts)
	end

  -- Setup each server
  lspconfig[server].setup(server_opts)
end

-- Setup null_ls, which we will use for some alternatives to the default
-- language servers
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
    },
})

local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "solid",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "solid",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "solid",
	})


