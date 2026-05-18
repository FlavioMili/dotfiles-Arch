vim.cmd("language en_US.UTF-8")

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.relativenumber = true
vim.o.number = true
vim.o.showmode = false
vim.o.cursorline = true
vim.o.mouse = "a"

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.scrolloff = 10

vim.o.updatetime = 400
vim.o.timeoutlen = 300
vim.o.undofile = true

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

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 120,
    })
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

vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
})
