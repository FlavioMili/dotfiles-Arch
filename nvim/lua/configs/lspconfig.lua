-- Diagnostic configuration (Subtle & Professional)
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Small circle instead of big block/letter
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Modern & Subtle diagnostic symbols (Restoring NvChad style)
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local servers = { "html", "cssls", "ruff", "vhdl_ls", "gopls" }

-- Enable standard servers
vim.lsp.enable(servers)

-- Special configuration for clangd (C++)
-- This fixes "Go to definition" and other common C++ LSP issues
vim.lsp.config("clangd", {
  capabilities = {
    offsetEncoding = { "utf-16" }, -- Crucial for clangd stability
  },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
})

vim.lsp.enable("clangd")
