require "nvchad.options"
vim.cmd("language en_US.UTF-8")
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.shiftwidth = 3
vim.o.tabstop = 3
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.o.undofile = true
vim.o.updatetime = 400
vim.o.timeoutlen = 300
vim.o.cursorline = true
vim.o.confirm = true

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
