local configs = require("nvim-treesitter.configs")
configs.setup {
  --[[ ensure_installed = "all", ]]
  --[[ sync_install = false, ]]
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "help" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "python", "yaml", "dart" } },
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
