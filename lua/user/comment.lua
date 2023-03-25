-- vim: foldmethod=marker

-- {{{ Setup comments for jsx and tsx
-- A series of protected calls to get references to plugins and modules
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  error("Comment.nvim plugin not found")
  return
end

local treesitter_configs
status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  error("nvim-treesitter.config not found")
  return
end

local ts_commentstring_comment_module
status_ok, ts_commentstring_comment_module = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not status_ok then
  error("ts_context_commentstring Comment.nvim module not found")
  return
end

-- Use setup the Comment.nvim plugin to use the correct comment characters in tsx and jsx
comment.setup {
  pre_hook = ts_commentstring_comment_module.create_pre_hook(),
}
-- }}}

-- Change the commentstring for lua files to be '--' instead of '--[[]]'
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("LuaComment", { clear = true }),
  pattern = "*.lua",
  callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "--")
  end
})
