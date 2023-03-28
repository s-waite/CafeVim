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


