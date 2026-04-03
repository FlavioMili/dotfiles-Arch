local wk = require("which-key")
wk.setup({
  preset = "modern", -- v3 preset
  spec = {
    { "<leader>f", group = "file/find" },
    { "<leader>g", group = "git" },
    { "<leader>c", group = "code" },
    { "<leader>r", group = "rename" },
    { "<leader>d", group = "document/lsp" },
  }
})
