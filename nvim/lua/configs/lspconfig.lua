vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "always" },
})

-- Native LSP Completion and Capabilities
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        -- Enable native completion (Nvim 0.12+)
        if vim.lsp.completion then
          vim.lsp.completion.enable(true, client.id)
        end
        
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end)
  end,
})

-- Configure clangd with correct root markers for your project
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=llvm",
  },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git", "build" },
})

-- Enable servers using the native 0.11/0.12 API
-- This avoids using the deprecated 'lspconfig' setup function
local servers = { "html", "cssls", "ruff", "vhdl_ls", "gopls", "clangd" }
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
