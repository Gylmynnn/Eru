--- NOTE: This for neovim options configuration

require "nvchad.options"
local opt = vim.opt

vim.diagnostic.config {
    virtual_text = false,
}
opt.cursorline = false
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.linebreak = true
opt.breakindent = true

opt.showmode = true
opt.number = true
opt.numberwidth = 5
opt.ruler = true

opt.signcolumn = "no"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true


-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
