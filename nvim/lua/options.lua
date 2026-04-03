vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"
vim.cmd("language en_US.UTF-8")

vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.g.have_nerd_font = true
vim.o.undofile = true
vim.o.updatetime = 400
vim.o.timeoutlen = 300
vim.o.cursorline = true
vim.o.confirm = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.exrc = true
vim.o.secure = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.showtabline = 1
vim.opt.fillchars:append({ eob = " " })
vim.opt.shortmess:append("I")

vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.o.list = true
vim.opt.listchars = {
  tab = "  ",
  trail = "·",
  nbsp = "␣",
  extends = "»",
  precedes = "«",
}
