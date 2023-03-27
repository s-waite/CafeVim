-- Language server to install
local servers = {
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "emmet_ls",
  "marksman",
  "gradle_ls",
  "tailwindcss",
  "jdtls"
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

  -- Don't set up the java language server, this is done seperately through the nvim-jdtls plugin
  if server ~= "jdtls" then
    lspconfig[server].setup(server_opts)
  end

end
