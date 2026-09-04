require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "cpp",
    "lua",
    "python",
    "vhdl",
    "sql",
    "go",
    "rust",
    "markdown",
    "markdown_inline",
  },
  highlight = { enable = true },
})
