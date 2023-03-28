local configs = require("nvim-treesitter.configs")
configs.setup {
  auto_install = true,
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "help" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = false, disable = { "python", "yaml", "dart" } },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 5000, -- Do not enable for files with more than n lines, int
  },
  -- For Comment.nvim integration
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
