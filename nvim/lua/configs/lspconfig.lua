vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "always" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        if vim.lsp.completion then
          vim.lsp.completion.enable(true, client.id)
        end
        -- Let conform.nvim handle formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end)
  end,
})

-- Pyright LSP configuration with virtualenv auto-detection
vim.lsp.config("pyright", {
  before_init = function(_, config)
    local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
    if vim.fn.executable(venv_python) == 1 then
      config.settings.python.pythonPath = venv_python
    end
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

-- Ruff LSP configuration (ignore lambda assignment E731)
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      lint = {
        ignore = { "E731" },
      },
    },
  },
})

-- Clangd LSP configuration
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

-- Active LSP language servers
local servers = { "html", "cssls", "ruff", "pyright", "gopls", "clangd" }
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
