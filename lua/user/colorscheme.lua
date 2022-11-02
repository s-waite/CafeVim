-- everforest specific, these options need to be before setting the colorscheme
vim.opt.background = 'dark'
vim.g.everforest_background = 'hard'

local colorscheme = "everforest"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end


