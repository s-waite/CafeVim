-- Language server to install
local servers = {
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "emmet_ls"
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

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, server in pairs(servers) do
  local server_opts = {
    on_attach,
    capabilities,
  }

  server = vim.split(server, "@")[1]

  lspconfig[server].setup(server_opts)
end
