require('lspconfig').sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    }
  }
}

require('lspconfig').tsserver.setup {}

require('lspconfig').tailwindcss.setup {}

require('lspconfig').emmet_ls.setup {}

require('lspconfig').html.setup {
  filetypes = { "html", "javascriptreact" },
}
