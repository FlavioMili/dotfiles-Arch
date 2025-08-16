require "nvchad.options"
vim.cmd("language en_US.UTF-8")

vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.shiftwidth = 0
vim.o.tabstop = 2
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.o.undofile = true
vim.o.updatetime = 400
vim.o.timeoutlen = 300
vim.o.cursorline = true
vim.o.confirm = true
vim.o.expandtab = true
vim.o.smartindent = true

-- trailing space characters
vim.opt.listchars = {
  tab = "▷ ",
  trail = "·",
  nbsp = "○",
}

-- Yank highlighting
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
